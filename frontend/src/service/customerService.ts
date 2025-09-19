import api from "../api/api";
import { GenericResponse, Customer } from "../types";


//Get all customers
export async function listCustomers(company_id: number) : Promise<GenericResponse<Customer[]>>
{

    const response = await api.post<GenericResponse<Customer[]>>('/customer/list',{company_id});
    return response.data;

}

//New Customer
export async function newCustomer(payload: FormData) : Promise<GenericResponse<Customer>>
{
    const response = await api.post<GenericResponse<Customer>>('/customer/create',payload);
    return response.data;
}

//Edit Customer
export async function editCustomer(payload: FormData) : Promise<GenericResponse<Customer>>
{
    const response = await api.post<GenericResponse<Customer>>('/customer/edit',payload);
    return response.data;
}

//Delete Customer
export async function deleteCustomer(customer_id: number) : Promise<GenericResponse<null>>
{
    const response = await api.post<GenericResponse<null>>('/customer/delete',{customer_id});
    return response.data;
}

//View Customer
export async function viewCustomer(customer_id: number): Promise<GenericResponse<Customer>> {
  try {
    const response = await api.post<GenericResponse<Customer[]>>('/customer/show', {customer_id});
    return {success: true,message: 'Customer retrieved successfully',data: response.data.data[0]};
  } catch (error: any) {
    console.error("View Customer error:", {success: error.response?.success,message: error.message,data: error.response?.data});
    // Return the correct error structure
    return {success: false,message: 'Customer fetch failed',data: {} as Customer};
  }
}