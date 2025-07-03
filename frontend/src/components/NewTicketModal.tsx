import React, { Fragment, useState, useContext, useEffect } from "react";
import { Dialog, Transition } from '@headlessui/react';
import { TicketContext } from "../context/TicketContext";
import { Ticket } from "../types";
import { useEditor, EditorContent } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';

interface Props {
  isOpen: boolean;
  onClose: () => void;
  onCreated: () => void;
}
const NewTicketModal: React.FC<Props> = ({ isOpen, onClose, onCreated }) => {
  const { newTicket } = useContext(TicketContext);
  const [form, setForm] = useState<Partial<Ticket>>({
    subject: '',
    description: '',
    email: '',
    phone: '',
    dept_id: undefined,
    priority_id: undefined,
    channel_id: undefined,
  });
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  // Reset form when modal closes
  useEffect(() => {
    if (!isOpen) {
      setForm({
        subject: '',
        description: '',
        email: '',
        phone: '',
        dept_id: undefined,
        priority_id: undefined,
        channel_id: undefined,
      });
      setError(null);
    }
  }, [isOpen]);
  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    setForm((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  };
const editor = useEditor({
    extensions: [StarterKit],
    content: "",
    onUpdate({ editor }) {
      setForm((f) => ({ ...f, description: editor.getHTML() }));
    },
     });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitting(true);
    setError(null);
    try {
      const user = JSON.parse(localStorage.getItem('user')!);
      const payload = { company_id: user.company_id, user_id: user.id, ...form };
      const resp = await newTicket(payload);
      if (resp.success) {
        onCreated();
        onClose();
      } else {
        setError(resp.message || 'Failed to create ticket');
      }
    } catch (err: any) {
      setError(err.message || 'An error occurred');
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <Transition.Root show={isOpen} as={Fragment}>
      <Dialog as="div" className="relative z-50 dark:bg-zinc-900 text-gray-800 dark:text-white" onClose={onClose}>
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

        <div className="fixed inset-0 z-50 overflow-y-auto">
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
              <Dialog.Panel className="bg-white dark:bg-zinc-800 rounded-lg w-full max-w-2xl p-6 space-y-4 shadow-xl transform transition-all border border-gray-300">
                <Dialog.Title className="text-lg font-medium text-gray-700 dark:text-white text-left">
                  Raise New Ticket
                </Dialog.Title>

                {error && <div className="text-red-600 text-sm">{error}</div>}

                <form onSubmit={handleSubmit} className="space-y-4">
                  <div>
                    <label className="block text-sm font-medium text-left">Subject</label>
                    <input
                      name="subject"
                      value={form.subject || ''}
                      onChange={handleChange}
                      required
                      className="mt-1 block w-full border rounded p-2 bg-gray-50 dark:bg-zinc-700"
                    />
                  </div>
                  <div>
                <label className="block text-sm font-medium text-left mb-1">Description</label>
                <div className="border rounded bg-white dark:bg-zinc-700 p-2 text-black dark:text-white">
                    {editor && <EditorContent editor={editor} />}
                </div>
                </div>

                  <div>
                    <label className="block text-sm font-medium text-left">Email</label>
                    <input
                      name="email"
                      type="email"
                      value={form.email || ''}
                      onChange={handleChange}
                      required
                      className="mt-1 block w-full border rounded p-2 bg-gray-50 dark:bg-zinc-700"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-left">Phone</label>
                    <input
                      name="phone"
                      value={form.phone || ''}
                      onChange={handleChange}
                      className="mt-1 block w-full border rounded p-2 bg-gray-50 dark:bg-zinc-700"
                    />
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                      <label className="block text-sm font-medium text-left">Department</label>
                      <select
                        name="dept_id"
                        value={form.dept_id || ''}
                        onChange={handleChange}
                        required
                        className="mt-1 block w-full border rounded p-2 bg-gray-50 dark:bg-zinc-700"
                      >
                        <option value="">Select</option>
                        <option value="1">Support</option>
                        <option value="2">Management</option>
                        <option value="3">Sales</option>
                      </select>
                    </div>

                    <div>
                      <label className="block text-sm font-medium text-left">Priority</label>
                      <select
                        name="priority_id"
                        value={form.priority_id || ''}
                        onChange={handleChange}
                        required
                        className="mt-1 block w-full border rounded p-2 bg-gray-50 dark:bg-zinc-700"
                      >
                        <option value="">Select</option>
                        <option value="1">Low</option>
                        <option value="2">Medium</option>
                        <option value="3">High</option>
                      </select>
                    </div>

                    <div>
                      <label className="block text-sm font-medium text-left">Channel</label>
                      <select
                        name="channel_id"
                        value={form.channel_id || ''}
                        onChange={handleChange}
                        required
                        className="mt-1 block w-full border rounded p-2 bg-gray-50 dark:bg-zinc-700"
                      >
                        <option value="">Select</option>
                        <option value="1">Email</option>
                        <option value="2">Whatsapp</option>
                        <option value="3">Portal</option>
                      </select>
                    </div>
                  </div>

                  <div className="flex justify-end space-x-2 mt-4">
                    <button
                      type="button"
                      onClick={onClose}
                      className="px-4 py-2 text-white rounded bg-red-200 dark:bg-red-600"
                      disabled={submitting}
                    >
                      Cancel
                    </button>
                    <button
                      type="submit"
                      className="px-4 py-2 rounded bg-violet-600 text-white"
                      disabled={submitting}
                    >
                      {submitting ? 'Saving…' : 'Save'}
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

export default NewTicketModal;
