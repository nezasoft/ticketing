import api from '../api/api';
import {AuthUser, Department, Email, GenericResponse,Setting, Integration, Template} from '../types';

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
      console.error("Settings error:", {
        success: error.response?.success,
        message: error.message,
        data: error.response?.data,
      });
  
      // Return the correct error structure
      return {
        success: false,
        message: 'Settings fetch failed',
        data: {} as Setting, // or null if you change GenericResponse<T | null>
      };
    }
     
}

//Delete User Function
export async function deleteUser( user_id: number): Promise<GenericResponse<any>>
{
  const response = await api.post<GenericResponse<any>>('/users/delete',{
    user_id

  });
  return response.data;
}

//Add New User 
export async function newUser(payload: FormData): Promise<GenericResponse<AuthUser>>
{

  const response = await api.post<GenericResponse<AuthUser>>(
    '/users/create',payload,

  );
  return response.data;
}

//View User
export async function viewUser(
  user_id: number
): Promise<GenericResponse<AuthUser>>
{
  try{
    const response = await api.post<GenericResponse<AuthUser[]>>('/users/show',{
      user_id
    });

    return {
      success: true,
      message: 'User retrieved successfully',
      data: response.data.data[0],
    };
  }catch(error: any)
  {
    console.error('View User Error:',{
      success: error.response?.success,
      message: error.message,
      data: error.response?.data,
    });

    return {
      success: false,
      message: 'User fetch failed',
      data: {} as AuthUser
    };
  }
}

//Edit User
export async function editUser
(
  payload: FormData
): Promise<GenericResponse<AuthUser>>
{
  const response = await api.post<GenericResponse<AuthUser>>('/users/edit',
    {
    payload
    }
  );
  return response.data;
}

//Add New Department
export async function newDepartment(payload: FormData) : Promise<GenericResponse<Department>>
{
  const response = await api.post<GenericResponse<Department>>(
    '/department/create',payload,
  );
  return response.data;
}

//Edit Department
export async function editDepartment(
  payload: FormData
): Promise<GenericResponse<Department>>
{
  const response = await api.post<GenericResponse<Department>>('/department/edit',payload);
  return response.data;
}

//Delete Department
export async function deleteDepartment( dept_id : number): Promise<GenericResponse<any>>
{
  const response = await api.post<GenericResponse<any>>('/department/delete',dept_id);
  return response.data;
}

//Add New Email
export async function newEmail(payload: FormData) : Promise<GenericResponse<Email>>
{
  const response  = await api.post<GenericResponse<Email>>('/email/create',payload);
  return response.data;
}
//Edit Email 
export  async function editEmail(payload: FormData): Promise<GenericResponse<Email>>{
  const response = await api.post<GenericResponse<Email>>('/email/edit',payload);
  return response.data;
}

//Delete Email
export async function deleteEmail(email_id: number): Promise<GenericResponse<null>>
{
  const response = await api.post<GenericResponse<null>>('/email/delete',email_id);
  return response.data;
}

//Add New  Integration Setting
export async function newIntegration(payload: FormData) : Promise<GenericResponse<Integration>>
{
  const response  = await api.post<GenericResponse<Integration>>('/integration/create',payload);
  return response.data;
}
//Edit Integration Setting
export  async function editIntegration(payload: FormData): Promise<GenericResponse<Integration>>{
  const response = await api.post<GenericResponse<Integration>>('/integration/edit',payload);
  return response.data;
}

//Delete Integration Setting
export async function deleteIntegration(integration_id: number): Promise<GenericResponse<null>>
{
  const response = await api.post<GenericResponse<null>>('/integration/delete',integration_id);
  return response.data;
}

//Email Templates

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
