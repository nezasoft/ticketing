import React from 'react';

interface ProgressBarProps {
  label: string;
  value: number;
  max: number;
}

const ProgressBar: React.FC<ProgressBarProps> = ({ label, value, max }) => {
  return (
    <div className="flex items-center justify-between mb-2">
      <span className="w-20 text-sm text-gray-600 dark:text-gray-300">{label}</span>
      <div className="flex-1 mx-2 bg-gray-200 dark:bg-zinc-800 h-2 rounded">
        <div
          className="bg-blue-500 h-2 rounded"
          style={{ width: `${(value / max) * 100}%` }}
        ></div>
      </div>
      <span className="w-6 text-sm">{value}</span>
    </div>
  );
};

export default ProgressBar;
