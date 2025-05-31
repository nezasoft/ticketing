<?php

namespace App\Http\Controllers;

use App\Models\Attachment;
use App\Models\AuthUser;
use App\Models\Company;
use App\Models\SlaEvent;
use App\Models\Ticket;
use App\Models\TicketAssignment;
use App\Models\TicketReply;
use App\Services\BackendService;
use App\Services\TicketService;
use App\Services\EmailService;
use App\Services\TwillioService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
class TicketController extends Controller
{
    protected $service;
    protected $ticket_service;

    public function __construct(BackendService $service, TicketService $ticketService)
    {
        $this->service = $service;
        $this->ticket_service = $ticketService;

    }

    public function index(Request $request)
    {
        $validator = Validator::make($request->only('company_id'), [
            'company_id' => 'required|integer|exists:companies,id',
        ]);

        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }
        $data = [];
        $records = Ticket::with('company','priority','status','channel','dept')->where('company_id',$request->company_id)->get();
        if(!empty($records))
        {
            foreach($records as $record)
            {
                $data[] = [
                'id' => $record->id,
                'ticket_no' => $record->ticket_no,
                'subject' => $record->subject,
                'description' => $record->description,
                'first_response' => Carbon::parse($record->first_response_at)->format('d M Y h:i:s a'),
                'resolve_at' => Carbon::parse($record->resolve_at)->format('d M Y h:i:s a'),
                'created_at' => Carbon::parse($record->created_at)->format('d M Y h:i:s a'),
                'priority'=> $record->priority->name ?? '',
                'status' => $record->status->name ?? '',
                'channel' => $record->channel->name ?? '',
                'dept' => $record->dept->name ?? '',
                'company' => $record->company->name ?? ''
                ];
            }

        }
        return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,$this->service::SUCCESS_MESSAGE, $data);
    }

    public function show(Request $request)
    {
        $validator = Validator::make($request->only('ticket_id'),[
            'ticket_id' => 'required|integer|exists:tickets,id',
        ]);

        if($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }
        $data = [];
        $events =  [];
        $assignments = [];
        $attachments = [];
        $replies = [];

        //Get Ticket Details
        $record = Ticket::with('company','priority','status','attachments','channel','events','assignments','replies','dept')->where('id', $request->ticket_id)->first();
        if($record)
        {
            //Get Related SLA Events
            $sla_events  = SlaEvent::with('type','status','policy')->where('ticket_id',$record->id)->get();
            if(!empty($sla_events))
            {
                foreach($sla_events as $event)
                {
                    $events[] = [
                        'id' => $event->id,
                        'created_at' => Carbon::parse($event->created_at)->format('d M Y h:i:s a'),
                        'updated_at'=> Carbon::parse($event->created_at)->format('d M Y h:i:s a'),
                        'due_date'=> Carbon::parse($event->created_at)->format('d M Y h:i:s a'),
                        'event_type' => $event->type->name ?? '',
                        'status' => $event->status->name ?? '',
                        'policy' => $event->policy->name ?? '',
                    ];
                }
            }

            //Get related assignments
            $ticket_assignments = TicketAssignment::with('user')->where('ticket_id',$record->id)->get();
            if(!empty($ticket_assignments))
            {
                foreach($ticket_assignments as $assignment)
                {
                    $assignments[] = [
                        'id' => $assignment->id,
                        'created_at' => Carbon::parse($assignment->created_at)->format('d M Y h:i:s a'),
                        'updated_at' => Carbon::parse($assignment->updated_at)->format('d M Y h:i:s a'),
                        'user' => Ucfirst(strtolower($assignment->user->name ?? ''))
                    ];
                }
            }

            //Get Related Replies
            $ticket_replies = TicketReply::with('user')->where('ticket_id',$record->id)->get();
            if(!empty($ticket_replies))
            {
                foreach($ticket_replies as $reply)
                {
                    $replies[]= [
                        'id' => $reply->id,
                        'reply_message' => $reply->reply_message ?? '',
                        'reply_at' => Carbon::parse($reply->reply_at)->format('d M Y h:i:s a'),
                        'created_at' => Carbon::parse($reply->created_at)->format('d M Y h:i:s a'),
                        'updated_at' => Carbon::parse($reply->updated_at)->format('d M Y h:i:s a'),
                        'user' => $reply->user->name ?? ''

                    ];
                }
            }

            //Get Related attachments
            $ticket_attachments = Attachment::with('user')->where('ticket_id',$record->id)->get();

            if(!empty($ticket_attachments))
            {
                foreach($ticket_attachments as $attachment)
                {
                    $attachments[] = [
                        'id' => $attachment->id,
                        'file_name' => $attachment->file_name,
                        'file_path' => $attachment->file_path,
                        'created_at' => Carbon::parse($attachment->created_at)->format('d M Y h:i:s a'),
                        'updated_at'=> Carbon::parse($attachment->updated_at)->format('d M Y h:i:s a'),
                        'user' => $attachment->user->name ?? '',

                    ];
                }
            }


            $data[] = [
                    'id' => $record->id,
                    'ticket_no' => $record->ticket_no,
                    'subject' => $record->subject,
                    'description' => $record->description,
                    'first_response' => Carbon::parse($record->first_response_at)->format('d M Y h:i:s a'),
                    'resolve_at' => Carbon::parse($record->resolve_at)->format('d M Y h:i:s a'),
                    'created_at' => Carbon::parse($record->created_at)->format('d M Y h:i:s a'),
                    'priority'=> $record->priority->name ?? '',
                    'status' => $record->status->name ?? '',
                    'channel' => $record->channel->name ?? '',
                    'dept' => $record->dept->name ?? '',
                    'company' => $record->company->name  ?? '',
                    'attachments' => $attachments,
                    'events' => $events,
                    'assignments' => $assignments,
                    'replies' => $replies,
            ];
        }
        return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,$this->service::SUCCESS_MESSAGE, $data);

    }

    public function create(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_id'=> 'required|integer|exists:auth_users,id',
            'customer_id'=> 'required|integer',
            'dept_id'=> 'required|integer|exists:departments,id',
            'priority_id'=> 'required|integer|exists:priorities,id',
            'company_id'=> 'required|integer|exists:companies,id',
            'ticket_type_id'=> 'required|integer|exists:ticket_types,id',
            'subject'=> 'required|string|max:255',
             'phone' => [
                'required',
                'regex:/^\+\d{10,15}$/'
            ],
            'email'=> 'nullable|email|max:100',
            'description'=> 'required|string|min:10|max:65535',
        ], [
            'phone.regex' => 'Phone number must include the country code and start with a + sign.',
        ]);
        if($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }

        $user_id = $request->user_id;
        $customer_id = $request->customer_id;
        $dept_id = $request->dept_id;
        $priority_id = $request->priority_id;
        $company_id = $request->company_id;
        $ticket_type = $request->ticket_type_id;
        $subject = $request->subject;
        $description = $request->description;
        $phone = substr($request->phone,1);
        $email = $request->email;

        $user = AuthUser::find($user_id);
        $company = Company::find($company_id);
        $list_users = [];
        $department_users = $this->ticket_service->getDepartmentUsersByDepartmentId($dept_id);

        if($department_users){
            $list_users = $department_users->authUsers;
        }
        DB::beginTransaction();
        try
        {
            $ticket = $this->ticket_service->confirmTicket($subject);
            if($ticket=== false)//This an entirely new thread so create a new ticket
                {
                        $ticket_type = $this->ticket_service::TICKET_TYPE_GUEST;
                        $this->ticket_service->saveChannelContact($this->ticket_service::PORTAL_CHANNEL,$company_id ,$email, $phone);
                        //Lets start by saving the channel Contact Information
                        $customer_type = $this->ticket_service::REGULAR_CUSTOMER;
                        //Before we save the ticket lets flag it as a high / low priority based on if its an existing customer
                        $customer = $this->ticket_service->identifyCustomer($phone);
                        $customer_name = " Esteemed Client";
                        if($customer)
                        {
                            $customer_id = $customer->id;
                            $customer_name = $customer->name;
                            $customer_type = $this->ticket_service::PREMIUM_CUSTOMER;
                        }

                        //Save Ticket
                        $ticket = $this->ticket_service->saveTicket($customer_id,$priority_id,$this->ticket_service::PORTAL_CHANNEL, $subject, $this->ticket_service::TICKET_STATUS_NEW, $description, $ticket_type, $company_id,$dept_id);
                        if($ticket)
                        {
                             //Get the appropriate  sla policy based on these basic parameters
                            $sla_rule = $this->ticket_service->findSLARule($priority_id, $this->ticket_service::PORTAL_CHANNEL, $customer_type);

                            //Trigger sla events only if the sla rules and policies have been configured by the entity
                            if($sla_rule)
                            {
                                $sla_id = $sla_rule->policy->id;
                                //Lets trigger an SLA Event based on this customers profile
                                $this->ticket_service->logSLAEvent($ticket->id, $sla_id, $this->ticket_service::SLA_EVENT_TYPE_TICKET_CREATED, $this->ticket_service::SLA_EVENT_TYPE_TICKET_CREATED,$company_id);
                            }
                            foreach($list_users as $user)
                            {
                                //Send Notification
                                $this->ticket_service->saveNotifications($user,$this->ticket_service::NEW_TICKET);
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
                    $thread = $this->ticket_service->saveThread($ticket->id, $description, $user_id);
                    if($thread)
                    {
                        //Get ticket details
                        $ticket = Ticket::find($thread->ticket_id);
                        //Make sure this is the initial response
                        if($ticket->first_response_at==null)
                        {
                            //trigger sla event
                            $ticket->customer_id == 0  ? $customer_type = $this->ticket_service::REGULAR_CUSTOMER : $customer_type = $this->ticket_service::PREMIUM_CUSTOMER;
                            //Get the appropriate  sla policy based on these basic parameters
                            $sla_rule = $this->ticket_service->findSLARule($ticket->priority_id, $this->ticket_service::PORTAL_CHANNEL, $customer_type);
                            //Trigger sla events only if the sla rules and policies have been configured by the entity
                            if($sla_rule)
                            {
                                $sla_id = $sla_rule->policy->id;
                                //Lets trigger an SLA Event based on this customers profile
                                $this->ticket_service->logSLAEvent($ticket->id, $sla_id, $this->ticket_service::SLA_EVENT_TYPE_FIRST_RESPONSE_SENT, $this->ticket_service::SLA_EVENT_TYPE_FIRST_RESPONSE_SENT,$company_id);
                            }

                        }
                        //send notification to user
                        $this->ticket_service->saveNotifications($list_users, $this->ticket_service::NEW_REPLY);
                        //Get Customer Details
                        $customer = $this->ticket_service->identifyCustomer($phone);
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
                                $ticket->status_id  = $this->ticket_service::TICKET_STATUS_PENDING;
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

                                if (env('APP_ENV') === 'production') {
                                        $this->sendWhatsAppMessage($company_id, 'whatsapp:+'.$phone, $message);
                                }
                            }

                        }else{

                             return $this->service->serviceResponse($this->service::FAILED_FLAG, 400,'Ticket not found' );
                        }

                }

                }
                DB::commit();
                 return $this->service->serviceResponse($this->service::SUCCESS_FLAG, 200,'Ticket raised successfully' );

        }catch(\Exception $e){
            DB::rollback();
        }
    }

     public function sendConfirmationEmail($email, $subject, $body)
    {
        $mailer = new EmailService();
        $sent = $mailer->sendmail($email, $subject, $body);

        return $sent ? "Email sent successfully." : "Email failed to send";

    }
    public function sendWhatsAppMessage($company_id, $to, $message)
    {
        $twilio = new TwillioService($company_id);
        $response = $twilio->sendMessage($to, $message);

        return $response->body;
    }
}
