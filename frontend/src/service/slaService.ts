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
    const response = await api.post<GenericResponse<SLAEvent[]>>('/slaevent/list',{company_id});
    return response.data;
}