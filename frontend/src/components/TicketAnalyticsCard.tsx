import React, { useState } from 'react';
import TicketTabs from './TicketTabs';
import ProgressBar from './ProgressBar';

const dummyData = {
  source: { Email: 50, Phone: 20, Website: 75, Chat: 30 },
  priority: { Urgent: 85, Medium: 40, High: 90, Low: 20 },
  status: { Open: 50 },
  category: { Question: 15 },
};

const TicketAnalyticsCard: React.FC = () => {
  const [activeTab, setActiveTab] = useState(3); // default Tickets Unsolved

  return (
    <div className="bg-white dark:bg-zinc-900 shadow rounded-md p-4">
      {/* Tabs */}
      <TicketTabs activeTab={activeTab} setActiveTab={setActiveTab} />

      {/* Content */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
        {/* Left */}
        <div>
          <h4 className="font-semibold text-sm mb-2">Tickets unsolved Split by Source</h4>
          {Object.entries(dummyData.source).map(([k, v]) => (
            <ProgressBar key={k} label={k} value={v} max={100} />
          ))}
          <div className="border-t my-4 dark:border-zinc-700"></div>
          <h4 className="font-semibold text-sm mb-2">Tickets unsolved Split by Status</h4>
          {Object.entries(dummyData.status).map(([k, v]) => (
            <ProgressBar key={k} label={k} value={v} max={100} />
          ))}
        </div>

        {/* Right */}
        <div>
          <h4 className="font-semibold text-sm mb-2">Tickets unsolved Split by Priority</h4>
          {Object.entries(dummyData.priority).map(([k, v]) => (
            <ProgressBar key={k} label={k} value={v} max={100} />
          ))}
          <div className="border-t my-4 dark:border-zinc-700"></div>
          <h4 className="font-semibold text-sm mb-2">Tickets unsolved Split by Category</h4>
          {Object.entries(dummyData.category).map(([k, v]) => (
            <ProgressBar key={k} label={k} value={v} max={100} />
          ))}
        </div>
      </div>

      {/* Footer */}
      <div className="flex justify-between items-center mt-4">
        <button className="text-sm border px-3 py-1 rounded dark:bg-zinc-800 dark:border-zinc-700">
          Last 7 days ▼
        </button>
        <a href="#" className="text-blue-500 text-sm hover:underline">
          View all →
        </a>
      </div>
    </div>
  );
};

export default TicketAnalyticsCard;
