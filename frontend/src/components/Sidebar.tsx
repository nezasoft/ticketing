import React, { useState } from "react";
import { Link } from "react-router-dom";
import {
  HomeIcon,
  TicketIcon,
  ClipboardDocumentCheckIcon,
  CheckCircleIcon,
  UsersIcon,
  ShieldCheckIcon,
  ChartBarIcon,
  Cog6ToothIcon,
  Bars3Icon,
  XMarkIcon,
} from "@heroicons/react/24/solid";

const Sidebar: React.FC = () => {
  const [isOpen, setIsOpen] = useState(false);
  const toggleSidebar = () => setIsOpen(!isOpen);

  return (
    <>
      {/* Mobile Toggle Button */}
      <button
        onClick={toggleSidebar}
        className="md:hidden fixed top-4 left-4 z-50 p-2 bg-white dark:bg-zinc-800 rounded shadow"
      >
        {isOpen ? (
          <XMarkIcon className="h-6 w-6 text-gray-800 dark:text-white" />
        ) : (
          <Bars3Icon className="h-6 w-6 text-gray-800 dark:text-white" />
        )}
      </button>

      {/* Sidebar Container */}
      <div
        className={`h-full overflow-y-auto backdrop-blur-md bg-white/30 dark:bg-zinc-700/30 custom-scrollbar
          fixed top-[70px] z-40 w-64 h-screen border-r border-gray-50 dark:border-neutral-700
          transition-transform duration-300 ease-in-out
          ${isOpen ? "translate-x-0" : "-translate-x-full"} md:translate-x-0`}
      >
        <div className="h-full overflow-y-auto bg-slate-50 dark:bg-zinc-800">
          <div className="pb-10 pt-2.5">
            <ul id="side-menu">
              <li className="px-5 py-3 text-xs font-medium text-gray-500 dark:text-gray-400 block">
                Menu
              </li>

              <li>
                <Link
                  to="/dashboard"
                  className="flex items-center gap-3 py-2.5 px-6 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                >
                  <HomeIcon className="h-5 w-5 text-violet-500" />
                  <span>Dashboard</span>
                </Link>
              </li>

              <li>
                <Link
                  to="#"
                  className="flex items-center gap-3 py-2.5 px-6 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                >
                  <TicketIcon className="h-5 w-5 text-violet-500" />
                  <span>Tickets</span>
                </Link>
                <ul>
                  <li>
                    <Link
                      to="/tickets"
                      className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                    >
                      <ClipboardDocumentCheckIcon className="h-4 w-4 text-violet-400" />
                      All Tickets
                    </Link>
                  </li>
                  <li>
                    <Link
                      to="#"
                      className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                    >
                      <CheckCircleIcon className="h-4 w-4 text-green-400" />
                      Closed Tickets
                    </Link>
                  </li>
                </ul>
              </li>

              <li>
                <Link
                  to="#"
                  className="flex items-center gap-3 py-2.5 px-6 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                >
                  <UsersIcon className="h-5 w-5 text-violet-500" />
                  <span>Customers</span>
                </Link>
              </li>

              <li>
                <Link
                  to="#"
                  className="flex items-center gap-3 py-2.5 px-6 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                >
                  <ShieldCheckIcon className="h-5 w-5 text-violet-500" />
                  <span>SLAs & Policies</span>
                </Link>
              </li>

              <li>
                <Link
                  to="#"
                  className="flex items-center gap-3 py-2.5 px-6 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                >
                  <ChartBarIcon className="h-5 w-5 text-violet-500" />
                  <span>Reports</span>
                </Link>
              </li>

              <li>
                <Link
                  to="#"
                  className="flex items-center gap-3 py-2.5 px-6 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                >
                  <Cog6ToothIcon className="h-5 w-5 text-violet-500" />
                  <span>Settings</span>
                </Link>
              </li>
            </ul>

            <div className="mx-6 my-12 text-center">
              <div className="rounded bg-violet-50/50 dark:bg-zinc-700/60 p-4">
                <h5 className="mb-2 text-base font-medium text-violet-500">
                  Unlimited Access
                </h5>
                <p className="text-sm text-slate-600 dark:text-gray-50">
                  Upgrade your plan from a Free trial, to select ‘Business Plan’.
                </p>
                <Link
                  to="#"
                  className="mt-4 inline-block bg-violet-500 text-white px-4 py-2 rounded"
                >
                  Upgrade Now
                </Link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Sidebar;
