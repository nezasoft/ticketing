<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SlaEvent extends Model
{
    protected $table = 'sla_event';

    public $timestamps = false;

    protected $fillable = [
        'ticket_id',
        'event_type_id',
        'status_id',
        'due_date',
        'met_at',
    ];

    // Relationships
    public function ticket()
    {
        return $this->belongsTo(Ticket::class, 'ticket_id');
    }

    public function eventType()
    {
        return $this->belongsTo(EventType::class, 'event_type_id');
    }

    public function status()
    {
        return $this->belongsTo(Status::class, 'status_id');
    }
}
