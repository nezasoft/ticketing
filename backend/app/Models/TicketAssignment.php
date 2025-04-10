<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TicketAssignment extends Model
{
    protected $table = 'ticket_assignments';

    protected $fillable = [
        'ticket_id',
        'user_id',
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
