<?php
namespace App\Services;
use App\Models\AuthUser;
use App\Models\BusinessDocument;
use App\Models\ChannelContact;
use App\Models\Customer;
use App\Models\Department;
use App\Models\Email;
use App\Models\SlaEvent;
use App\Models\SlaPolicy;
use App\Models\SlaRule;
use App\Models\Ticket;
use App\Models\TicketReply;
use App\Models\WhatsApp;
use App\Models\Notification;
use Carbon\Carbon;
class TicketService
{

    //Channel Types
    const PORTAL_CHANNEL = 1;
    const EMAIL_CHANNEL = 2;
    const WHATSAPP_CHANNEL = 3;
    const CHATBOT_CHANNEL = 4;
    const TICKET_CODE = 'TK';
    //Priorities
    const HIGH_PRIORITY = 1;
    const LOW_PRIORITY = 2;
    const MEDIUM_PRIORITY = 3;
    //Ticket Status
    const TICKET_STATUS_NEW = 1;
    const TICKET_STATUS_RESOLVED = 2;
    const TICKET_STATUS_PENDING = 3;
     const TICKET_STATUS_ARCHIVED = 4;
    const TICKET_STATUS_CLOSED = 5;
    const TICKET_TYPE_CUSTOMER = 1;
    const TICKET_TYPE_GUEST = 2;
    //SLA Events
    const SLA_EVENT_TYPE_TICKET_CREATED = 1;
    const SLA_EVENT_TYPE_FIRST_RESPONSE_SENT = 2;
    const SLA_EVENT_TYPE_TICKET_ASSIGNED = 3;
    const SLA_EVENT_TYPE_TICKET_STATUS_CHANGED = 4;
    const SLA_EVENT_TYPE_TICKET_CUSTOMER_RESPONSE = 5;
    const SLA_EVENT_TYPE_TICKET_RESOLVED = 6;
    const SLA_EVENT_TYPE_TICKET_CLOSED = 7;
    const SLA_EVENT_TYPE_TICKET_SLA_BREACH = 8;
    const SLA_EVENT_TYPE_TICKET_ESCALATION = 9;

    const PREMIUM_CUSTOMER = 1;
    const REGULAR_CUSTOMER = 2;

    //Notifications
    const REGISTRATION = 1;
    const NEW_REPLY = 2;
    const NEW_TICKET =3;
    const TICKET_CLOSED = 4;
    const TICKET_RESOLVED = 5;


    public function saveChannelContact($channel_id,$company_id, $email='', $phone='')
    {
       // First Confirm the contact already exists
       $contact = ChannelContact::where(['email'=> $email])->orWhere(['phone'=> $phone])->first();
       if(!$contact)
       {
             ChannelContact::create([
                'channel_id'=> $channel_id,
                'email'=> $email,
                'phone' => $phone,
                'company_id' => $company_id,
                'created_at'=> Carbon::now(),
            ]);
       }
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

    public function saveTicket($customer_id=0,$priority_id,$channel_id, $subject, $status_id, $description, $ticket_type, $company_id,$dept_id, $phone='', $email='')
    {

        $ticket_no = $this->generateTicketNumber();
        $ticket = new Ticket;
        $ticket->ticket_no = $ticket_no;
        $ticket->customer_id = $customer_id;
        $ticket->priority_id = $priority_id;
        $ticket->channel_id = $channel_id;
        $ticket->subject = $subject.'- ['.$ticket_no.']';
        $ticket->status_id = $status_id;
        $ticket->description = $description;
        $ticket->created_at = Carbon::now();
        $ticket->ticket_type_id = $ticket_type;
        $ticket->company_id = $company_id;
        $ticket->dept_id = $dept_id;
        $ticket->phone = $phone;
        $ticket->email = $email;
        $ticket->save();

        if($ticket)
        {
            return $ticket;
        }

        return false;

    }

    public function saveThread($ticket_id, $message, $user_id)
    {
        $thread = new TicketReply;
        $thread->ticket_id = $ticket_id;
        $thread->user_id = $user_id;
        $thread->reply_message = $message;
        $thread->created_at = Carbon::now();
        $thread->reply_at = Carbon::now();
        $thread->save();

        if($thread)
        {
            return $thread;
        }

        return false;

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
    public function identifyCompany($email)
    {
        $email = Email::where('email',$email)->first();
        if($email)
        {
            return $email;

        }
        return false;

    }

    //This method will confirm if this email address belongs to users within the company
    //Or external entities. If the email belongs to users within the company return thier identities

    public function identifyCompanyEmailAddress($email)
    {
        $company = Email::where('email',$email)->first();
        if($company)
        {
            return $company;
        }
        return false;
    }

    public function identifyCompanyWhatsAppBusiness($phone)
    {
        $company = WhatsApp::with('company')->where('phone_no_id',$phone)->first();
        if($company)
        {
            return $company;
        }
        return false;
    }
    public function confirmTicket($title)
    {
        $ticket = Ticket::where('subject', $title)->first();
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
    public function getDepartmentUsersByUserId($user_id)
    {
        $user = AuthUser::find($user_id);
        if($user)
        {
            //Lets Get his department id
            $dept_id = $user->dept_id;
            $department = Department::with('emails')->with('authUsers')->where('id', $dept_id)->first();
            if($department)
            {
                return $department;
            }
            return false;
        }
        return false;
    }

    public function getDepartmentUsersByDepartmentId($department_id)
    {
        $department = Department::with('emails')->with('authUsers')->where('id', $department_id)->first();
        if($department)
        {
            return $department;
        }
        return false;
    }

    public function getDepartmentUsersByEmail($email)
    {
        $department = Department::with(['emails', 'authUsers'])->whereHas('emails', function($query) use ($email) {
                $query->where('email', $email);
            })->first();
        if ($department) {
            return $department;
        }
        return false;
    }

    //This method is used to validate WhatsApp Business IDs
    public function validateWhatsAppBusiness($phone_no_id)
    {
        $wb = WhatsApp::where(['phone_no_id'=>$phone_no_id])->first();
        if($wb)
        {
            return $wb;
        }
        return false;
    }
    public function sendConfirmationSMS($phone, $message)
    {
        return ;
    }
    public function SLADueDate($sla_id, $start_date, $event_type)
    {
        $sla_min = 0;
        $sla_policy = SlaPolicy::find($sla_id);
        if($sla_policy)
        {
            if($event_type==static::SLA_EVENT_TYPE_TICKET_CREATED)
            {
                $sla_min = (int)$sla_policy->response_time_min;
            }elseif($event_type==static::SLA_EVENT_TYPE_TICKET_ASSIGNED)
            {
                $sla_min = (int)$sla_policy->resolve_time_min;
            }
        }
        $due_date = date('Y-m-d H:i:s', strtotime("+{$sla_min} minutes", strtotime($start_date)));
        return $due_date;
    }
    public function logSLAEvent($ticket_id, $sla_id, $event_type, $ticket_status,$company_id)
    {
        //Lets trigger an SLA Event based on this customers profile
        $sla_event = new SlaEvent;
        $sla_event->ticket_id = $ticket_id;
        $sla_event->event_type_id = $event_type;
        $sla_event->status_id = $ticket_status;
        $sla_event->due_date = $this->SLADueDate($sla_id, Carbon::now(), $event_type);
        $sla_event->company_id = $company_id;
        $sla_event->sla_policy_id = $sla_id;
        $sla_event->save();
    }
    public function findSLARule($priority_id, $channel, $customer_type): ?SlaRule
    {
        $sla_rule = SlaRule::with('policy')->where('priority_id',$priority_id)->where('channel_id',$channel)->where('customer_type_id',$customer_type)->first();
        return $sla_rule;
    }


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
