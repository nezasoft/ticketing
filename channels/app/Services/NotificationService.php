<?php
namespace App\Services;

use App\Models\Notification;
use App\Models\User;

class NotificationService
{
    const REGISTRATION = 1;
    const NEW_REPLY = 2;
    const NEW_TICKET =3;

    public function saveNotification($user,$type)
    {
        $notification = new Notification();
        $notification->user_id = $user->id;
        $notification->type_id = $type;
        $notification->save();

    }


}
