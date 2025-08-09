import React, { useEffect, useState, useContext, useCallback } from 'react';
import { Ticket } from '../types';
import { TicketContext } from '../context/TicketContext';
import TicketList from '../components/tickets/TicketList';
import Sidebar from '../components/Sidebar';
import Navbar from '../components/Navbar';
import { ArrowPathIcon,EllipsisVerticalIcon } from '@heroicons/react/24/outline';
import NewTicketModal from '../components/tickets/NewTicketModal';

const Tickets: React.FC = () => {
  const [tickets, setTickets] = useState<Ticket[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [isModalOpen, setModalOpen] = useState(false);
  const ticketCtx = useContext(TicketContext);
  const fetchTickets = useCallback(async () => {
    try {
      const userString = localStorage.getItem('user');
      if (!userString) {
        console.warn('User not found in localStorage');
        return;
      }
      const user = JSON.parse(userString);
      const companyId = user.company_id;
      if (ticketCtx?.listTickets) {
        const response = await ticketCtx.listTickets(companyId);
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
  }, [ticketCtx]);

  useEffect(() => {
    fetchTickets();
  }, [fetchTickets]);

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
        <h2 className="text-xl font-semibold">Tickets</h2>
        <div className="flex flex-wrap gap-2 items-center">
          <button onClick={() => setModalOpen(true)} className="bg-violet-500 text-sm text-white px-4 py-2 rounded font-medium hover:bg-violet-600 ">
            + Raise Ticket
          </button>
        </div>
      </div>
        <TicketList tickets={tickets} />
        <NewTicketModal
          isOpen={isModalOpen}
          onClose={() => setModalOpen(false)}
          onCreated={fetchTickets} // ✅ Reload after ticket creation
        />
      </main>
    </div>
  );
};
export default Tickets;
