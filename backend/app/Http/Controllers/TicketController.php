<?php

namespace App\Http\Controllers;

use App\Models\Ticket;
use App\Services\BackendService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class TicketController extends Controller
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
        $data = [];
        $records = Ticket::with('company','priority','status','attachments','channel','events','assignments','replies','dept')->where('company_id',$request->company_id)->get();
        $data = $records;
        return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,$this->service::SUCCESS_MESSAGE, $data);
    }
}
