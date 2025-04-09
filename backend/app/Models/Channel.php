<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Channel extends Model
{
    protected $table = 'channel';

    protected $fillable = ['name'];

    // Relationships
    public function contacts()
    {
        return $this->hasMany(ChannelContact::class, 'channel_id');
    }

    public function slaRules()
    {
        return $this->hasMany(SlaRule::class, 'channel_id');
    }

    public function tickets()
    {
        return $this->hasMany(Ticket::class, 'channel_id');
    }
}
