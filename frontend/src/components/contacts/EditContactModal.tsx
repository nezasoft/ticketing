import React, { Fragment, useState, useContext, useEffect } from "react";
import { Dialog, Transition } from "@headlessui/react";
import { ChannelContactContext } from "../../context/ChannelContactContext";
import { ChannelContact } from "../../types";
import { toast } from "react-toastify";

interface Props {
  isOpen: boolean;
  onClose: () => void;
  onUpdated: () => void;   // callback to refresh list
  contact: Partial<ChannelContact>;
}

const EditContactModal: React.FC<Props> = ({isOpen, onClose, onUpdated, contact}) => 
{
    const {editContact} = useContext(ChannelContactContext);
    const [form, setForm] = useState<Partial<ChannelContact>>({
        name: '',
        email: '',
        website: '',
        phone: '',
        client_no: ''
    });
    const [submitting, setSubmitting]  = useState(false);
    const [error, setError] = useState<string | null>(null);
    useEffect(()=>
    {
        if(isOpen && contact)
        {
            setForm(
                {
                    name: contact.name,
                    email: contact.email,
                    website: contact.website,
                    phone: contact.phone,
                    client_no: contact.client_no
                }
            );
        }
        if(!isOpen)
        {
            setError(null);
        }
    },[isOpen, contact]);

      const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
      ) => {
        setForm((prev) => ({ ...prev, [e.target.name]: e.target.value }));
      };
    const handleSubmit = async (e: React.FormEvent) => 
    {
        e.preventDefault();
        if(!contact || !contact.id)
        {
            console.error("No data provided to be updated");
            return ;
        }
        setSubmitting(true);
        setError(null);

        try{
            const currentUser = JSON.parse(localStorage.getItem("user")!);
            const formData = new FormData();
            formData.append("company_id",currentUser.company_id);
            formData.append("user_id",currentUser.id);
            formData.append("contactId",contact.id.toString());
            formData.append("channelId",contact.channel_id?.toString());
            Object.entries(form).forEach(([keyboard, value])=>
            {
                if(value !== undefined &&  value !==null)
                {
                    formData.append(keyboard, value as string);
                }
            });
            const response = await editContact(formData);
            if (response.success) {
                toast.success("Record updated successfully");
                onUpdated();
                onClose();
            } else {
                const message =
                typeof response.message === "string" ? response.message : Object.values(response.message || {}).join(",");
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
          <Dialog as="div" className="relative z-50" onClose={onClose} >
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
                        Edit Contact
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
                                        <label className="block text-sm font-medium text-left">Name</label>
                                        <input 
                                        autoComplete="off"
                                        name="name"
                                        value={form.name || ''}
                                        onChange={handleChange}
                                        required
                                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                                         />
                                        <label className="block text-sm font-medium text-left">Email</label>
                                        <input 
                                        autoComplete="off"
                                        type="email"
                                        name="email"
                                        value={form.email|| ''}
                                        onChange={handleChange}
                                        required
                                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                                         />
                                         <label className="block text-sm font-medium text-left">Phone</label>
                                        <input 
                                        autoComplete="off"
                                        name="phone"
                                        value={form.phone || ''}
                                        onChange={handleChange}
                                        required
                                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                                         />
                                         <input 
                                        autoComplete="off"
                                        type="text"
                                        name="website"
                                        value={form.website|| ''}
                                        onChange={handleChange}
                                        required
                                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                                         />
                                        <label className="block text-sm font-medium text-left">Client No</label>
                                        <input 
                                        autoComplete="off"
                                        name="client_no"
                                        value={form.client_no|| ''}
                                        onChange={handleChange}
                                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                                         />
                                         <label className="block text-sm font-medium text-left">Account No</label>
                    
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

export default EditContactModal;
