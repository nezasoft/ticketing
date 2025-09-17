import React, {useEffect, useState, useContext, useCallback} from 'react';
import Sidebar from '../components/common/Sidebar';
import Navbar from '../components/common/Navbar';
import { ArrowPathIcon } from '@heroicons/react/24/outline';
import { SLARule } from '../types';
import { SLAContext } from '../context/SLAContext';
import NewSLARuleModal from '../components/sla_rules/NewSLARuleModal';
import SLARuleList from '../components/sla_rules/SLARuleList';


const SLARules: React.FC = () => 
{
    const [sla_rules, setSLARules] = useState<SLARule[]>([]);
    const [loading, setLoading] = useState<boolean>(true);
    const [isModalOpen, setModalOpen] = useState(false);
    const slaCtx = useContext(SLAContext);
    const fetchSLARules = useCallback(async ()=>
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
            if (slaCtx?.listSLARules) {
            const response = await slaCtx.listSLARules(companyId);
            if (response.success && response.data) {
              setSLARules(response.data);
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
    fetchSLARules();
  }, [fetchSLARules]);
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
        <h2 className="text-xl font-semibold">SLA Rules</h2>
         <div className="flex flex-wrap gap-2 items-center">
          <button onClick={() => setModalOpen(true)} className="bg-violet-500 text-sm text-white px-4 py-2 rounded font-medium hover:bg-violet-600 ">
            + New SLA Rule
          </button>
        </div>
    
      </div>
      <SLARuleList sla_rules={sla_rules} onUpdated={fetchSLARules} />
      <NewSLARuleModal
                isOpen={isModalOpen}
                onClose={() => setModalOpen(false)}
                onCreated={fetchSLARules} // ✅ Reload after creation
      />
      </main>
    </div>
  );

};

export default SLARules;