import React, {createContext,useState,useCallback,useMemo,ReactNode} from 'react';
import {TicketContextType,Ticket,GenericResponse,Reply, TicketResolve, TicketClose} from '../types';
import {getTickets,editTicket,viewTicket,newTicket,deleteTicket,replyTicket,resolveTicket, closeTicket} from '../service/ticketService';

const defaultContext: TicketContextType = {
  ticket: null,
  loading: false,
  listTickets: async () => ({ success: false, message: '', data: [] }),
  viewTicket: async () => ({ success: false, message: '', data: null }),
  editTicket: async () => ({ success: false, message: '', data: null }),
  newTicket: async () => ({ success: false, message: '', data: null }),
  deleteTicket: async () => ({ success: false, message: '', data: null }),
  replyTicket: async () => ({ success: false, message: '', data: null }),
  resolveTicket: async () => ({ success: false, message: '', data: null }),
  closeTicket: async () => ({ success: false, message: '', data: null }),
};

export const TicketContext = createContext<TicketContextType>(defaultContext);
type Props = {
  children: ReactNode;
};

export const TicketProvider: React.FC<Props> = ({ children }) => {
  const [ticket, setTicket] = useState<Ticket | null>(null);
  const [loading, setLoading] = useState<boolean>(false);
  const fetchTickets = useCallback(async (company_id: number): Promise<GenericResponse<Ticket[]>> => {
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
  }, []);

  const handleViewTicket = useCallback(async (ticket_id: number): Promise<GenericResponse<Ticket | null>> => {
    setLoading(true);
    try {
      const response = await viewTicket(ticket_id);
      setTicket(response.data);
      return {
        success: true,
        message: 'Ticket retrieved successfully',
        data: response.data,
      };
    } catch (error) {
      console.error('Error viewing ticket', error);
      return { success: false, message: 'Error viewing ticket', data: null };
    } finally {
      setLoading(false);
    }
  }, []);

  const handleEditTicket = useCallback(async (
    ticket_id: number,
    data: Partial<Ticket>
  ): Promise<GenericResponse<Ticket | null>> => {
    return editTicket(ticket_id, data);
  }, []);

  const handleNewTicket = useCallback(async (
    payload: FormData
  ): Promise<GenericResponse<Ticket | null>> => {
    return newTicket(payload);
  }, []);

  const handleDeleteTicket = useCallback(async (
    ticket_id: number
  ): Promise<GenericResponse<null>> => {
    return deleteTicket(ticket_id);
  }, []);

  const handleReplyTicket = useCallback(async (
    payload: FormData
  ):Promise<GenericResponse<Reply | null>> =>{
    return replyTicket(payload);
  },[]);

  const handleResolveTicket = useCallback(async (
    payload: FormData):Promise<GenericResponse<TicketResolve | null>> =>
  {
    return resolveTicket(payload);
  },[]);

  const handleCloseTicket = useCallback(async (
    payload: FormData
  ): Promise<GenericResponse<TicketClose | null>> =>
  {
    return closeTicket(payload);
  },[]);

  const contextValue = useMemo(() => ({
    ticket,
    loading,
    listTickets: fetchTickets,
    viewTicket: handleViewTicket,
    editTicket: handleEditTicket,
    newTicket: handleNewTicket,
    deleteTicket: handleDeleteTicket,
    replyTicket: handleReplyTicket,
    resolveTicket: handleResolveTicket,
    closeTicket: handleCloseTicket
  }), [
    ticket,
    loading,
    fetchTickets,
    handleViewTicket,
    handleEditTicket,
    handleNewTicket,
    handleDeleteTicket,
    handleReplyTicket,
    handleResolveTicket,
    handleCloseTicket
  ]);

  return (
    <TicketContext.Provider value={contextValue}>
      {children}
    </TicketContext.Provider>
  );
};
