<?php

namespace App\Http\Controllers;

use App\Models\AuthUser;
use App\Models\Channel;
use App\Models\CountryCode;
use App\Models\Customer;
use App\Models\CustomerType;
use App\Models\Department;
use App\Models\Email;
use App\Models\EventType;
use App\Models\IntegrationSetting;
use App\Models\NotificationType;
use App\Models\Priority;
use App\Models\Role;
use App\Models\SlaPolicy;
use App\Models\Status;
use App\Models\Template;
use App\Models\TicketType;
use App\Services\BackendService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class SettingsController extends Controller
{

    protected $service;

    public function __construct(BackendService $backendService)
    {
        $this->service = $backendService;

    }
    public function getPriorities()
    {
        $data =[];
        $records = Priority::orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id' => $record->id,
                    'name'=> $record->name,
                ];
            }
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, 'Success',$data);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200,'No records found!');

    }

    public function getTicketTypes()
    {
        $data =[];
        $records = TicketType::orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id' => $record->id,
                    'name'=> $record->name,
                ];
            }
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, 'Success',$data);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200,'No records found!');

    }

    public function getTicketStatus()
    {
        $data =[];
        $records = Status::orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id' => $record->id,
                    'name'=> $record->name,
                ];
            }
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, 'Success',$data);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200,'No records found');
    }

    public function getNotificationTypes()
    {
        $data =[];
        $records = NotificationType::orderBy('id','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id' => $record->id,
                    'message'=> $record->message,
                    'type' => $record->type,
                    'icon_class' => $record->icon_class,
                ];
            }
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, 'Success',$data);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200,'No records found');
    }

    public function getRoles()
    {
        $data = [];
        $records = Role::where('id','>',1)->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id'=> $record->id,
                    'name'=> $record->name
                ];
            }
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, '',$data);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,400,'No records found');
    }

    public function getChannels()
    {
        $data = [];
        $records = Channel::orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id'=> $record->id,
                    'name'=> $record->name
                ];
            }
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, '',$data);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,400,'No records found');

    }

    public function getAllSettings(Request $request)
    {

        $validator = Validator::make($request->only('company_id'), [
            'company_id' => 'required|integer|exists:companies,id',
        ]);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $data = [];
        $priorities = [];
        $roles = [];
        $notification_types = [];
        $ticket_status = [];
        $channels = [];
        $departments = [];
        $country_codes = [];
        $customer_types = [];
        $sla_policies =[];
        $customers = [];
        $users = [];
        $emails = [];
        $event_types= [];
        $integrations = [];
        $templates = [];
        $records = Channel::orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $channels[] = [
                    'id'=> $record->id,
                    'name'=> $record->name
                ];
            }
        }

        $records = Priority::orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $priorities[] = [
                    'id'=> $record->id,
                    'name'=> $record->name
                ];
            }
        }

        $records = Role::orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $roles[] = [
                    'id'=> $record->id,
                    'name'=> $record->name
                ];
            }
        }
        $records = EventType::orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $event_types[] = [
                    'id'=> $record->id,
                    'name'=> $record->name
                ];
            }
        }

        $records = NotificationType::orderBy('id','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $notification_types[] = [
                    'id' => $record->id,
                    'message'=> $record->message,
                    'type' => $record->type,
                    'icon_class' => $record->icon_class,
                ];
            }
        }

        $records = Status::orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $ticket_status[] = [
                    'id' => $record->id,
                    'name'=> $record->name,
                ];
            }
        }

        $records = Department::where('company_id',$request->company_id)->orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $departments[] = [
                    'id' => $record->id,
                    'name'=> $record->name,
                ];
            }
        }

        $records = CountryCode::orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $country_codes[] = [
                    'id' => $record->id,
                    'name'=> $record->name,
                    'nice_name'=> $record->nicename,
                    'iso'=> $record->iso,
                    'numcode'=> $record->numcode,
                    'phonecode'=> $record->phonecode,
                ];
            }
        }

        $records = CustomerType::where('company_id',$request->company_id)->orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $customer_types[] = [
                    'id' => $record->id,
                    'name'=> $record->name
                ];
            }
        }
        $records = IntegrationSetting::where('company_id',$request->company_id)->orderBy('code','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $integrations[] = [
                    'id' => $record->id,
                    'code'=> $record->code,
                    'value' => $record->value
                ];
            }
        }


        $records = Email::where('company_id',$request->company_id)->orderBy('name','asc')->get();
        if(count($records) !=0)
        {
            foreach($records as $record)
            {
                $emails[]=[
                    'id' => $record->id,
                    'name' => $record->name,
                    'email'=> $record->email,
                    'department' => $record->department->name ?? '',
                    'priority' => $record->priority->name ?? '',
                    'dept_id' => $record->dept_id,
                    'priority_id' => $record->priority_id,
                    'username' => $record->username,
                    'password' => $record->password,
                    'host' => $record->fetching_host,
                    'incoming_port' => $record->fetching_port,
                    'outgoing_port'=> $record->sending_port,
                    'protocol' => $record->fetching_protocol,
                    'encryption' => $record->fetching_encryption,
                    'folder' => $record->folder,
                    'active' => $record->active == 1 ? 'Yes' : 'No',

                ];
            }
        }

        $records = SlaPolicy::where('company_id',$request->company_id)->orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $sla_policies[] = [
                    'id' => $record->id,
                    'name'=> $record->name
                ];
            }
        }

        $records =  Customer::where('company_id',$request->company_id)->orderBy('name','asc')->get();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $customers[] = [
                    'id' => $record->id,
                    'name'=> $record->name,
                    'email'=> $record->email ?? '',
                    'phone'=> $record->phone ?? '',
                    'client_no' => $record->client_no ?? '',
                    'account_no' => $record->account_no ?? ''
                ];
            }
        }
        $records = AuthUser::with('department','role')->where('company_id', $request->company_id)->orderBy('name', 'asc')->get();
        if(count($records)!=0)
        {
            foreach($records as $record)
            {
                $created_at = Carbon::parse($record->created_at);
                $created_at = $created_at->format('jS M Y g:i a');
                $users[] = [
                    'id' => $record->id,
                    'name' => $record->name,
                    'email' => $record->email ?? '',
                    'phone' => $record->phone ?? '',
                    'department' => $record->department->name ?? '',
                    'role' => $record->role->name ?? '',
                    'dept_id'=>$record->dept_id,
                    'active' => $record->status == 1 ? 'Yes' : 'No',
                    'date_created' => $this->service->formatDate($record->created_at)
                ];

            }
        }
        $records =Template::with('type')->orderBy('id','asc')->get();
        if(count($records)!=0)
        {
            foreach($records as $record)
            {
                $templates[] =
                [
                    'id' => $record->id,
                    'name' => $record->name ?? '',
                    'subject' => $record->subject ?? '',
                    'message' => $record->message ?? '',
                    'type' => $record->type->name ?? ''
                ];
            }
        }

        $data[] = [
            'priorities' => $priorities,
            'roles' => $roles,
            'notification_types' => $notification_types,
            'ticket_status' => $ticket_status,
            'channels' => $channels,
            'departments' => $departments,
            'country_codes' => $country_codes,  
            'customer_types' => $customer_types,
            'sla_policies' => $sla_policies,
            'customers' => $customers,
            'users' => $users,
            'emails' => $emails,
            'event_types' => $event_types,
            'integrations' => $integrations,
            'templates' => $templates,
        ];

        return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, '',$data);

    }
}
