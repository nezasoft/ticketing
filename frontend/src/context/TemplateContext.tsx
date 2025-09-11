
import React, { createContext, ReactNode, useCallback, useMemo, useState } from 'react';
import { TemplateContextType, Template, GenericResponse} from "../types";
import { getTemplates, newTemplate, editTemplate, deleteTemplate } from '../service/templateService';

const defaultContext: TemplateContextType = {
    template: null,
    loading: false,
    //Templates
    listTemplates: async() => ({success: false, message:'',data:[]}),
    newTemplate: async () => ({success: false, message:'',data:null}),
    editTemplate: async () => ({success: false, message:'', data:null}),
    deleteTemplate: async () => ({success: false, message:'', data: null}),
    
};

export const TemplateContext = createContext<TemplateContextType>(defaultContext);

type Props = {
    children: ReactNode;
};

export const TemplateProvider: React.FC<Props> =  ({children}) =>
{
    const [template] =  useState<Template | null>(null);
    const [loading,setLoading] = useState<boolean>(false);

    const fetchTemplates = useCallback(async (company_id: number): Promise<GenericResponse<Template[]>> => {
        setLoading(true);
        try {
          const response = await getTemplates(company_id);
          return response;
        } catch (error) {
          console.error('Error fetching templates', error);
          return { success: false, message: 'Error fetching tickets', data: [] };
        } finally {
          setLoading(false);
        }
      }, []);

    /*const handleViewTemplate = useCallback(async (ticket_id: number): Promise<GenericResponse<Ticket | null>> => {
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
  }, []);*/

//Template Methods
 const handleNewTemplate = useCallback(async (payload: FormData) : Promise<GenericResponse<Template | null>> =>
{
  return newTemplate(payload);
},[]);

const handleEditTemplate =  useCallback(async (
  payload: FormData
): Promise<GenericResponse<Template | null>> =>
{
  return editTemplate(payload);
},[]);

const handleDeleteTemplate = useCallback(async (template_id: number) : Promise<GenericResponse<null>> =>
{
  return deleteTemplate(template_id);
},[]);

  const contextValue = useMemo(() => ({
    template,
    loading,
    listTemplates: fetchTemplates,
    newTemplate: handleNewTemplate,
    editTemplate: handleEditTemplate,
    deleteTemplate: handleDeleteTemplate
  }), [
    template,
    loading,
    fetchTemplates,
    handleNewTemplate,
    handleEditTemplate,
    handleDeleteTemplate,
  ]);
   return (
      <TemplateContext.Provider value={contextValue}>
        {children}
      </TemplateContext.Provider>
    );

};

