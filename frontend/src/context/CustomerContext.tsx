import { createContext, useCallback, useState, ReactNode, useMemo } from "react";
import { CustomerContextType, Customer, GenericResponse } from "../types";
import { listCustomers, newCustomer, editCustomer, deleteCustomer, viewCustomer } from "../service/customerService";


const defaultContext: CustomerContextType = {
    customer: null,
    loading: false,
    listCustomers: async() => ({success: false, message:'', data:[]}),
    viewCustomer: async() => ({success: false, message:'', data:null}),
    newCustomer: async() => ({success: false, message:'', data:null}),
    editCustomer: async() => ({success: false, message:'', data:null}),
    deleteCustomer: async() => ({success: false, message:'', data:null}),

};

export const CustomerContext = createContext<CustomerContextType>(defaultContext);

type Props = {
    children: ReactNode;
};

export const CustomerProvider : React.FC<Props> = ({children}) => 
{
    const [customer, setCustomer] = useState<Customer | null>(null);
    const [loading, setLoading] = useState<boolean>(false);
    //List
    const fetchCustomers = useCallback(async (company_id: number) : Promise<GenericResponse<Customer[]>> =>
    {
        setLoading(true);

        try{
            const response = await listCustomers(company_id);
            return response;
        }catch(error)
        {
            console.error('Error fetching records', error);
            return {success: false, message: 'Error fetching records', data:[]};
        }finally
        {
            setLoading(false);
        }
    },[]);

    //New
     const handleNewCustomer = useCallback(async (payload: FormData) : Promise<GenericResponse<Customer | null>> =>
    {
      return newCustomer(payload);
    },[]);
    //Edit
    const handleEditCustomer =  useCallback(async (payload: FormData): Promise<GenericResponse<Customer | null>> =>
    {
      return editCustomer(payload);
    },[]);
    //Delete
    const handleDeleteCustomer = useCallback(async (customer_id: number) : Promise<GenericResponse<null>> =>
    {
      return deleteCustomer(customer_id);
    },[]);

    //View
    const handleViewCustomer = useCallback(async (customer_id: number): Promise<GenericResponse<Customer | null>> => {
        setLoading(true);
        try {
          const response = await viewCustomer(customer_id);
          setCustomer(response.data);
          return {success: true,message: 'Record retrieved successfully',data: response.data,};
        } catch (error) {
          console.error('Error viewing record', error);
          return { success: false, message: 'Error viewing record', data: null };
        } finally {
          setLoading(false);
        }
    }, []);

    const contextValue = useMemo(()=>({
        customer,
        loading,
        listCustomers: fetchCustomers,
        viewCustomer: handleViewCustomer,
        newCustomer: handleNewCustomer,
        editCustomer: handleEditCustomer,
        deleteCustomer: handleDeleteCustomer
    }),[
        customer,
        loading,
        fetchCustomers,
        handleViewCustomer,
        handleNewCustomer,
        handleEditCustomer,
        handleDeleteCustomer
    ]);

    return (
        <CustomerContext.Provider value={contextValue}>
            {children}
        </CustomerContext.Provider>
    );
 

};
