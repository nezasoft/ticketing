import React, { useState } from "react";
import { useNavigate } from 'react-router-dom';
import { EllipsisVerticalIcon, PrinterIcon, BarsArrowDownIcon, MagnifyingGlassIcon } from '@heroicons/react/24/solid';
import { Dialog } from '@headlessui/react';
import * as XLSX from 'xlsx';
import { saveAs } from 'file-saver';
import jsPDF from 'jspdf';
import autoTable from 'jspdf-autotable';

import DOMPurify from 'dompurify';
import Pagination from "../common/Pagination";
// Dummy types and pagination logic. Replace with actual types and data handling.
type Ticket = {
  id: number;
  ticket_no: string;
  created_at?: string;
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
  const [currentPage, setCurrentPage] = useState(1);
  const [selectedTicket, setSelectedTicket] = useState<Ticket | null>(null);
  const [searchTerm, setSearchTerm] = useState("");
  const [openDropdown, setOpenDropdown] = useState<number | null>(null);
  const [openDropdownExportOptions, setOpenDropdownExportOptions] = useState(false);
  const itemsPerPage = 10;

  const filteredTickets = tickets.filter(ticket =>
  ticket.subject?.toLowerCase().includes(searchTerm.toLowerCase()) ||
  ticket.ticket_no?.toLowerCase().includes(searchTerm.toLowerCase()) ||
  ticket.channel?.toLowerCase().includes(searchTerm.toLowerCase()) ||
  ticket.status?.toLowerCase().includes(searchTerm.toLowerCase()) ||
  ticket.email?.toLowerCase().includes(searchTerm.toLowerCase())
);

  const paginatedTickets = filteredTickets.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );
 
  const navigate = useNavigate();
  const handleView = (ticketId: number) => {
    // Navigate to the ticket detail page
    navigate(`/tickets/${ticketId}`);
  };

// Excel:
const handleExportToExcel = () => {
  // use filteredTickets to export only what the user sees
  const worksheet = XLSX.utils.json_to_sheet(
    filteredTickets.map(t => ({
      'Ticket ID': t.ticket_no,
      Subject:    t.subject || '',
      Email:      t.email   || '',
      Phone:      t.phone   || '',
      Channel:    t.channel,
      Priority:   t.priority,
      Status:     t.status,
    }))
  );

  const workbook = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(workbook, worksheet, 'Tickets');
  const excelBuffer = XLSX.write(workbook, { bookType: 'xlsx', type: 'array' });
  const blob = new Blob([excelBuffer], { type: 'application/octet-stream' });
  saveAs(blob, 'tickets.xlsx');
};

// PDF:
const handleExportToPDF = () => {
  const doc = new jsPDF();
  const tableColumn = ['Ticket ID', 'Subject', 'Email', 'Phone', 'Channel', 'Priority', 'Status'];
  const tableRows = filteredTickets.map(t => [
    t.ticket_no,
    t.subject   || '',
    t.email     || '',
    t.phone     || '',
    t.channel,
    t.priority,
    t.status,
  ]);

  autoTable(doc, {
    head: [tableColumn],
    body: tableRows,
  });

  doc.save('tickets.pdf');
};

const statusClassMap: Record<string, string> = {
  New: 'bg-purple-100 text-purple-600',
  Pending: 'bg-yellow-100 text-yellow-600',
  Resolved: 'bg-green-100 text-green-600',
  Closed: 'bg-gray-200 text-gray-700',
};
const priorityClassMap: Record<string, string> = {
  Low: 'bg-purple-100 text-purple-600',
  Medium: 'bg-yellow-100 text-yellow-600',
  High: 'bg-red-200 text-red-700',
};
  const totalPages = Math.ceil(filteredTickets.length / itemsPerPage);
  return (
    <div className="p-4">
      <div className="flex flex-wrap gap-2 items-center justify-between mb-4">
        <div className="flex">
          <div className="relative w-full md:w-64">
            <MagnifyingGlassIcon className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input
              type="text"
              placeholder="Search by Subject, Ticket ID, Channel, Status, Phone or Email"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-10 pr-3 py-2 border border-gray-300 rounded-full text-xs dark:bg-zinc-800 dark:text-white focus:outline-none focus:ring-2 focus:ring-violet-500"
            />
          </div>
        </div>
        <div className="flex gap-2">
          <div className="relative">
            <input
              type="date"
              className="border rounded px-2 mr-2 py-2 text-sm text-violet-500 dark:text-gray-200 dark:bg-zinc-800 dark:border-zinc-700"
            />
            <button
              className="bg-violet-500 text-white border px-4 py-2 rounded text-sm"
              onClick={() => setOpenDropdownExportOptions(prev => !prev)}
            >
              <BarsArrowDownIcon className="w-4 h-4" />
            </button>
            {openDropdownExportOptions && (
              <div className="absolute right-0 mt-2 w-28 bg-white dark:bg-zinc-800 shadow-lg rounded-md text-sm border dark:border-zinc-700 z-50">
                <button className="block w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-left" onClick={handleExportToExcel}>
                  Excel
                </button>
                <button className="block w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-left" onClick={handleExportToPDF}>
                  Pdf
                </button>
              </div>
            )}
          </div>
          <button className="bg-violet-500 text-white border px-4 py-2 rounded text-sm"> <PrinterIcon className="w-4 h-4" /></button>
        </div>
      </div>
      <div className="overflow-x-auto bg-white dark:bg-zinc-900 rounded-lg shadow">
        <table className="min-w-full text-sm text-gray-700 dark:text-gray-200">
          <thead className="bg-gray-100 dark:bg-zinc-800">
            <tr className="text-xs">
              <th className="px-4 py-3 text-left">Ticket ID</th>
              <th className="px-4 py-3 text-left">Date / Time</th>
              <th className="px-4 py-3 text-left">Subject</th>
              <th className="px-4 py-3 text-left">Channel</th>
              <th className="px-4 py-3 text-left">Priority</th>
              <th className="px-4 py-3 text-left">Status</th>
              <th className="px-4 py-3 text-left">Action</th>
            </tr>
          </thead>
          <tbody>
            {paginatedTickets.map(ticket => (
              <tr
                key={ticket.id}
                onClick={() => handleView(ticket.id)}
                className="hover:bg-gray-50 dark:hover:bg-zinc-800 text-xs"
              >
                <td
                  className="px-4 py-3 text-violet-600 font-semibold cursor-pointer"
                  onClick={() => setSelectedTicket(ticket)}
                >
                  #{ticket.ticket_no}
                </td>
                <td className="px-4 py-3">{ticket.created_at}</td>
                <td className="px-4 py-3">{ticket.subject}</td>
                <td className="px-4 py-3">{ticket.channel}</td>
                <td className="px-4 py-3">
                  <span className={`px-2 py-1 text-xs rounded-full font-medium ${ priorityClassMap[ticket.priority] || 'bg-red-100 text-red-600'}`}>
                    {ticket.priority}
                  </span>
                </td>
                <td className="px-4 py-3">
                   <span className={`px-2 py-1 text-xs rounded font-medium ${ statusClassMap[ticket.status] || 'bg-red-100 text-red-600'}`}>
                    {ticket.status}
                  </span>
                </td>
                <td className="relative px-4 py-3">
                  <button
                     onClick={(e) => {
                        e.stopPropagation(); // Prevent row click
                        setOpenDropdown(openDropdown === ticket.id ? null : ticket.id);
                      }}
                      className="flex items-center gap-1 text-sm px-3 py-1 rounded bg-gray-100 hover:bg-gray-200 dark:bg-zinc-700 dark:hover:bg-zinc-600"
                  >
                    <EllipsisVerticalIcon className="w-4 h-4" />
                  </button>
                  {openDropdown === ticket.id && (
                    <div className="absolute right-0 mt-2 w-28 bg-white dark:bg-zinc-800 shadow-lg rounded-md text-sm border dark:border-zinc-700 z-50">
                      <button onClick={() => handleView(ticket.id)} className="block w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-left">View</button>
                    </div>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      {/* Pagination */}
      <Pagination 
        currentPage={currentPage}
        totalPages={totalPages}
        totalItems={filteredTickets.length}
        itemsPerPage={itemsPerPage}
        onPageChange={setCurrentPage}
      />
      {/* Modal */}
      <Dialog open={!!selectedTicket} onClose={() => setSelectedTicket(null)} className="fixed z-50 inset-0 overflow-y-auto dark:bg-zinc-900 text-gray-800 dark:text-white">
        <div className="flex items-center justify-center min-h-screen p-4">
          <Dialog.Panel className="bg-white dark:bg-zinc-900 p-6 rounded-lg shadow-xl w-full max-w-md">
            <Dialog.Title className="text-lg font-semibold mb-4">Ticket Details</Dialog.Title>
            {selectedTicket && (
              <div className="space-y-2 text-sm">
                <div><strong>Subject:</strong> {selectedTicket.subject}</div>
                <div><strong>Email:</strong> {selectedTicket.email}</div>
                <div><strong>Phone:</strong> {selectedTicket.phone}</div>
                <div><strong>Priority:</strong> {selectedTicket.priority}</div>
                <div><strong>Status:</strong> {selectedTicket.status}</div>
                <div><strong>Description:</strong>  <p className="text-gray-500 text-xs" dangerouslySetInnerHTML={{ __html: DOMPurify.sanitize(selectedTicket.description) }}></p></div>
              </div>
            )}
            <div className="mt-4 text-right">
              <button onClick={() => setSelectedTicket(null)} className="px-4 py-2 rounded bg-red-700">Close</button>
            </div>
          </Dialog.Panel>
        </div>
      </Dialog>
    </div>
  );
};
export default TicketList;
