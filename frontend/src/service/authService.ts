import api from '../api/api';
import { AuthUser, GenericResponse } from '../types';

// Login function
export async function loginUser(
  email: string,
  password: string
): Promise<GenericResponse<{ user: AuthUser; token: string }>> {
  const response = await api.post<GenericResponse<{ user: AuthUser; token: string }>>(
    '/user/login',
    { email, password }
  );

  return response.data;
}

// Register function
export async function registerUSer(
  email: string,
  password: string,
  name: string,
  phone: string
): Promise<GenericResponse<any>> {
  const response = await api.post<GenericResponse<any>>('/user/create', {
    name,
    email,
    phone,
    password,
  });

  return response.data;
}

// Recover Password function
export async function recoverPassword(
  email: string
): Promise<GenericResponse<any>> {
  const response = await api.post<GenericResponse<any>>('/user/recover', {
    email,
  });

  return response.data;
}
