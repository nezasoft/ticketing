<?php

namespace App\Http\Controllers;

use App\Models\Ticket;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Services\ChannelManagerService;

class ChannelManagerController extends Controller
{
    protected $service;

    public function __construct(ChannelManagerService $service)
    {
        $this->service = $service;

    }

    /**
     * Process incoming email webhook.
     *
     * Expected payload:
     * {
     *   "sender": "user@example.com",
     *   "subject": "Issue subject",
     *   "body": "Detailed message content"
     * }
     */
    public function receiveEmail(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'sender'  => 'required|email',
            'subject' => 'required|string',
            'body'    => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid payload.'], 400);
        }

        $email = $request->input('sender');
        $subject = $request->input('subject');
        $description = $request->input('body');

        //Lets start by saving the channel Contact Information
        if($this->service->saveChannelContact($this->service::EMAIL_CHANNEL, $email)===true)
        {
            $priority_id = $this->service::LOW_PRIORITY;
            //Before we save the ticket lets flag it as a high / low priority based on if its an existing customer
            if($this->service->identifyCustomer($email))
            {
                $priority_id = $this->service::HIGH_PRIORITY;
            }
            //Save Ticket
            $this->service->saveTicket($customer_id='',$priority_id,$this->service::EMAIL_CHANNEL, $subject, $this->service::TICKET_STATUS_NEW, $description);
        }

        return $this->service->serviceResponse('success',200,'Email processed successfuly');
    }

    /**
     * Process incoming WhatsApp webhook.
     *
     * Expected payload:
     * {
     *   "phone": "+1234567890",
     *   "message": "Message content here"
     * }
     */
    public function receiveWhatsApp(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'phone'   => 'required|string|max:255',
            'message' => 'required|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid payload.'], 400);
        }
        $phone = $request->input('phone');
        $message = $request->input('message');

             //Lets start by saving the channel Contact Information
             if($this->service->saveChannelContact($this->service::WHATSAPP_CHANNEL, $phone)===true)
             {
                 $priority_id = $this->service::LOW_PRIORITY;
                 //Before we save the ticket lets flag it as a high / low priority based on if its an existing customer
                 if($this->service->identifyCustomer($phone))
                 {
                     $priority_id = $this->service::HIGH_PRIORITY;
                 }
                 //Save Ticket
                 $this->service->saveTicket($customer_id='',$priority_id,$this->service::WHATSAPP_CHANNEL, $message, $this->service::TICKET_STATUS_NEW, $message);
             }

             return $this->service->serviceResponse('success',200,'WhatsApp message processed successfully.');


    }

    /**
     * Process incoming Chatbot webhook.
     *
     * Expected payload:
     * {
     *   "user_id": 123,
     *   "message": "Chatbot message text"
     * }
     */
    public function receiveChatbot(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_id' => 'required|integer',
            'message' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid payload.'], 400);
        }

        $ticket = Ticket::create([
            'channel'     => 'chatbot',
            'source'      => $request->input('user_id'),
            'subject'     => 'Chatbot Message',
            'description' => $request->input('message'),
            'status'      => 'new',
        ]);

        return response()->json([
            'message'   => 'Chatbot message processed successfully.',
            'ticket_id' => $ticket->id,
        ], 200);
    }
}
