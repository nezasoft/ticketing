<?php

namespace App\Http\Controllers;
use App\Models\Department;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Services\BackendService;
class DepartmentController extends Controller
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
        $data = [];
        $records = Department::where('company_id',$request->company_id)->orderBy("id","desc")->paginate(10);
        if($records)
        {
            foreach($records as $record)
            {
                $data[] = [
                    "id"=> $record->id,
                    "name"=> $record->name
                    ];
            }
        }
        return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,'Success', $data);
    }

    public function create(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'company_id' => 'required|integer|min:1|exists:companies,id',
            'name' => 'required|string|max:255',
        ]);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $dept = new Department();
        $dept->company_id = $request->company_id;
        $dept->name = $request->name;
        if($dept->save())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, 'Request processed successfully');
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200, 'Failed processing this request. Please try again!');

    }

    public function edit(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'dept_id' => 'required|integer|min:1|exists:departments,id',
            'name' => 'required|string|max:255',
        ]);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $dept = Department::find($request->dept_id);
        $dept->name = $request->name;
        if($dept->save())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,'Request processed successfuly');
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200, 'Failed processing this request. Please try again!');
    }

    public function delete(Request $request)
    {
        $validator = Validator::make($request->only('dept_id'), [
            'dept_id' => 'required|integer|exists:departments,id',
        ]);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $dept = Department::find($request->dept_id);
        if($dept->delete())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,'Request processed successfuly');
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200, 'Failed processing this request. Please try again!');
    }
}
