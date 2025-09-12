<?php

namespace App\Http\Controllers;

use App\Models\SlaEvent;
use App\Services\BackendService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
class SLAEventController extends Controller
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
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $data= [];
        $records = SlaEvent::with(['policy','type','ticket','status'])->whereHas('company', function ($query) use ($request) {
            $query->where('id', $request->company_id);
            })->orderBy('id','DESC')->get();
        if(!empty($records))
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id' => $record->id,
                    'policy' => $record->policy->name ?? '',
                    'event_type' => $record->type->name,
                    'ticket_no' => $record->ticket->ticket_no ?? '',
                    'status' => $record->status->name ?? '',
                    'due_date' => $this->service->formatDate($record->due_date),
                    'met_date' => $this->service->formatDate($record->met_at),
                    'created_at' => $this->service->formatDate($record->created_at)

                ];
            }
        }

        return $this->service->serviceResponse($this->service::SUCCESS_FLAG, 200, $this->service::SUCCESS_MESSAGE, $data);
    }



}
