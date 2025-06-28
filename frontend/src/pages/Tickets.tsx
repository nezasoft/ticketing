import React, { useEffect, useState, useContext } from 'react';
import { Ticket } from '../types';
import { TicketContext } from '../context/TicketContext';
import TicketList from '../components/TicketList';
import Sidebar from '../components/Sidebar';
import Navbar from '../components/Navbar';
import { ArrowPathIcon } from '@heroicons/react/24/outline';

const Tickets: React.FC = () => {
  const [tickets, setTickets] = useState<Ticket[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const ticketCtx = useContext(TicketContext);
  useEffect(() => {
    const fetchTickets = async () => {
      try {
        const userString = localStorage.getItem('user');
        if (!userString) {
          console.warn('User not found in localStorage');
          return;
        }

        const user = JSON.parse(userString);
        const companyId = user.company_id;

        if (ticketCtx && ticketCtx.listTickets) {
          const response = await ticketCtx.listTickets(companyId);
          console.log(response);
          if (response.success && response.data) {
            setTickets(response.data);
          } else {
            console.error('Failed to fetch tickets:', response.message);
          }
        }
      } catch (error) {
        console.error('Error fetching tickets:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchTickets();
  }, [ticketCtx]);

  if (loading) {
    return (
      <div className="flex flex-col items-center justify-center h-screen bg-white dark:bg-zinc-900 text-gray-800 dark:text-white">
        <ArrowPathIcon className="h-10 w-10 animate-spin text-violet-600 mb-4" />
        <p className="text-lg font-medium">Loading...</p>
        <div className="w-48 mt-4 h-1 bg-violet-100 rounded overflow-hidden">
          <div className="h-full bg-violet-500 animate-pulse w-1/2"></div>
        </div>
      </div>
    );
  }

  return (
    <div className="flex">
      <Navbar />
      <Sidebar />
      <main className="md:ml-[250px] md:mt-[70px] ml-0 p-4 w-full h-full">
        <TicketList tickets={tickets} />
      </main>
    </div>
  );
};

export default Tickets;
