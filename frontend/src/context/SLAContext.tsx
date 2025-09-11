
import React, { createContext, ReactNode, useCallback, useMemo, useState } from 'react';
import { SLAContextType, SLAEvent,SLAPolicy,SLARule, GenericResponse} from "../types";
import { getSLAPolicies, getSLAEvents, getSLARules, newSLAPolicy, newSLARule, editSLAPolicy, editSLARule, deleteSLAPolicy, deleteSLARule } from '../service/slaService';

const defaultContext: SLAContextType = {
    sla_policy: null,
    sla_rule: null,
    sla_event: null,
    loading: false,
    //List
    listSLAPolicies: async() => ({success: false, message:'',data:[]}),
    listSLARules: async() => ({success: false, message:'',data:[]}),
    listSLAEvents: async() => ({success: false, message:'',data:[]}),
    //Actions
    newSLAPolicy: async () => ({success: false, message:'',data:null}),
    editSLAPolicy: async () => ({success: false, message:'', data:null}),
    deleteSLAPolicy: async () => ({success: false, message:'', data: null}),

    newSLARule: async () => ({success: false, message:'',data:null}),
    editSLARule: async () => ({success: false, message:'', data:null}),
    deleteSLARule: async () => ({success: false, message:'', data: null}),
    
};

export const SLAContext = createContext<SLAContextType>(defaultContext);

type Props = {
    children: ReactNode;
};

export const SLAProvider: React.FC<Props> =  ({children}) =>
{
    const [sla_policy] =  useState<SLAPolicy | null>(null);
    const [sla_rule] =  useState<SLARule | null>(null);
    const [sla_event] =  useState<SLAEvent | null>(null);
    const [loading,setLoading] = useState<boolean>(false);

    //Policies
    const fetchSLAPolicies = useCallback(async (company_id: number): Promise<GenericResponse<SLAPolicy[]>> => {
        setLoading(true);
        try {
          const response = await getSLAPolicies(company_id);
          return response;
        } catch (error) {
          console.error('Error fetching records', error);
          return { success: false, message: 'Error fetching records', data: [] };
        } finally {
          setLoading(false);
        }
      }, []);
      //Events
      const fetchSLAEvents = useCallback(async (company_id: number): Promise<GenericResponse<SLAEvent[]>> => {
        setLoading(true);
        try {
          const response = await getSLAEvents(company_id);
          return response;
        } catch (error) {
          console.error('Error fetching records', error);
          return { success: false, message: 'Error fetching records', data: [] };
        } finally {
          setLoading(false);
        }
      }, []);

      //Rules
      const fetchSLARules = useCallback(async (company_id: number): Promise<GenericResponse<SLARule[]>> => {
        setLoading(true);
        try {
          const response = await getSLARules(company_id);
          return response;
        } catch (error) {
          console.error('Error fetching records', error);
          return { success: false, message: 'Error fetching records', data: [] };
        } finally {
          setLoading(false);
        }
      }, []);


//SLA Methods
 const handleNewSLAPolicy = useCallback(async (payload: FormData) : Promise<GenericResponse<SLAPolicy | null>> =>
{
  return newSLAPolicy(payload);
},[]);

const handleEditSLAPolicy =  useCallback(async (
  payload: FormData
): Promise<GenericResponse<SLAPolicy | null>> =>
{
  return editSLAPolicy(payload);
},[]);

const handleDeleteSLAPolicy = useCallback(async (template_id: number) : Promise<GenericResponse<null>> =>
{
  return deleteSLAPolicy(template_id);
},[]);


 const handleNewSLARule = useCallback(async (payload: FormData) : Promise<GenericResponse<SLARule | null>> =>
{
  return newSLARule(payload);
},[]);

const handleEditSLARule =  useCallback(async (
  payload: FormData
): Promise<GenericResponse<SLARule | null>> =>
{
  return editSLARule(payload);
},[]);

const handleDeleteSLARule = useCallback(async (template_id: number) : Promise<GenericResponse<null>> =>
{
  return deleteSLARule(template_id);
},[]);

  const contextValue = useMemo(() => ({
    sla_policy,
    sla_rule,
    sla_event,
    loading,
    listSLAPolicies: fetchSLAPolicies,
    listSLARules: fetchSLARules,
    listSLAEvents: fetchSLAEvents,
    newSLARule: handleNewSLARule,
    editSLARule: handleEditSLARule,
    deleteSLARule: handleDeleteSLARule,
    newSLAPolicy: handleNewSLAPolicy,  
    editSLAPolicy: handleEditSLAPolicy,
    deleteSLAPolicy: handleDeleteSLAPolicy,
  }), [
    sla_policy,
    sla_rule,
    sla_event,
    loading,
    fetchSLAPolicies,
    fetchSLAEvents,
    fetchSLARules,
    handleNewSLAPolicy,
    handleEditSLAPolicy,
    handleDeleteSLAPolicy,
    handleNewSLARule,
    handleEditSLARule,
    handleDeleteSLARule
  ]);

   return (
      <SLAContext.Provider value={contextValue}>
        {children}
      </SLAContext.Provider>
    );

};

