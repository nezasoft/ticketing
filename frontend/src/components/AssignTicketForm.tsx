import React, { useContext, useState } from 'react';
import { UserPlusIcon } from '@heroicons/react/24/solid';
import { SettingContext } from '../context/SettingContext';

type AssignTicketFormProps = {
  onSubmit: (remarks: string, user_id: string) => void;
  isSubmitting?: boolean;
};

const AssignTicketForm: React.FC<AssignTicketFormProps> = ({
  onSubmit,
  isSubmitting = false
}) => {
  const [user_id, setUserId] = useState('');
  const [remarks, setRemarks] = useState('');
  const [errors, setErrors] = useState<{ user_id?: string; remarks?: string }>({});
  const { setting } = useContext(SettingContext);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    let formErrors: { user_id?: string; remarks?: string } = {};

    if (!user_id) {
      formErrors.user_id = 'Please select a user.';
    }

    if (!remarks.trim()) {
      formErrors.remarks = 'Remarks cannot be empty.';
    }

    if (Object.keys(formErrors).length > 0) {
      setErrors(formErrors);
      return;
    }

    setErrors({});
    onSubmit(user_id, remarks.trim());
    setRemarks('');
  };

  return (
    <form
      onSubmit={handleSubmit}
      className="mt-6 shadow-lg rounded-lg p-4 bg-gray-50 dark:bg-zinc-800"
    >
      <label className="block text-sm font-medium text-gray-700 dark:text-white mb-2">User</label>
      <select
        className="mt-1 block w-full border border-gray-200 rounded p-2 bg-gray-50 dark:bg-zinc-700"
        name="user_id"
        onChange={(e) => setUserId(e.target.value)}
        value={user_id}
      >
        <option value="">Select</option>
        {Array.isArray(setting?.users) &&
          setting?.users.map((u) => (
            <option key={u.id} value={u.id}>
              {u.name}
            </option>
          ))}
      </select>
      {errors.user_id && (
        <p className="text-red-600 text-xs mt-1">{errors.user_id}</p>
      )}

      <label className="block text-sm font-medium text-gray-700 dark:text-white mt-4 mb-2">
        Remarks
      </label>
      <textarea
        name="remarks"
        value={remarks}
        onChange={(e) => setRemarks(e.target.value)}
        placeholder="Write your remarks..."
        className="w-full p-3 border border-violet-600 rounded-md text-sm text-gray-800 dark:text-white dark:bg-zinc-900"
        rows={4}
      />
      {errors.remarks && (
        <p className="text-red-600 text-xs mt-1">{errors.remarks}</p>
      )}

      <div className="mt-4 flex justify-end">
        <button
          type="submit"
          disabled={isSubmitting}
          className="flex items-center gap-2 text-sm border px-4 py-2 text-white bg-violet-600 rounded hover:bg-violet-700 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {isSubmitting && (
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
          <UserPlusIcon className="w-4 h-4" />
          {isSubmitting ? 'Assigning...' : 'Assign Ticket'}
        </button>
      </div>
    </form>
  );
};

export default AssignTicketForm;
