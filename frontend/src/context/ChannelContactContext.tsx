import { createContext, useCallback, useState, ReactNode, useMemo } from "react";
import { ContactContextType, ChannelContact, GenericResponse } from "../types";
import { listContacts, newContact, editContact, deleteContact, viewContact } from "../service/contactService";


const defaultContext: ContactContextType = {
    contact: null,
    loading: false,
    listContacts: async() => ({success: false, message:'', data:[]}),
    viewContact: async() => ({success: false, message:'', data:null}),
    newContact: async() => ({success: false, message:'', data:null}),
    editContact: async() => ({success: false, message:'', data:null}),
    deleteContact: async() => ({success: false, message:'', data:null}),

};

export const ChannelContactContext = createContext<ContactContextType>(defaultContext);

type Props = {
    children: ReactNode;
};

export const ContactProvider : React.FC<Props> = ({children}) => 
{
    const [contact, setContact] = useState<ChannelContact | null>(null);
    const [loading, setLoading] = useState<boolean>(false);
    //List
    const fetchContacts = useCallback(async (company_id: number) : Promise<GenericResponse<ChannelContact[]>> =>
    {
        setLoading(true);

        try{
            const response = await listContacts(company_id);
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
     const handleNewContact = useCallback(async (payload: FormData) : Promise<GenericResponse<ChannelContact| null>> =>
    {
      return newContact(payload);
    },[]);
    //Edit
    const handleEditContact =  useCallback(async (payload: FormData): Promise<GenericResponse<ChannelContact | null>> =>
    {
      return editContact(payload);
    },[]);
    //Delete
    const handleDeleteContact = useCallback(async (contact_id: number) : Promise<GenericResponse<null>> =>
    {
      return deleteContact(contact_id);
    },[]);

    //View
    const handleViewContact = useCallback(async (contact_id: number): Promise<GenericResponse<ChannelContact | null>> => {
        setLoading(true);
        try {
          const response = await viewContact(contact_id);
          setContact(response.data);
          return {success: true,message: 'Record retrieved successfully',data: response.data,};
        } catch (error) {
          console.error('Error viewing record', error);
          return { success: false, message: 'Error viewing record', data: null };
        } finally {
          setLoading(false);
        }
    }, []);

    const contextValue = useMemo(()=>({
        contact,
        loading,
        listContacts: fetchContacts,
        viewContact: handleViewContact,
        newContact: handleNewContact,
        editContact: handleEditContact,
        deleteContact: handleDeleteContact
    }),[
        contact,
        loading,
        fetchContacts,
        handleViewContact,
        handleNewContact,
        handleEditContact,
        handleDeleteContact
    ]);

    return (
        <ChannelContactContext.Provider value={contextValue}>
            {children}
        </ChannelContactContext.Provider>
    );
 

};
