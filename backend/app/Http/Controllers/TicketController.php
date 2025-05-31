<?php

namespace App\Http\Controllers;

use App\Models\SlaEvent;
use App\Models\Ticket;
use App\Models\TicketAssignment;
use App\Models\TicketReply;
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
        $records = Ticket::with('company','priority','status','channel','dept')->where('company_id',$request->company_id)->get();
        if(!empty($records))
        {
            foreach($records as $record)
            {
                $data[] = [
                'id' => $record->id,
                'ticket_no' => $record->ticket_no,
                'subject' => $record->subject,
                'description' => $record->description,
                'first_response' => Carbon::parse($record->first_response_at)->format('d M Y h:i:s a'),
                'resolve_at' => Carbon::parse($record->resolve_at)->format('d M Y h:i:s a'),
                'created_at' => Carbon::parse($record->created_at)->format('d M Y h:i:s a'),
                'priority'=> $record->priority->name ?? '',
                'status' => $record->status->name ?? '',
                'channel' => $record->channel->name ?? '',
                'dept' => $record->dept->name ?? '',
                'company' => $record->company->name ?? ''
                ];
            }

        }
        return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,$this->service::SUCCESS_MESSAGE, $data);
    }

    public function show(Request $request)
    {
        $validator = Validator::make($request->only('ticket_id'),[
            'ticket_id' => 'required|integer|exists:tickets,id',
        ]);

        if($validator->fails())
        {
            return $this->service->serviceResponse($this->service::FAILED_FLAG, 400, $validator->errors());
        }
        $data = [];
        $events =  [];
        $assignments = [];
        $replies = [];

        //Get Ticket Details
        $record = Ticket::with('company','priority','status','attachments','channel','events','assignments','replies','dept')->where('id', $request->ticket_id)->first();
        if($record)
        {
            //Get Related SLA Events
            $sla_events  = SlaEvent::with('type','status','policy')->where('ticket_id',$record->id)->get();
            if(!empty($sla_events))
            {
                foreach($sla_events as $event)
                {
                    $events[] = [
                        'id' => $event->id,
                        'created_at' => Carbon::parse($event->created_at)->format('d M Y h:i:s a'),
                        'updated_at'=> Carbon::parse($event->created_at)->format('d M Y h:i:s a'),
                        'due_date'=> Carbon::parse($event->created_at)->format('d M Y h:i:s a'),
                        'event_type' => $event->type->name ?? '',
                        'status' => $event->status->name ?? '',
                        'policy' => $event->policy->name ?? '',
                    ];
                }
            }

            //Get related assignments
            $ticket_assignments = TicketAssignment::with('user')->where('ticket_id',$record->id)->get();
            if(!empty($ticket_assignments))
            {
                foreach($ticket_assignments as $assignment)
                {
                    $assignments[] = [
                        'id' => $assignment->id,
                        'created_at' => Carbon::parse($assignment->created_at)->format('d M Y h:i:s a'),
                        'updated_at' => Carbon::parse($assignment->updated_at)->format('d M Y h:i:s a'),
                        'user' => Ucfirst(strtolower($assignment->user->name ?? ''))
                    ];
                }
            }

            //Get Related Replies
            $ticket_replies = TicketReply::with('user')->where('ticket_id',$record->id)->get();
            if(!empty($ticket_replies))
            {
                foreach($ticket_replies as $reply)
                {
                    $replies[]= [
                        'id' => $reply->id,
                        'reply_message' => $reply->reply_message ?? '',
                        'reply_at' => Carbon::parse($reply->reply_at)->format('d M Y h:i:s a'),
                        'created_at' => Carbon::parse($reply->created_at)->format('d M Y h:i:s a'),
                        'updated_at' => Carbon::parse($reply->updated_at)->format('d M Y h:i:s a'),
                        'user' => $reply->user->name ?? ''

                    ];
                }
            }

            $data[] = [
                    'id' => $record->id,
                    'ticket_no' => $record->ticket_no,
                    'subject' => $record->subject,
                    'description' => $record->description,
                    'first_response' => Carbon::parse($record->first_response_at)->format('d M Y h:i:s a'),
                    'resolve_at' => Carbon::parse($record->resolve_at)->format('d M Y h:i:s a'),
                    'created_at' => Carbon::parse($record->created_at)->format('d M Y h:i:s a'),
                    'priority'=> $record->priority->name ?? '',
                    'status' => $record->status->name ?? '',
                    'channel' => $record->channel->name ?? '',
                    'dept' => $record->dept->name ?? '',
                    'company' => $record->company->name  ?? '',
                    'attachments' => $record->attachments,
                    'events' => $events,
                    'assignments' => $assignments,
                    'replies' => $replies,
            ];
        }
        return $this->service->serviceResponse($this->service::SUCCESS_FLAG,200,$this->service::SUCCESS_MESSAGE, $data);

    }
}
