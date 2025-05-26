<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TicketEscallation extends Model
{
    protected $table = 'ticket_escalations';

    public function ticket()
    {
        return $this->belongsTo(Ticket::class,'ticket_id');
    }

    public function trigger_user()
    {
        return $this->belongsTo(User::class,'triggered_by');
    }

    public function notify_user()
    {
        return $this->belongsTo(User::class,'notified_user_id');
    }
}
