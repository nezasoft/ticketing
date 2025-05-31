<?php

namespace App\Http\Controllers;

use App\Models\AuthUser;
use App\Models\Company;
use App\Models\Ticket;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use App\Services\ChannelManagerService;
use App\Services\EmailService;
use App\Services\NotificationService;
use App\Services\TwillioService;
use Carbon\Carbon;

class ChannelManagerController extends Controller
{
    protected $channel;
    protected $notify;

    public function __construct(ChannelManagerService $channel_service, NotificationService $notify_service)
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
     *   a8"recipient" : "info@nezaoft.net, support@nezasoft.net"
     *   "subject": "Issue subject",
     *   "body": "Detailed message content"
     * }
     */
    public function receiveEmail(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'sender'        => 'required|email',
            'recipient'     => 'required|array',
            'recipient.*'   => 'required|email',
            'subject'       => 'required|string|min:10|max:255',
            'body'          => 'required|string|min:10|max:65535',
            'user_id'       => 'nullable|int',
        ]);

        if ($validator->fails()) {
            return $this->channel->serviceResponse('error',400,$validator->errors());
        }

        $email  = $request->input('sender') ?? $request->input('from');
        $recipient = $request->input('recipient');
        $subject = $request->input('subject');
        $description    = $request->input('body') ?? $request->input('body-html');
        $user_id = $request->input('user_id');
        $phone = '';
        if(empty($user_id))
        {
            $user_id = 0;
        }

        $company_email = $recipient[0] ?? ''; //Lets try to get the first item in the emails array
        if(empty($company_email))
        {
            return $this->channel->serviceResponse('error',400,'Company email has not been configured. Please setup your email accounts');

        }
        $company = $this->channel->identifyCompany($company_email);
        if(!$company)
        {
            $company = $this->channel->identifyCompany($email); // in scenarios where the sender is from  the organization and not an external user / entity
            if(!$company){ //lets fetch using the second email in the recipient list
                $company_email = $recipient[1] ?? '';
                $company = $this->channel->identifyCompany($company_email);
            }
        }
        $company_id = $company->company_id;
        DB::beginTransaction();
        try
        {
            $ticket = $this->channel->confirmTicket($subject);
            $support_name = $company->name;
            //First lets confirm is the response if from users email of company email
            $group_mail = $this->channel->identifyCompanyEmailAddress($email);
            $dept_id = 1;
            if($group_mail)
            {
                $support_name = $group_mail->name;
                $dept_id = $group_mail->dept_id;
            }

        if($ticket=== false)//This an entirely new thread so create a new ticket
        {
                $ticket_type = $this->channel::TICKET_TYPE_GUEST;
                $this->channel->saveChannelContact($this->channel::EMAIL_CHANNEL,$company_id ,$email);
                 //Lets start by saving the channel Contact Information
                $priority_id = $this->channel::LOW_PRIORITY;
                $customer_id = 0;
                $customer_type = $this->channel::REGULAR_CUSTOMER;
                //Before we save the ticket lets flag it as a high / low priority based on if its an existing customer
                $customer = $this->channel->identifyCustomer($email);
                $customer_name = " Esteemed Client";
                if($customer)
                {
                    $priority_id = $this->channel::HIGH_PRIORITY;
                    $ticket_type = $this->channel::TICKET_TYPE_CUSTOMER;
                    $customer_id = $customer->id;
                    $customer_name = $customer->name;
                    $customer_type = $this->channel::PREMIUM_CUSTOMER;

                }
                //Save Ticket
                $ticket = $this->channel->saveTicket($customer_id,$priority_id,$this->channel::EMAIL_CHANNEL, $subject, $this->channel::TICKET_STATUS_NEW, $description, $ticket_type, $company_id,$dept_id,$phone,$email);
                if($ticket)
                {
                    //Get the appropriate  sla policy based on these basic parameters
                    $sla_rule = $this->channel->findSLARule($priority_id, $this->channel::EMAIL_CHANNEL, $customer_type);
                    //Trigger sla events only if the sla rules and policies have been configured by the entity
                    if($sla_rule)
                    {
                        $sla_id = $sla_rule->policy->id;
                        //Lets trigger an SLA Event based on this customers profile
                        $this->channel->logSLAEvent($ticket->id, $sla_id, $this->channel::SLA_EVENT_TYPE_TICKET_CREATED, $this->channel::SLA_EVENT_TYPE_TICKET_CREATED,$company_id);
                    }

                    foreach($recipient as $to_email)
                    {
                        //Send Notifications to users who belong to the department with this email address
                        $users = $this->notify->getDepartmentUsers($to_email);
                        //Send Notification
                        $this->notify->saveNotifications($users,$this->notify::NEW_TICKET);
                        //Send Email to team
                        $this->sendConfirmationEmail($to_email,$ticket->subject,$description);
                    }
                    //send feedback to sender
                    $message = '<p>Dear '.$customer_name.',  we have received your request. Our team will reach out to you in regards to the subject matter.
                     Please use this ticket no to track the status of your ticket. </p>
                      <p> Ticket No: <strong>'.$ticket->ticket_no.'<strong></p>
                      <p>Kind Regards,</p>
                      <p>'.ucwords(strtolower($support_name)).'</p>';
                     $this->sendConfirmationEmail($email,$ticket->subject,$message);
                }

        }else{ //Update existing thread

            //save thread
            $thread = $this->channel->saveThread($ticket->id, $description, $user_id);
            if($thread)
            {
                    //Get ticket details
                    $ticket = Ticket::find($thread->ticket_id);
                    //Make sure this is the initial response
                    if($ticket->first_response_at==null)
                    {
                        //trigger sla event
                        $ticket->customer_id == 0  ? $customer_type = $this->channel::REGULAR_CUSTOMER : $customer_type = $this->channel::PREMIUM_CUSTOMER;
                        //Get the appropriate  sla policy based on these basic parameters
                        $sla_rule = $this->channel->findSLARule($ticket->priority_id, $this->channel::EMAIL_CHANNEL, $customer_type);
                        //Trigger sla events only if the sla rules and policies have been configured by the entity
                        if($sla_rule)
                        {
                            $sla_id = $sla_rule->policy->id;
                            //Lets trigger an SLA Event based on this customers profile
                            $this->channel->logSLAEvent($ticket->id, $sla_id, $this->channel::SLA_EVENT_TYPE_FIRST_RESPONSE_SENT, $this->channel::SLA_EVENT_TYPE_FIRST_RESPONSE_SENT,$company_id);
                        }

                    }

                $users = $this->notify->getDepartmentUsers($email);
                //send notification to user
                $this->notify->saveNotifications($users, $this->notify::NEW_REPLY);
                //Get Customer Details
                $customer = $this->channel->identifyCustomer($email);
                $customer_name = "Esteemed Client";
                if($customer)
                {
                    $customer_id = $customer->id;
                    $customer_name = $customer->name;
                }
                if($ticket)
                {
                    if($ticket->first_response_at==null)
                    {
                        //Update ticket details
                        $ticket->first_response_at = Carbon::now();
                        $ticket->status_id = $this->channel::TICKET_STATUS_PENDING;
                        $ticket->save();
                    }


                    //Send email response to the customer  / client
                    $message = '<p>Dear '.$customer_name.',  '.$description.' </p><p>Kind Regards,</p><p>'.ucwords(strtolower($support_name)).' Team</p>';
                    foreach($recipient as $to_email)
                    {
                        $this->sendConfirmationEmail($to_email,$ticket->subject,$message);
                    }

                }else{
                    return $this->channel->serviceResponse('error',400,'Ticket not found!');

                }

            }

        }
        DB::commit();
        return $this->channel->serviceResponse('success',200,'Email processed successfuly');
        }catch(\Exception $e)
        {
            DB::rollback();
            return $this->channel->serviceResponse('error',400,$e->getMessage());

        }


    }

    public function receiveWebPortal(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_id'=> 'required|integer|min:1',
            'department_id'=> 'required|integer|min:1',
            'company_id'=> 'required|integer|min:1',
            'subject'=> 'required|string|max:255',
            'phone'=> 'required|string|max:15',
            'email'=> 'nullable|string|max:100',
            'message'=> 'required|string|min:10|max:65535',
            ]);
            if ($validator->fails()) {
                return  $this->channel->serviceResponse('error',400,$validator->errors());
            }

            $user_id = $request->user_id;
            $department_id = $request->department_id;
            $subject = $request->subject;
            $description = $request->message;
            $phone = $request->phone;
            $email = $request->email ?? '';
            $company_id = $request->company_id;
            $user = AuthUser::find($user_id);
            $company = Company::find($company_id);
            if(!$company)
            {
                return  $this->channel->serviceResponse('error',400,'Request from invalid company');
            }
            if(!$user)
            {

                return  $this->channel->serviceResponse('error',400,'Request from invalid user');
            }

            $list_users = [];
            $department_users = $this->channel->getDepartmentUsersByDepartmentId($department_id);

            if($department_users){
                $list_users = $department_users->authUsers;
            }

            DB::beginTransaction();
            try{
                $ticket = $this->channel->confirmTicket($subject);
                if($ticket=== false)//This an entirely new thread so create a new ticket
                {
                        $ticket_type = $this->channel::TICKET_TYPE_GUEST;
                        $this->channel->saveChannelContact($this->channel::PORTAL_CHANNEL,$company_id ,$email, $phone);
                        //Lets start by saving the channel Contact Information
                        $priority_id = $this->channel::LOW_PRIORITY;
                        $customer_id = 0;
                        $customer_type = $this->channel::REGULAR_CUSTOMER;
                        //Before we save the ticket lets flag it as a high / low priority based on if its an existing customer
                        $customer = $this->channel->identifyCustomer($phone);
                        $customer_name = " Esteemed Client";
                        if($customer)
                        {
                            $priority_id = $this->channel::HIGH_PRIORITY;
                            $ticket_type = $this->channel::TICKET_TYPE_CUSTOMER;
                            $customer_id = $customer->id;
                            $customer_name = $customer->name;
                            $customer_type = $this->channel::PREMIUM_CUSTOMER;
                        }

                        //Save Ticket
                        $ticket = $this->channel->saveTicket($customer_id,$priority_id,$this->channel::PORTAL_CHANNEL, $subject, $this->channel::TICKET_STATUS_NEW, $description, $ticket_type, $company_id,$department_id,$phone, $email);
                        if($ticket)
                        {
                             //Get the appropriate  sla policy based on these basic parameters
                            $sla_rule = $this->channel->findSLARule($priority_id, $this->channel::PORTAL_CHANNEL, $customer_type);

                            //Trigger sla events only if the sla rules and policies have been configured by the entity
                            if($sla_rule)
                            {
                                $sla_id = $sla_rule->policy->id;
                                //Lets trigger an SLA Event based on this customers profile
                                $this->channel->logSLAEvent($ticket->id, $sla_id, $this->channel::SLA_EVENT_TYPE_TICKET_CREATED, $this->channel::SLA_EVENT_TYPE_TICKET_CREATED,$company_id);
                            }
                            foreach($list_users as $user)
                            {
                                //Send Notification
                                $this->notify->saveNotifications($user,$this->notify::NEW_TICKET);
                                //Send Email to team
                                $this->sendConfirmationEmail($user->email,$ticket->subject,$description);
                            }
                            //send feedback to sender
                            $message = '<p>Dear '.$customer_name.',  we have received your request. Our team will reach out to you in regards to the subject matter.
                            Please use this ticket no to track the status of your ticket. </p>
                            <p> Ticket No: <strong>'.$ticket->ticket_no.'<strong></p>
                            <p>Kind Regards,</p>
                            <p>'.ucwords(strtolower($department_users->name)).'</p>';
                            $this->sendConfirmationEmail($email,$ticket->subject,$message);
                        }

                }else{ //Update existing thread
                    $support_name = $department_users->name;
                    //save thread
                    $thread = $this->channel->saveThread($ticket->id, $description, $user_id);
                    if($thread)
                    {
                        //Get ticket details
                        $ticket = Ticket::find($thread->ticket_id);
                        //Make sure this is the initial response
                        if($ticket->first_response_at==null)
                        {
                            //trigger sla event
                            $ticket->customer_id == 0  ? $customer_type = $this->channel::REGULAR_CUSTOMER : $customer_type = $this->channel::PREMIUM_CUSTOMER;
                            //Get the appropriate  sla policy based on these basic parameters
                            $sla_rule = $this->channel->findSLARule($ticket->priority_id, $this->channel::PORTAL_CHANNEL, $customer_type);
                            //Trigger sla events only if the sla rules and policies have been configured by the entity
                            if($sla_rule)
                            {
                                $sla_id = $sla_rule->policy->id;
                                //Lets trigger an SLA Event based on this customers profile
                                $this->channel->logSLAEvent($ticket->id, $sla_id, $this->channel::SLA_EVENT_TYPE_FIRST_RESPONSE_SENT, $this->channel::SLA_EVENT_TYPE_FIRST_RESPONSE_SENT,$company_id);
                            }

                        }
                        //send notification to user
                        $this->notify->saveNotifications($list_users, $this->notify::NEW_REPLY);
                        //Get Customer Details
                        $customer = $this->channel->identifyCustomer($phone);
                        $customer_name = "Esteemed Client";
                        if($customer)
                        {
                            $customer_id = $customer->id;
                            $customer_name = $customer->name;
                        }
                        if($ticket)
                        {
                            //check if the ticket has been responded to
                            if($ticket->first_response_at==null)
                            {
                                $ticket->first_response_at = Carbon::now();
                                $ticket->status_id  = $this->channel::TICKET_STATUS_PENDING;
                                $ticket->save();
                            }

                            //Send email response to the customer  / client
                            $message = '<p>Dear '.$customer_name.',  '.$description.' </p><p>Kind Regards,</p><p>'.ucwords(strtolower($support_name)).' Team</p>';

                            if(!empty($email)){
                                $this->sendConfirmationEmail($email,$ticket->subject,$message);
                            }

                            if(!empty($phone)){
                                //send customer SMS
                                //$this->channel->sendConfirmationSMS($phone,$message);
                                //alternatively send whatsapp message
                                /*uncomment once the system goes live */
                                if (env('APP_ENV') === 'production') {
                                        $this->sendWhatsAppMessage($company_id, 'whatsapp:+'.$phone, $message);
                                }

                            }

                        }else{
                            return $this->channel->serviceResponse('error',400,'Ticket not found');
                        }

                }

                }
        DB::commit();
        return $this->channel->serviceResponse('success',200,'Portal ticket request processed successfuly');

            }catch(\Exception $e)
            {
                DB::rollback();
                return  $this->channel->serviceResponse('error',400,$e->getMessage());
            }
    }

    /**
     * Process incoming WhatsApp webhook.
     *
     * Expected Payload
     * {
    * "entry": [
    *{
    *  "id": "WHATSAPP_BUSINESS_ACCOUNT_ID",
    *  "changes": [
   *     {
    *      "value": {
   *         "messages": [
    *          {
    *            "from": "254712345678",
    *            "text": { "body": "Hello" },
    *            "id": "ABGG123...",
    *            "timestamp": "1710000000"
    *          }
    *        ],
    *        "metadata": {
    *          "phone_number_id": "1234567890",
    *          "display_phone_number": "+254700000000"
    *        }
    *      },
    *      "field": "messages"
    *    }
    *  ]
    *}
 * ]
*}

     */
    public function receiveWhatsApp(Request $request)
    {


        $validator = Validator::make($request->all(), [
            'From'=> 'required|string|max:255',
            'To'=> 'required|string|max:255',
            'Body'=> 'required|string|max:1000',
            'ProfileName'=> 'required|string|max:255',
            'WaId'=> 'required|string|max:255',
            'MessageType'=> 'required|string|max:255',

        ]);

        if ($validator->fails()) {
            return $this->channel->serviceResponse('error',400,$validator->errors());
        }

        $from = $request->input('From');       // "whatsapp:+254724802834"
        $to = $request->input('To');           // "whatsapp:+14155238886"
        $message = $request->input('Body');    // "Another one"
        $senderName = $request->input('ProfileName'); // "Walter"
        $waId = $request->input('WaId');       // WhatsApp ID, i.e. phone number
        $msgType = $request->input('MessageType'); // "text"

        \Log::info('Received WhatsApp Message', [
            'from' => $from,
            'name' => $senderName,
            'wa_id' => $waId,
            'message' => $message,
            'type' => $msgType,
        ]);

        $to = preg_replace('/[^0-9]/', '', $to);
        $from = preg_replace('/[^0-9]/', '', $from);

        $email = '';
        $whatsapp = $this->channel->validateWhatsAppBusiness($to);
        if($whatsapp==false){
                \Log::warning('Unknown WhatsApp source. Message dropped.', ['phone_no_id' => $to]);
                return $this->channel->serviceResponse('error',400,'Theres no organization associated with the WhatsApp Business ID provided');
        }

        //Identify Company using the pre configured WhatsApp Business Account
        $company = $this->channel->identifyCompanyWhatsAppBusiness($to);
        if($company==false){
                return $this->channel->serviceResponse('error',400,'WhatsApp Organization Details Not Found');
        }
        $company_id = $company->company_id;
        $list_users = [];
        $department_users = $this->channel->getDepartmentUsersByEmail($company->company->email);
        if($department_users){
                $list_users = $department_users->authUsers;
        }


        DB::beginTransaction();
        try
        {
            $ticket = $this->channel->confirmTicket($message);
            $support_name = $company->company->name;
            //First lets confirm is the response if from users email of company email
            $group_mail = $this->channel->identifyCompanyEmailAddress($company->company->email);
            $department_id = 1;
            if($group_mail)
            {
                $support_name = $group_mail->name;
                $department_id = $group_mail->dept_id;
            }

        if($ticket=== false)//This an entirely new thread so create a new ticket
        {

                $ticket_type = $this->channel::TICKET_TYPE_GUEST;
                $this->channel->saveChannelContact($this->channel::WHATSAPP_CHANNEL,$company_id ,$email,$from);
                 //Lets start by saving the channel Contact Information
                $priority_id = $this->channel::LOW_PRIORITY;
                $customer_id = 0;
                $customer_type = $this->channel::REGULAR_CUSTOMER;
                //Before we save the ticket lets flag it as a high / low priority based on if its an existing customer
                $customer = $this->channel->identifyCustomer($from);
                $customer_name = "Esteemed Client";
                if($customer)
                {
                    $priority_id = $this->channel::HIGH_PRIORITY;
                    $ticket_type = $this->channel::TICKET_TYPE_CUSTOMER;
                    $customer_id = $customer->id;
                    $customer_name = $customer->name;
                    $customer_type = $this->channel::PREMIUM_CUSTOMER;
                }
                //Save Ticket
                $ticket = $this->channel->saveTicket($customer_id,$priority_id,$this->channel::WHATSAPP_CHANNEL, $message, $this->channel::TICKET_STATUS_NEW, $message, $ticket_type, $company_id,$department_id,$from, $email);
                if($ticket)
                {
                            //Get the appropriate  sla policy based on these basic parameters
                            $sla_rule = $this->channel->findSLARule($priority_id, $this->channel::WHATSAPP_CHANNEL, $customer_type);
                            //Trigger sla events only if the sla rules and policies have been configured by the entity
                            if($sla_rule)
                            {
                                $sla_id = $sla_rule->policy->id;
                                //Lets trigger an SLA Event based on this customers profile
                                $this->channel->logSLAEvent($ticket->id, $sla_id, $this->channel::SLA_EVENT_TYPE_TICKET_CREATED, $this->channel::SLA_EVENT_TYPE_TICKET_CREATED,$company_id);
                            }

                            foreach($list_users as $user)
                            {

                                //Send Notification
                            $this->notify->saveNotifications($user,$this->notify::NEW_TICKET);
                                //Send Email to team
                                $this->sendConfirmationEmail($user->email,$ticket->subject,$message);
                            }
                            //send feedback to sender
                            $message = 'Dear '.$customer_name.',  we have received your request. Our team will reach out to you in regards to the subject matter.
                            Please use this ticket no to track the status of your ticket.
                            Ticket No: '.$ticket->ticket_no.'
                            Kind Regards,
                            '.ucwords(strtolower($support_name));
                      //send customer acknowledgement receipt
                       /*uncomment once the system goes live */
                       if (env('APP_ENV') === 'production') {
                            $this->sendWhatsAppMessage($company_id, $to, $message);
                       }
                    //
                }
        }
        DB::commit();
        return $this->channel->serviceResponse('success',200,'WhatsApp processed successfuly');
        }catch(\Exception $e)
        {
            DB::rollback();
            return $this->channel->serviceResponse('error',400,$e->getMessage());

        }

    }

    public function sendWhatsAppMessage($company_id, $to, $message)
    {
        $twilio = new TwillioService($company_id);
        $response = $twilio->sendMessage($to, $message);

        return $response->body;
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

    public function sendConfirmationEmail($email, $subject, $body)
    {
        $mailer = new EmailService();
        $sent = $mailer->sendmail($email, $subject, $body);

        return $sent ? "Email sent successfully." : "Email failed to send";

    }
}
