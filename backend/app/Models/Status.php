<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Status extends Model
{
    protected $table = 'status';

    public $timestamps = false;

    protected $fillable = []; // Add fields if needed.

    // Relationships
    public function slaEvents()
    {
        return $this->hasMany(SlaEvent::class, 'status_id');
    }

    public function tickets()
    {
        return $this->hasMany(Ticket::class, 'status_id');
    }
}
