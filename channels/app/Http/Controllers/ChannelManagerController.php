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

        //Lets start by saving the channel Contact Information
        if($this->service->saveChannelContact($this->service::EMAIL_CHANNEL, $email)===true)
        {
            //Generate Ticket

        }




        // Here you could add logic to match an incoming message with an existing ticket.
        $ticket = Ticket::create([
            'channel'     => 'email',
            'source'      => $request->input('sender'),
            'subject'     => $request->input('subject'),
            'description' => $request->input('body'),
            'status'      => 'new',
        ]);

        // Optionally dispatch a job for further asynchronous processing.
        return response()->json([
            'message'   => 'Email processed successfully.',
            'ticket_id' => $ticket->id,
        ], 200);
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
            'phone'   => 'required|string',
            'message' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => 'Invalid payload.'], 400);
        }

        $ticket = Ticket::create([
            'channel'     => 'whatsapp',
            'source'      => $request->input('phone'),
            'subject'     => 'WhatsApp Message',
            'description' => $request->input('message'),
            'status'      => 'new',
        ]);

        return response()->json([
            'message'   => 'WhatsApp message processed successfully.',
            'ticket_id' => $ticket->id,
        ], 200);
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
