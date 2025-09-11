<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SlaEvent extends Model
{
    protected $table = 'sla_events';

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

    public function type()
    {
        return $this->belongsTo(EventType::class, 'event_type_id');
    }

    public function status()
    {
        return $this->belongsTo(Status::class, 'status_id');
    }
    public function policy()
    {
        return $this->belongsTo(SlaPolicy::class, 'sla_policy_id');
    }

    public function company()
    {
        return $this->belongsTo(Company::class,'company_id');
    }
}
