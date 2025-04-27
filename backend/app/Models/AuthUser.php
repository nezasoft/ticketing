<?php
// app/Models/AuthUser.php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use App\Notifications\CustomResetPassword;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
class AuthUser extends Authenticatable
{
    use HasFactory, Notifiable;
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
    public function sendPasswordResetNotification($token)
    {
        $this->notify(new CustomResetPassword($token));
    }

}
