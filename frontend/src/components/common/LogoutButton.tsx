import React, {useContext} from 'react';
import { AuthContext } from '../../context/AuthContext';
import { useNavigate, Link } from 'react-router-dom';

const LogoutButton: React.FC = () => 
{
    const {logout} = useContext(AuthContext);
    const navigate = useNavigate();

    const handleLogout = () => 
    {
        logout(); //Clear token and user
        navigate('/login'); //Redirect to Login
    };

    return(
        <Link to="#"
        onClick={handleLogout} 
        className="block px-3 py-2 hover:bg-gray-50 dark:hover:bg-zinc-700 text-gray-800 dark:text-gray-100 text-sm"
        >
        <i className="mdi mdi-logout mr-1" /> Logout
        </Link>
    );

};

export default LogoutButton;