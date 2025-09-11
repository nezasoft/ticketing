import React, { useState,  useEffect } from "react";
import {
  PrinterIcon,
  BarsArrowDownIcon,
  MagnifyingGlassIcon,
} from "@heroicons/react/24/solid";
import * as XLSX from "xlsx";
import { saveAs } from "file-saver";
import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";

type EventType =  {
    id: number;
    name: string;
};

type EventTypesListProps ={
    eventTypes: EventType[];
    onUpdated: () => void;
};

const EventTypesList: React.FC<EventTypesListProps> = ({eventTypes}) => 
{
    const [currentPage, setCurrentPage] = useState(1);
    const [searchTerm, setSearchTerm] = useState("");
    const [openDropdownExportOptions, setOpenDropdownExportOptions] = useState(false);
    const itemsPerPage = 10;
    const term = searchTerm.toLowerCase();
    const filteredEventTypes = eventTypes.filter((eventType)=>
    {
        const matchesText = String(eventType.name ?? "").toLowerCase().includes(term);
        return (
            matchesText
        )
    });

    const paginatedEventTypes = filteredEventTypes
    .slice((currentPage - 1) * itemsPerPage,currentPage * itemsPerPage);

    useEffect(()=>
    {
        setCurrentPage(1);

    },[eventTypes, searchTerm]);

    useEffect(()=>
    {
        const handleClickOutside = () => setOpenDropdownExportOptions(false);
        if(openDropdownExportOptions)
        {
            window.addEventListener("click",handleClickOutside);
        }

        return () => window.removeEventListener("click",handleClickOutside);
    },[openDropdownExportOptions]);

    const handleExportToExcel = () => 
    {

        const worksheet = XLSX.utils.json_to_sheet(
            filteredEventTypes.map((d)=>({
                EventType: d.name
            }))
        );
        const workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet,"EventTypes");
        const excelBuffer = XLSX.write(workbook,{bookType: "xlsx", type: "array"});
        const blob = new Blob([excelBuffer,{type:"application/octet-stream"}]);
        saveAs(blob,"EventTypes.xlsx");
    }

    const handleExportToPDF = () =>
    {
        const doc = new jsPDF();
        const tableColumn = ["Name"];
        const tableRows =filteredEventTypes.map((d)=> [
            d.name
        ]);

        autoTable(doc,{
            head: [tableColumn],
            body: tableRows,
        });
        doc.save("EventTypes.pdf");
    };

    const totalPages = Math.ceil(filteredEventTypes.length / itemsPerPage);

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
            <th className="px-4 py-3 text-left">Name</th>
          </tr>
        </thead>
        <tbody>
          {paginatedEventTypes.length > 0 ? (
            paginatedEventTypes.map((event, index) => (
              <tr
                key={event.id}
                className="hover:bg-gray-50 dark:hover:bg-zinc-800 text-xs"
              >
                {/* Numbering column */}
                <td className="px-4 py-3">
                  {(currentPage - 1) * itemsPerPage + index + 1}
                </td>

                <td className="px-4 py-3 text-violet-600 font-semibold">{event.name}</td>

                {/* Right-aligned action menu */}
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
          {filteredEventTypes.length > 0
            ? `Showing ${(currentPage - 1) * itemsPerPage + 1}–${Math.min(
                currentPage * itemsPerPage,
                filteredEventTypes.length
              )} of ${filteredEventTypes.length}`
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
            disabled={currentPage === totalPages || filteredEventTypes.length === 0}
            onClick={() => setCurrentPage((prev) => prev + 1)}
            className="px-3 py-1 bg-white border rounded disabled:opacity-50 dark:bg-zinc-900 text-gray-800 dark:text-white"
          >
            Next
          </button>
        </div>
      </div>
    </div>
  );
};

export default EventTypesList;
