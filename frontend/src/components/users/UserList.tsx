import React, { useState, useContext, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import {
  EllipsisVerticalIcon,
  PrinterIcon,
  BarsArrowDownIcon,
  MagnifyingGlassIcon,
} from "@heroicons/react/24/solid";
import * as XLSX from "xlsx";
import { saveAs } from "file-saver";
import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";
import { toast } from "react-toastify";
import { SettingContext } from "../../context/SettingContext";
import EditUserModal from "./EditUserModal";

type AuthUser = {
  id: number;
  name: string;
  email: string;
  phone?: string;
  department?: string;
  role?: string;
  active: string;
  date_created?: string;
};

type AuthUserListProps = {
  users: AuthUser[];
  onUpdated: () => void;   // callback from parent
};

const UserList: React.FC<AuthUserListProps> = ({ users, onUpdated }) => {
  const [currentPage, setCurrentPage] = useState(1);
  const [selectedUser, setSelectedUser] = useState<AuthUser | null>(null);
  const [searchTerm, setSearchTerm] = useState("");
  const [openDropdown, setOpenDropdown] = useState<number | null>(null);
  const [openDropdownExportOptions, setOpenDropdownExportOptions] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);

  const [startDate, setStartDate] = useState<string>("");
  const [endDate, setEndDate] = useState<string>("");
  const settingCtx = useContext(SettingContext);
  const itemsPerPage = 10;

  const term = searchTerm.toLowerCase();
  // 🔹 Apply both text and date filters
  const filteredUsers = users.filter((user) => {
  const matchesText =
      String(user.name ?? "").toLowerCase().includes(term) ||
      String(user.email ?? "").toLowerCase().includes(term) ||
      String(user.phone ?? "").toLowerCase().includes(term) ||
      String(user.department ?? "").toLowerCase().includes(term) ||
      String(user.role ?? "").toLowerCase().includes(term) ||
      String(user.active ?? "").toLowerCase().includes(term);

      // format the date string (e.g. "9th Aug 2025 9:25 am")
  const formattedDate = user.date_created ? formatDate(user.date_created) : "";

  // convert to Date for comparison
  const userDate = user.date_created ? new Date(user.date_created) : null;

  const matchesDate =
    (!startDate || (userDate && userDate >= new Date(startDate))) &&
    (!endDate || (userDate && userDate <= new Date(endDate)));

  // ✅ now text search also checks formatted date string
  return (
    matchesText ||
    formattedDate.toLowerCase().includes(term) // allow searching by formatted date
  ) && matchesDate;
  });

  const paginatedUsers = filteredUsers.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );

  const navigate = useNavigate();

  // Reset page when users change or search changes
  useEffect(() => {
    setCurrentPage(1);
  }, [users, searchTerm]);

  // Close export dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = () => setOpenDropdownExportOptions(false);
    if (openDropdownExportOptions) {
      window.addEventListener("click", handleClickOutside);
    }
    return () => window.removeEventListener("click", handleClickOutside);
  }, [openDropdownExportOptions]);

  const handleEditClick = (user: AuthUser) => {
    setSelectedUser(user);
    setIsEditOpen(true);
  };

  const handleView = (userId: number) => {
    setOpenDropdown(null);
    navigate(`/users/${userId}`);
  };

  const handleDelete = async (userId: number) => {
    const confirmDelete = window.confirm("Are you sure you want to delete this user?");
    if (!confirmDelete) return;

    try {
      setOpenDropdown(null);
      const response = await settingCtx?.deleteUser?.(userId);
      if (response?.success) {
        toast.success("User deleted successfully!");
      } else {
        toast.error("Failed to delete user.");
      }
    } catch (error) {
      console.error("Failed to delete user:", error);
      toast.error("Failed to delete user.");
    }
  };

  const handleExportToExcel = () => {
    const worksheet = XLSX.utils.json_to_sheet(
      filteredUsers.map((u) => ({
        Name: u.name || "",
        Email: u.email || "",
        Phone: u.phone || "",
        Department: u.department || "",
        Role: u.role || "",
        Active: u.active || "",
        Date: u.date_created || "",
      }))
    );
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, "Users");
    const excelBuffer = XLSX.write(workbook, { bookType: "xlsx", type: "array" });
    const blob = new Blob([excelBuffer], { type: "application/octet-stream" });
    saveAs(blob, "users.xlsx");
  };

  const handleExportToPDF = () => {
    const doc = new jsPDF();
    const tableColumn = ["Name", "Email", "Phone", "Department", "Role", "Active", "Date"];
    const tableRows = filteredUsers.map((u) => [
      u.name || "",
      u.email || "",
      u.phone || "",
      u.department || "",
      u.role || "",
      u.active || "",
      u.date_created || "",
    ]);
    autoTable(doc, {
      head: [tableColumn],
      body: tableRows,
    });
    doc.save("users.pdf");
  };

  const totalPages = Math.ceil(filteredUsers.length / itemsPerPage);

  function formatDate(dateStr?: string): string {
  if (!dateStr) return "";

  const date = new Date(dateStr);

  const day = date.getDate();
  const month = date.toLocaleString("en-US", { month: "short" });
  const year = date.getFullYear();

  const hours = date.getHours();
  const minutes = date.getMinutes();
  const ampm = hours >= 12 ? "pm" : "am";
  const formattedHours = hours % 12 || 12; // convert 0 -> 12
  const formattedMinutes = minutes.toString().padStart(2, "0");

  // Add ordinal suffix
  const getOrdinal = (n: number) => {
    if (n > 3 && n < 21) return "th"; // special case 11–20
    switch (n % 10) {
      case 1: return "st";
      case 2: return "nd";
      case 3: return "rd";
      default: return "th";
    }
  };

  return `${day}${getOrdinal(day)} ${month} ${year} ${formattedHours}:${formattedMinutes} ${ampm}`;
}


  return (
    <div className="p-4">
      {/* Search + Export */}
      <div className="flex flex-wrap gap-2 items-center justify-between mb-4">
        <div className="flex">
          <div className="relative w-full md:w-64">
            <MagnifyingGlassIcon className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input
              type="text"
              placeholder="Search by name, email, phone, department"
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
                value={startDate}
                onChange={(e) => setStartDate(e.target.value)}
                className="border rounded px-2 py-2 text-sm text-violet-500 dark:text-gray-200 dark:bg-zinc-800 dark:border-zinc-700"
              />
              <span className="text-gray-500 dark:text-gray-300 text-sm">to</span>
              <input
                type="date"
                value={endDate}
                onChange={(e) => setEndDate(e.target.value)}
                className="border rounded px-2 py-2 text-sm text-violet-500 dark:text-gray-200 dark:bg-zinc-800 dark:border-zinc-700"
              />
            <button
              className="bg-violet-500 text-white border px-4 py-2 rounded text-sm"
              onClick={(e) => {
                e.stopPropagation();
                setOpenDropdownExportOptions((prev) => !prev);
              }}
            >
              <BarsArrowDownIcon className="w-4 h-4" />
            </button>
            {openDropdownExportOptions && (
              <div className="absolute right-0 mt-2 w-28 bg-white dark:bg-zinc-800 shadow-lg rounded-md text-sm border dark:border-zinc-700 z-50">
                <button
                  className="block w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-left"
                  onClick={handleExportToExcel}
                >
                  Excel
                </button>
                <button
                  className="block w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-left"
                  onClick={handleExportToPDF}
                >
                  Pdf
                </button>
              </div>
            )}
          </div>
          <button
            className="bg-violet-500 text-white border px-4 py-2 rounded text-sm"
            onClick={() => window.print()}
          >
            <PrinterIcon className="w-4 h-4" />
          </button>
        </div>
      </div>

      {/* Table */}
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
            {paginatedUsers.length > 0 ? (
              paginatedUsers.map((user) => (
                <tr
                  key={user.id}
                  className="hover:bg-gray-50 dark:hover:bg-zinc-800 text-xs cursor-pointer"
                >
                  <td className="px-4 py-3 text-violet-600 font-semibold">{user.name}</td>
                  <td className="px-4 py-3">{user.email}</td>
                  <td className="px-4 py-3">{user.phone}</td>
                  <td className="px-4 py-3">{user.department}</td>
                  <td className="px-4 py-3">{user.role}</td>
                  <td className="px-4 py-3">{user.active}</td>
                  <td className="px-4 py-3">{user.date_created}</td>
                  <td className="relative px-4 py-3">
                    <button
                      onClick={(e) => {
                        e.stopPropagation();
                        setOpenDropdown(openDropdown === user.id ? null : user.id);
                      }}
                      className="flex items-center gap-1 text-sm px-3 py-1 rounded bg-gray-100 hover:bg-gray-200 dark:bg-zinc-700 dark:hover:bg-zinc-600"
                    >
                      <EllipsisVerticalIcon className="w-4 h-4" />
                    </button>
                    {openDropdown === user.id && (
                      <div className="absolute right-0 mt-2 w-28 bg-white dark:bg-zinc-800 shadow-lg rounded-md text-sm border dark:border-zinc-700 z-50">
                        <button
                          onClick={() => handleView(user.id)}
                          className="block w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-left"
                        >
                          View
                        </button>
                        <button
                          onClick={() => handleEditClick(user)}
                          className="block w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-left"
                        >
                          Edit
                        </button>
                        <button
                          onClick={() => handleDelete(user.id)}
                          className="block w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-left text-red-600"
                        >
                          Delete
                        </button>
                      </div>
                    )}
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan={8} className="px-4 py-6 text-center text-gray-500">
                  No results found
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* Pagination */}
      <div className="flex justify-between items-center mt-4 text-sm">
        <div>
          {filteredUsers.length > 0
            ? `Showing ${(currentPage - 1) * itemsPerPage + 1}–${Math.min(
                currentPage * itemsPerPage,
                filteredUsers.length
              )} of ${filteredUsers.length}`
            : "No results to display"}
        </div>
        <div className="flex gap-2">
          <button
            disabled={currentPage === 1}
            onClick={() => setCurrentPage((prev) => prev - 1)}
            className="px-3 py-1 bg-white border rounded disabled:opacity-50 dark:bg-zinc-900 text-gray-800 dark:text-white"
          >
            Previous
          </button>
          <button
            disabled={currentPage === totalPages || filteredUsers.length === 0}
            onClick={() => setCurrentPage((prev) => prev + 1)}
            className="px-3 py-1 bg-white border rounded disabled:opacity-50 dark:bg-zinc-900 text-gray-800 dark:text-white"
          >
            Next
          </button>
        </div>
      </div>

      {/* Edit User Modal */}
      {isEditOpen && selectedUser && (
      <EditUserModal
        isOpen={isEditOpen}
        onClose={() => setIsEditOpen(false)}
        onUpdated={onUpdated}
        user={selectedUser}
      />
    )}
    </div>
  );
};

export default UserList;
