<?php

namespace App\Http\Controllers;

use App\Models\Attachment;
use App\Models\AuthUser;
use App\Models\Company;
use App\Models\SlaEvent;
use App\Models\Department;
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
                'email' => $record->email ?? '',
                'phone' => $record->phone ?? '',
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
                    'phone' => $record->phone ?? '',
                    'email' => $record->email ?? '',
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
            'email'=> 'nullable|email|max:500',
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
        $dept= Department::find($dept_id);

        $list_users = [];
        $department_users = $this->ticket_service->getDepartmentUsersByDepartmentId($dept_id);

        if($department_users){
            $list_users = $department_users->authUsers;
        }
        DB::beginTransaction();
        try
        {

                        $ticket_type = $this->ticket_service::TICKET_TYPE_GUEST;
                        $this->ticket_service->saveChannelContact($this->ticket_service::PORTAL_CHANNEL,$company_id ,$email, $phone);
                        //Lets start by saving the channel Contact Information
                        $customer_type = $this->ticket_service::REGULAR_CUSTOMER;
                        //Before we save the ticket lets flag it as a high / low priority based on if its an existing customer
                        $customer = $this->ticket_service->identifyCustomer($phone);
                        $customer_name = "Esteemed Client";
                        if($customer)
                        {
                            $customer_id = $customer->id;
                            $customer_name = $customer->name;
                            $customer_type = $this->ticket_service::PREMIUM_CUSTOMER;
                        }
                        //Save Ticket
                        $ticket = $this->ticket_service->saveTicket($customer_id,$priority_id,$this->ticket_service::PORTAL_CHANNEL, $subject, $this->ticket_service::TICKET_STATUS_NEW, $description, $ticket_type, $company_id,$dept_id, $phone, $email);
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
                            if(!empty($email))
                            {
                                //send feedback to sender
                                $data = ["ticket_no"=>$ticket->ticket_no,"name"=>$customer_name,"department"=>$dept->name];
                                $template = "create-ticket";
                                $this->service->sendEmail($email,$template, $data);
                            }
                        }
                 DB::commit();
                 return $this->service->serviceResponse($this->service::SUCCESS_FLAG, 200,'Ticket raised successfully' );

        }catch(\Exception $e){
            DB::rollback();
        }
    }

    public function edit(Request $request)
    {
         $validator = Validator::make($request->all(), [
            'ticket_id' => 'required|integer|exists:tickets,id',
            'user_id'=> 'required|integer|exists:auth_users,id',
            'status_id'=> 'required|integer|exists:statuses,id',
            'customer_id'=> 'required|integer',
            'dept_id'=> 'required|integer|exists:departments,id',
            'priority_id'=> 'required|integer|exists:priorities,id',
            'ticket_type_id'=> 'required|integer|exists:ticket_types,id',
            'phone' => [
                'required',
                'regex:/^\+\d{10,15}$/'
            ],
            'email'=> 'nullable|email|max:50',
        ], [
            'phone.regex' => 'Phone number must include the country code and start with a + sign.',
        ]);
        if($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }
        //Get ticket details
        $ticket = Ticket::find($request->ticket_id);
        if($ticket)
        {
            $ticket->customer_id = $request->customer_id;
            $ticket->dept_id = $request->dept_id;
            $ticket->priority_id = $request->priority_id;
            $ticket->ticket_type_id = $request->ticket_type_id;
            $ticket->status_id = $request->status_id;
            $ticket->updated_at = Carbon::now();

            if($ticket->save())
            {
                $dept = Department::find($request->dept_id);
                $list_users = [];
                $department_users = $this->ticket_service->getDepartmentUsersByDepartmentId($request->dept_id);
                if($department_users){
                    $list_users = $department_users->authUsers;
                }
                //Before we save the ticket lets flag it as a high / low priority based on if its an existing customer
                $customer_type = $this->ticket_service::REGULAR_CUSTOMER;
                $customer = $this->ticket_service->identifyCustomer($request->phone);
                $customer_name = "Esteemed Client";
                if($customer)
                {
                    $customer_id = $customer->id;
                    $customer_name = $customer->name;
                    $customer_type = $this->ticket_service::PREMIUM_CUSTOMER;
                }
                //If the ticket is closed then we need to trigger the appropriate SLA Event and send customer email notification
                if($ticket->status_id==$this->ticket_service::TICKET_STATUS_CLOSED)
                {
                            //Get the appropriate  sla policy based on these basic parameters
                            $sla_rule = $this->ticket_service->findSLARule($ticket->priority_id, $this->ticket_service::PORTAL_CHANNEL, $customer_type);
                            //Trigger sla events only if the sla rules and policies have been configured by the entity
                            if($sla_rule)
                            {
                                $sla_id = $sla_rule->policy->id;
                                //Lets trigger an SLA Event based on this customers profile
                                $this->ticket_service->logSLAEvent($ticket->id, $sla_id, $this->ticket_service::SLA_EVENT_TYPE_TICKET_CLOSED, $request->status_id,$ticket->company_id);
                            }
                            foreach($list_users as $user)
                            {
                                $description = 'Ticket  <strong>'.$ticket->ticket_no.'-'.$ticket->subject.'</strong> has been closed ';
                                //Send Notification
                                $this->ticket_service->saveNotifications($user,$this->ticket_service::TICKET_CLOSED);
                                //Send Email to team
                                $this->sendConfirmationEmail($user->email,$ticket->subject,$description);
                            }
                            if(!empty($email))
                            {
                                //send feedback to sender
                                $data = ["ticket_no"=>$ticket->ticket_no,"department"=>$dept->name];
                                $template = "close-ticket";
                                $this->service->sendEmail($request->email,$template, $data);
                            }
                }elseif($ticket->status_id==$this->ticket_service::TICKET_STATUS_RESOLVED)
                {
                            //Get the appropriate  sla policy based on these basic parameters
                            $sla_rule = $this->ticket_service->findSLARule($ticket->priority_id, $this->ticket_service::PORTAL_CHANNEL, $customer_type);
                            //Trigger sla events only if the sla rules and policies have been configured by the entity
                            if($sla_rule)
                            {
                                $sla_id = $sla_rule->policy->id;
                                //Lets trigger an SLA Event based on this customers profile
                                $this->ticket_service->logSLAEvent($ticket->id, $sla_id, $this->ticket_service::SLA_EVENT_TYPE_TICKET_RESOLVED, $request->status_id,$ticket->company_id);
                            }
                            foreach($list_users as $user)
                            {
                                $description = 'Ticket  <strong>'.$ticket->ticket_no.'-'.$ticket->subject.'</strong> has been resolved ';
                                //Send Notification
                                $this->ticket_service->saveNotifications($user,$this->ticket_service::TICKET_RESOLVED);
                                //Send Email to team
                                $this->sendConfirmationEmail($user->email,$ticket->subject,$description);
                            }
                            if(!empty($email))
                            {
                                //send feedback to sender
                                $data = ["ticket_no"=>$ticket->ticket_no,"department"=>$dept->name];
                                $template = "resolve-ticket";
                                $this->service->sendEmail($request->email,$template, $data);
                            }
                }
                return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,'Request processed successfuly');
            }
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,400, 'Failed processing this request. Please try again!');

    }

    public function reply(Request $request)
    {
         $validator = Validator::make($request->all(), [
            'ticket_id' => 'required|integer|exists:tickets,id',
            'user_id'=> 'required|integer|exists:auth_users,id',
            'description' => 'required|string|min:10|max:65535',
            'agent_signature' => 'required|string|max:20'
        ]);
        if($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }

        $ticket = Ticket::find($request->ticket_id);
        if($ticket)
        {
            $user = AuthUser::find($request->user_id);
            $list_users = [];
            $department_users = $this->ticket_service->getDepartmentUsersByDepartmentId($ticket->dept_id);

            if($department_users){
                $list_users = $department_users->authUsers;
            }
                    $support_name = $department_users->name;
                    //save thread
                    $thread = $this->ticket_service->saveThread($ticket->id, $request->description, $request->user_id);
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
                            $sla_rule = $this->ticket_service->findSLARule($ticket->priority_id, $ticket->channel_id, $customer_type);
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
                        if($ticket)
                        {
                            //check if the ticket has been responded to
                            if($ticket->first_response_at==null)
                            {
                                $ticket->first_response_at = Carbon::now();
                            }
                            $ticket->status_id  = $this->ticket_service::TICKET_STATUS_PENDING;
                            $ticket->save();
                            //Send email response to the customer  / client
                            if(!empty($ticket->email)){
                                $data = ["ticket_no"=>$ticket->ticket_no,"agent_sign"=>$request->agent_signature,"content"=>$request->description];
                                $template = "ticket-reply";
                                $this->service->sendEmail($ticket->email,$template, $data);
                            }
                            if(!empty($ticket->phone)){
                                //send customer SMS
                                //$this->channel->sendConfirmationSMS($phone,$message);
                                //alternatively send whatsapp message
                                if (env('APP_ENV') === 'production') {
                                        $this->sendWhatsAppMessage($ticket->company_id, 'whatsapp:+'.$ticket->phone, $request->description);
                                }
                            }
                            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,'Request processed successfuly');

                        }else{

                             return $this->service->serviceResponse($this->service::FAILED_FLAG, 400,'Ticket not found' );
                        }
                }
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,400, 'Failed processing this request. Please try again!');

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
