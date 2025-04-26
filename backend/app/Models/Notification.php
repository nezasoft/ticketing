<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    protected $table = 'notifications';

    protected $fillable = ['user_id','type_id'];

    public function notification_types()
    {
        return $this->belongsTo(NotificationType::class);
    }
}
