<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    protected $table = 'notifications';

    protected $fillable = ['user_id','type_id'];

    public function type()
    {
        return $this->belongsTo(NotificationType::class,"type_id");
    }

    public function user()
    {
        return $this->belongsTo(AuthUser::class,"user_id");
    }


}
