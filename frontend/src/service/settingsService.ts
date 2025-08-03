import api from '../api/api';
import {GenericResponse,Setting} from '../types';

//Get All System Settigs
export async function getSettings(company_id:number):Promise<GenericResponse<Setting>>
{
  try
  {
    const response = await api.post<GenericResponse<Setting[]>>(
        '/settings/all',
        { company_id }
      );
      return {
      success: true,
      message: 'Setting retrieved successfully',
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
        data: {} as Setting, // or null if you change GenericResponse<T | null>
      };
    }
     
}