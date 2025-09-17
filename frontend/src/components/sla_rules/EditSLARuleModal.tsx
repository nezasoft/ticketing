import React, { Fragment, useState, useContext, useEffect } from "react";
import { Dialog, Transition } from "@headlessui/react";
import { SettingContext } from "../../context/SettingContext";
import { SLAContext } from "../../context/SLAContext";
import { SLARule } from "../../types";
import { toast } from "react-toastify";

interface Props {
  isOpen: boolean;
  onClose: () => void;
  onUpdated: () => void;
  sla_rule: Partial<SLARule>;
}

const EditSLARuleModal: React.FC<Props> = ({
  isOpen,
  onClose,
  onUpdated,
  sla_rule,
}) => {
  const { editSLARule } = useContext(SLAContext);
  const { setting } = useContext(SettingContext);

  const [form, setForm] = useState<Partial<SLARule>>({});
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Reset form values when modal opens with a rule
  useEffect(() => {
    if (isOpen && sla_rule) {
      setForm({
        sla_policy_id: sla_rule.sla_policy_id,
        customer_type_id: sla_rule.customer_type_id,
        priority_id: sla_rule.priority_id,
        channel_id: sla_rule.channel_id,
      });
    }
    if (!isOpen) setError(null);
  }, [isOpen, sla_rule]);

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    const { name, value } = e.target;
    setForm((prev) => ({
      ...prev,
      [name]:
        value === "" ? undefined : isNaN(Number(value)) ? value : Number(value),
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!sla_rule?.id) {
      toast.error("Invalid SLA Rule selected");
      return;
    }

    setSubmitting(true);
    setError(null);

    try {
      const storedUser = localStorage.getItem("user");
      if (!storedUser) throw new Error("User not found in localStorage");

      const currentUser = JSON.parse(storedUser);
      const formData = new FormData();
      formData.append("company_id", String(currentUser.company_id));
      formData.append("user_id", String(currentUser.id));
      formData.append("rule_id", String(sla_rule.id));

      Object.entries(form).forEach(([key, value]) => {
        if (value !== undefined && value !== null && String(value) !== "") {
          formData.append(key, String(value));
        }
      });

      const response = await editSLARule(formData);

      if (response.success) {
        toast.success("Record updated successfully");
        onUpdated();
        onClose();
      } else {
        const message =
          typeof response.message === "string"
            ? response.message
            : Object.values(response.message || {}).join(",");
        toast.error(message || "Failed to update record");
      }
    } catch (err: any) {
      toast.error(err.message || "Unexpected error occurred");
    } finally {
      setSubmitting(false);
    }
  };

  /** Small helper to render select fields */
  const renderSelect = (
    label: string,
    name: keyof SLARule,
    options: { id: number; name: string }[] | undefined
  ) => (
    <div>
      <label className="block text-sm font-medium text-left">{label}</label>
      <select
        name={name}
        value={form[name] !== undefined ? String(form[name]) : ""}
        onChange={handleChange}
        required
        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
      >
        <option value="">Select</option>
        {options?.map((d) => (
          <option key={d.id} value={String(d.id)}>
            {d.name}
          </option>
        ))}
      </select>
    </div>
  );

  return (
    <Transition.Root show={isOpen} as={Fragment}>
      <Dialog
        as="div"
        className="relative z-50"
        onClose={onClose} // ✅ backdrop/Escape closes modal
      >
        <Transition.Child
          as={Fragment}
          enter="ease-out duration-300"
          enterFrom="opacity-0"
          enterTo="opacity-100"
          leave="ease-in duration-200"
          leaveFrom="opacity-100"
          leaveTo="opacity-0"
        >
          <div className="fixed inset-0 bg-gray-600 bg-opacity-30 transition-opacity" />
        </Transition.Child>

        <div className="fixed inset-0 z-50 overflow-y-auto dark:bg-zinc-900 text-gray-800 dark:text-white">
          <div className="flex min-h-full items-center justify-center p-4 text-center">
            <Transition.Child
              as={Fragment}
              enter="ease-out duration-300"
              enterFrom="opacity-0 scale-95"
              enterTo="opacity-100 scale-100"
              leave="ease-in duration-200"
              leaveFrom="opacity-100 scale-100"
              leaveTo="opacity-0 scale-95"
            >
              <Dialog.Panel className="bg-white dark:bg-zinc-800 rounded-lg w-full max-w-2xl p-6 space-y-4 shadow-xl border border-gray-300">
                <div className="flex justify-between items-center">
                  <Dialog.Title className="text-lg font-medium text-gray-800 dark:text-white text-left">
                    Edit SLA Rule
                  </Dialog.Title>
                  <button
                    onClick={onClose}
                    type="button"
                    className="text-gray-500 hover:text-gray-700 dark:hover:text-white text-xl font-bold"
                  >
                    &times;
                  </button>
                </div>

                {error && <div className="text-red-600 text-sm">{error}</div>}

                <form onSubmit={handleSubmit} className="space-y-4">
                  {renderSelect("SLA Policy", "sla_policy_id", setting?.sla_policies)}
                  {renderSelect("Customer Type", "customer_type_id", setting?.customer_types)}
                  {renderSelect("Priority", "priority_id", setting?.priorities)}
                  {renderSelect("Channel", "channel_id", setting?.channels)}

                  <div className="flex justify-end space-x-2 mt-4">
                    <button
                      type="button"
                      onClick={onClose}
                      className="px-4 py-2 text-white rounded bg-gray-600 dark:bg-red-600"
                      disabled={submitting}
                    >
                      Cancel
                    </button>
                    <button
                      type="submit"
                      className="px-4 py-2 rounded bg-violet-600 text-white"
                      disabled={submitting}
                    >
                      {submitting ? "Saving..." : "Save Changes"}
                    </button>
                  </div>
                </form>
              </Dialog.Panel>
            </Transition.Child>
          </div>
        </div>
      </Dialog>
    </Transition.Root>
  );
};

export default EditSLARuleModal;
