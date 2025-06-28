import React, {
  createContext,
  useState,
  useEffect,
  ReactNode,
  FC,
} from 'react';
import { AuthContextType, AuthUser, GenericResponse } from '../types';
import { loginUser, registerUSer, recoverPassword } from '../service/authService';

// 1.  Default (fallback) context value 
const defaultContext: AuthContextType = {
  user: null,
  token: null,
  loading: true,
  login: async () => ({
    success: false,
    message: '',
    data: { user: {} as AuthUser, token: '' },
  }),
  logout: () => {},
  register: async () => ({ success: false, message: '', data: null }),
  recover: async () => ({ success: false, message: '', data: null }),
};

export const AuthContext = createContext<AuthContextType>(defaultContext);

// 2.  Provider       

interface Props {
  children: ReactNode;
}

export const AuthProvider: FC<Props> = ({ children }) => {
  const [user, setUser] = useState<AuthUser | null>(null);
  const [token, setToken] = useState<string | null>(null);
  const [loading, setLoading] = useState<boolean>(true);

  // Restore auth state from localStorage on first mount 

  useEffect(() => {
    const storedUser = localStorage.getItem('user');
    const storedToken = localStorage.getItem('token');

    try {
      if (storedUser && storedToken) {
        setUser(JSON.parse(storedUser));
        setToken(storedToken);
      }
    } catch (err) {
      console.error('Auth restore error:', err);
      localStorage.removeItem('user');
      localStorage.removeItem('token');
    } finally {
      setLoading(false);
    }
  }, []);


  // Login                                                          

  const login = async (
    email: string,
    password: string
  ): Promise<GenericResponse<{ user: AuthUser; token: string }>> => {
    const response = await loginUser(email, password);

    if (response.success) {
      setUser(response.data.user);
      setToken(response.data.token);

      localStorage.setItem('user', JSON.stringify(response.data.user));
      localStorage.setItem('token', response.data.token);
    }

    return response;
  };


  // Register                                                 

  const register = async (
    email: string,
    password: string,
    phone: string,
    name: string
  ): Promise<GenericResponse<any>> => {
    return registerUSer(email, password, phone, name);
  };


  // Recover password                                              

  const recover = async (email: string): Promise<GenericResponse<any>> => {
    return recoverPassword(email);
  };


  // Logout                                                       
  const logout = () => {
    setUser(null);
    setToken(null);
    localStorage.removeItem('user');
    localStorage.removeItem('token');
  };

  // Provider value                                                
  return (
    <AuthContext.Provider
      value={{ user, token, loading, login, logout, register, recover }}
    >
      {/* Render children only after auth state has hydrated */}
      {!loading && children}
    </AuthContext.Provider>
  );
};
