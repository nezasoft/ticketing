import api from '../api/api';
import { Ticket, GenericResponse} from '../types';

//Get Tickets Function
export async function getTickets(company_id:number): Promise<GenericResponse<Ticket[]>>
{
    const response = await api.post<GenericResponse<Ticket[]>>(
    '/tickets/list',
    { company_id }
  );
  return response.data;
}

//Create Ticket Function
export async function newTicket(
  payload: FormData
): Promise<GenericResponse<Ticket>>
{
    const response = await api.post<GenericResponse<Ticket>>(
    '/tickets/create',
     payload,
     {
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  }
  );
  return response.data;
}

//View Ticket Function
export async function viewTicket(
  ticket_id: number
): Promise<GenericResponse<Ticket>> {
  try {
    const response = await api.post<GenericResponse<Ticket[]>>('/tickets/show', {
      ticket_id,
    });

    return {
      success: true,
      message: 'Ticket retrieved successfully',
      data: response.data.data[0],
    };
  } catch (error: any) {
    console.error("viewTicket error:", {
      success: error.response?.success,
      message: error.message,
      data: error.response?.data,
    });

    // Return the correct error structure
    return {
      success: false,
      message: 'Ticket fetch failed',
      data: {} as Ticket, // or null if you change GenericResponse<T | null>
    };
  }
}

//Edit Ticket Function
export async function editTicket(
  ticket_id: number,
  data: Partial<Ticket>
): Promise<GenericResponse<Ticket>> {
  const response = await api.post<GenericResponse<Ticket>>('/tickets/edit', {
    ticket_id,
    ...data
  });

  return response.data;
}
//Delete Ticket Function
export async function deleteTicket(
  ticket_id: number
): Promise<GenericResponse<any>> {
  const response = await api.post<GenericResponse<any>>('/tickets/delete', {
    ticket_id,
  });

  return response.data;
}
//Reply Ticket Function
export async function replyTicket(payload: FormData): Promise<GenericResponse<any>> {
  const response = await api.post<GenericResponse<any>>('/tickets/reply', payload, {
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  });
  return response.data;
}
//Resolve Ticket Function
export async function resolveTicket(payload: FormData): Promise<GenericResponse<any>>
{
  const response = await api.post<GenericResponse<any>>('/tickets/resolve',payload,{

  });
  return response.data;
}
//Close Ticket Function
export async function closeTicket(payload: FormData): Promise<GenericResponse<any>>
{
  const response = await api.post<GenericResponse<any>>('/tickets/close', payload, {
  });
  return response.data;
}