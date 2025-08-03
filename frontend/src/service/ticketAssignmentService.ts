import api from "../api/api";
import {GenericResponse, TicketAssignment} from '../types';

//Get Ticket Assignments Function
export async function getTicketAssignments(company_id:number): Promise<GenericResponse<TicketAssignment[]>>
{
    const response = await api.post<GenericResponse<TicketAssignment[]>>('/tickets/assignments',{company_id});
    return response.data;
}

//Create Ticket Assignment Function
export async function newTicketAssignment(
    payload: FormData
): Promise<GenericResponse<TicketAssignment>>
{
    const response = await api.post<GenericResponse<TicketAssignment>>('/tickets/assign',payload,{});
    return response.data;
}

//Edit Ticket Assignment
export async function editTicketAssignment(
    ticket_assignment_id : number,
    data: Partial<TicketAssignment>

): Promise<GenericResponse<TicketAssignment>>
{
    const response = await api.post<GenericResponse<TicketAssignment>>('/tickets/reassign',{
        ticket_assignment_id, ...data
    });
    return response.data;
}