<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class NotificationType extends Model
{
    protected $table = "notification_types";
    protected $fillable = ['message','type_id','company_id','icon_class'];

    public function notifications()
    {
        return $this->hasMany(Notification::class,'type_id','id');
    }
}
