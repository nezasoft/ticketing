import React, { useEffect, useState, useContext } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { Ticket } from '../types';
import { TicketContext } from '../context/TicketContext';
import TicketDetail from '../components/TicketDetail';
import Sidebar from '../components/Sidebar';
import Navbar from '../components/Navbar';
import { ArrowPathIcon, ArrowLeftIcon } from '@heroicons/react/24/outline';

const TicketView: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [ticket, setTicket] = useState<Ticket | null>(null);
  const [loading, setLoading] = useState<boolean>(true);

  const { viewTicket } = useContext(TicketContext); // Extract only the function

  useEffect(() => {
    const ticketId = parseInt(id ?? '');
    if (!id || isNaN(ticketId)) return;

    const fetch = async () => {
      setLoading(true);
      try {
        const response = await viewTicket(ticketId);
        if (response.success && response.data) {
          setTicket(response.data);
        } else {
          console.error('Ticket fetch failed:', response.message);
        }
      } catch (err) {
        console.error('Fetch error:', err);
      } finally {
        setLoading(false);
      }
    };

    fetch();
  }, [id, viewTicket]); // Only depends on stable references

  if (!id || isNaN(parseInt(id))) {
    return (
      <div className="flex flex-col items-center justify-center h-screen bg-white dark:bg-zinc-900 text-gray-800 dark:text-white">
        <p className="text-lg font-medium text-red-500">Invalid Ticket ID</p>
        <button
          onClick={() => navigate('/tickets')}
          className="mt-4 px-4 py-2 bg-violet-600 text-white rounded hover:bg-violet-700"
        >
          Go back to Tickets
        </button>
      </div>
    );
  }

  if (loading) {
    return (
      <div className="flex flex-col items-center justify-center h-screen bg-white dark:bg-zinc-900 text-gray-800 dark:text-white">
        <ArrowPathIcon className="h-10 w-10 animate-spin text-violet-600 mb-4" />
        <p className="text-lg font-medium">Loading...</p>
      </div>
    );
  }

  if (!ticket) {
    return (
      <div className="flex flex-col items-center justify-center h-screen bg-white dark:bg-zinc-900 text-gray-800 dark:text-white">
        <p className="text-lg font-medium text-red-500">Ticket not found</p>
        <button
          onClick={() => navigate('/tickets')}
          className="mt-4 px-4 py-2 bg-violet-600 text-white rounded hover:bg-violet-700"
        >
          Go back to Tickets
        </button>
      </div>
    );
  }

  return (
    <div className="flex dark:bg-zinc-900 text-gray-800 dark:text-white">
      <Navbar />
      <Sidebar />
      <main className="md:ml-[250px] md:mt-[70px] p-4 w-full h-full">
        <div className="flex flex-wrap items-center justify-between mb-4">
          <h2 className="text-xl font-semibold">Tickets</h2>
        </div>
        <button
          onClick={() => navigate(-1)}
          aria-label="Go back"
          className="mb-4 p-2 bg-violet-500 text-white rounded-full hover:bg-violet-600"
        >
          <ArrowLeftIcon className="h-4 w-4" />
        </button>
        <TicketDetail
          ticket_id = {ticket.id}
          subject={ticket.subject}
          description={ticket.description}
          attachments={ticket.attachments ?? []}
          thread_attachments={ticket.thread_attachments ?? []}
          replies={ticket.replies ?? []}
          events={ticket.events ?? []}
          status={ticket.status}
          priority={ticket.priority}
          ticket_no={ticket.ticket_no}
          phone={ticket.phone}
          email={ticket.email}
          channel={ticket.channel}
          created_at={ticket.created_at}
        />
      </main>
    </div>
  );
};

export default TicketView;
