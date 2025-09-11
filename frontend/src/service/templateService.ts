import api from '../api/api';
import { Template, GenericResponse } from '../types';

//Get All Templates
export  async function getTemplates(company_id: number):Promise<GenericResponse<Template[]>>
{
  const response = await api.post<GenericResponse<Template[]>>('/templates/list',{company_id});
   return response.data;
}

//Add New
export async function newTemplate(payload: FormData) : Promise<GenericResponse<Template>>
{
  const response  = await api.post<GenericResponse<Template>>('/templates/create',payload);
  return response.data;
}
//Edit 
export  async function editTemplate(payload: FormData): Promise<GenericResponse<Template>>{
  const response = await api.post<GenericResponse<Template>>('/templates/edit',payload);
  return response.data;
}

//Delete
export async function deleteTemplate(template_id: number): Promise<GenericResponse<null>>
{
  const response = await api.post<GenericResponse<null>>('/templates/delete',template_id);
  return response.data;
}

