<?php
namespace App\Services;

use App\Models\AuthUser;
use App\Models\Email;
use App\Models\Notification;
use Carbon\Carbon;

class NotificationService
{
    const REGISTRATION = 1;
    const NEW_REPLY = 2;
    const NEW_TICKET =3;

    public function saveNotifications($users, $type)
    {
        // If a single user is passed, wrap it into an array
        if (is_object($users)) {
            $users = [$users];
        }
    
        if (!empty($users) && is_iterable($users)) {
            foreach ($users as $user) {
                if (is_object($user) && isset($user->id)) {
                    $notification = new Notification();
                    $notification->user_id = $user->id;
                    $notification->type_id = $type;
                    $notification->created_at = Carbon::now();
                    $notification->save();
                }
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
            $notification->created_at = Carbon::now();

            $notification->save();
        }
    }

    public function getDepartmentUsers($email_address)
    {
        $users = [];
        $users = AuthUser::whereHas('emails', function($query) use ($email_address) {
            $query->where('email', $email_address);
        })->get();

       /* return response()->json([
            'users' => $users,
            'email' => $email_address,
        ]);*/

        return $users;
    }





}
