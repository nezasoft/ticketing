import api from "../api/api";
import { SLARule, SLAEvent, SLAPolicy, GenericResponse } from "../types";

//Get all SLA Rules
export async function getSLARules(company_id: number):Promise<GenericResponse<SLARule[]>>
{
    const response = await api.post<GenericResponse<SLARule[]>>('/slarule/list',{company_id});
    return response.data;
}
//Get all SLA Policies
export async function getSLAPolicies(company_id: number):Promise<GenericResponse<SLAPolicy[]>>
{
    const response = await api.post<GenericResponse<SLAPolicy[]>>('/slapolicy/list',{company_id});
    return response.data;
}

//Get All SLA Events
export async function getSLAEvents(company_id: number):Promise<GenericResponse<SLAEvent[]>>
{
    const response = await api.post<GenericResponse<SLAEvent[]>>('/slaevents/list',{company_id});
    return response.data;
}

/** SLA Policies */
//Add New
export async function newSLAPolicy(payload: FormData) : Promise<GenericResponse<SLAPolicy>>
{
  const response  = await api.post<GenericResponse<SLAPolicy>>('/slapolicy/create',payload);
  return response.data;
}
//Edit 
export  async function editSLAPolicy(payload: FormData): Promise<GenericResponse<SLAPolicy>>{
  const response = await api.post<GenericResponse<SLAPolicy>>('/slapolicy/edit',payload);
  return response.data;
}

//Delete
export async function deleteSLAPolicy(item_id: number): Promise<GenericResponse<null>> {
  const response = await api.post<GenericResponse<null>>('/slapolicy/delete', { item_id });
  return response.data;
}

/** SLA Rules */
//Add New
export async function newSLARule(payload: FormData) : Promise<GenericResponse<SLARule>>
{
  const response  = await api.post<GenericResponse<SLARule>>('/slarule/create',payload);
  return response.data;
}
//Edit 
export  async function editSLARule(payload: FormData): Promise<GenericResponse<SLARule>>{
  const response = await api.post<GenericResponse<SLARule>>('/slarule/edit',payload);
  return response.data;
}

//Delete
export async function deleteSLARule(item_id: number): Promise<GenericResponse<null>> {
  const response = await api.post<GenericResponse<null>>('/slarule/delete', { item_id });
  return response.data;
}