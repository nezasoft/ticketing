import React, {useState, useContext} from 'react';

import { AuthContext } from './AuthContext';
import { useNavigate } from 'react-router-dom';



const Login: React.FC = () => 
{
    const { login } = useContext(AuthContext);
    const navigate = useNavigate();
    const [email, setEmail]  = useState('');
    const [password, setPassword] = useState('');


    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();

        try{
            await login(email,password);
            navigate('/dashboard');

        }catch(error)
        {
            console.error('Login Error:', error);
        }
    };

return (
    <form onSubmit={handleSubmit}>
        <h2>Login</h2>
        <div>
            <label>Email</label>
            <input type="email" value="{email}" onChange={(e)=> setEmail(e.target.value)} required />
        </div>
        <div>
            <label>Password:</label>
            <input type="password" value={password} onChange={(e)=> setPassword(e.target.value)} required />
        </div>
        <button type="submit">Login</button>
    </form>

)
    

};

export default Login;