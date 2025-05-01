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
            return $this->service->serviceResponse('error', 400, $validator->errors());
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
                    'port' => $email->fetching_port,
                    'protocol'=> $email->fetching_protocol,
                    'encryption'=> $email->fetching_encryption,
                    'department' => $email->department->name ?? null,
                    'priority' => $email->priority->name ?? null,
                    ];

            }
            return $this->service->serviceResponse('success', 200,'Success', $records);
        }
        return $this->service->serviceResponse('error', 400,'No records found');

    }
}
