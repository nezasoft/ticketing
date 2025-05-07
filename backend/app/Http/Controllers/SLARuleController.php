<?php

namespace App\Http\Controllers;

use App\Models\SlaRule;
use App\Services\BackendService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
class SLARuleController extends Controller
{
    protected $service;

    public function __construct(BackendService $service)
    {
        $this->service = $service;

    }

    public function index(Request $request)
    {
        $validator = Validator::make($request->only('company_id'), [
            'company_id' => 'required|integer|exists:companies,id',
        ]);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }
        $data= [];
        $records = SlaRule::with(['policy','type','priority','channel'])->whereHas('company', function ($query) use ($request) {
            $query->where('id', $request->company_id);
            })->get();

        if(count($records) > 0) {
            foreach ($records as $record) {
                $data[] = [
                    'id'=> $record->id,
                    'sla_policy' => $record->policy->name,
                    'customer_type'=> $record->type->name,
                    'priority'=> $record->priority->name,
                    'channel'=> $record->channel->name,
                ];
            }
        }

        return $this->service->serviceResponse($this->service::SUCCESS_FLAG, 200, $this->service::SUCCESS_MESSAGE, $data);

    }

    public function create(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'sla_policy_id'=> 'required|integer|exists:sla_policies,id',
            'customer_type_id'=> 'required|integer|exists:customer_types,id',
            'priority_id'=> 'required|integer|exists:priorities,id',
            'channel_id'=> 'required|integer|exists:channels,id',
            'company_id'=> 'required|integer|exists:companies,id'

        ]);

        if ($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG,400, $validator->errors());
        }

        $sla_rule = new SlaRule;
        $sla_rule->company_id = $request->companyid;
        $sla_rule->sla_policy_id = $request->sla_policy_id;
        $sla_rule->priority_id =$request->priority_id;
        $sla_rule->channel_id = $request->channel_id;
        $sla_rule->customer_type_id =$request->customer_type_id;

        if($sla_rule->save())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, $this->service::SUCCESS_MESSAGE);
        }

        return $this->service->serviceResponse($this->service::FAILED_FLAG,400, $this->service::FAILED_MESSAGE);

    }

    public function edit(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'sla_policy_id'=> 'required|integer|exists:sla_policies,id',
            'customer_type_id'=> 'required|integer|exists:customer_types,id',
            'priority_id'=> 'required|integer|exists:priorities,id',
            'channel_id'=> 'required|integer|exists:channels,id',
            'company_id'=> 'required|integer|exists:companies,id',
            'rule_id'=> 'required|integer|exists:sla_rules,id'

        ]);

        if ($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG,400, $validator->errors());
        }

        $sla_rule = SLARule::find($request->rule_id);

        if($sla_rule)
        {
            $sla_rule->priority_id =$request->priority_id;
            $sla_rule->customer_type_id = $request->customer_type_id;
            $sla_rule->sla_policy_id = $request->sla_policy_id;
            $sla_rule->priority_id = $request->priority_id;
            $sla_rule->channel_id = $request->channel_id;
            $sla_rule->company_id = $request->company_id;

            if($sla_rule->save())
            {
                return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, $this->service::SUCCESS_MESSAGE);
            }
        }

        return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $this->service::FAILED_MESSAGE);

    }
}
