import React, {useEffect, useState} from 'react';
import {useParams} from 'react-router-dom';
import api from '../api/api';

import {Ticket} from '../types';


const TicketView: React.FC = () =>
{
    const { id } = useParams<{ id: string }>();
    const [ticket, setTicket] = useState<Ticket | null>(null);
    const [loading, setLoading] = useState<boolean>(true);

    useEffect(()=>{
        async function fetchTicket()
        {
            try{
            const response = await api.get<{data: Ticket}>(`/ticket/${id}`);
            setTicket(response.data.data);
            }catch(error)
            {
                console.error('Error fetching ticket details:', error);

            }finally{
                setLoading(false);
            }

        }
        fetchTicket();
        
    },[id]);

    if(loading) return <p>Loading ticket details...</p>
    if(!ticket) return <p>Ticket not found</p>;

    return (
        <div>
            <h2>{ticket.subject}</h2>
            <p>{ticket.description}</p>
            <p>Ticket No: {ticket.ticket_no}</p>
            <p>Status: {ticket.status_id}</p>
            {/* You can implement a section for replies as well. */}
            
        </div>
    );
};

export default TicketView;