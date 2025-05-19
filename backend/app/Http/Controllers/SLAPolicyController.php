<?php

namespace App\Http\Controllers;

use App\Models\SlaPolicy;
use Illuminate\Http\Request;
use App\Services\BackendService;
use Illuminate\Support\Facades\Validator;
class SLAPolicyController extends Controller
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
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }
        $data=[];
        $records = SlaPolicy::where('company_id', $request->input('company_id'))->get();
        if(count($records) > 0) {
            foreach($records as $rec) {
                $data[] = [
                    'id'=> $rec->id,
                    'name' => $rec->name,
                    'response_time_min' => $rec->response_time_min,
                    'resolve_time_min'=> $rec->resolve_time_min,
                    'company_id'=> $rec->company_id,
                    'created_at'=> $rec->created_at,
                    'updated_at'=> $rec->updated_at
                ];
            }

        }
        return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,$this->service::SUCCESS_MESSAGE, $data);
    }

    public function create(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name'=> 'required|string|max:255|unique:sla_policies,name',
            'response_time'=> 'required|integer|min:1',
            'resolve_time'=> 'required|integer|min:1',
            'is_default'=>'required|integer|min:0',
            'company_id'=> 'required|integer|exists:companies,id'

        ]);

        if ($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG,400, $validator->errors());
        }
         $sla_policy = new SlaPolicy;
         $sla_policy->name = $request->input('name');
         $sla_policy->response_time_min = $request->input('response_time');
         $sla_policy->resolve_time_min = $request->input('resolve_time');
         $sla_policy->is_default = $request->input('is_default');
         $sla_policy->company_id = $request->input('company_id');

         if($sla_policy->save())
         {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, $this->service::SUCCESS_MESSAGE);
         }

        return $this->service->serviceResponse($this->service::FAILED_FLAG,400, $this->service::FAILED_MESSAGE);

    }

    public function edit(Request $request)
    {
            $validator = Validator::make($request->all(), [
            'name'=> 'required|string|max:255',
            'response_time'=> 'required|integer|min:1',
            'resolve_time'=> 'required|integer|min:1',
            'is_default'=>'required|integer|min:0',
            'company_id'=> 'required|integer|exists:companies,id',
            'policy_id' => 'required|integer|exists:sla_policies,id'
            ]);

            if ($validator->fails())
            {
                return $this->service->serviceResponse($this->service::FAILED_FLAG,400, $validator->errors());
            }

            $sla_policy = SLAPolicy::find($request->policy_id);
            if($sla_policy)
            {
                $sla_policy->name = $request->name;
                $sla_policy->response_time_min = $request->response_time;
                $sla_policy->resolve_time_min = $request->resolve_time;
                $sla_policy->is_default = $request->is_default;
                $sla_policy->company_id = $request->company_id;
                if($sla_policy->save())
                {
                    return $this->service->serviceResponse($this->service::SUCCESS_FLAG, 200, $this->service::SUCCESS_MESSAGE);
                }
            }
            return $this->service->serviceResponse($this->service::FAILED_FLAG,400, $this->service::FAILED_MESSAGE);

    }

    public function delete(Request $request)
    {
        $validator = Validator::make($request->only('item_id'), [
            'item_id' => 'required|integer|exists:policies,id',
        ]);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }

        $policy = SLAPolicy::find($request->item_id);

        if($policy->delete())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,'Request processed successfuly');
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,400, 'Failed processing this request. Please try again!');

    }

}
