<?php
// app/Models/Ticket.php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    protected $table = 'tickets';

    protected $fillable = [
        'ticket_no',
        'customer_id',
        'priority_id',
        'channel_id',
        'subject',
        'status_id',
        'ticket_type_id',
        'company_id',
        'description',
        'first_response_at',
        'resolved_at',
    ];

    // Relationships'
    public function company()
    {
        return $this->belongsTo(Company::class,'company_id');
    }
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

    public function events()
    {
        return $this->hasMany(SlaEvent::class, 'ticket_id');
    }

    public function assignments()
    {
        return $this->hasMany(TicketAssignment::class, 'ticket_id');
    }

    public function replies()
    {
        return $this->hasMany(TicketReply::class, 'ticket_id');
    }

    public function dept()
    {
        return $this->belongsTo(Department::class,'dept_id');
    }
}
