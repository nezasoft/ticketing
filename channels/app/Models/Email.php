<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Email extends Model
{
    protected $table = 'emails';


    public function department()
    {
        return $this->belongsTo(Department::class,'dept_id','id');
    }
    public function user()
    {
        return $this->hasMany(AuthUser::class,'user_id','id');
    }
}
