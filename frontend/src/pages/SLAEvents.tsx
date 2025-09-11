import React, {useEffect, useState, useContext, useCallback} from 'react';
import { SLAEvent } from '../types';
import Sidebar from '../components/common/Sidebar';
import Navbar from '../components/common/Navbar';
import { SLAContext } from '../context/SLAContext';
import { ArrowPathIcon } from '@heroicons/react/24/outline';
import SLAEventsList from '../components/sla_events/SLAEventsList';


const SLAEvents: React.FC = () => 
{
    const [sla_events, setSLAEvents] = useState<SLAEvent[]>([]);
    const [loading, setLoading] = useState<boolean>(true);
    const slaCtx = useContext(SLAContext);

    const fetchSLAEvents = useCallback(async ()=>
    {
        try
        {
            const userString = localStorage.getItem('user');
            if(!userString)
            {
                console.warn('User not found in localStorage');
                return;
            }      
            const user = JSON.parse(userString);
            const companyId = user.company_id;
            if (!user.company_id) {
              console.warn("User company id missing.");
              return;
            }
            if (slaCtx?.listSLAEvents) {
            const response = await slaCtx.listSLAEvents(companyId);
            if (response.success && response.data) {
              setSLAEvents(response.data);
            } else {
              console.error('Failed to fetch records:', response.message);
            }
          }
    } catch (error) {
      console.error('Error fetching records:', error);
    } finally {
      setLoading(false);
    }
  }, [slaCtx]);
  useEffect(() => {
    fetchSLAEvents();
  }, [fetchSLAEvents]);
  if (loading) {
    return (
      <div className="flex flex-col items-center justify-center h-screen bg-white dark:bg-zinc-900 text-gray-800 dark:text-white">
        <ArrowPathIcon className="h-10 w-10 animate-spin text-violet-600 mb-4" />
        <p className="text-lg font-medium">Loading...</p>        
      </div>
    );
  }
    return (
    <div className="flex dark:bg-zinc-900 text-gray-800 dark:text-white">
      <Navbar />
      <Sidebar />
      <main className="md:ml-[250px] md:mt-[70px] ml-0 p-4 w-full h-full ">
        <div className="flex flex-wrap items-center justify-between mb-4">
        <h2 className="text-xl font-semibold">SLA Events</h2>   
      </div>
      <SLAEventsList sla_events={sla_events} onUpdated={fetchSLAEvents} />
      </main>
    </div>
  );

};

export default SLAEvents;