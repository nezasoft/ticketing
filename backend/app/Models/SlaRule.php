<?php
// app/Models/SlaRule.php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SlaRule extends Model
{
    protected $table = 'sla_rules';


    // Relationships
    public function policy()
    {
        return $this->belongsTo(SlaPolicy::class, 'sla_policy_id');
    }

    public function type()
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

    public function company()
    {
        return $this->belongsTo(Company::class,'company_id');
    }
}
