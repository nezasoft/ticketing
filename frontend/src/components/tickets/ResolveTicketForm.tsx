import React, { useCallback, useState } from "react";
import { CheckCircleIcon } from "@heroicons/react/24/solid";

type ResolveTicketFormProps = {
  onSubmit: (remarks: string) => void;
  isSubmitting?: boolean;
};

const ResolveTicketForm: React.FC<ResolveTicketFormProps> = ({
  onSubmit,
  isSubmitting = false,
}) => {
  const [remarks, setRemarks] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    // Trim to check for non-empty input
    if (remarks.trim() === '') {
      setError('Remarks cannot be empty.');
      return;
    }

    setError('');
    onSubmit(remarks.trim());
    setRemarks('');
  };

  return (
    <form
      onSubmit={handleSubmit}
      className="mt-6 shadow-lg rounded-lg p-4 bg-gray-50 dark:bg-zinc-800"
    >
      <label className="block text-sm font-medium text-gray-700 dark:text-white mb-2">
        Remarks
      </label>
      <textarea
        value={remarks}
        onChange={(e) => setRemarks(e.target.value)}
        placeholder="Write your remark..."
        className="w-full p-3 border border-violet-600 rounded-md text-sm text-gray-800 dark:text-white dark:bg-zinc-900"
        rows={4}
      />
      {error && (
        <p className="text-red-600 text-xs mt-1">{error}</p>
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
          <CheckCircleIcon className="w-4 h-4" />
          {isSubmitting ? 'Sending...' : 'Resolve Ticket'}
        </button>
      </div>
    </form>
  );
};

export default ResolveTicketForm;
