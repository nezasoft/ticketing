<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Priority extends Model
{
    protected $table = 'priority';

    public $timestamps = false;

    protected $fillable = ['name'];

    // Relationships
    public function tickets()
    {
        return $this->hasMany(Ticket::class, 'priority_id');
    }

    public function slaRules()
    {
        return $this->hasMany(SlaRule::class, 'priority_id');
    }
}

