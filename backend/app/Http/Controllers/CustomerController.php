<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Services\BackendService;
use App\Imports\CustomersImport;
use Maatwebsite\Excel\Facades\Excel;
class CustomerController extends Controller
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

        $data =[];
        $records = Customer::where('company_id', $request->company_id)->get();
        if(count($records) > 0)
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id'=> $record->id,
                    'name'=> $record->name,
                    'email'=> $record->email,
                    'phone'=> $record->phone,
                    'client_no' => $record->client_no,
                    'account_no' => $record->account_no
                ];
            }

            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,'Success', $data);
        }

        return $this->service->serviceResponse($this->service::FAILED_FLAG,200,'No record found');
    }

    public function create(Request $request)
    {
        $messages = ['phone.regex' => 'The phone number must be in international format (e.g., 14155552671).'];
        $validator = Validator::make($request->all(),[
            'company_id' => 'required|integer|min:1|exists:companies,id',
            'email'=> 'required|email|unique:customers,email',
            "phone" => [
            'required',
            'regex:/^[1-9]\d{1,14}$/'
            ],
            'name' => 'required|string|max:255',
            'client_no' => 'nullable|string|max:255',
            'account_no' => 'nullable|string|max:255'
        ],$messages);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }

        $customer = new Customer();
        $customer->name = $request->name;
        $customer->email= $request->email;
        $customer->phone = $request->phone;
        $customer->client_no = $request->client_no;
        $customer->account_no = $request->account_no;
        $customer->company_id = $request->company_id;

        if($customer->save())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,$this->service::SUCCESS_MESSAGE);

        }

        return $this->service->serviceResponse($this->service::FAILED_FLAG,200,$this->service::FAILED_MESSAGE);
    }

    public function edit(Request $request)
    {
        $messages = ['phone.regex' => 'The phone number must be in international format (e.g., 14155552671).'];
        $validator = Validator::make($request->all(),[
            'customer_id' => 'required|integer|min:1|exists:customers,id',
            'company_id' => 'required|integer|min:1|exists:companies,id',
            'email'=> 'required|email',
            "phone" => [
            'required',
            'regex:/^[1-9]\d{1,14}$/'
            ],
            'name' => 'required|string|max:255',
            'client_no' => 'nullable|string|max:255',
            'account_no' => 'nullable|string|max:255'
        ],$messages);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }

        $customer = Customer::find( $request->customer_id );

        if($customer)
        {
            $customer->name = $request->name;
            $customer->phone = $request->phone;
            $customer->client_no = $request->client_no;
            $customer->email = $request->email;
            $customer->account_no = $request->account_no;

            if($customer->save())
            {
                return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,$this->service::SUCCESS_MESSAGE);
            }
        }
         return $this->service->serviceResponse($this->service::FAILED_FLAG,200,$this->service::FAILED_MESSAGE);

    }

    public function import(Request $request)
    {


        $validator = Validator::make($request->all(),[
            'file' => 'required|mimes:xlsx,xls,csv|max:2048',
            'company_id' => 'required|exists:companies,id'
        ]);
        if ($validator->fails()) {
            return $this->service->serviceResponse('error', 400, $validator->errors());
        }

        try {
            $companyId = $request->input('company_id');
            Excel::import(new CustomersImport($companyId), $request->file('file'));
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,$this->service::SUCCESS_MESSAGE);
        } catch (\Exception $e) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG,400,$this->service::FAILED_MESSAGE);
        }

    }
}
