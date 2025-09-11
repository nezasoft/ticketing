import  {createContext,useState,useEffect,ReactNode,FC} from 'react';
import { AuthContextType, AuthUser, GenericResponse } from '../types';
import { loginUser, registerUSer, recoverPassword } from '../service/authService';
import { jwtDecode } from 'jwt-decode'; 
import { toast } from 'react-toastify';
import { tokenManager } from '../utils/tokenManager';

interface DecodedToken {
  exp: number;
  [key: string]: any;
}
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
  const storedExp = localStorage.getItem('token_exp');

  try {
    if (storedUser && storedToken) {
      setUser(JSON.parse(storedUser));
      setToken(storedToken);
    }

    if (storedExp) {
      const now = Date.now();
      const expiry = parseInt(storedExp, 10) * 1000;

      if (now >= expiry) {
        logout(); // Token already expired
      } else {
        scheduleLogout(parseInt(storedExp, 10));
      }
    }
  } catch (err) {
    console.error('Auth restore error:', err);
    localStorage.removeItem('user');
    localStorage.removeItem('token');
    localStorage.removeItem('token_exp');
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
  const decoded: DecodedToken = jwtDecode(response.data.token);
  // 🔑 Write to memory immediately
  tokenManager.setToken(response.data.token);
  // then update state / localStorage
  setUser(response.data.user);
  setToken(response.data.token);
  localStorage.setItem("user", JSON.stringify(response.data.user));
  localStorage.setItem("token_exp", decoded.exp.toString());
  scheduleLogout(decoded.exp);
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
const logout = (notify = false) => {
  // clear auth state
  setUser(null);
  setToken(null);

  // clear both memory + localStorage
  tokenManager.clear();
  localStorage.removeItem("user");
  localStorage.removeItem("token_exp");

  if (notify) {
    toast.error("Session expired. Please log in again.");
  }

  // redirect after a short delay
  /*setTimeout(() => {
    if (typeof window !== "undefined") {
      window.location.href = "/login";
    }
  }, 100);*/
};

const scheduleLogout = (exp: number) => {
  const now = Date.now();
  const expiry = exp * 1000;
  const timeout = expiry - now;

  if (timeout > 0) {
    setTimeout(() => {
      logout(true); // 👈 auto logout with toast
    }, timeout);
  } else {
    logout(true); // Token already expired
  }
};
  // Provider value                                                
  return (
    <AuthContext.Provider value={{ user, token, loading, login, logout, register, recover }}>
      {/* Render children only after auth state has hydrated */}
      {!loading && children}
    </AuthContext.Provider>
  );
};
