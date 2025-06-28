import api from '../api/api';
import { Ticket, GenericResponse } from '../types';

const token = localStorage.getItem('token');

//Get Tickets Function
export async function getTickets(company_id:number): Promise<GenericResponse<Ticket[]>>
{
    const response = await api.post<GenericResponse<any>>(
    '/tickets/list',
    { company_id }
  );
  return response.data;
}

//Create Ticket Function
export async function newTicket(
    company_id:number,
    data: Partial<Ticket>
): Promise<GenericResponse<Ticket>>
{
    const response = await api.post<GenericResponse<Ticket>>(
    '/tickets/create',
    { company_id, ...data }
  );
  return response.data;
}

//View Ticket Function
export async function viewTicket(
  ticket_id: number
): Promise<GenericResponse<Ticket>> {
  const response = await api.post<GenericResponse<Ticket>>('/tickets/show', {
    ticket_id,
  });

  return response.data;
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