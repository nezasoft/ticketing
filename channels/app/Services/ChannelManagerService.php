<?php
namespace App\Services;

use App\Models\BusinessDocument;
use App\Models\ChannelContact;
use App\Models\Customer;
use App\Models\Ticket;
use Illuminate\Support\Facades\Date;

class ChannelManagerService
{
    const PORTAL_CHANNEL = 1;
    const EMAIL_CHANNEL = 2;
    const WHATSAPP_CHANNEL = 3;
    const CHATBOT_CHANNEL = 4;
    const TICKET_CODE = 'TK';
    const HIGH_PRIORITY = 1;
    const LOW_PRIORITY = 2;
    const MEDIUM_PRIORITY = 3;
    const TICKET_STATUS_NEW = 1;

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

    public function generateNumber($start, $count, $digits)
    {
        $result = array();
        for($n = $start; $n < $start + $count; $n++)
        {
            $result[] = str_pad($n, $digits, "0", STR_PAD_LEFT);
        }
        return $result;
    }

    public function generateTicketNumber()
    {
        $doc = BusinessDocument::where("doc_code",static::TICKET_CODE)->first();
        if($doc)
        {
            $numbers = $this->generateNumber($doc->document_value, 1, 8);
            foreach($numbers as $num)
            {
                $ticket_no = $doc->document_no.$num;
            }
            return $ticket_no;
        }
    }

    public function saveTicket($customer_id='',$priority_id,$channel_id, $subject, $status_id, $description)
    {
        $ticket = new Ticket;
        $ticket->ticket_no = $this->generateTicketNumber();
        $ticket->customer_id = $customer_id;
        $ticket->priority_id = $priority_id;
        $ticket->channel_id = $channel_id;
        $ticket->subject = $subject;
        $ticket->status = $status_id;
        $ticket->description = $description;
        $ticket->save();

    }
    public function identifyCustomer($customer_ref)
    {

        $customer = Customer::where('email', $customer_ref)->orWhere('phone', $customer_ref)->first();
        if($customer)
        {
            return true;
        }

        return false;
    }
    public function serviceResponse($response_type= '',$response_code= '',$response_message= '')
    {
        return response()->json([
            $response_type => 'true',
            'message'   => $response_message,
        ], $response_code);
    }

}
