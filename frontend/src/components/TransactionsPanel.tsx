import React from 'react';
import { ArrowUpIcon, ArrowDownIcon } from '@heroicons/react/24/solid';

interface Transaction {
  type: string;
  coin: string;
  value: string;
  amount: string;
  date: string;
  up: boolean;
}

interface Activity {
  icon: React.JSX.Element;
  date: string;
  address: string;
  amount: string;
  value: string;
}

const transactions: Transaction[] = [
  { type: 'Buy', coin: 'BTC', value: '0.016 BTC', amount: '$125.20', date: '14 Mar, 2021', up: true },
  { type: 'Sell', coin: 'ETH', value: '0.56 ETH', amount: '$112.34', date: '15 Mar, 2021', up: false },
  { type: 'Buy', coin: 'LTC', value: '1.88 LTC', amount: '$94.22', date: '16 Mar, 2021', up: true },
  { type: 'Buy', coin: 'ETH', value: '0.42 ETH', amount: '$84.32', date: '17 Mar, 2021', up: true },
  { type: 'Sell', coin: 'BTC', value: '0.018 BTC', amount: '$145.80', date: '18 Mar, 2021', up: false },
  { type: 'Buy', coin: 'BTC', value: '0.016 BTC', amount: '$125.20', date: '18 Mar, 2021', up: true },
];

const activities: Activity[] = [
  { icon: <ArrowUpIcon className="h-5 w-5 text-green-500" />, date: '24/05/2021, 18:24:56', address: '0xb77a...dad', amount: '+0.5 BTC', value: '$178.53' },
  { icon: <ArrowDownIcon className="h-5 w-5 text-red-500" />, date: '24/05/2021, 18:24:56', address: '0xb77a...dad', amount: '-20.5 ETH', value: '$3541.45' },
  { icon: <ArrowUpIcon className="h-5 w-5 text-green-500" />, date: '24/05/2021, 18:24:56', address: '0xb77a...dad', amount: '+0.5 BTC', value: '$5791.45' },
  { icon: <ArrowDownIcon className="h-5 w-5 text-red-500" />, date: '24/05/2021, 18:24:56', address: '0xb77a...dad', amount: '-1.5 LTC', value: '$5791.45' },
  { icon: <ArrowUpIcon className="h-5 w-5 text-green-500" />, date: '24/05/2021, 18:24:56', address: '0xb77a...dad', amount: '+0.5 BTC', value: '$5791.45' },
];

const TransactionsPanel: React.FC = () => {
  return (
    <div className="container mx-auto  mt-2">
      <div className="flex flex-col md:flex-row gap-6">
        {/* Transactions */}
        <div className="flex-1 bg-white dark:bg-zinc-800 dark:text-white rounded p-4 shadow">
          <div className="flex justify-between items-center border-b dark:border-zinc-700 pb-2 mb-4">
            <h3 className="text-lg font-semibold">Transactions</h3>
            <div className="flex gap-2 text-sm text-violet-500">
              <button className="font-medium hover:underline">All</button>
              <button className="hover:text-violet-400">Sell</button>
              <button className="hover:text-violet-400">Buy</button>
            </div>
          </div>
          {transactions.map((tx, index) => (
            <div
              key={index}
              className="flex justify-between items-center py-3 border-b last:border-b-0 border-gray-100 dark:border-zinc-700"
            >
              <div className="flex items-center gap-2">
                {tx.up ? (
                  <ArrowUpIcon className="h-5 w-5 text-green-500" />
                ) : (
                  <ArrowDownIcon className="h-5 w-5 text-red-500" />
                )}
                <div>
                  <p className="font-medium">{tx.type} {tx.coin}</p>
                  <p className="text-xs text-gray-500 dark:text-gray-400">{tx.date}</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium">{tx.value}</p>
                <p className="text-xs text-gray-500 dark:text-gray-400">Coin Value</p>
              </div>
              <div className="text-right">
                <p className="font-medium">{tx.amount}</p>
                <p className="text-xs text-gray-500 dark:text-gray-400">Amount</p>
              </div>
            </div>
          ))}
        </div>

        {/* Activity */}
        <div className="flex-1 bg-white dark:bg-zinc-800 dark:text-white rounded p-4 shadow">
          <div className="flex justify-between items-center border-b dark:border-zinc-700 pb-2 mb-4">
            <h3 className="text-lg font-semibold">Recent Activity</h3>
            <select className="text-sm border rounded px-2 py-1 bg-white dark:bg-zinc-700 dark:border-zinc-600 dark:text-white">
              <option>Today</option>
              <option>Yesterday</option>
              <option>This Week</option>
            </select>
          </div>
          <div className="space-y-4">
            {activities.map((activity, index) => (
              <div key={index} className="flex gap-3 items-center">
                <div>{activity.icon}</div>
                <div className="flex-1">
                  <p className="text-sm text-gray-700 dark:text-gray-300">{activity.date}</p>
                  <p className="text-xs text-gray-400">{activity.address}</p>
                </div>
                <div className="text-right">
                  <p className="font-medium">{activity.amount}</p>
                  <p className="text-sm text-gray-500 dark:text-gray-400">{activity.value}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default TransactionsPanel;
