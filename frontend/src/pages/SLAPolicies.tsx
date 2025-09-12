import React, {useEffect, useState, useContext, useCallback} from 'react';
import { SLAPolicy, Template } from '../types';
import Sidebar from '../components/common/Sidebar';
import Navbar from '../components/common/Navbar';
import { SLAContext } from '../context/SLAContext';
import { ArrowPathIcon } from '@heroicons/react/24/outline';
import SLAPolicyList from '../components/sla_policies/SLAPolicyList';
import NewSLAPolicyModal from '../components/sla_policies/NewSLAPolicyModal';

const SLAPolicies: React.FC = () => 
{
    const [sla_policies, setSLAPolicies] = useState<SLAPolicy[]>([]);
    const [loading, setLoading] = useState<boolean>(true);
    const [isModalOpen, setModalOpen] = useState(false);
    const slaCtx = useContext(SLAContext);
    const fetchSLAPolicies = useCallback(async ()=>
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
            if (slaCtx?.listSLAPolicies) {
            const response = await slaCtx.listSLAPolicies(companyId);
            if (response.success && response.data) {
              setSLAPolicies(response.data);
            } else {
              console.error('Failed to fetch templates:', response.message);
            }
          }
    } catch (error) {
      console.error('Error fetching templates:', error);
    } finally {
      setLoading(false);
    }
  }, [slaCtx]);
  useEffect(() => {
    fetchSLAPolicies();
  }, [fetchSLAPolicies]);
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
        <h2 className="text-xl font-semibold">SLA Policies</h2>
         <div className="flex flex-wrap gap-2 items-center">
          <button onClick={() => setModalOpen(true)} className="bg-violet-500 text-sm text-white px-4 py-2 rounded font-medium hover:bg-violet-600 ">
            + New SLA Policy
          </button>
        </div>
    
      </div>
      <SLAPolicyList sla_policies={sla_policies} onUpdated={fetchSLAPolicies} />
      <NewSLAPolicyModal
                isOpen={isModalOpen}
                onClose={() => setModalOpen(false)}
                onCreated={fetchSLAPolicies} // ✅ Reload after creation
      />
      </main>
    </div>
  );

};

export default SLAPolicies;