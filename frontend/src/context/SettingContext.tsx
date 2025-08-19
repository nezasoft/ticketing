import React, {createContext,useState,useCallback,useMemo,ReactNode,useEffect} from 'react';
import {SettingContextType,Setting,AuthUser,GenericResponse} from '../types';
import {getSettings, newUser, editUser, deleteUser, viewUser} from '../service/settingsService';

const defaultContext: SettingContextType = {
  setting: null,
  user: null,
  loading: false,
  listSettings: async () => ({ success: false, message: '', data: null }),
  newUser: async () => ({success: false, message:'',data:null}),
  viewUser: async () => ({success: false, message:'',data:null}),
  editUser: async () => ({success: false, message:'', data:null}),
  deleteUser: async () => ({success:false, message:'', data:null})
};
export const SettingContext = createContext<SettingContextType>(defaultContext);

type Props = {
  children: ReactNode;
};
export const SettingProvider: React.FC<Props> = ({ children }) => {
  const [setting, setSetting] = useState<Setting | null>(null);
  const [user, setUser] = useState<AuthUser | null>(null);
  
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



  const contextValue = useMemo(() => ({
    setting,
    user,
    loading,
    listSettings: fetchSettings,
    newUser: handleNewUser,
    editUser: handleEditUser,
    deleteUser: handleDeleteUser,
    viewUser: handleViewUser
  }), [
    setting,
    user,
    loading,
    fetchSettings,
    handleNewUser,
    handleEditUser,
    handleDeleteUser,
    handleViewUser
  ]);

  return (
    <SettingContext.Provider value={contextValue}>
      {children}
    </SettingContext.Provider>
  );
};

