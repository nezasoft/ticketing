import React, { Fragment, useState, useContext, useEffect, DragEvent } from 'react';
import { Dialog, Transition } from '@headlessui/react';
import { TicketContext } from '../../context/TicketContext';
import { Ticket } from '../../types';
import { CKEditor } from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import { SettingContext } from '../../context/SettingContext';
import Select from 'react-select';
import { toast } from 'react-toastify';
import { TicketIcon } from "@heroicons/react/24/solid";
interface Props {
  isOpen: boolean;
  onClose: () => void;
  onCreated: () => void;
}

const NewTicketModal: React.FC<Props> = ({ isOpen, onClose, onCreated }) => {
  const { newTicket } = useContext(TicketContext);
  const { setting } = useContext(SettingContext);

  const [form, setForm] = useState<Partial<Ticket>>({
    subject: '',
    description: '',
    email: '',
    phone: '',
    name: '',
    dept_id: undefined,
    priority_id: undefined,
    channel_id: undefined,
    customer_id: undefined,
    customer_type: 0,
  });

  const [files, setFiles] = useState<File[]>([]);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [isExistingCustomer, setIsExistingCustomer] = useState(false);
  const [selectedCustomer, setSelectedCustomer] = useState<any>(null);

  useEffect(() => {
    if (!isOpen) {
      setForm({
        subject: '',
        description: '',
        email: '',
        phone: '',
        name:'',
        dept_id: undefined,
        priority_id: undefined,
        channel_id: undefined,
        customer_type: 0,
      });
      setFiles([]);
      setSelectedCustomer(null);
      setIsExistingCustomer(false);
      setError(null);
    }
  }, [isOpen]);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    setForm((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitting(true);
    setError(null);

    try {
      const user = JSON.parse(localStorage.getItem('user')!);
      const formData = new FormData();
      formData.append('company_id', user.company_id);
      formData.append('user_id', user.id);

      Object.entries(form).forEach(([key, value]) => {
        if (value !== undefined && value !== null) {
          formData.append(key, value as string);
        }
      });

      files.forEach((file, i) => {
        formData.append(`attachments[${i}]`, file);
      });

      const response = await newTicket(formData);

      if (response.success) {
        toast.success('Ticket raised successfully');
        onCreated();
        onClose();
      } else {
        const message =
          typeof response.message === 'string'
            ? response.message
            : Object.values(response.message || {}).join(', ');
        toast.error(message || 'Failed to raise new ticket');
      }
    } catch (err: any) {
      toast.error(err.message || 'Unexpected error occurred');
    } finally {
      setSubmitting(false);
    }
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files) {
      setFiles([...files, ...Array.from(e.target.files)]);
    }
  };

  const handleDrop = (e: DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    e.stopPropagation();
    if (e.dataTransfer.files) {
      setFiles([...files, ...Array.from(e.dataTransfer.files)]);
    }
  };

  const handleDragOver = (e: DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    e.stopPropagation();
  };

  const removeFile = (index: number) => {
    setFiles((prev) => prev.filter((_, i) => i !== index));
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
                    Raise New Ticket
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
                  <div className="flex items-center gap-4 mb-2">
                    <label className="text-sm font-medium">Is Existing Customer?</label>
                    <input
                      type="checkbox"
                      checked={isExistingCustomer}
                      onChange={(e) => {
                        const checked = e.target.checked;
                        setIsExistingCustomer(checked);
                        setForm((prev) => ({
                          ...prev,
                          customer_type: checked ? 1 : 0,
                        }));
                      }}
                      className="w-4 h-4"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-left">Subject</label>
                    <input
                      autoComplete="off"
                      name="subject"
                      value={form.subject || ''}
                      onChange={handleChange}
                      required
                      className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-left mb-1">Description</label>
                    <CKEditor
                      editor={ClassicEditor as any}
                      data={form.description || ''}
                      onChange={(_, editor) => {
                        const data = editor.getData();
                        setForm((prev) => ({ ...prev, description: data }));
                      }}
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-left">Attachments</label>
                    <div
                      onDrop={handleDrop}
                      onDragOver={handleDragOver}
                      className="border-2 border-dashed border-gray-200 p-4 rounded bg-white dark:bg-zinc-700 text-center cursor-pointer"
                    >
                      <input
                        type="file"
                        multiple
                        className="hidden"
                        id="fileUpload"
                        onChange={handleFileChange}
                      />
                      <label htmlFor="fileUpload" className="cursor-pointer text-sm text-gray-600">
                        Click to select files or drag and drop here
                      </label>
                      {files.length > 0 && (
                        <ul className="mt-2 text-xs text-left">
                          {files.map((file, idx) => (
                            <li key={idx} className="flex justify-between items-center">
                              {file.name}
                              <button
                                type="button"
                                onClick={() => removeFile(idx)}
                                className="text-red-500 hover:text-red-700 text-xs ml-2"
                              >
                                Remove
                              </button>
                            </li>
                          ))}
                        </ul>
                      )}
                    </div>
                  </div>

                  {isExistingCustomer && (
                    <div>
                      <label className="block text-sm font-medium text-left">Customer</label>
                      <Select
                        options={setting?.customers?.map((c) => ({
                          value: c.id,
                          label: `${c.name} (${c.account_no} - ${c.phone})`,
                          email: c.email,
                          phone: c.phone,
                        }))}
                        value={selectedCustomer}
                        onChange={(selected) => {
                          setSelectedCustomer(selected);
                          setForm((prev) => ({
                            ...prev,
                            email: selected?.email || '',
                            phone: selected?.phone || '',
                            name: selected?.name || '',
                            customer_id: selected?.value,
                          }));
                        }}
                        placeholder="Select customer..."
                        isClearable
                        className="react-select-container"
                        classNamePrefix="react-select"
                      />
                    </div>
                  )}

                  <label className="block text-sm font-medium text-left">Full Name</label>
                  <input
                    name="name"
                    value={form.name || ''}
                    autoComplete="off"
                    onChange={handleChange}
                    disabled={isExistingCustomer}
                    className="mt-1 block w-full border-gray-200 border rounded p-2 bg-gray-50 dark:bg-zinc-700"
                  />

                  <label className="block text-sm font-medium text-left">Email</label>
                  <input
                    name="email"
                    type="email"
                    autoComplete="off"
                    value={form.email || ''}
                    onChange={handleChange}
                    required
                    disabled={isExistingCustomer}
                    className="mt-1 block w-full border-gray-200 border rounded p-2 bg-gray-50 dark:bg-zinc-700"
                  />

                  <label className="block text-sm font-medium text-left">Phone</label>
                  <input
                    name="phone"
                    value={form.phone || ''}
                    autoComplete="off"
                    onChange={handleChange}
                    disabled={isExistingCustomer}
                    className="mt-1 block w-full border-gray-200 border rounded p-2 bg-gray-50 dark:bg-zinc-700"
                  />

                  <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                      <label className="block text-sm font-medium text-left">Department</label>
                      <select
                        name="dept_id"
                        value={form.dept_id || ''}
                        onChange={handleChange}
                        required
                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                      >
                        <option value="">Select</option>
                        {setting?.departments?.map((d) => (
                          <option key={d.id} value={d.id}>
                            {d.name}
                          </option>
                        ))}
                      </select>
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-left">Priority</label>
                      <select
                        name="priority_id"
                        value={form.priority_id || ''}
                        onChange={handleChange}
                        required
                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                      >
                        <option value="">Select</option>
                        {setting?.priorities?.map((p) => (
                          <option key={p.id} value={p.id}>
                            {p.name}
                          </option>
                        ))}
                      </select>
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-left">Channel</label>
                      <select
                        name="channel_id"
                        value={form.channel_id || ''}
                        onChange={handleChange}
                        required
                        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
                      >
                        <option value="">Select</option>
                        {setting?.channels?.map((c) => (
                          <option key={c.id} value={c.id}>
                            {c.name}
                          </option>
                        ))}
                      </select>
                    </div>
                  </div>

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
                      {submitting && (
                        <svg
                          className="animate-spin h-4 w-4 text-white"
                          xmlns="http://www.w3.org/2000/svg"
                          fill="none"
                          viewBox="0 0 24 24"
                        >
                          <circle
                            className="opacity-25"
                            cx="12"
                            cy="12"
                            r="10"
                            stroke="currentColor"
                            strokeWidth="4"
                          ></circle>
                          <path
                            className="opacity-75"
                            fill="currentColor"
                            d="M4 12a8 8 0 018-8v8H4z"
                          ></path>
                        </svg>
                      )}
                      {submitting ? 'Sending...' : 'Save'}
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
