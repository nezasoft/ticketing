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
        $validator = Validator::make($request->only('CompanyID'), [
            'CompanyID' => 'required|integer|min:1',
        ]);

        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }
        $records = [];
        $records = ChannelContact::with(['channel', 'company'])->where('company_id', $request->CompanyID)->get();
        if($records)
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG, 200,'Success', $records);
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG, 400,'No records found');

    }

    public function createChanneContact(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'CompanyID' => 'required|integer|min:1',
            'ChannelID' => 'required|integer|min:1',
            'Email'=> 'nullable|email',
            'Phone' => 'nullable|string|max:15'
        ]);

        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }
        $channel_contact = new ChannelContact();
        $channel_contact->company_id = $request->CompanyID;
        $channel_contact->channel_id = $request->ChannelID;
        $channel_contact->email = $request->Email;
        $channel_contact->phone = $request->Phone;
        $channel_contact->created_at = Carbon::now();
        $channel_contact->updated_at = Carbon::now();
        $channel_contact->save();

        if($channel_contact)
        {
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200, 'Request processed successfully!');
        }

        return $this->service->serviceResponse($this->service::FAILED_FLAG,400, 'Error occured while processing request!');

    }

    public function updateChannelContact(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'ContactID' => 'required|integer|min:1',
            'ChannelID' => 'required|integer|min:1',
            'Email'     => 'nullable|email',
            'Phone'     => 'nullable|string|max:15'
        ]);

        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }

        $channel_contact = ChannelContact::find($request->ContactID);

        if ($channel_contact) {
            $channel_contact->update([
                'channel_id' => $request->ChannelID,
                'email'      => $request->Email,
                'phone'      => $request->Phone,
                'updated_at' => Carbon::now()
            ]);

            return $this->service->serviceResponse($this->service::SUCCESS_FLAG, 200, 'Request processed successfully!');
        }

        return $this->service->serviceResponse($this->service::FAILED_FLAG, 404, 'Channel contact not found.');
    }

    public function deleteChannelContact(Request $request)
    {
        $validator = Validator::make($request->only('ContactID'), [
            'ContactID' => 'required|integer|min:1',
        ]);

        if ($validator->fails()) {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }

        //Find channel contact by id
        $channel_contact = ChannelContact::find($request->ContactID);
        if($channel_contact)
        {
            $channel_contact->delete();
            return $this->service->serviceResponse($this->service::SUCCESS_FLAG, 200, 'Request processed successfully!');
        }
        return $this->service->serviceResponse($this->service::FAILED_FLAG, 404, 'Channel contact not found.');

    }


}
