<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Department extends Model
{
    protected $table = 'departments';

    public $timestamps = false;

    protected $fillable = ['name'];

    // Relationships
    public function authUsers()
    {
        return $this->hasMany(AuthUser::class, 'dept_id');
    }

    public function emails()
    {
        return $this->hasMany(Email::class,'dept_id');
    }
}
