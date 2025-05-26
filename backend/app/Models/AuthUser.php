<?php
// app/Models/AuthUser.php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;

class AuthUser extends Authenticatable
{
    protected $table = 'auth_users';

    protected $fillable = [
        'name',
        'email',
        'password_hash',
        'phone',
        'dept_id',
        'status',
    ];

    // Relationships
    public function department()
    {
        return $this->belongsTo(Department::class, 'dept_id');
    }

    public function attachments()
    {
        return $this->hasMany(Attachment::class, 'user_id');
    }

    public function ticketAssignments()
    {
        return $this->hasMany(TicketAssignment::class, 'user_id');
    }

    public function ticketReplies()
    {
        return $this->hasMany(TicketReply::class, 'user_id');
    }

    public function emails()
    {
        return $this->hasMany(Email::class,'dept_id','dept_id');
    }
}
