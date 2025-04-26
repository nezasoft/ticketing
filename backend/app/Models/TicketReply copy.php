<?php
// app/Models/TicketReply.php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TicketReply extends Model
{
    protected $table = 'ticket_replies';

    protected $fillable = [
        'ticket_id',
        'user_id',
        'reply_message',
        'reply_at',
    ];

    // Relationships
    public function ticket()
    {
        return $this->belongsTo(Ticket::class, 'ticket_id');
    }

    public function user()
    {
        return $this->belongsTo(AuthUser::class, 'user_id');
    }
}
