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
        
    }


}
