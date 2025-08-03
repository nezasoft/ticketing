<?php

namespace App\Http\Controllers;

use App\Models\IntegrationSetting;
use App\Services\BackendService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class IntegrationController extends Controller
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
        $configs = IntegrationSetting::where('company_id',$request->company_id)->get();
        $records =[];
        if(count($configs) > 0)
        {
            foreach ($configs as $config)
            {
                $created_at = Carbon::parse($config->created_at);
                $created_at = $created_at->format('jS M Y g:i a');
                $updated_at = Carbon::parse($config->updated_at);
                $updated_at = $updated_at->format('jS M Y g:i a');
                $records[] = [
                    'id'=> $config->id,
                    'code'=> $config->code,
                    'value'=> $config->value,
                    'created_at' => $created_at,
                    'updated_at' => $updated_at,
                    ];

            }
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG, 200,'Success', $records);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG, 200,'No records found');       
    }

     public function create(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'company_id'=> 'required|integer|exists:companies,id',
            'code'=> 'required|string|max:255',
            'value'=> 'required|string|max:255',
        ]);
        if ($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG,200, $validator->errors());
        }
        $config = new IntegrationSetting;
        $config->company_id = $request->company_id;
        $config->code = $request->code;
        $config->value = $request->value; 
        if($config->save())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, $this->service::SUCCESS_MESSAGE);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200, $this->service::FAILED_MESSAGE);
    }

    public function edit(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'item_id'=> 'required|integer|exists:integration_settings,id',
            'code'=> 'required|string|max:255',
            'value'=> 'required|string|max:255',
        ]);
        if($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG,200, $validator->errors());
        }
        $config = IntegrationSetting::find($request->item_id);
        if($config)
        {
            $config->code = $request->code;
            $config->value = $request->value; 
            if($config->save())
            {
                return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, $this->service::SUCCESS_MESSAGE);
            }
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $this->service::FAILED_MESSAGE);
    }

    public function delete(Request $request)
    {
        $validator = Validator::make($request->only('item_id'), [
            'item_id' => 'required|integer|exists:integration_settings,id',
        ]);

        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $dept = IntegrationSetting::find($request->item_id);

        if($dept->delete())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,'Request processed successfuly');
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200, 'Failed processing this request. Please try again!');

    }
}
