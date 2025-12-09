import api from "../api/api";
import { GenericResponse, ChannelContact } from "../types";


//Get all contacts
export async function listContacts(company_id: number) : Promise<GenericResponse<ChannelContact[]>>
{

    const response = await api.post<GenericResponse<ChannelContact[]>>('/contacts/list',{company_id});
    return response.data;

}

//New Contact
export async function newContact(payload: FormData) : Promise<GenericResponse<ChannelContact>>
{
    const response = await api.post<GenericResponse<ChannelContact>>('/contacts/create',payload);
    return response.data;
}

//Edit Contact
export async function editContact(payload: FormData) : Promise<GenericResponse<ChannelContact>>
{
    const response = await api.post<GenericResponse<ChannelContact>>('/contacts/edit',payload);
    return response.data;
}

//Delete Contact
export async function deleteContact(contact_id: number) : Promise<GenericResponse<null>>
{
    const response = await api.post<GenericResponse<null>>('/contacts/delete',{contact_id});
    return response.data;
}

//View Contact
export async function viewContact(contact_id: number): Promise<GenericResponse<ChannelContact>> {
  try {
    const response = await api.post<GenericResponse<ChannelContact[]>>('/contacts/show', {contact_id});
    return {success: true,message: 'Contact retrieved successfully',data: response.data.data[0]};
  } catch (error: any) {
    console.error("View Contact error:", {success: error.response?.success,message: error.message,data: error.response?.data});
    // Return the correct error structure
    return {success: false,message: 'Contact fetch failed',data: {} as ChannelContact};
  }
}