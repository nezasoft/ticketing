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
        $records = SlaPolicy::where('company_id', $request->input('company_id'))->get();
    }


}
