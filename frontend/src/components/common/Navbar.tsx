import React, { useState } from "react";
import {Link } from 'react-router-dom';
import LogoutButton from "./LogoutButton";

const Navbar: React.FC = () => {
  const [isNotificationOpen, setIsNotificationOpen] = useState(false);
  const [isProfileOpen, setIsProfileOpen] = useState(false);
  const [darkMode, setDarkMode] = useState(false);

  const toggleNotificationDropdown = () => {
    setIsNotificationOpen((prev) => !prev);
    setIsProfileOpen(false);
  };

  const toggleProfileDropdown = () => {
    setIsProfileOpen((prev) => !prev);
    setIsNotificationOpen(false);
  };

  const toggleDarkMode = () => {
    setDarkMode(!darkMode);
    document.documentElement.classList.toggle("dark");
  };

  return (
    <nav className="fixed top-0 left-0 right-0 z-10 flex items-center bg-white dark:bg-zinc-800 print:hidden dark:border-zinc-700 ltr:pr-6 rtl:pl-6">
      <div className="flex justify-between w-full">
        {/* Left: Brand */}
        <div className="flex items-center topbar-brand w-64">
          <div className=" hidden lg:flex navbar-brand items-center px-6 h-[70px]  border-gray-50 dark:border-zinc-700 dark:bg-zinc-800">
            <Link to="/dashboard" className="flex items-center text-lg font-bold dark:text-white">
              <img src="logo.png" alt="Logo" className="w-6 h-6 ltr:mr-2 rtl:ml-2" />
              <span className="hidden xl:block text-gray-700 dark:text-gray-100">RT Oris</span>
            </Link>
          </div>
        </div>

        {/* Right Section */}
        <div className="flex justify-between w-full items-center border-b border-[#e9e9ef] dark:border-zinc-600 ltr:pl-6 rtl:pr-6">
          {/* Search */}
          <form className="hidden xl:block">
            <div className="relative flex items-center max-w-[250px]">
              <input
                type="text"
                placeholder="Search..."
                className="w-full py-2 pl-3 pr-10 rounded-md border border-gray-200 dark:border-zinc-600 bg-[#f8f9fa] dark:bg-[#363a38] text-sm text-gray-800 dark:text-gray-100 placeholder:text-sm dark:placeholder:text-gray-400 focus:outline-none focus:ring-2 focus:ring-violet-500"
              />
              <button
                type="submit"
                className="absolute right-1.5 top-1/2 -translate-y-1/2 w-8 h-8 flex items-center justify-center bg-violet-500 text-white rounded shadow"
              >
                <i className="bx bx-search-alt text-lg" />
              </button>
            </div>
          </form>


          {/* Right Icons */}
          <div className="flex items-center gap-2">
            {/* Dark/Light Mode Toggle */}
            <button onClick={toggleDarkMode} className="hidden sm:block text-xl px-3 h-[70px] text-gray-600 dark:text-gray-100">
              {darkMode ? (
                <i data-feather="sun" className="w-5 h-5" />
              ) : (
                <i data-feather="moon" className="w-5 h-5" />
              )}
            </button>

            {/* Notifications */}
            <div className="relative">
              <button
                type="button"
                onClick={toggleNotificationDropdown}
                className="px-4 h-[70px] text-gray-600 dark:text-gray-100 relative"
              >
                <i data-feather="bell" className="w-5 h-5" />
                <span className="absolute text-xs px-1 bg-red-500 text-white font-medium rounded-full left-6 top-2.5">
                  5
                </span>
              </button>

              {isNotificationOpen && (
                <div className="absolute right-0 mt-2 w-80 bg-white dark:bg-zinc-800 border border-gray-50 dark:border-gray-700 rounded shadow z-50">
                  <div className="p-4 border-b dark:border-gray-700 flex justify-between text-sm">
                    <span className="text-gray-700 dark:text-gray-100">Notifications</span>
                    <Link to="#" className="text-xs underline dark:text-gray-400">Unread (3)</Link>
                  </div>
                  <div className="max-h-56 overflow-y-auto">
                    <Link to="#" className="block px-4 py-2 hover:bg-gray-50 dark:hover:bg-zinc-700 text-gray-800 dark:text-gray-100 text-sm"> 
                      <div className="flex gap-3 items-center">
                        <img src="logo.png" alt="User" className="w-8 h-8 rounded-full" />
                        <div>
                          <div>James Lemire</div>
                          <div className="text-xs text-gray-600 dark:text-gray-400">
                            It will seem like simplified English. <br />
                            <i className="mdi mdi-clock-outline" /> 1 hour ago
                          </div>
                        </div>
                      </div>
                    </Link>
                    {/* Add more notification items if needed */}
                  </div>
                  <div className="text-center p-2 border-t dark:border-zinc-600">
                    <Link to="#" className="text-violet-500 text-sm flex items-center justify-center gap-1">
                      <i className="mdi mdi-arrow-right-circle" /> View More...
                    </Link>
                  </div>
                </div>
              )}
            </div>

            {/* Profile Dropdown */}
            <div className="relative">
              <button
                onClick={toggleProfileDropdown}
                className="flex items-center px-3 py-2 h-[70px] border-x border-gray-50 bg-gray-50/30 dark:bg-zinc-700 dark:border-zinc-600 dark:text-gray-100"
              >
                <img
                  src="logo.png"
                  alt="Avatar"
                  className="w-9 h-9 border-[3px] border-gray-700 dark:border-zinc-400 rounded-full ltr:mr-2 rtl:ml-2"
                />
                <span className="hidden xl:block font-medium">Shawn L.</span>
                <i className="hidden mdi mdi-chevron-down xl:block" />
              </button>

              {isProfileOpen && (
                <div className="absolute right-0 mt-2 w-40 bg-white dark:bg-zinc-800 border border-gray-50 dark:border-zinc-600 rounded shadow z-50">
                  <Link to="#"
                    className="block px-3 py-2 hover:bg-gray-50 dark:hover:bg-zinc-700 text-gray-800 dark:text-gray-100 text-sm"
                  >
                    <i className="mdi mdi-face-man mr-1" /> Profile
                  </Link>
                  <Link to="#"
                    className="block px-3 py-2 hover:bg-gray-50 dark:hover:bg-zinc-700 text-gray-800 dark:text-gray-100 text-sm"
                  >
                    <i className="mdi mdi-lock mr-1" /> Lock Screen
                  </Link>
                  <hr className="border-gray-100 dark:border-gray-700" />
                  <LogoutButton />
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
