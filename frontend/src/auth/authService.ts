import api from '../api/api';
import {AuthUser, ApiResponse} from '../types';

interface LoginResponse extends ApiResponse<AuthUser>
{
    token: string;
}

export async function loginUser(email:string, password:string): Promise<LoginResponse>
{
   const response = await api.post<LoginResponse>('/user/login',{email, password});
   
   return response.data;
}