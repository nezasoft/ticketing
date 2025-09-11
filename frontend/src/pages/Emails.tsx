import React, {useEffect, useState, useContext, useCallback} from 'react';
import { Email } from '../types';
import Sidebar from '../components/common/Sidebar';
import Navbar from '../components/common/Navbar';
import { SettingContext } from '../context/SettingContext';
import { ArrowPathIcon} from '@heroicons/react/24/outline';
import EmailList from '../components/emails/EmailList';
import NewEmailModal from '../components/emails/NewEmailModal';
const Emails: React.FC = () => 
{
    const [emails, setEmails] = useState<Email[]>([]);
    const [loading, setLoading] = useState<boolean>(true);
    const [isModalOpen, setModalOpen] = useState(false);
    const settingCtx = useContext(SettingContext);
    const fetchEmails = useCallback(async ()=>
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
            if (settingCtx?.listSettings) {
            const response = await settingCtx.listSettings(companyId);
            if (response.success && response.data?.emails) {
              setEmails(response.data.emails);
            } else {
              console.error('Failed to fetch emails:', response.message);
            }
          }
    } catch (error) {
      console.error('Error fetching emails:', error);
    } finally {
      setLoading(false);
    }
  }, [settingCtx]);
  useEffect(() => {
    fetchEmails();
  }, [fetchEmails]);
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
        <h2 className="text-xl font-semibold">Email Accounts</h2>
         <div className="flex flex-wrap gap-2 items-center">
          <button onClick={() => setModalOpen(true)} className="bg-violet-500 text-sm text-white px-4 py-2 rounded font-medium hover:bg-violet-600 ">
            + New Email Account
          </button>
        </div>
    
      </div>
      <EmailList emails={emails} onUpdated={fetchEmails} />
      <NewEmailModal
                isOpen={isModalOpen}
                onClose={() => setModalOpen(false)}
                onCreated={fetchEmails} // ✅ Reload after creation
      />
      </main>
    </div>
  );

};

export default Emails;