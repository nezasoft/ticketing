import React, {useState} from 'react';
import api from '../../api/api';
import { useNavigate } from 'react-router-dom';


const TicketForm: React.FC = () => 
{
    const [subject, setSubject] = useState('');
    const [description, setDescription] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (e: React.FormEvent) => 
    {
        e.preventDefault();

        try{
            //Adjust payloads as required by the API implementation
            await api.post('/tickets',{subject, description});
            navigate(`/dashboard`);

        }catch(error)
        {
            console.error('Error created ticket', error);
        }
    };
    return (
        <form onSubmit={handleSubmit}>
            <h2>Create New Ticket</h2>
            <div>
                <label>Subject:</label>
                <input value={subject} onChange={(e) => setSubject(e.target.value)} required />
            </div>
            <div>
                <label>Description</label>
                <textarea value={description} onChange={(e)=>setDescription(e.target.value)} required />
            </div>
            <button type="submit">Submit Ticket</button>
        </form>

    );
};

export default TicketForm;