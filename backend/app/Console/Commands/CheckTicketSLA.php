<?php

namespace App\Console\Commands;

use App\Models\Department;
use App\Models\DepartmentHead;
use App\Models\SlaEvent;
use App\Models\Ticket;
use App\Models\TicketEscallation;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Notification;

class CheckTicketSLA extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:check-ticket-s-l-a';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
         $now = Carbon::now(); 
         $tickets = Ticket::where('status', '!=', 2)->whereNull('escalated_at')->get();
        foreach ($tickets as $ticket) {
            //Lets get the SLA Details
            $sla_event = SlaEvent::with('policy')->where('ticket_id',$ticket->id,)->where('event_type_id',1)->first();//Get the sla  details of the create ticket event
            //only process tickets that have slas
            if($sla_event)
            {
                $slaDeadline = $ticket->created_at->addMinutes($sla_event->policy->resolve_time_min);
                if ($now->greaterThanOrEqualTo($slaDeadline->subMinutes(15))) {
                    $this->escalate($ticket);
                }

            }
            
        }

        $this->info('SLA check completed.');
    }
    protected function escalate($ticket)
    {
        $ticket->update([
            'priority' => 1,
            'escalated_at' => now()
        ]);
        //Get the team manager details
        $hod = DepartmentHead::with('user')->where('dept_id',$ticket->dept_id)->first();
        // Notify team manager or escalation contact
        if ($hod && $hod->user->email) {
            Notification::route('mail', $hod->user->email)
                ->notify(new SLAEscalationNotification($ticket));
        }

        // Log escalation
        TicketEscalation::create([
            'ticket_id' => $ticket->id,
            'reason' => 'SLA violation threshold reached',
            'notified_user' => $ticket->team->manager_email ?? 'N/A',
            'triggered_by' => 'system',
            'escalated_at' => now()
        ]);
    }
    
}
