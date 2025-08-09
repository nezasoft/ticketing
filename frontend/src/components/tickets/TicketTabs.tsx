import React from 'react';
import {
  DocumentIcon,
  CheckBadgeIcon,
  ArrowPathIcon,
  ExclamationTriangleIcon,
} from '@heroicons/react/24/outline';

type TabItem = {
  name: string;
  icon: React.ElementType;
};

const tabs: TabItem[] = [
  { name: 'Tickets Created', icon: DocumentIcon },
  { name: 'Tickets Resolved', icon: CheckBadgeIcon },
  { name: 'Tickets Reopened', icon: ArrowPathIcon },
  { name: 'Tickets Unsolved', icon: ExclamationTriangleIcon },
];

interface TicketTabsProps {
  activeTab: number;
  setActiveTab: (index: number) => void;
}

const TicketTabs: React.FC<TicketTabsProps> = ({ activeTab, setActiveTab }) => {
  return (
    <div className="flex border-b dark:border-zinc-700">
      {tabs.map((tab, index) => (
        <button
          key={tab.name}
          onClick={() => setActiveTab(index)}
          className={`flex items-center px-4 py-2 text-sm font-medium ${
            activeTab === index
              ? 'border-b-2 border-blue-500 text-blue-600 dark:text-blue-400'
              : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-white'
          }`}
        >
          <tab.icon className="h-4 w-4 mr-2" />
          {tab.name}
        </button>
      ))}
    </div>
  );
};

export default TicketTabs;
