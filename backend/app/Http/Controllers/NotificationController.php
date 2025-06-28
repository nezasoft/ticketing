<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use App\Services\BackendService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
class NotificationController extends Controller
{
    protected $service;

    public function __construct(BackendService $service)
    {
        $this->service = $service;
    }

    public function index(Request $request)
    {
        $validator = Validator::make($request->only('user_id'), [
            'user_id' => 'required|integer|exists:auth_users,id',
        ]);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }

        $data = [];
        $records = Notification::with(['user', 'type'])->whereHas('user', function ($query) use ($request) {
        $query->where('id', $request->user_id);
        })->get();

        if(count($records)>0)
        {
            foreach ($records as $record)
            {

                $date = Carbon::parse($record->created_at);
                $date = $date->format('jS M Y g:i a');
                $data[] = [
                    'user_id'=> $record->user_id,
                    'type'=> $record->type->type,
                    'message'=> $record->type->message,
                    'user' => $record->user->name,
                    'created_at' => $date,
                    'read' => $record->read

                ];
            }
        }
        return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,$this->service::SUCCESS_MESSAGE, $data);
    }
}
