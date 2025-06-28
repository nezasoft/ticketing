
import React from 'react';
import {
  PieChart, Pie, Cell, Tooltip, ResponsiveContainer, Label,
} from 'recharts';

const data = [
  { name: 'Bitcoin', value: 4025.32, color: '#34d399', unit: 'BTC', amount: 0.4412 },
  { name: 'Ethereum', value: 1123.64, color: '#6366f1', unit: 'ETH', amount: 4.5701 },
  { name: 'Litecoin', value: 2263.09, color: '#60a5fa', unit: 'LTC', amount: 35.3811 },
];

const WalletBalance: React.FC = () => {
  const total = data.reduce((sum, d) => sum + d.value, 0);

  return (
    <div className="bg-white dark:bg-zinc-800 dark:text-white rounded p-4 shadow mt-2">
      <div className="flex justify-between items-start mb-4">
        <h2 className="text-lg font-semibold text-gray-800 dark:text-white">Wallet Balance</h2>
        <div className="space-x-2">
          {['ALL', '1M', '6M', '1Y'].map((label, idx) => (
            <button
              key={idx}
              className={`text-sm px-3 py-1 rounded ${
                label === '1M'
                  ? 'bg-indigo-100 text-indigo-600 font-medium'
                  : 'bg-gray-100 dark:bg-zinc-700 dark:text-gray-200'
              }`}
            >
              {label}
            </button>
          ))}
        </div>
      </div>

      <div className="flex flex-wrap md:flex-nowrap gap-8">
        {/* Pie Chart */}
        <div className="w-full md:w-1/2 h-[250px]">
          <ResponsiveContainer width="100%" height="100%">
            <PieChart>
              <Pie
                data={data}
                dataKey="value"
                nameKey="name"
                cx="50%"
                cy="50%"
                outerRadius={80}
                label={({ percent }) => `${((percent ?? 0) * 100).toFixed(1)}%`}
                >
                {data.map((entry, index) => (
                    <Cell key={index} fill={entry.color} />
                ))}
            </Pie>
              <Tooltip formatter={(value: any) => `$${value.toFixed(2)}`} />
            </PieChart>
          </ResponsiveContainer>
        </div>

        {/* Legend / Values */}
        <div className="w-full md:w-1/2 space-y-5">
          {data.map((item, idx) => (
            <div key={idx} className="flex items-start space-x-3">
              <span
                className="inline-block mt-1 w-2.5 h-2.5 rounded-full"
                style={{ backgroundColor: item.color }}
              ></span>
              <div>
                <p className="text-gray-800 dark:text-white font-medium">{item.name}</p>
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  <span className="font-bold">{item.amount}</span> {item.unit} = ${item.value.toLocaleString()}
                </p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default WalletBalance;
