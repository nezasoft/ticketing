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
  UserPlusIcon,
  FolderOpenIcon
} from "@heroicons/react/24/solid";

const Sidebar: React.FC = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [isTicketsOpen, setIsTicketsOpen] = useState(false);
  const [isSettingsOpen, setIsSettingsOpen]= useState(false);
  const [isSLAOpen, setIsSLAOpen]= useState(false);

  const toggleSidebar = () => setIsOpen(!isOpen);
  const toggleTickets = () => setIsTicketsOpen(!isTicketsOpen);
  const toggleSettings = () => setIsSettingsOpen(!isSettingsOpen);
  const toggleSLA = () => setIsSLAOpen(!isSLAOpen);

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

              {/* Tickets Dropdown */}
              <li>
                <button
                  onClick={toggleTickets}
                  className="w-full flex items-center justify-between gap-3 py-2.5 px-6 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                >
                  <span className="flex items-center gap-3">
                    <TicketIcon className="h-5 w-5 text-violet-500" />
                    Tickets
                  </span>
                  <svg
                    className={`h-4 w-4 transform transition-transform ${
                      isTicketsOpen ? "rotate-90" : ""
                    }`}
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M9 5l7 7-7 7"
                    />
                  </svg>
                </button>

                {isTicketsOpen && (
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
                    <li>
                      <Link
                        to="#"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <UsersIcon className="h-4 w-4 text-red-400" />
                        Assignments
                      </Link>
                    </li>
                  </ul>
                )}
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
                  <UserPlusIcon className="h-5 w-5 text-violet-500" />
                  <span>Contacts</span>
                </Link>
              </li>
                  {/* SLA & Polices Dropdown */}
              <li>
                <button
                  onClick={toggleSLA}
                  className="w-full flex items-center justify-between gap-3 py-2.5 px-6 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                >
                  <span className="flex items-center gap-3">
                    <ShieldCheckIcon className="h-5 w-5 text-violet-500" />
                    SLAs & Policies
                  </span>
                  <svg
                    className={`h-4 w-4 transform transition-transform ${
                      isSLAOpen ? "rotate-90" : ""
                    }`}
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M9 5l7 7-7 7"
                    />
                  </svg>
                </button>

                {isSLAOpen && (
                  <ul>
                    <li>
                      <Link
                        to="#"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <ClipboardDocumentCheckIcon className="h-4 w-4 text-violet-400" />
                        SLA Rules
                      </Link>
                    </li>
                    <li>
                      <Link
                        to="#"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <ClipboardDocumentCheckIcon className="h-4 w-4 text-violet-400" />
                        SLA Policies
                      </Link>
                    </li>
                    <li>
                      <Link
                        to="#"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <ClipboardDocumentCheckIcon className="h-4 w-4 text-violet-400" />
                        SLA Events
                      </Link>
                    </li>
                    <li>
                      <Link
                        to="#"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <ClipboardDocumentCheckIcon className="h-4 w-4 text-violet-400" />
                        SLA Escalations
                      </Link>
                    </li>
    
                  </ul>
                )}
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
              {/* Settings Dropdown */}
              <li>
                <button
                  onClick={toggleSettings}
                  className="w-full flex items-center justify-between gap-3 py-2.5 px-6 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                >
                  <span className="flex items-center gap-3">
                    <Cog6ToothIcon className="h-5 w-5 text-violet-500" />
                    Settings
                  </span>
                  <svg
                    className={`h-4 w-4 transform transition-transform ${
                      isSettingsOpen ? "rotate-90" : ""
                    }`}
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M9 5l7 7-7 7"
                    />
                  </svg>
                </button>

                {isSettingsOpen && (
                  <ul>
                    <li>
                      <Link
                        to="/users"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <FolderOpenIcon className="h-4 w-4 text-violet-400" />
                        Users
                      </Link>
                    </li>
                    <li>
                      <Link
                        to="/departments"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <FolderOpenIcon className="h-4 w-4 text-violet-400" />
                        Departments
                      </Link>
                    </li>
                    <li>
                      <Link
                        to="/emails"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <FolderOpenIcon className="h-4 w-4 text-violet-400" />
                        Emails
                      </Link>
                    </li>
                    <li>
                      <Link
                        to="/event_types"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <FolderOpenIcon className="h-4 w-4 text-violet-400" />
                        Event Types
                      </Link>
                    </li>
                    <li>
                      <Link
                        to="#"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <FolderOpenIcon className="h-4 w-4 text-violet-400" />
                        Integrations
                      </Link>
                    </li>
                    <li>
                      <Link
                        to="#"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <FolderOpenIcon className="h-4 w-4 text-violet-400" />
                        Priorities
                      </Link>
                    </li>
                    <li>
                      <Link
                        to="#"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <FolderOpenIcon className="h-4 w-4 text-violet-400" />
                        User Roles
                      </Link>
                    </li>
                    <li>
                      <Link
                        to="#"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <FolderOpenIcon className="h-4 w-4 text-violet-400" />
                        Status
                      </Link>
                    </li>
                    <li>
                      <Link
                        to="#"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <FolderOpenIcon className="h-4 w-4 text-violet-400" />
                        Mail Templates
                      </Link>
                    </li>
                    <li>
                      <Link
                        to="#"
                        className="flex items-center gap-2 pl-14 pr-6 py-2 text-sm font-medium text-gray-950 dark:text-gray-300 hover:text-violet-500 dark:hover:text-white"
                      >
                        <FolderOpenIcon className="h-4 w-4 text-violet-400" />
                        Template Types
                      </Link>
                    </li>          
                  </ul>
                )}
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
