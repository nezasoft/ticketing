import React from 'react';
import {CheckCircleIcon,UserGroupIcon,GlobeAltIcon,BuildingOfficeIcon,CpuChipIcon,GiftIcon,AcademicCapIcon,ArrowDownIcon} from '@heroicons/react/24/solid';
import TicketAnalyticsCard from '../tickets/TicketAnalyticsCard';

const UserDetail: React.FC = () => {
  return (
    <div className="max-w-6xl mx-auto mt-10 space-y-6">
      {/* Header Card */}
      <div className="bg-white dark:bg-zinc-900 shadow rounded-md overflow-hidden">
        <div className="h-48 bg-cover bg-center bg-purple-800"/>
        <div className="flex flex-col md:flex-row gap-6 px-6 py-6 -mt-16 relative">
          <div className="w-32 h-32 rounded-full border-4 border-white dark:border-zinc-900 overflow-hidden shadow">
            <img src="/profile.jpg" className="w-full h-full object-cover" alt="Profile" />
          </div>
          <div className="flex-1">
            <h1 className="text-md font-semibold flex items-center gap-2 text-gray-900 dark:text-white">
              Anthony Hopkins <CheckCircleIcon className="w-5 h-5 text-blue-500" />
            </h1>
            <p className="text-gray-600 dark:text-gray-300">Senior Software Engineer at Technext Limited</p>
            <p className="text-sm text-gray-400">New York, USA</p>
            <div className="flex gap-3 mt-4">
      
              <button className="bg-violet-500 text-white dark:bg-zinc-800 dark:text-white text-sm px-4 py-1.5 rounded-full">Message</button>
            </div>
          </div>
          <div className="flex flex-col gap-2 text-sm text-gray-600 dark:text-gray-300">
            <div className="flex items-center gap-2"><UserGroupIcon className="w-4 h-4" />See followers (330)</div>
            <div className="flex items-center gap-2"><GlobeAltIcon className="w-4 h-4 text-red-500" />Google</div>
            <div className="flex items-center gap-2"><BuildingOfficeIcon className="w-4 h-4" />Apple</div>
            <div className="flex items-center gap-2"><CpuChipIcon className="w-4 h-4 text-blue-700" />Hewlett Packard</div>
          </div>
        </div>
      </div>

      {/* Info Grid */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {/* Left Column */}
        <div className="col-span-2 space-y-6">
          {/* Intro */}
          <div className="bg-white dark:bg-zinc-900 shadow rounded-md p-4">
            <h2 className="text-lg font-semibold mb-2">Intro</h2>
            <p className="text-sm text-gray-600 dark:text-gray-300">
              Dedicated, passionate, and accomplished Full Stack Developer with 9+ years of progressive experience...<br />
              <button className="text-blue-600 mt-1 text-xs flex items-center gap-1">Show full <ArrowDownIcon className="w-4 h-4" /></button>
            </p>
          </div>

          {/* Tickets */}
          <div className="bg-white dark:bg-zinc-900 shadow rounded-md p-4">
            <div className="flex justify-between mb-3">
              <h2 className="text-lg font-semibold">Support Tickets</h2>
              <a href="#" className="text-sm text-blue-600">All Tickets</a>
            </div>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm text-gray-600 dark:text-gray-300">
              <div><AppleLogo /> New <br />3243 associates</div>
              <div><GoogleLogo /> Pending<br />34598 associates</div>
              <div><IntelLogo /> Resolved<br />7652 associates</div>
              <div><FacebookLogo /> Closed<br />765 associates</div>
            </div>
          </div>
          <TicketAnalyticsCard />
          {/* Activity Log */}
          <div className="bg-white dark:bg-zinc-900 shadow rounded-md p-4">
            <div className="flex justify-between mb-3">
              <h2 className="text-lg font-semibold">Activity log</h2>
              <a href="#" className="text-sm text-blue-600">All logs</a>
            </div>
            <ul className="text-sm text-gray-700 dark:text-gray-300 space-y-3">
              <li><GiftIcon className="w-4 h-4 inline-block text-pink-500 mr-2" /> Jennifer Kent Congratulated Anthony Hopkins<br /><span className="text-xs text-gray-500">November 13, 5:00 AM</span></li>
              <li><AcademicCapIcon className="w-4 h-4 inline-block text-yellow-500 mr-2" /> Caltech tagged Anthony Hopkins in a post<br /><span className="text-xs text-gray-500">November 8, 5:00 PM</span></li>
              <li>Anthony Hopkins joined Victory day with Tony Stark<br /><span className="text-xs text-gray-500">November 1, 11:30 AM</span></li>
              <li>MIT invited Anthony Hopkins to an event<br /><span className="text-xs text-gray-500">October 28, 12:00 PM</span></li>
            </ul>
          </div>
        </div>

        {/* Right Column */}
        <div className="space-y-6">
          {/* Experience */}
          <div className="bg-white dark:bg-zinc-900 shadow rounded-md p-4">
            <h2 className="text-lg font-semibold mb-3">Experience</h2>
            <ul className="text-sm text-gray-600 dark:text-gray-300 space-y-3">
              <li>
                <strong>Big Data Engineer</strong> at Google <CheckCircleIcon className="inline w-4 h-4 text-blue-500" /><br />
                Jan 2017 - Present • 6 yrs 9 mos<br />California, USA
              </li>
              <li>
                <strong>Software Engineer</strong> at Apple <CheckCircleIcon className="inline w-4 h-4 text-blue-500" /><br />
                Jan 2012 - Apr 2012 • 4 mos<br />California, USA
              </li>
              <li>
                <strong>Mobile App Developer</strong> at Nike <CheckCircleIcon className="inline w-4 h-4 text-blue-500" /><br />
                Jan 2011 - Apr 2012 • 1 yr 4 mos<br />Beaverton, USA
              </li>
            </ul>
          </div>

          {/* Education */}
          <div className="bg-white dark:bg-zinc-900 shadow rounded-md p-4">
            <h2 className="text-lg font-semibold mb-3">Education</h2>
            <ul className="text-sm text-gray-600 dark:text-gray-300 space-y-3">
              <li>
                <strong>Stanford University</strong> <CheckCircleIcon className="inline w-4 h-4 text-blue-500" /><br />
                Computer Science and Engineering<br />2010 - 2014 • 4 yrs<br />California, USA
              </li>
              <li>
                <strong>Staten Island Technical High School</strong> <CheckCircleIcon className="inline w-4 h-4 text-blue-500" /><br />
                Higher Secondary School Certificate, Science<br />2008 - 2010 • 2 yrs<br />New York, USA
              </li>
              <li>
                <strong>Thomas Jefferson High School</strong> <CheckCircleIcon className="inline w-4 h-4 text-blue-500" /><br />
                Secondary School Certificate, Science<br />2003 - 2008 • 5 yrs<br />Alexandria, USA
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};

export default UserDetail;

// Replace below with your own icons or import from assets
const AppleLogo = () => <span className="text-2xl"></span>;
const GoogleLogo = () => <span className="text-2xl text-red-500">G</span>;
const IntelLogo = () => <span className="text-2xl text-blue-600">i</span>;
const FacebookLogo = () => <span className="text-2xl text-blue-700">f</span>;
