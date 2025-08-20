import React from 'react';

const DashboardStats = () => {
  const stats = [
    {
      title: 'My Wallet',
      value: '$865.2k',
      change: '+ $20.9k',
      changeColor: 'text-green-600 bg-green-100',
      sparkColor: 'text-violet-500',
    },
    {
      title: 'Number of Trades',
      value: '6258',
      change: '- 29 Trades',
      changeColor: 'text-red-600 bg-red-100',
      sparkColor: 'text-violet-500',
    },
    {
      title: 'Invested Amount',
      value: '$4.32M',
      change: '+ $2.8k',
      changeColor: 'text-green-600 bg-green-100',
      sparkColor: 'text-violet-500',
    },
    {
      title: 'Profit Ration',
      value: '12.57%',
      change: '+ 2.95%',
      changeColor: 'text-green-600 bg-green-100',
      sparkColor: 'text-violet-500',
    },
  ];

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">
      {stats.map((stat, index) => (
        <div
          key={index}
          className="bg-white dark:bg-zinc-800 border border-gray-200 dark:border-zinc-700 rounded-lg p-4 shadow-sm"
        >
          <div className="mb-2 text-sm text-gray-600 dark:text-gray-300">{stat.title}</div>
          <div className="text-2xl font-bold text-gray-900 dark:text-white">{stat.value}</div>
          <div className="flex items-center mt-1 text-sm">
            <span
              className={`px-2 py-0.5 rounded-full text-xs font-medium ${stat.changeColor} mr-2`}
            >
              {stat.change}
            </span>
            <span className="text-gray-500 dark:text-gray-400">Since last week</span>
          </div>
          {/* Replace this with a sparkline or chart component */}
          <div className="mt-4 h-16">
            <div className={`w-full h-full border-t ${stat.sparkColor}`}>
              {/* Example placeholder line (can be replaced with a chart) */}
              <svg viewBox="0 0 100 30" className="w-full h-full stroke-current">
                <polyline
                  fill="none"
                  strokeWidth="2"
                  points="0,20 10,15 20,17 30,10 40,13 50,10 60,15 70,17 80,13 90,16 100,14"
                />
              </svg>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
};

export default DashboardStats;
