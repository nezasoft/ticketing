<?php

namespace App\Http\Controllers;

use App\Models\Priority;
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
                $data[] = $record->id;
                $data[] = $record->name;
            }
            return $this->service->serviceResponse('success',200, 'Success',$data);
        }
        return $this->service->serviceResponse('error',400,'No records found!');

    }
}
