<?php
// app/Models/Ticket.php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    protected $table = 'ticket';

    protected $fillable = [
        'ticket_no',
        'customer_id',
        'priority_id',
        'channel_id',
        'subject',
        'status_id',
        'description',
        'first_response_at',
        'resolved_at',
    ];

    // Relationships
    public function priority()
    {
        return $this->belongsTo(Priority::class, 'priority_id');
    }

    public function channel()
    {
        return $this->belongsTo(Channel::class, 'channel_id');
    }

    public function status()
    {
        return $this->belongsTo(Status::class, 'status_id');
    }

    public function attachments()
    {
        return $this->hasMany(Attachment::class, 'ticket_id');
    }

    public function slaEvents()
    {
        return $this->hasMany(SlaEvent::class, 'ticket_id');
    }

    public function ticketAssignments()
    {
        return $this->hasMany(TicketAssignment::class, 'ticket_id');
    }

    public function ticketReplies()
    {
        return $this->hasMany(TicketReply::class, 'ticket_id');
    }
}
