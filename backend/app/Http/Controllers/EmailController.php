<?php

namespace App\Http\Controllers;

use App\Models\Email;
use Illuminate\Http\Request;
use App\Services\BackendService;
use Illuminate\Support\Facades\Validator;
class EmailController extends Controller
{
    protected $service;

    public function __construct(BackendService $backendService)
    {
        $this->service = $backendService;

    }

    public function index(Request $request)
    {
        $validator = Validator::make($request->only('company_id'), [
            'company_id' => 'required|integer|exists:companies,id',
        ]);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }

        $emails = Email::with(['department','priority'])->where('company_id',$request->company_id)->get();

        $records =[];
        if(count($emails) > 0)
        {
            foreach ($emails as $email)
            {
                $records[] = [
                    'id'=> $email->id,
                    'email'=> $email->email,
                    'name'=> $email->name,
                    'username' => $email->username,
                    'password' => $email->password,
                    'host' => $email->fetching_host,
                    'incoming_port' => $email->fetching_port,
                    'outgoing_port' => $email->sending_port,
                    'protocol'=> $email->fetching_protocol,
                    'encryption'=> $email->fetching_encryption,
                    'department' => $email->department->name ?? null,
                    'priority' => $email->priority->name ?? null,
                    ];

            }
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG, 200,'Success', $records);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG, 200,'No records found');

    }

    public function edit(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email_id' => 'required|integer|exists:emails,id',
            'name'=> 'required|string|max:255',
            'email'=> 'required|email',
            'dept_id'=> 'required|integer|exists:departments,id',
            'priority_id' => 'required|integer|exists:priorities,id',
            'company_id' => 'required|integer|exists:companies,id',
            'username'=> 'required|string|max:255',
            'password'=> 'required|string|max:255',
            'host' => 'required|string|max:255',
            'incoming_port'=> 'required|integer',
            'outgoing_port'=> 'required|integer',
            'protocol'=>'required|string|max:255',
            'folder'=>'required|string|max:255',
            'encryption'=> 'required|string|max:255'
        ]);

        if ($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG,200, $validator->errors());
        }

        $email = Email::find($request->email_id);
        if($email)
        {
            $email->name = $request->name;
            $email->email = $request->email;
            $email->dept_id = $request->dept_id;
            $email->priority_id = $request->priority_id;
            $email->company_id = $request->company_id;
            $email->username = $request->username;
            $email->password = $request->password;
            $email->fetching_host = $request->host;
            $email->fetching_port = $request->incoming_port;
            $email->sending_port = $request->outgoing_port;
            $email->fetching_protocol = $request->protocol;
            $email->fetching_encryption = $request->encryption;
            $email->folder = $request->folder;

            if($email->save())
            {
                return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,$this->service::SUCCESS_MESSAGE);

            }

        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200,$this->service::FAILED_MESSAGE);

    }

    public function create(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name'=> 'required|string|max:255',
            'email'=> 'required|email|unique:emails,email',
            'dept_id'=> 'required|integer|exists:departments,id',
            'priority_id' => 'required|integer|exists:priorities,id',
            'company_id' => 'required|integer|exists:companies,id',
            'username'=> 'required|string|max:255',
            'password'=> 'required|string|max:255',
            'host' => 'required|string|max:255',
            'incoming_port'=> 'required|integer',
            'outgoing_port'=> 'required|integer',
            'protocol'=>'required|string|max:255',
            'folder'=> 'required|string|max:255',
            'encryption'=> 'required|string|max:255'
        ]);

        if ($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG,200, $validator->errors());
        }

        $email = new Email();
        $email->name = $request->name;
        $email->email = $request->email;
        $email->dept_id = $request->dept_id;
        $email->priority_id = $request->priority_id;
        $email->company_id = $request->company_id;
        $email->username = $request->username;
        $email->password = $request->password;
        $email->fetching_host = $request->host;
        $email->fetching_port = $request->incoming_port;
        $email->sending_port = $request->outgoing_port;
        $email->fetching_protocol = $request->protocol;
        $email->fetching_encryption = $request->encryption;
        $email->folder = $request->folder;

        //Lets create email config settings for this company

        if($email->save())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, $this->service::SUCCESS_MESSAGE);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200, $this->service::FAILED_MESSAGE);
    }

    public function show(Request $request)
    {
        $validator = Validator::make($request->only('email_id'),[
            'email_id' => 'required|integer|exists:emails,id',
        ]);

        if($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }

        $email = Email::with('department','priority')->where(['id'=>$request->email_id])->first();
        if($email)
        {
            $email = [
                    'id'=>$email->id,
                    'name'=>$email->name ??'',
                    'email'=> $email->email,
                    'department' => $email->department->name ?? '',
                    'priority' => $email->priority->name ?? '',
                    'dept_id' => $email->dept_id,
                    'priority_id' => $email->priority_id,
                    'username' => $email->username,
                    'password' => $email->password,
                    'host' => $email->fetching_host,
                    'incoming_port' => $email->fetching_port,
                    'outgoing_port'=> $email->sending_port,
                    'protocol' => $email->fetching_protocol,
                    'encryption' => $email->fetching_encryption,
                    'folder' => $email->folder,
                    'active' => $email->active == 1 ? 'Yes' : 'No',
                    'date_created' => $this->service->formatDate($email->created_at)
            ];
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,$email);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200,$this->service::FAILED_MESSAGE);

    }

    public function delete(Request $request)
    {
        $validator = Validator::make($request->only('email_id'), [
            'email_id' => 'required|integer|exists:emails,id',
        ]);

        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $email = Email::find($request->email_id);

        if($email->delete())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,'Request processed successfuly');
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200, 'Failed processing this request. Please try again!');

    }
}
