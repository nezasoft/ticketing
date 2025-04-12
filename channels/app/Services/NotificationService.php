<?php
namespace App\Services;

use App\Models\AuthUser;
use App\Models\Email;
use App\Models\Notification;
use App\Models\User;

class NotificationService
{
    const REGISTRATION = 1;
    const NEW_REPLY = 2;
    const NEW_TICKET =3;

    public function saveNotifications($users,$type)
    {

        if(!empty($users))
        {
            foreach($users as $user)
            {
                $notification = new Notification();
                $notification->user_id = $user->id;
                $notification->type_id = $type;
                $notification->save();
            }
        }

    }
    public function saveNotification($user,$type)
    {
        if(!empty($user))
        {
            $notification = new Notification();
            $notification->user_id = $user->id;
            $notification->type_id = $type;
            $notification->save();
        }
    }

    public function getDepartmentUsers($email)
    {

        $email = Email::where('email', $email)->first();

        if ($email && $email->department) {
            $users = $email->department->users;
        }
        return $users;
    }




}
