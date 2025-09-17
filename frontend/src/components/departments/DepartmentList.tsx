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
import EditDepartmentModal from "./EditDepartmentModal";
import Pagination from "../common/Pagination";
type Department =  {
    id: number;
    name: string;
};

type DepartmentListProps ={
    depts: Department[];
    onUpdated: () => void;
};

const DepartmentList: React.FC<DepartmentListProps> = ({depts, onUpdated}) => 
{
    const [currentPage, setCurrentPage] = useState(1);
    const [searchTerm, setSearchTerm] = useState("");
    const [selectedDepartment, setSelectedDepartment] = useState<Department | null>(null);
    const [openDropdown, setOpenDropdown] = useState<number | null>(null);
    const [openDropdownExportOptions, setOpenDropdownExportOptions] = useState(false);
    const [isEditOpen, setIsEditOpen] = useState(false);
    const settingCtx = useContext(SettingContext);
    const itemsPerPage = 10;
    const term = searchTerm.toLowerCase();
    const filteredDepartments = depts.filter((dept)=>
    {
        const matchesText = String(dept.name ?? "").toLowerCase().includes(term);
        return (
            matchesText
        )
    });
    const paginatedDepartments = filteredDepartments.slice((currentPage - 1) * itemsPerPage,currentPage * itemsPerPage);
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

    const handleEditClick = (dept: Department) => 
    {
        setIsEditOpen(true);
    };

    const handleDelete = async (deptId: number) => 
    {
        const confirmDelete = window.confirm("Are you sure you want to delete this record?");
        if(!confirmDelete) return;
        try{
            setOpenDropdown(null);
            const response = await settingCtx?.deleteDepartment?.(deptId);
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
            filteredDepartments.map((d)=>({
                Department: d.name
            }))
        );
        const workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet,"Departments");
        const excelBuffer = XLSX.write(workbook,{bookType: "xlsx", type: "array"});
        const blob = new Blob([excelBuffer,{type:"application/octet-stream"}]);
        saveAs(blob,"departments.xlsx");
    }

    const handleExportToPDF = () =>
    {
        const doc = new jsPDF();
        const tableColumn = ["Name"];
        const tableRows =filteredDepartments.map((d)=> [
            d.name
        ]);
        autoTable(doc,{
            head: [tableColumn],
            body: tableRows,
        });
        doc.save("departments.pdf");
    };
    const totalPages = Math.ceil(filteredDepartments.length / itemsPerPage);
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
            <th className="px-4 py-3 text-right">Action</th>
          </tr>
        </thead>
        <tbody>
          {paginatedDepartments.length > 0 ? (
            paginatedDepartments.map((dept, index) => (
              <tr
                key={dept.id}
                className="hover:bg-gray-50 dark:hover:bg-zinc-800 text-xs cursor-pointer"
              >
                {/* Numbering column */}
                <td className="px-4 py-3">
                  {(currentPage - 1) * itemsPerPage + index + 1}
                </td>

                <td className="px-4 py-3 text-violet-600 font-semibold">{dept.name}</td>

                {/* Right-aligned action menu */}
                <td className="relative px-4 py-3 text-right">
                  <button
                    onClick={(e) => {
                      e.stopPropagation();
                      setOpenDropdown(openDropdown === dept.id ? null : dept.id);
                      setSelectedDepartment(dept); // make sure edit works
                    }}
                    className="inline-flex items-center gap-1 text-sm px-3 py-1 rounded bg-gray-100 hover:bg-gray-200 dark:bg-zinc-700 dark:hover:bg-zinc-600"
                  >
                    <EllipsisVerticalIcon className="w-4 h-4" />
                  </button>

                  {openDropdown === dept.id && (
                    <div className="absolute right-0 mt-2 w-28 bg-white dark:bg-zinc-800 shadow-lg rounded-md text-sm border dark:border-zinc-700 z-50">
                      <button
                        onClick={() => handleEditClick(dept)}
                        className="block w-full px-4 py-2 hover:bg-gray-100 dark:hover:bg-zinc-700 text-left"
                      >
                        Edit
                      </button>
                      <button
                        onClick={() => handleDelete(dept.id)}
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
        totalItems={filteredDepartments.length}
        itemsPerPage={itemsPerPage}
        onPageChange={setCurrentPage}
      />
      {/* Edit User Modal */}
      {isEditOpen && selectedDepartment && (
      <EditDepartmentModal
        isOpen={isEditOpen}
        onClose={() => setIsEditOpen(false)}
        onUpdated={onUpdated}
        dept={selectedDepartment}
      />
    )}
    </div>
  );
};

export default DepartmentList;
