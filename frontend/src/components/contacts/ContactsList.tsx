import React, { useState, useContext, useEffect } from "react";

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
import { ChannelContactContext } from "../../context/ChannelContactContext";
import EditContactModal from "./EditContactModal";

import Pagination from "../common/Pagination";
type ChannelContact =  {
    id: number;
    channel_id: number;
    full_name: string;
    email?: string;
    phone?: string;
    company_id:number;
    channel?: any[];
    company?: any[];

};

type ContactListProps ={
    contacts: ChannelContact[];
    onUpdated: () => void;
};

const ContactsList: React.FC<ContactListProps> = ({contacts, onUpdated}) => 
{
    const [currentPage, setCurrentPage] = useState(1);
    const [searchTerm, setSearchTerm] = useState("");
    const [selectedContact, setSelectedContact] = useState<ChannelContact | null>(null);
    const [openDropdown, setOpenDropdown] = useState<number | null>(null);
    const [openDropdownExportOptions, setOpenDropdownExportOptions] = useState(false);
    const [isEditOpen, setIsEditOpen] = useState(false);
    const contactCtx = useContext(ChannelContactContext);
    const itemsPerPage = 10;
    const term = searchTerm.toLowerCase();
    const filteredContacts = contacts.filter((contact)=>
    {
        const matchesText =
            String(contact.full_name ?? "").toLowerCase().includes(term) ||
            String(contact.phone ?? "").toLowerCase().includes(term) ||
            String(contact.email ?? "").toLowerCase().includes(term);
        return (
            matchesText
        )
    });
    const paginatedContacts = filteredContacts.slice((currentPage - 1) * itemsPerPage,currentPage * itemsPerPage);
    useEffect(()=>
    {
        setCurrentPage(1);
    },[searchTerm]);

    useEffect(()=>
    {
        const handleClickOutside = () => setOpenDropdownExportOptions(false);
        if(openDropdownExportOptions)
        {
            window.addEventListener("click",handleClickOutside);
        }
        return () => window.removeEventListener("click",handleClickOutside);
    },[openDropdownExportOptions]);

    const handleEditClick = (contact: ChannelContact) => 
    {
        setIsEditOpen(true);
    };

    const handleDelete = async (contact_id: number) => 
    {
        const confirmDelete = window.confirm("Are you sure you want to delete this record?");
        if(!confirmDelete) return;
        try{
            setOpenDropdown(null);
            const response = await contactCtx?.deleteContact?.(contact_id);
            if(response?.success)
            {
                toast.success("Record deleted successfully!");
            }else{
                toast.error("Failed to delete record");
            }
        }catch(error)
        {
            console.error("Failed to delete record:", error);
            toast.error("Failed to delete record");
        }
    };

    const handleExportToExcel = () => 
    {
        const worksheet = XLSX.utils.json_to_sheet(
            filteredContacts.map((d)=>({
                Contact: d.full_name,
                Email: d.email,
                Phone: d.phone
            }))
        );
        const workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet,"Contacts");
        const excelBuffer = XLSX.write(workbook,{bookType: "xlsx", type: "array"});
        const blob = new Blob([excelBuffer,{type:"application/octet-stream"}]);
        saveAs(blob,"contacts.xlsx");
    }

    const handleExportToPDF = () =>
    {
        const doc = new jsPDF();
        const tableColumn = ["Name","Email","Phone"];
        const tableRows =filteredContacts.map((d)=> [
            d.full_name ?? "",
            d.email ?? "",
            d.phone ?? ""
        ]);
        autoTable(doc,{
            head: [tableColumn],
            body: tableRows,
        });
        doc.save("contacts.pdf");
    };
    const totalPages = Math.ceil(filteredContacts.length / itemsPerPage);
    return (
    <div className="p-4">
      {/* Search + Export */}
      <div className="flex flex-wrap gap-2 items-center justify-between mb-4">
        <div className="flex">
          <div className="relative w-full md:w-64">
            <MagnifyingGlassIcon className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input
              type="text"
              placeholder="Search Name"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-10 pr-3 py-2 border border-gray-300 rounded-full text-xs dark:bg-zinc-800 dark:text-white focus:outline-none focus:ring-2 focus:ring-violet-500"
            />
          </div>
        </div>
        <div className="flex gap-2">
          <div className="relative">
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
            <th className="px-4 py-3 text-left w-12">#</th>
            <th className="px-4 py-3 text-left">Full Name</th>
            <th className="px-4 py-3 text-left">Email</th>
            <th className="px-4 py-3 text-left">Phone</th>
            <th className="px-4 py-3 text-right">Action</th>
          </tr>
        </thead>
        <tbody>
          {paginatedContacts.length > 0 ? (
            paginatedContacts.map((contact, index) => (
              <tr
                key={contact.id}
                className="hover:bg-gray-50 dark:hover:bg-zinc-800 text-xs cursor-pointer odd:bg-white even:bg-gray-50 dark:odd:bg-gray-900 dark:even:bg-gray-800"
              >
                {/* Numbering column */}
                <td className="px-4 py-3">
                  {(currentPage - 1) * itemsPerPage + index + 1}
                </td>
                <td className="px-4 py-3 text-violet-600 font-semibold">{contact.full_name}</td>
                <td className="px-4 py-3 text-violet-600 font-semibold">{contact.email}</td>
                <td className="px-4 py-3 text-violet-600 font-semibold">{contact.phone}</td>
                {/* Right-aligned action menu */}
                <td className="relative px-4 py-3 text-right">
                  <button
                    onClick={(e) => {
                      e.stopPropagation();
                      setOpenDropdown(openDropdown === contact.id ? null : contact.id);
                      setSelectedContact(contact); // make sure edit works
                    }}
                    className="inline-flex items-center gap-1 text-sm px-3 py-1 rounded bg-gray-100 hover:bg-gray-200 dark:bg-zinc-700 dark:hover:bg-zinc-600"
                  >
                    <EllipsisVerticalIcon className="w-4 h-4" />
                  </button>
                  {openDropdown === contact.id && (
                    <div className="absolute right-0 mt-2 w-28 bg-white dark:bg-zinc-800 shadow-lg rounded-md text-sm border dark:border-zinc-700 z-50">
                      <button
                        onClick={() => handleEditClick(contact)}
                        className="block w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-left"
                      >
                        Edit
                      </button>
                      <button
                        onClick={() => handleDelete(contact.id)}
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
      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        totalItems={filteredContacts.length}
        itemsPerPage={itemsPerPage}
        onPageChange={setCurrentPage}
      />
      {/* Edit User Modal */}
      {isEditOpen && selectedContact && (
      <EditContactModal
        isOpen={isEditOpen}
        onClose={() => setIsEditOpen(false)}
        onUpdated={onUpdated}
        contact={selectedContact}
      />
    )}
    </div>
  );
};

export default ContactsList;
