<?php
// app/Models/SlaRule.php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SlaRule extends Model
{
    protected $table = 'sla_rule';

    public $timestamps = false;

    protected $fillable = [
        'sla_policy_id',
        'customer_type_id',
        'priority_id',
        'channel_id',
    ];

    // Relationships
    public function slaPolicy()
    {
        return $this->belongsTo(SlaPolicy::class, 'sla_policy_id');
    }

    public function customerType()
    {
        return $this->belongsTo(CustomerType::class, 'customer_type_id');
    }

    public function priority()
    {
        return $this->belongsTo(Priority::class, 'priority_id');
    }

    public function channel()
    {
        return $this->belongsTo(Channel::class, 'channel_id');
    }
}
