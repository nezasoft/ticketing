import React, { Fragment, useState, useContext, useEffect } from "react";
import { Dialog, Transition } from "@headlessui/react";
import { SettingContext } from "../../context/SettingContext";
import { SLAContext } from "../../context/SLAContext";
import { SLARule } from "../../types";
import { toast } from "react-toastify";

interface Props {
  isOpen: boolean;
  onClose: () => void;
  onCreated: () => void;
}

const NewSLARuleModal: React.FC<Props> = ({ isOpen, onClose, onCreated }) => {
  const { newSLARule } = useContext(SLAContext);
  const { setting } = useContext(SettingContext);

  const [form, setForm] = useState<Partial<SLARule>>({
    sla_policy_id: undefined,
    customer_type_id: undefined,
    priority_id: undefined,
    channel_id: undefined,
  });

  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!isOpen) {
      // Reset form when modal closes
      setForm({
        sla_policy_id: undefined,
        customer_type_id: undefined,
        priority_id: undefined,
        channel_id: undefined,
      });
      setError(null);
    }
  }, [isOpen]);

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    setForm((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitting(true);
    setError(null);

    try {
      const storedUser = localStorage.getItem("user");
      if (!storedUser) {
        throw new Error("User not found in localStorage");
      }
      const user = JSON.parse(storedUser);

      const formData = new FormData();
      formData.append("company_id", String(user.company_id));
      formData.append("user_id", String(user.id));

      Object.entries(form).forEach(([key, value]) => {
        if (value !== undefined && value !== null && String(value) !== "") {
          formData.append(key, String(value));
        }
      });

      const response = await newSLARule(formData);

      if (response.success) {
        toast.success("Record created successfully");
        onCreated();
        onClose();
      } else {
        const message =
          typeof response.message === "string"
            ? response.message
            : Object.values(response.message || {}).join(",");
        toast.error(message || "Failed to create a new record");
      }
    } catch (err: any) {
      toast.error(err.message || "Unexpected error occurred");
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <Transition.Root show={isOpen} as={Fragment}>
      <Dialog
        as="div"
        className="relative z-50"
        onClose={onClose} // ✅ allow backdrop/Escape close
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
                    Create SLA Rule
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
                  {/* SLA Policy */}
                  <div>
                    <label className="block text-sm font-medium text-left">
                      SLA Policy
                    </label>
                    <select
                      name="sla_policy_id"
                      value={form.sla_policy_id || ""}
                      onChange={handleChange}
                      required
                      className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                    >
                      <option value="">Select</option>
                      {setting?.sla_policies?.map((d) => (
                        <option key={d.id} value={d.id}>
                          {d.name}
                        </option>
                      ))}
                    </select>
                  </div>

                  {/* Customer Type */}
                  <div>
                    <label className="block text-sm font-medium text-left">
                      Customer Type
                    </label>
                    <select
                      name="customer_type_id"
                      value={form.customer_type_id || ""}
                      onChange={handleChange}
                      required
                      className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                    >
                      <option value="">Select</option>
                      {setting?.customer_types?.map((d) => (
                        <option key={d.id} value={d.id}>
                          {d.name}
                        </option>
                      ))}
                    </select>
                  </div>

                  {/* Priority */}
                  <div>
                    <label className="block text-sm font-medium text-left">
                      Priority
                    </label>
                    <select
                      name="priority_id"
                      value={form.priority_id || ""}
                      onChange={handleChange}
                      required
                      className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                    >
                      <option value="">Select</option>
                      {setting?.priorities?.map((d) => (
                        <option key={d.id} value={d.id}>
                          {d.name}
                        </option>
                      ))}
                    </select>
                  </div>

                  {/* Channel */}
                  <div>
                    <label className="block text-sm font-medium text-left">
                      Channel
                    </label>
                    <select
                      name="channel_id"
                      value={form.channel_id || ""}
                      onChange={handleChange}
                      required
                      className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                    >
                      <option value="">Select</option>
                      {setting?.channels?.map((d) => (
                        <option key={d.id} value={d.id}>
                          {d.name}
                        </option>
                      ))}
                    </select>
                  </div>

                  {/* Buttons */}
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

export default NewSLARuleModal;
