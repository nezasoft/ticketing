import React, {useEffect, useState, useContext, useCallback} from 'react';
import { ChannelContact } from '../types';
import Sidebar from '../components/common/Sidebar';
import Navbar from '../components/common/Navbar';
import { ChannelContactContext } from '../context/ChannelContactContext';
import { ArrowPathIcon } from '@heroicons/react/24/solid';
import ContactList from '../components/contacts/ContactsList';
import NewContactModal from '../components/contacts/NewContactModal';

const Contacts: React.FC = () =>
{
    const [contacts, setContacts] = useState<ChannelContact[]>([]);
    const [loading, setLoading] = useState<boolean>(true);
    const [isModalOpen, setModalOpen] = useState(false);
    const contactCtx = useContext(ChannelContactContext);


    const fetchContacts = useCallback(async ()=>
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
            if(!user.company_id)
            {
                console.warn("User company id missing.");
                return;
            }
            if(contactCtx?.listContacts)
            {
                const response = await contactCtx.listContacts(companyId);
                if(response.success && response.data)
                {
                    setContacts(response.data);
                }else{
                    console.log('Failed to fetch records:',response.message);
                }
            }
        }catch(error)
        {
            console.error('Error fetching records');
        }finally{
            setLoading(false);
        }
    },[contactCtx]);

    useEffect(()=>
    {
        fetchContacts();
    },[fetchContacts]);

    if(loading)
    {
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
            <main className="md:ml-[250px] md:mt-[70px] ml-0 p-4 w-full h-full">
                <div className="flex flex-wrap items-center justify-between mb-4">
                    <h2 className="text-xl font-semibold">Contacts</h2>
                    <div className="flex flex-wrap gap-2 items-center">
                        <button onClick={()=>setModalOpen(true)} className="bg-violet-500 text-sm text-white px-4 py-2 rounded font-medium hover:bg-violet-600">                           
                            + New Contact
                        </button>
                    </div>
                </div>
                <ContactList contacts={contacts} onUpdated={fetchContacts} />
                <NewContactModal 
                isOpen={isModalOpen}
                onClose={()=> setModalOpen(false)}
                onCreated={fetchContacts}
                 />

            </main>
        </div>
    );

};

export default Contacts;