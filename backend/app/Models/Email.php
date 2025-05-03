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
    public function priority()
    {
        return $this->belongsTo(Priority::class,'priority_id','id');
    }

}
