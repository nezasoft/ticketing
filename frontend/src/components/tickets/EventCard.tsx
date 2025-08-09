import React from 'react';

interface EventCardProps {
  created_at: string;
  due_date: string;
  event_type: string;
  status: string;
  policy: string;
}

const EventCard: React.FC<EventCardProps> = ({
  created_at,
  due_date,
  event_type,
  status,
  policy
}) => {
  const eventDate = new Date(created_at);
  const month = eventDate.toLocaleString('default', { month: 'short' });
  const day = eventDate.getDate();

  const statusClassMap: Record<string, string> = {
  New: 'bg-purple-100 text-purple-600',
  Pending: 'bg-yellow-100 text-yellow-600',
  Resolved: 'bg-green-100 text-green-600',
  Closed: 'bg-gray-200 text-gray-700',
};

  return (
   
    <div className="flex ">
      {/* Calendar Box */}
      <div className="flex flex-col items-center justify-center w-16 h-16 bg-violet-100 text-violet-600 font-bold rounded">
        <span className="text-xs">{month}</span>
        <span className="text-lg">{day}</span>
      </div>

      {/* Event Info */}
      <div className="ml-4 flex-1 ">
        <h6 className="text-sm font-semibold text-gray-800 mb-1">
            <span className="hover:underline">{event_type}</span>
            <span
              className={`ml-1 px-2 py-0.5 text-xs rounded-full ${
                statusClassMap[status] || 'bg-red-100 text-red-600'
              }`}
            >
              {status}
            </span>
        </h6>
        <p className="text-gray-600 mb-1 text-sm mb-1">
          SLA Policy:{' '}
          <span className="text-gray-800 underline">{policy}</span>
        </p>
        <p className="text-gray-500 mb-0 text-xs">Created At: {created_at}</p>
        <p className="text-gray-500 mb-0 text-xs">Due Date: {due_date}</p>
        <div className="border-b border-dashed my-3" />
      </div>
    </div>
  );
};

export default EventCard;
