<?php

namespace App\Http\Controllers;
use App\Models\Template;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Services\BackendService;

class TemplateController extends Controller
{

    protected $service;
    public function __construct(BackendService $backendService)
    {
        $this->service = $backendService;

    }

    public function index()
    {

        $data = [];
        $records =Template::with('type')->orderBy('id','asc')->get();
        if($records)
        {
            foreach($records as $record)
            {
                $data[] = [
                    'id' => $record->id,
                    'name' => $record->name ?? '',
                    'subject' => $record->subject ?? '',
                    'message' => $record->message ?? '',
                    'type_id' => $record->type ?? '',
                    'type' => $record->type->name ?? ''
                    ];
            }
        }
        return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,'Success', $data);
    }

    public function create(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'type_id' => 'required|integer|min:1|exists:template_types,id',
            'name' => 'required|string|max:255|unique:templates,name',
            'subject' => 'required|string|max:255',
            'message' => 'required|string|max:65255',
        ]);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $template = new Template();
        $template->type = $request->type_id;
        $template->name = $request->name;
        $template->subject = $request->subject;
        $template->message = $request->message;
        if($template->save())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, 'Request processed successfully');
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200, 'Failed processing this request. Please try again!');

    }

    public function edit(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'item_id' => 'required|integer|min:1|exists:templates,id',
            'type_id' => 'required|integer|min:1|exists:template_types,id',
            'name' => 'required|string|max:255',
            'subject' => 'required|string|max:255',
            'message' => 'required|string|max:65255',
        ]);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $template = Template::find($request->item_id);
        $template->type = $request->type_id;
        $template->name = $request->name;
        $template->subject = $request->subject;
        $template->message = $request->message;
        if($template->save())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,'Request processed successfuly');
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200, 'Failed processing this request. Please try again!');
    }

    public function delete(Request $request)
    {
        $validator = Validator::make($request->only('item_id'), [
            'item_id' => 'required|integer|exists:templates,id',
        ]);
        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $template = Template::find($request->item_id);
        if($template->delete())
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,'Request processed successfuly');
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200, 'Failed processing this request. Please try again!');
    }
}
