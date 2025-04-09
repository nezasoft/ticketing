<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SlaPolicy extends Model
{
    protected $table = 'sla_policy';

    protected $fillable = [
        'name',
        'response_time_min',
        'resolve_time_min',
        'is_default',
    ];

    // Relationships
    public function slaRules()
    {
        return $this->hasMany(SlaRule::class, 'sla_policy_id');
    }
}
