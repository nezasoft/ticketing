<?php

namespace App\Http\Controllers;

use App\Models\NotificationType;
use App\Models\Priority;
use App\Models\Status;
use App\Models\TicketType;
use App\Services\BackendService;
use Illuminate\Http\Request;

class SettingsController extends Controller
{

    protected $service;


    public function __construct(BackendService $backendService)
    {
        $this->service = $backendService;

    }
    public function getPriorities()
    {
        $data =[];
        $records = Priority::all();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id' => $record->id,
                    'name'=> $record->name,
                ];
            }
            return $this->service->serviceResponse('success',200, 'Success',$data);
        }
        return $this->service->serviceResponse('error',400,'No records found!');

    }

    public function getTicketTypes()
    {
        $data =[];
        $records = TicketType::all();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id' => $record->id,
                    'name'=> $record->name,
                ];
            }
            return $this->service->serviceResponse('success',200, 'Success',$data);
        }
        return $this->service->serviceResponse('error',400,'No records found!');

    }

    public function getTicketStatus()
    {
        $data =[];
        $records = Status::all();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id' => $record->id,
                    'name'=> $record->name,
                ];
            }
            return $this->service->serviceResponse('success',200, 'Success',$data);
        }
        return $this->service->serviceResponse('error',400,'No records found');
    }

    public function getNotificationTypes()
    {
        $data =[];
        $records = NotificationType::all();
        if(count($records) != 0)
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id' => $record->id,
                    'message'=> $record->message,
                    'type' => $record->type,
                    'icon_class' => $record->icon_class,
                ];
            }
            return $this->service->serviceResponse('success',200, 'Success',$data);
        }
        return $this->service->serviceResponse('error',400,'No records found');
    }
}
