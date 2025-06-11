import React, {createContext, useState, ReactNode, useEffect} from 'react';

import { AuthContextType, AuthUser } from '../types';
import {loginUser} from './authService';

export const AuthContext = createContext<AuthContextType>({
    user: null,
    token: null,
    login: async () => {},
    logout: () => {}
});

interface Props {
    children: ReactNode;
}

export const AuthProvider: React.FC<Props> = ({children}) =>
{
    const [user, setUser] = useState<AuthUser | null>(null);
    const [token, setToken] = useState<string | null>(null);

    useEffect(()=>{
        //Optionally, load token/user info from localStorage on init
        const storedUser = localStorage.getItem('user');
        const storedToken = localStorage.getItem('token');

        if(storedUser && storedToken)
        {
            setUser(JSON.parse(storedUser));
            setToken(storedToken);
        }
    },[]);

    const login = async(email: string, password:string) => {
        const data = await loginUser(email,password);
        setUser(data.data);
        setToken(data.token);

        localStorage.setItem('user', JSON.stringify(data.data));
        localStorage.setItem('token',data.token);
    };

    const logout = () => {
        setUser(null);
        setToken(null);
        localStorage.removeItem('user');
        localStorage.removeItem('token');
    };

    return (
    <AuthContext.Provider value={{user, token, login, logout}}>
        {children}
    </AuthContext.Provider>)
}