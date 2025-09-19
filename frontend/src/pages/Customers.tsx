import React, {useEffect, useState, useContext, useCallback} from 'react';
import { Customer } from '../types';
import Sidebar from '../components/common/Sidebar';
import Navbar from '../components/common/Navbar';
import { CustomerContext } from '../context/CustomerContext';
import { ArrowPathIcon } from '@heroicons/react/24/solid';
import CustomerList from '../components/customers/CustomerList';
import NewCustomerModal from '../components/customers/NewCustomerModal';

const Customers: React.FC = () =>
{
    const [customers, setCustomers] = useState<Customer[]>([]);
    const [loading, setLoading] = useState<boolean>(true);
    const [isModalOpen, setModalOpen] = useState(false);
    const customerCtx = useContext(CustomerContext);


    const fetchCustomers = useCallback(async ()=>
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
            if(customerCtx?.listCustomers)
            {
                const response = await customerCtx.listCustomers(companyId);
                if(response.success && response.data)
                {
                    setCustomers(response.data);
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
    },[customerCtx]);

    useEffect(()=>
    {
        fetchCustomers();
    },[fetchCustomers]);

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
                    <h2 className="text-xl font-semibold">Customers</h2>
                    <div className="flex flex-wrap gap-2 items-center">
                        <button onClick={()=>setModalOpen(true)} className="bg-violet-500 text-sm text-white px-4 py-2 rounded font-medium hover:bg-violet-600">                           
                            + New Customer
                        </button>
                    </div>
                </div>
                <CustomerList customers={customers} onUpdated={fetchCustomers} />
                <NewCustomerModal 
                isOpen={isModalOpen}
                onClose={()=> setModalOpen(false)}
                onCreated={fetchCustomers}
                 />

            </main>
        </div>
    );

};

export default Customers;