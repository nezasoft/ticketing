<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ChannelContact extends Model
{
    protected $table = 'channel_contacts';

    // Because the table uses non-standard column names for timestamps:
    public $timestamps = false;

    protected $fillable = [
        'channel_id',
        'email',
        'phone',
        'date_created',
        'date_updated',
    ];

    // Relationships
    public function channel()
    {
        return $this->belongsTo(Channel::class, 'channel_id');
    }
}
