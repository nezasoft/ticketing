import React, {useEffect, useState} from 'react';
import api from '../api/api';
import {Ticket} from '../types';
import TicketCard from '../components/tickets/TicketCard';
import Sidebar from '../components/common/Sidebar';
import Navbar from '../components/common/Navbar';
import DashboardStats from '../components/common/DashboardStats';
import WalletBalance from '../components/common/WalletBalance';
import TransactionsPanel from '../components/common/TransactionsPanel';
import { ArrowPathIcon } from '@heroicons/react/24/outline'; // Loading spinner icon

const Dashboard: React.FC = () => 
{
    const [tickets, setTickets] = useState<Ticket[]>([]);
    const [loading, setLoading] = useState<boolean>(true);

    useEffect(()=>{
        async function fetchTickets()
        {
            try
            {
               /* const response = await api.post<{data: Ticket[]}>('/tickets/list');
                console.log(response);
                setTickets(response.data.data);*/

            }catch (error)
            {
                console.error('Error fetching tickets:', error);
            }finally
            {
                setLoading(false);
            }
        }
        fetchTickets();

    },[]);

    if (loading)
    return (
        <div className="flex flex-col items-center justify-center h-screen bg-white dark:bg-zinc-900 text-gray-800 dark:text-white">
        <ArrowPathIcon className="h-10 w-10 animate-spin text-violet-600 mb-4" />
        <p className="text-lg font-medium">Loading...</p>

        {/* Optional progress bar below */}
        <div className="w-48 mt-4 h-1 bg-violet-100 rounded overflow-hidden">
            <div className="h-full bg-violet-500 animate-pulse w-1/2"></div>
        </div>
        </div>
    );

    return (
        <div className="flex">
            <Navbar/>
            <Sidebar/>
            <main className="md:ml-[250px] md:mt-[70px] ml-0 p-4">
                <DashboardStats/>
                <WalletBalance/>
                <TransactionsPanel/>
            </main>         
        </div>
    );
};
export default Dashboard;

