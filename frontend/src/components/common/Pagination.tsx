import React from "react";

interface PaginationProps {
  currentPage: number;
  totalPages: number;
  totalItems: number;
  itemsPerPage: number;
  onPageChange: (page: number) => void;
}

const Pagination: React.FC<PaginationProps> = ({
  currentPage,
  totalPages,
  totalItems,
  itemsPerPage,
  onPageChange,
}) => {
  if (totalPages <= 1) return null; // no pagination needed

  return (
    <div className="flex justify-between items-center mt-4 text-sm">
      {/* Info text */}
      <div>
        {totalItems > 0
          ? `Showing ${(currentPage - 1) * itemsPerPage + 1}–${Math.min(
              currentPage * itemsPerPage,
              totalItems
            )} of ${totalItems}`
          : "No results to display"}
      </div>

      {/* Pagination buttons */}
      <div className="flex items-center space-x-1">
        {/* Previous */}
        <button
          type="button"
          disabled={currentPage === 1}
          onClick={() => onPageChange(currentPage - 1)}
          className={`px-3 py-1 rounded-md border text-sm ${
            currentPage === 1
              ? "bg-gray-200 text-gray-400 cursor-not-allowed"
              : "bg-white hover:bg-gray-100 dark:bg-zinc-900 dark:text-white"
          }`}
        >
          Previous
        </button>

        {/* Page numbers */}
        {Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
          <button
            key={page}
            type="button"
            onClick={() => onPageChange(page)}
            className={`px-3 py-1 rounded-md border text-sm ${
              page === currentPage
                ? "bg-violet-600 text-white"
                : "bg-white hover:bg-gray-100 dark:bg-zinc-900 dark:text-white"
            }`}
          >
            {page}
          </button>
        ))}

        {/* Next */}
        <button
          type="button"
          disabled={currentPage === totalPages || totalItems === 0}
          onClick={() => onPageChange(currentPage + 1)}
          className={`px-3 py-1 rounded-md border text-sm ${
            currentPage === totalPages || totalItems === 0
              ? "bg-gray-200 text-gray-400 cursor-not-allowed"
              : "bg-white hover:bg-gray-100 dark:bg-zinc-900 dark:text-white"
          }`}
        >
          Next
        </button>
      </div>
    </div>
  );
};

export default Pagination;
