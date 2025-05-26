<?php

namespace App\Console\Commands;

use App\Models\Department;
use App\Models\DepartmentHead;
use App\Models\SlaEvent;
use App\Models\Ticket;
use App\Models\TicketEscallation;
use App\Notifications\SLAEscalationNotification;
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
    protected $description = 'This command is used to detect unmet SLAs on tickets and notify the respective heads of departments associated with tickets in question';

    /**
     * Execute the console command.
     */
   public function handle()
{
    $now = Carbon::now(); 

    $tickets = Ticket::where('status_id', '!=', 2)
        ->whereNull('escalated_at')
        ->get();

    foreach ($tickets as $ticket) {
        $sla_event = SlaEvent::with('policy')
            ->where('ticket_id', $ticket->id)
            ->where('event_type_id', 1)
            ->first();

        if (!$sla_event) {
            \Log::info("No SLA found for Ticket ID {$ticket->id}");
            continue;
        }

        $slaDeadline = $ticket->created_at->copy()->addMinutes($sla_event->policy->resolve_time_min);
        if ($now->greaterThanOrEqualTo($slaDeadline->subMinutes(15))) {
            $this->escalate($ticket);
        }
    }

    $this->info('SLA check completed.');
}

protected function escalate($ticket)
{
    if ($ticket->escalated_at) {
        return;
    }

    $ticket->update([
        'priority' => 1,
        'escalated_at' => now()
    ]);

    $hod = DepartmentHead::with('user')->where('dept_id', $ticket->dept_id)->first();

    if (!$hod || !$hod->user->email) {
        \Log::warning("Missing HOD or email for Ticket ID {$ticket->id}");
        return;
    }

    Notification::route('mail', $hod->user->email)
        ->notify(new SLAEscalationNotification($ticket));

    TicketEscallation::create([
        'ticket_id' => $ticket->id,
        'reason' => 'SLA violation threshold reached',
        'notified_user' => $hod->user->email,
        'triggered_by' => 3,//system
        'escalated_at' => now()
    ]);
}

    
}
