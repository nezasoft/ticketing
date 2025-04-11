<?php
namespace App\Services;

use App\Models\BusinessDocument;
use App\Models\ChannelContact;
use App\Models\Customer;
use App\Models\Ticket;
use App\Models\TicketReply;
use Carbon\Carbon;


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
            'created_at'=> Carbon::now(),
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
            $this->updateTicketNumberSequence($doc->id);
            return $ticket_no;
        }
    }

    public function updateTicketNumberSequence($id)
    {
        $doc = BusinessDocument::find($id);
        $doc->increment('document_value');
    }

    public function saveTicket($customer_id='',$priority_id,$channel_id, $subject, $status_id, $description)
    {
        $ticket_no = $this->generateTicketNumber();
        $ticket = new Ticket;
        $ticket->ticket_no = $ticket_no;
        $ticket->customer_id = $customer_id;
        $ticket->priority_id = $priority_id;
        $ticket->channel_id = $channel_id;
        $ticket->subject = $subject.'['.$ticket_no.']';
        $ticket->status = $status_id;
        $ticket->description = $description;
        $ticket->save();

        //Update Ticket No

    }

    public function saveThread($ticket_id, $message)
    {
        $thread = new TicketReply;
        $thread->ticket_id = $ticket_id;
        $thread->reply_message = $message;
        $thread->reply_at = Carbon::now();
        $thread->save();

    }
    public function identifyCustomer($customer_ref)
    {

        $customer = Customer::where('email', $customer_ref)->orWhere('phone', $customer_ref)->first();
        if($customer)
        {
            return $customer;
        }

        return false;
    }
    public function confirmTicket($title)
    {
        $ticket = Ticket::where('title', $title)->first();
        if($ticket)
        {
            return $ticket;

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
