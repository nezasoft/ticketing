<?php
namespace App\Services;

use App\Models\ChannelContact;
use Illuminate\Support\Facades\Date;

class ChannelManagerService
{
    const PORTAL_CHANNEL = 1;
    const EMAIL_CHANNEL = 2;
    const WHATSAPP_CHANNEL = 3;
    const CHATBOT_CHANNEL = 4;

    public function saveChannelContact($channel_id, $email='', $phone='')
    {
        $channel_contact = ChannelContact::create([
            'channel_id'=> $channel_id,
            'email'=> $email,
            'phone' => $phone,
            'created_at'=> Date::now(),
        ]);

        if($channel_contact)
        {
            return true;
        }

        return false;
    }

    public function generateRandomString()
    {

    }

    public function generateTicketNumber()
    {
        $ticket_no = 12345555;

        return $ticket_no;
    }

    public function saveTickect($ticket_no,$customer_id='',$priority_id,$channel_id, $subject, $status_id, $description )
    {


    }

}
