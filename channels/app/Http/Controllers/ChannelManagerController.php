<?php

namespace App\Http\Controllers;

use App\Models\Ticket;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Services\ChannelManagerService;
use App\Services\NotificationService;

class ChannelManagerController extends Controller
{
    protected $channel;
    protected $notify;


    public function __construct(ChannelManagerService $channel_service, NotificationService $notify_service )
    {
        $this->channel = $channel_service;
        $this->notify = $notify_service;

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

        $email  = $request->input('sender') ?? $request->input('from');
        $subject = $request->input('subject');
        $description    = $request->input('body-plain') ?? $request->input('body-html');
    

        $ticket = $this->channel->confirmTicket($subject);

        if($ticket=== false)//This an entirely new thread so create a new ticket
        {
            //Lets start by saving the channel Contact Information
            if($this->channel->saveChannelContact($this->channel::EMAIL_CHANNEL, $email)===true)
            {
                $priority_id = $this->channel::LOW_PRIORITY;
                $customer_id = '';
                //Before we save the ticket lets flag it as a high / low priority based on if its an existing customer
                $customer = $this->channel->identifyCustomer($email);
                if($customer)
                {
                    $priority_id = $this->channel::HIGH_PRIORITY;
                    $customer_id = $customer->id;
                }
                //Save Ticket
                $ticket = $this->channel->saveTicket($customer_id,$priority_id,$this->channel::EMAIL_CHANNEL, $subject, $this->channel::TICKET_STATUS_NEW, $description);
                if($ticket===true)
                {
                    //Send Notifications to users who belong to the department with this email address
                    $users = $this->notify->getDepartmentUsers($email);
                    //Send Notification
                    $this->notify->saveNotifications($users,$this->notify::NEW_TICKET);
                }

            }

        }else{ //Update existing thread

            //save thread
            $thread = $this->channel->saveThread($ticket->id, $description);
            if($thread==true)
            {
                $users = $this->notify->getDepartmentUsers($email);
                //send notification to user
                $this->notify->saveNotifications($users, $this->notify::NEW_REPLY);
            }

        }

        return $this->channel->serviceResponse('success',200,'Email processed successfuly');
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
             if($this->channel->saveChannelContact($this->channel::WHATSAPP_CHANNEL, $phone)===true)
             {
                 $priority_id = $this->channel::LOW_PRIORITY;
                 //Before we save the ticket lets flag it as a high / low priority based on if its an existing customer
                 if($this->channel->identifyCustomer($phone))
                 {
                     $priority_id = $this->channel::HIGH_PRIORITY;
                 }
                 //Save Ticket
                 $this->channel->saveTicket($customer_id='',$priority_id,$this->channel::WHATSAPP_CHANNEL, $message, $this->channel::TICKET_STATUS_NEW, $message);
             }

             return $this->channel->serviceResponse('success',200,'WhatsApp message processed successfully.');

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
