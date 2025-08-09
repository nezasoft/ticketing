import React from 'react';
import { Ticket } from '../../types';
import {Link} from 'react-router-dom';

interface TicketCardProps
{
    ticket: Ticket;
}

const TicketCard: React.FC<TicketCardProps> = ({ticket}) => {
    return (
        <div className="ticket-card" style={{ border: '1px solid #ccc', padding: '1rem', marginBottom: '1rem' }}>
            <h3>{ticket.subject || 'No Subject' }</h3>
            <p>{ticket.description?.substring(0,100)}...</p>
            <small>Ticket No: {ticket.ticket_no}</small>

            <br/>
            <Link to={`/tickets/${ticket.id}`}>View Details</Link>
        </div>
    );
};

export default TicketCard;