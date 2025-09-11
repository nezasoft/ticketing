import React, { useState, useContext, useEffect, useRef } from "react";

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
import EditIntegrationModal from "./EditIntegrationModal";

type Integration =  {
    id: number;
    value: string;
    code: string;
    company_id: number;
};

type IntegrationListProps ={
    integrations: Integration[];
    onUpdated: () => void;
};

const IntegrationList: React.FC<IntegrationListProps> = ({integrations, onUpdated}) => 
{
    const [currentPage, setCurrentPage] = useState(1);
    const [searchTerm, setSearchTerm] = useState("");
    const [openDropdown, setOpenDropdown] = useState<number | null>(null);
    const [openDropdownExportOptions, setOpenDropdownExportOptions] = useState(false);
    const [isEditOpen, setIsEditOpen] = useState(false);
    const dropdownRef = useRef<HTMLDivElement | null>(null);
    const [selectedIntegration, setSelectedIntegration] = useState<Integration | null>(null);


    const settingCtx = useContext(SettingContext);
    const itemsPerPage = 10;
    const term = searchTerm.toLowerCase();
    const filteredIntegrations = integrations.filter((integration)=>
    {
        const matchesText = 
        String(integration.code ?? "").toLowerCase().includes(term) ||
        String(integration.value ?? "").toLowerCase().includes(term);
        return (
            matchesText
        )
    });
    const paginatedEmails = filteredIntegrations.slice((currentPage - 1) * itemsPerPage,currentPage * itemsPerPage);
    useEffect(()=>
    {
        setCurrentPage(1);
    },[integrations, searchTerm]);
    useEffect(()=>
    {
        const handleClickOutside = () => setOpenDropdownExportOptions(false);
        if(openDropdownExportOptions)
        {
            window.addEventListener("click",handleClickOutside);
        }

        return () => window.removeEventListener("click",handleClickOutside);
    },[openDropdownExportOptions]);
    const handleEditClick = (integration: Integration) => 
    {
        setOpenDropdown(null);
        setIsEditOpen(true);
    };
    const handleDelete = async (integrationId: number) => 
    {
        const confirmDelete = window.confirm("Are you sure you want to delete this record?");
        if(!confirmDelete) return;

        try{
            setOpenDropdown(null);
            const response = await settingCtx?.deleteIntegration?.(integrationId);
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
            filteredIntegrations.map((e)=>({
                Code: e.code,
                Value: e.value
            }))
        );
        const workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet,"Email Accounts");
        const excelBuffer = XLSX.write(workbook,{bookType: "xlsx", type: "array"});
        const blob = new Blob([excelBuffer,{type:"application/octet-stream"}]);
        saveAs(blob,"emails.xlsx");
    }

    const handleExportToPDF = () =>
    {
        const doc = new jsPDF();
        const tableColumn = ["Name"];
        const tableRows =filteredIntegrations.map((e)=> [
            e.code || "",
            e.value || ""
        ]);

        autoTable(doc,{
            head: [tableColumn],
            body: tableRows,
        });
        doc.save("emails.pdf");
    };
  //Handle Option Buttons click events ie. auto hide when clicked
 useEffect(() => {
      const handleClickOutside = (event: MouseEvent) => {
        if (
          dropdownRef.current &&
          !dropdownRef.current.contains(event.target as Node)
        ) {
          setOpenDropdown(null);
        }
      };
      document.addEventListener("mousedown", handleClickOutside);
      return () => document.removeEventListener("mousedown", handleClickOutside);
    }, []);

    const totalPages = Math.ceil(filteredIntegrations.length / itemsPerPage);
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
            <th className="px-4 py-3 text-left">Code</th>
            <th className="px-4 py-3 text-left">Value</th>
            <th className="px-4 py-3 text-left">Action</th>
          </tr>
        </thead>
        <tbody>
          {paginatedEmails.length > 0 ? (
            paginatedEmails.map((integration, index) => (
              <tr
                key={integration.id}
                className="hover:bg-gray-50 dark:hover:bg-zinc-800 text-xs cursor-pointer odd:bg-white even:bg-gray-50 dark:odd:bg-gray-900 dark:even:bg-gray-800"
              >
                {/* Numbering column */}
                <td className="px-4 py-3">
                  {(currentPage - 1) * itemsPerPage + index + 1}
                </td>
                <td className="px-4 py-3 text-violet-600 font-semibold">{integration.code}</td>
                <td className="px-4 py-3 text-violet-600 font-semibold">{integration.value}</td>

                {/* Right-aligned action menu */}
                <td className="relative px-4 py-3 text-right">
                  <button
                    onClick={(e) => {
                      e.stopPropagation();
                      setOpenDropdown(openDropdown === integration.id ? null : integration.id);
                      setSelectedIntegration(integration); 
                    }}
                    className="inline-flex items-center gap-1 text-sm px-3 py-1 rounded bg-gray-100 hover:bg-gray-200 dark:bg-zinc-700 dark:hover:bg-zinc-600"
                  >
                    <EllipsisVerticalIcon className="w-4 h-4" />
                  </button>

                  {openDropdown === integration.id && (
                    <div  ref={dropdownRef} className="absolute right-0 mt-2 w-28 bg-white dark:bg-zinc-800 shadow-lg rounded-md text-sm border dark:border-zinc-700 z-50">
                      <button
                        onClick={() => handleEditClick(integration)}
                        className="block w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-left"
                      >
                        Edit
                      </button>
                      <button
                        onClick={() => handleDelete(integration.id)}
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
          {filteredIntegrations.length > 0
            ? `Showing ${(currentPage - 1) * itemsPerPage + 1}–${Math.min(
                currentPage * itemsPerPage,
                filteredIntegrations.length
              )} of ${filteredIntegrations.length}`
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
            disabled={currentPage === totalPages || filteredIntegrations.length === 0}
            onClick={() => setCurrentPage((prev) => prev + 1)}
            className="px-3 py-1 bg-white border rounded disabled:opacity-50 dark:bg-zinc-900 text-gray-800 dark:text-white"
          >
            Next
          </button>
        </div>
      </div>

      {/* Edit Item Modal */}
      {isEditOpen && selectedIntegration && (
      <EditIntegrationModal
        isOpen={isEditOpen}
        onClose={() => setIsEditOpen(false)}
        onUpdated={onUpdated}
        integration={selectedIntegration}
      />
    )}

    </div>
  );
};

export default IntegrationList;
