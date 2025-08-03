<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ChannelContact extends Model
{
    protected $table = 'channel_contacts';
    // Relationships
    public function channel()
    {
        return $this->belongsTo(Channel::class, 'channel_id');
    }

    public function company()
    {

        return $this->belongsTo(Company::class,'company_id');
    }
}
