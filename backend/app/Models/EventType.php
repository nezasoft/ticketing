<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EventType extends Model
{
    protected $table = 'event_type';

    public $timestamps = false;

    protected $fillable = ['name'];

    // Relationships
    public function slaEvents()
    {
        return $this->hasMany(SlaEvent::class, 'event_type_id');
    }
}
