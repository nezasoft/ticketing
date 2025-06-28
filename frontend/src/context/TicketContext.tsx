import React, {createContext,useState,useEffect, ReactNode} from 'react';
import {TicketContextType,Ticket,GenericResponse} from '../types';
import {getTickets,editTicket,viewTicket,newTicket,deleteTicket} from '../service/ticketService';

// Create the default context
const defaultContext: TicketContextType = {
  ticket: null,
  loading: false,
  listTickets: async () => ({ success: false, message: '', data: [] }),
  viewTicket: async () => ({ success: false, message: '', data: null }),
  editTicket: async () => ({ success: false, message: '', data: null }),
  newTicket: async () => ({ success: false, message: '', data: null }),
  deleteTicket: async () => ({ success: false, message: '', data: null }),
};

export const TicketContext = createContext<TicketContextType>(defaultContext);

type Props = {
  children: ReactNode;
};

export const TicketProvider: React.FC<Props> = ({ children }) => {
  const [ticket, setTicket] = useState<Ticket | null>(null);
  const [loading, setLoading] = useState<boolean>(false);

  const fetchTickets = async (company_id: number): Promise<GenericResponse<Ticket[]>> => {
    setLoading(true);
    try {
      const response = await getTickets(company_id);
      return response;
    } catch (error) {
      console.error('Error fetching tickets', error);
      return { success: false, message: 'Error fetching tickets', data: [] };
    } finally {
      setLoading(false);
    }
  };

  const handleViewTicket = async (ticket_id: number): Promise<GenericResponse<Ticket | null>> => {
    setLoading(true);
    try {
      const response = await viewTicket(ticket_id);
      setTicket(response.data);
      return response;
    } catch (error) {
      return { success: false, message: 'Error viewing ticket', data: null };
    } finally {
      setLoading(false);
    }
  };

  const handleEditTicket = async (ticket_id: number, data: Partial<Ticket>): Promise<GenericResponse<Ticket | null>> => {
    return editTicket(ticket_id, data);
  };

  const handleNewTicket = async (company_id: number, data: Partial<Ticket>): Promise<GenericResponse<Ticket | null>> => {
    return newTicket(company_id, data);
  };

  const handleDeleteTicket = async (ticket_id: number): Promise<GenericResponse<null>> => {
    return deleteTicket(ticket_id);
  };

  return (
    <TicketContext.Provider
      value={{
        ticket,
        loading,
        listTickets: fetchTickets,
        viewTicket: handleViewTicket,
        editTicket: handleEditTicket,
        newTicket: handleNewTicket,
        deleteTicket: handleDeleteTicket,
      }}
    >
      {children}
    </TicketContext.Provider>
  );
};
