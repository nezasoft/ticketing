import React, { useState, useContext } from "react";
import { useNavigate } from 'react-router-dom';
import { EllipsisVerticalIcon, PrinterIcon, BarsArrowDownIcon, MagnifyingGlassIcon } from '@heroicons/react/24/solid';
import { Dialog } from '@headlessui/react';
import * as XLSX from 'xlsx';
import { saveAs } from 'file-saver';
import jsPDF from 'jspdf';
import autoTable from 'jspdf-autotable';
import { toast } from 'react-toastify';
import { SettingContext } from '../context/SettingContext';
import DOMPurify from 'dompurify';
// Dummy types and pagination logic. Replace with actual types and data handling.
type AuthUser = {
  id: number;
  name: string;
  email: string;
  phone: string;
  department: string;
  role: string;
  active: string;
  date_created: string;
};

type AuthUserListProps = {
  users: AuthUser[];
};

const UserList: React.FC<AuthUserListProps> = ({ users }) => {
  const [currentPage, setCurrentPage] = useState(1);
  const [selectedUser, setSelectedUser] = useState<AuthUser | null>(null);
  const [searchTerm, setSearchTerm] = useState("");
  const [openDropdown, setOpenDropdown] = useState<number | null>(null);
  const [openDropdownExportOptions, setOpenDropdownExportOptions] = useState(false);
  const settingCtx = useContext(SettingContext);
  const itemsPerPage = 10;

  const filteredUsers = users.filter(user =>
    user.name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    user.email.toLowerCase().includes(searchTerm.toLowerCase()) ||
    user.phone?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    user.department.toLowerCase().includes(searchTerm.toLowerCase()) ||
    user.active.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const paginatedUsers = filteredUsers.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );
 
  const navigate = useNavigate();
  const handleEdit = (userId: number) => {
    // Navigate to the user edit page
    navigate(`/users/${userId}/edit`);
  };
  const handleView = (userId: number) => {
    // Navigate to the user detail page
    navigate(`/users/${userId}`);
  };

  const handleDelete = async (ticketId: number) => {
  const confirmDelete = window.confirm("Are you sure you want to delete this ticket?");
  if (!confirmDelete) return;
  try 
  {
    const response = await settingCtx?.deleteUser?.(userId);
    if (response?.success && response.data) {
        toast.success("User deleted successfully!");
    } else {
        toast.error("Failed to delete user.");
    }
    // Optionally refresh or update list
  } catch (error) {
    console.error("Failed to delete user:", error);
    toast.error("Failed to delete user.");
  }
};

// Excel:
const handleExportToExcel = () => {
  // use filteredTickets to export only what the user sees
  const worksheet = XLSX.utils.json_to_sheet(
    filteredUsers.map(u => ({
      Name:    u.name || '',
      Email:      u.email   || '',
      Phone:      u.phone   || '',
      Department: u.department   || '',
      Role:      u.role   || '',
      Active:      u.active   || '',
      Date:      u.date_created   || '',

    }))
  );

  const workbook = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(workbook, worksheet, 'Users');
  const excelBuffer = XLSX.write(workbook, { bookType: 'xlsx', type: 'array' });
  const blob = new Blob([excelBuffer], { type: 'application/octet-stream' });
  saveAs(blob, 'users.xlsx');
};

// PDF:
const handleExportToPDF = () => {
  const doc = new jsPDF();
  const tableColumn = ['Name', 'Email', 'Phone', 'Department', 'Role', 'Active','Date'];
  const tableRows = filteredUsers.map(u => [
      u.name || '',
      u.email   || '',
      u.phone   || '',
      u.department   || '',
      u.role   || '',
      u.active   || '',
      u.date_created   || ''
  ]);

  autoTable(doc, {
    head: [tableColumn],
    body: tableRows,
  });

  doc.save('users.pdf');
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
  const totalPages = Math.ceil(filteredUsers.length / itemsPerPage);
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
              <th className="px-4 py-3 text-left">Name</th>
              <th className="px-4 py-3 text-left">Email</th>
              <th className="px-4 py-3 text-left">Phone</th>
              <th className="px-4 py-3 text-left">Department</th>
              <th className="px-4 py-3 text-left">Role</th>
              <th className="px-4 py-3 text-left">Active</th>
              <th className="px-4 py-3 text-left">Date Created</th>
              <th className="px-4 py-3 text-left">Action</th>
            </tr>
          </thead>
          <tbody>
            {paginatedUsers.map(user => (
              <tr
                key={user.id}
                onClick={() => handleView(user.id)}
                className="hover:bg-gray-50 dark:hover:bg-zinc-800 text-xs"
              >
                <td
                  className="px-4 py-3 text-violet-600 font-semibold cursor-pointer"
                  onClick={() => setSelectedUser(user)}
                >
                  {user.name}
                </td>
                <td className="px-4 py-3">{user?.email}</td>
                <td className="px-4 py-3">{user?.phone}</td>
                <td className="px-4 py-3">{user.department}</td>
                <td className="px-4 py-3">{user.role}</td>
                <td className="px-4 py-3">{user.active}</td>
                <td className="px-4 py-3">{user.date_created}</td>

                <td className="relative px-4 py-3">
                  <button
                     onClick={(e) => {
                        e.stopPropagation(); // Prevent row click
                        setOpenDropdown(openDropdown === user.id ? null : user.id);
                      }}
                      className="flex items-center gap-1 text-sm px-3 py-1 rounded bg-gray-100 hover:bg-gray-200 dark:bg-zinc-700 dark:hover:bg-zinc-600"
                  >
                    <EllipsisVerticalIcon className="w-4 h-4" />
                  </button>
                  {openDropdown === user.id && (
                    <div className="absolute right-0 mt-2 w-28 bg-white dark:bg-zinc-800 shadow-lg rounded-md text-sm border dark:border-zinc-700 z-50">
                      <button onClick={() => handleView(user.id)} className="block w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-left">View</button>
                    </div>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Pagination */}
      <div className="flex justify-between items-center mt-4 text-sm">
        <div>
          Showing {((currentPage - 1) * itemsPerPage) + 1}–
          {Math.min(currentPage * itemsPerPage, filteredUsers.length)} of {filteredUsers.length}
        </div>
        <div className="flex gap-2">
          <button
            disabled={currentPage === 1}
            onClick={() => setCurrentPage(prev => prev - 1)}
            className="px-3 py-1 bg-white border rounded disabled:opacity-50 dark:bg-zinc-900 text-gray-800 dark:text-white"
          >Previous</button>
          <button
            disabled={currentPage === totalPages}
            onClick={() => setCurrentPage(prev => prev + 1)}
            className="px-3 py-1 bg-white border rounded disabled:opacity-50 dark:bg-zinc-900 text-gray-800 dark:text-white"
          >Next</button>
        </div>
      </div>

    </div>
  );
};

export default UserList;
