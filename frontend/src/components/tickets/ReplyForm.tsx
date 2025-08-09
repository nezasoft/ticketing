import React, { useCallback, useState } from 'react';
import { PaperAirplaneIcon } from '@heroicons/react/24/solid';

type ReplyFormProps = {
  onSubmit: (message: string, files: File[]) => void;
  isSubmitting?: boolean;
};

const ReplyForm: React.FC<ReplyFormProps> = ({ onSubmit, isSubmitting = false }) => {
  const [replyMessage, setReplyMessage] = useState('');
  const [selectedFiles, setSelectedFiles] = useState<File[]>([]);
  const [isDragging, setIsDragging] = useState(false);

  const handleFiles = useCallback((files: FileList | null) => {
    if (!files) return;
    const fileArray = Array.from(files);
    setSelectedFiles((prev) => [...prev, ...fileArray]);
  }, []);

  const handleDrop = (e: React.DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    setIsDragging(false);
    handleFiles(e.dataTransfer.files);
  };

  const handleDragOver = (e: React.DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    setIsDragging(true);
  };

  const handleDragLeave = () => {
    setIsDragging(false);
  };

  const handleFileInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    handleFiles(e.target.files);
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSubmit(replyMessage, selectedFiles);
    setReplyMessage('');
    setSelectedFiles([]);
  };

  const removeFile = (index: number) => {
    setSelectedFiles((files) => files.filter((_, i) => i !== index));
  };

  return (
    <form onSubmit={handleSubmit} className="mt-6 shadow-lg rounded-lg p-4 bg-gray-50 dark:bg-zinc-800">
      <label className="block text-sm font-medium text-gray-700 dark:text-white mb-2">Reply Message</label>
      <textarea
        value={replyMessage}
        onChange={(e) => setReplyMessage(e.target.value)}
        placeholder="Write your reply..."
        className="w-full p-3 border border-violet-600 rounded-md text-sm text-gray-800 dark:text-white dark:bg-zinc-900"
        rows={4}
        required
      />

      <div
        className={`mt-4 border-2 border-dashed rounded-md p-4 transition ${
          isDragging ? 'border-violet-500 bg-violet-50' : 'border-gray-300'
        }`}
        onDrop={handleDrop}
        onDragOver={handleDragOver}
        onDragLeave={handleDragLeave}
      >
        <label className="block text-sm font-medium text-gray-700 dark:text-white mb-2">
          Upload Files (Drag & Drop or click)
        </label>
        <input
          type="file"
          multiple
          onChange={handleFileInputChange}
          className="hidden"
          id="file-upload"
        />
        <label
          htmlFor="file-upload"
          className="block text-sm text-gray-600 cursor-pointer p-2 border border-dashed border-gray-300 rounded bg-white hover:bg-gray-50 dark:bg-zinc-900"
        >
          Click to browse files or drag them here
        </label>

        {selectedFiles.length > 0 && (
          <ul className="mt-4 space-y-2 text-sm">
            {selectedFiles.map((file, index) => (
              <li
                key={index}
                className="flex items-center justify-between bg-white dark:bg-zinc-900 px-3 py-2 rounded shadow-sm border"
              >
                <div>
                  <p className="font-medium text-gray-800 dark:text-white">{file.name}</p>
                  <p className="text-xs text-gray-500">{(file.size / 1024).toFixed(2)} KB</p>
                </div>
                <button
                  type="button"
                  onClick={() => removeFile(index)}
                  className="text-red-500 hover:text-red-700 text-xs"
                >
                  Remove
                </button>
              </li>
            ))}
          </ul>
        )}
      </div>

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
          <PaperAirplaneIcon className="w-4 h-4" />
          {isSubmitting ? 'Sending...' : 'Send Reply'}
        </button>
      </div>
    </form>
  );
};

export default ReplyForm;
