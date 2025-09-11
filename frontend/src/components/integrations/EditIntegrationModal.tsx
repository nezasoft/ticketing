import React, { Fragment, useState, useContext, useEffect } from "react";
import { Dialog, Transition } from "@headlessui/react";
import { SettingContext } from "../../context/SettingContext";
import { Integration } from "../../types";
import { toast } from "react-toastify";

interface Props {
  isOpen: boolean;
  onClose: () => void;
  onUpdated: () => void;   // callback to refresh list
  integration: Partial<Integration>;
}

const EditIntegrationModal: React.FC<Props> = ({isOpen, onClose, onUpdated, integration}) => 
{
    const {editIntegration} = useContext(SettingContext);
    const [form, setForm] = useState<Partial<Integration>>({
        code: "",
        value: "",
        company_id: undefined
    });
    const [submitting, setSubmitting]  = useState(false);
    const [error, setError] = useState<string | null>(null);
    useEffect(()=>
    {
        if(isOpen && integration)
        {
            setForm(
                {
                    code: integration.code,
                    value: integration.value
                }
            );
        }
        if(!isOpen)
        {
            setError(null);
        }
    },[isOpen, integration]);

      const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
      ) => {
        setForm((prev) => ({ ...prev, [e.target.name]: e.target.value }));
      };
    const handleSubmit = async (e: React.FormEvent) => 
    {
        e.preventDefault();
        if(!integration || !integration.id)
        {
            console.error("No record provided for updated");
            return ;
        }
        setSubmitting(true);
        setError(null);

        try{
            const currentUser = JSON.parse(localStorage.getItem("user")!);
            const formData = new FormData();
            formData.append("company_id",currentUser.company_id);
            formData.append("user_id",currentUser.id);
            formData.append("item_id",integration.id.toString());
            Object.entries(form).forEach(([keyboard, value])=>
            {
                if(value !== undefined &&  value !==null)
                {
                    formData.append(keyboard, value as string);
                }
            });
            const response = await editIntegration(formData);
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

      return (
        <Transition.Root show={isOpen} as={Fragment}>
          <Dialog as="div" className="relative z-50" onClose={() => {}}>
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
                        Edit Integration Setting
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
                      <label className="block text-sm font-medium text-left">
                        Code
                      </label>
                      <input
                        autoComplete="off"
                        name="code"
                        value={form.code || ""}
                        onChange={handleChange}
                        required
                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                      /> 
                      <label className="block text-sm font-medium text-left">
                        Value
                      </label>
                      <input
                        autoComplete="off"
                        name="value"
                        value={form.value || ""}
                        onChange={handleChange}
                        required
                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                      /> 
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

export default EditIntegrationModal;
