<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Services\BackendService;
use App\Models\ChannelContact;
use Carbon\Carbon;
use Illuminate\Support\Facades\Validator;

class ChannelContactController extends Controller
{
    protected $service;


    public function __construct(BackendService $backendService)
    {
        $this->service = $backendService;

    }

    public function getContactList(Request $request)
    {
        $validator = Validator::make($request->only('company_id'), [
            'company_id' => 'required|integer|min:1',
        ]);

        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $records = [];
        $records = ChannelContact::with(['channel', 'company'])->where('company_id', $request->company_id)->get();
        if($records)
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG, 200,'Success', $records);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG, 200,'No records found');

    }

    public function createChanneContact(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'company_id' => 'required|integer|min:1',
            'channel_id' => 'required|integer|min:1',
            'full_name'  => 'required|string|max:255',
            'email'=> 'nullable|email',
            'phone' => 'nullable|string|max:15'
        ]);

        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $channel_contact = new ChannelContact();
        $channel_contact->company_id = $request->company_id;
        $channel_contact->channel_id = $request->channel_id;
        $channel_contact->email = $request->email;
        $channel_contact->phone = $request->phone;
        $channel_contact->full_name = $request->full_name;
        $channel_contact->created_at = Carbon::now();
        $channel_contact->updated_at = Carbon::now();
        $channel_contact->save();
        if($channel_contact)
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, 'Request processed successfully!');
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG,200, 'Error occured while processing request!');
    }

    public function updateChannelContact(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'contact_id' => 'required|integer|min:1',
            'channel_id' => 'required|integer|min:1',
            'full_name' => 'required|string|max:255',
            'email'     => 'nullable|email',
            'phone'     => 'nullable|string|max:15'
        ]);

        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }
        $channel_contact = ChannelContact::find($request->contact_id);
        if ($channel_contact) {
            $channel_contact->channel_id = $request->channel_id;
            $channel_contact->full_name = $request->full_name;
            $channel_contact->email = $request->email;
            $channel_contact->phone = $request->phone;
            $channel_contact->updated_at = Carbon::now();
            $channel_contact->save();
            if($channel_contact)
            {
                return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, 'Request processed successfully!');
            }
        }

        return $this->service->serviceResponse($this->service::FAILED_FLAG, 404, 'Channel contact not found.');
    }

    public function deleteChannelContact(Request $request)
    {
        $validator = Validator::make($request->only('contact_id'), [
            'contact_id' => 'required|integer|min:1',
        ]);

        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 200, $validator->errors());
        }

        //Find channel contact by id
        $channel_contact = ChannelContact::find($request->contact_id);
        if($channel_contact)
        {
            $channel_contact->delete();
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG, 200, 'Request processed successfully!');
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG, 404, 'Channel contact not found.');

    }


}
