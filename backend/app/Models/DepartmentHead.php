<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DepartmentHead extends Model
{
    protected $table = 'department_heads';

    public function user()
    {
        return $this->belongsTo(AuthUser::class,'user_id');
    }

    public function dept()
    {
        return $this->belongsTo(Department::class,'dept_id');
    }
}
