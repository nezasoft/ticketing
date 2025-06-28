import React, { useState } from "react";
import { ArrowUpIcon, ArrowDownIcon } from '@heroicons/react/24/solid';

type Ticket = {
  id: number;
  ticket_no: string;
  email?: string;
  phone?: string;
  subject?: string;
  description: string;
  priority: string;
  status: string;
  channel: string;
  dept: string;
  company: string;
};

type TicketListProps = {
  tickets: Ticket[];
};

const TicketList: React.FC<TicketListProps> = ({ tickets }) => {
  const [openMenu, setOpenMenu] = useState<number | null>(null);

  return (
    <div className="w-full h-full p-6 bg-white dark:bg-zinc-900 text-gray-900 dark:text-gray-100">
      <div className="flex flex-wrap items-center justify-between mb-4">
        <h2 className="text-xl font-semibold">Tickets</h2>
        <div className="flex flex-wrap gap-2 items-center">
          <button className="bg-violet-500 text-white px-4 py-2 rounded font-medium hover:bg-violet-600">
            + Raise Ticket
          </button>
          <input
            type="date"
            className="border rounded px-4 py-2 text-sm text-gray-600 dark:text-gray-200 dark:bg-zinc-800 dark:border-zinc-700"
          />
          <button className="p-2 rounded hover:bg-gray-100 dark:hover:bg-zinc-700">
            ...
          </button>
        </div>
      </div>

      <div className="overflow-x-auto bg-white dark:bg-zinc-800 rounded shadow border dark:border-zinc-700 w-full h-full">
        <table className="min-w-full divide-y divide-gray-200 dark:divide-zinc-700 text-sm">
          <thead className="bg-gray-50 dark:bg-zinc-700">
            <tr>
              <th className="p-3">
                <input type="checkbox" />
              </th>
              <th className="p-3 text-left font-medium text-gray-500 dark:text-gray-300">Ticket ID</th>
              <th className="p-3 text-left font-medium text-gray-500 dark:text-gray-300">Channel</th>
              <th className="p-3 text-left font-medium text-gray-500 dark:text-gray-300">Subject</th>
              <th className="p-3 text-left font-medium text-gray-500 dark:text-gray-300">Email</th>
              <th className="p-3 text-left font-medium text-gray-500 dark:text-gray-300">Phone</th>
              <th className="p-3 text-left font-medium text-gray-500 dark:text-gray-300">Department</th>
              <th className="p-3 text-left font-medium text-gray-500 dark:text-gray-300">Priority</th>
              <th className="p-3 text-left font-medium text-gray-500 dark:text-gray-300">Status</th>
              <th className="p-3 text-left font-medium text-gray-500 dark:text-gray-300">Action</th>
            </tr>
          </thead>
          <tbody>
            {tickets.map((ticket, idx) => (
              <tr key={ticket.id} className="border-b hover:bg-gray-50 dark:hover:bg-zinc-700 dark:border-zinc-700">
                <td className="p-3">
                  <input type="checkbox" />
                </td>
                <td className="p-3 font-semibold text-violet-700 dark:text-violet-400">{ticket.ticket_no}</td>
                <td className="p-3">{ticket.channel}</td>
                <td className="p-3">{ticket.subject}</td>
                <td className="p-3">{ticket.email}</td>
                <td className="p-3">{ticket.phone}</td>
                <td className="p-3">{ticket.dept}</td>
                <td className="p-3">
                  <span
                    className={`px-2 py-1 text-xs rounded font-semibold ${
                      ticket.priority === "High"
                        ? "bg-red-100 text-red-700 dark:bg-red-800 dark:text-red-200"
                        : "bg-yellow-100 text-yellow-700 dark:bg-yellow-700 dark:text-yellow-100"
                    }`}
                  >
                    {ticket.priority}
                  </span>
                </td>
                <td className="p-3">
                  <span
                    className={`px-2 py-1 text-xs rounded font-semibold ${
                      ticket.status === "closed"
                        ? "bg-green-100 text-green-700 dark:bg-green-800 dark:text-green-200"
                        : "bg-yellow-100 text-yellow-700 dark:bg-yellow-700 dark:text-yellow-100"
                    }`}
                  >
                    {ticket.status}
                  </span>
                </td>
                <td className="p-3">
                  <button className="flex items-center gap-2 px-3 py-1 rounded bg-gray-100 hover:bg-gray-200 dark:bg-zinc-700 dark:hover:bg-zinc-600 text-sm">
                    <ArrowDownIcon className="w-4 h-4" />
                    Pdf
                  </button>
                </td>
                <td className="p-3 relative">
                  <button
                    className="p-2 hover:bg-gray-200 dark:hover:bg-zinc-700 rounded"
                    onClick={() => setOpenMenu(prev => (prev === idx ? null : idx))}
                  >
                    <ArrowUpIcon className="w-4 h-4" />
                  </button>
                  {openMenu === idx && (
                    <div className="absolute right-0 mt-2 w-32 bg-white dark:bg-zinc-800 border rounded shadow z-10 dark:border-zinc-600">
                      <button className="w-full text-left px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-sm">
                        Edit
                      </button>
                      <button className="w-full text-left px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-sm">
                        Print
                      </button>
                      <button className="w-full text-left px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-sm text-red-500">
                        Delete
                      </button>
                    </div>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default TicketList;
