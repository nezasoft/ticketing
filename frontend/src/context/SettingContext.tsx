import React, {createContext,useState,useCallback,useMemo,ReactNode,useEffect} from 'react';
import {SettingContextType,Setting,AuthUser,Department,Email,EventType, GenericResponse} from '../types';
import {getSettings, newUser, editUser, deleteUser, viewUser,
  newDepartment, editDepartment, deleteDepartment, newEmail, editEmail, deleteEmail
 } from '../service/settingsService';

const defaultContext: SettingContextType = {
  setting: null,
  user: null,
  dept: null,
  email: null,
  eventType: null,
  loading: false,
  listSettings: async () => ({ success: false, message: '', data: null }),
  newUser: async () => ({success: false, message:'',data:null}),
  viewUser: async () => ({success: false, message:'',data:null}),
  editUser: async () => ({success: false, message:'', data:null}),
  deleteUser: async () => ({success:false, message:'', data:null}),
  //Departments
  newDepartment: async () => ({success: false, message:'',data:null}),
  editDepartment: async () => ({success: false, message:'',data:null}),
  deleteDepartment: async () => ({success:false, message:'', data:null}),
  //Emails
  newEmail: async () => ({success: false, message:'',data:null}),
  editEmail: async () => ({success: false, message:'', data:null}),
  deleteEmail: async () => ({success: false, message:'', data: null})
};
export const SettingContext = createContext<SettingContextType>(defaultContext);

type Props = {
  children: ReactNode;
};
export const SettingProvider: React.FC<Props> = ({ children }) => {
  const [setting, setSetting] = useState<Setting | null>(null);
  const [user, setUser] = useState<AuthUser | null>(null);
  const [dept, setDept] = useState<Department | null>(null);
  const [email,setEmail] = useState<Email | null>(null);
  const [eventType] = useState<EventType | null >(null);
  
  const [loading, setLoading] = useState<boolean>(false);

    // Load from localStorage on init
    useEffect(() => {
        const stored = localStorage.getItem('app_settings');
        if (stored) {
        try {
            setSetting(JSON.parse(stored));
        } catch (err) {
            console.warn('Failed to parse settings from localStorage', err);
        }
        }
    }, []);

  const fetchSettings = useCallback(async (company_id: number): Promise<GenericResponse<Setting | null>> => {
    setLoading(true);
    try {
      const response = await getSettings(company_id);
      setSetting(response.data);
    // Persist to localStorage
      localStorage.setItem('app_settings', JSON.stringify(response.data));

      return {
        success: true,
        message: 'Settings retrieved successfully',
        data: response.data,
      };
    } catch (error) {
      console.error('Error retrieving settings', error);
      return { success: false, message: 'Error viewing ticket', data: null };
    } finally {
      setLoading(false);
    }
  }, []);

  //Edit user
  const handleEditUser = useCallback(async (
    payload: FormData
  ): Promise<GenericResponse<AuthUser | null>> => 
  {
    return editUser(payload);
  },[]);

  //New User 
  const handleNewUser = useCallback(async (payload: FormData) : Promise<GenericResponse<AuthUser | null>> =>
  {
    return newUser(payload);
  },[] );

//Delete user 
  const handleDeleteUser = useCallback(async (
    user_id: number
  ): Promise<GenericResponse<null>> =>
    {
      return deleteUser(user_id);
    },
  []);

  //View user
  const handleViewUser = useCallback(async (user_id: number): Promise<GenericResponse<AuthUser | null>> =>
  {
    setLoading(true);
    try
    {
      const response = await viewUser(user_id);
      setUser(response.data);
      return{
        success: true,
        message: 'User retrieved successfully',
        data: response.data,
      };
    }catch(error)
    {
      console.error('Error viewing user',error);
      return {success: false, message: 'Error viewing user', data:null};
    }finally{
      setLoading(false);
    }
  },[]);


  //Departments Methods
  //Add New
  const handleNewDepartment = useCallback(async (payload: FormData) : Promise<GenericResponse<Department | null>> =>
    {
      return newDepartment(payload);
    },[]);
  //Edit Department
  const handleEditDepartment = useCallback(async (
    payload: FormData
  ): Promise<GenericResponse<Department | null>> =>
  {
    return editDepartment(payload);
  },[]);
  //Delete Department
  const handleDeleteDepartment = useCallback(async (
    dept_id: number
  ): Promise<GenericResponse<null>> =>
    {
      return deleteDepartment(dept_id);
    },
  []);
 //Email Settings Methods
 const handleNewEmail = useCallback(async (payload: FormData) : Promise<GenericResponse<Email | null>> =>
{
  return newEmail(payload);
},[]);

const handleEditEmail =  useCallback(async (
  payload: FormData
): Promise<GenericResponse<Email | null>> =>
{
  return editEmail(payload);
},[]);

const handleDeleteEmail = useCallback(async (email_id: number) : Promise<GenericResponse<null>> =>
{
  return deleteEmail(email_id);
},[]);


  const contextValue = useMemo(() => ({
    setting,
    user,
    dept,
    email,
    eventType,
    loading,
    listSettings: fetchSettings,
    newUser: handleNewUser,
    editUser: handleEditUser,
    deleteUser: handleDeleteUser,
    viewUser: handleViewUser,
    newDepartment: handleNewDepartment,
    editDepartment: handleEditDepartment,
    deleteDepartment: handleDeleteDepartment,
    newEmail: handleNewEmail,
    editEmail: handleEditEmail,
    deleteEmail: handleDeleteEmail
  }), [
    setting,
    user,
    dept,
    email,
    eventType,
    loading,
    fetchSettings,
    handleNewUser,
    handleEditUser,
    handleDeleteUser,
    handleViewUser,
    handleNewDepartment,
    handleEditDepartment,
    handleDeleteDepartment,
    handleNewEmail,
    handleEditEmail,
    handleDeleteEmail,
  ]);

  return (
    <SettingContext.Provider value={contextValue}>
      {children}
    </SettingContext.Provider>
  );
};

