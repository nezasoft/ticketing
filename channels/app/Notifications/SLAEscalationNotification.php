<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class SLAEscalationNotification extends Notification
{
    use Queueable;
    protected $ticket;

    public function __construct($ticket)
    {
        $this->ticket = $ticket;
    }

    public function via($notifiable)
    {
        return ['mail'];
    }

    public function toMail($notifiable)
    {
        return (new MailMessage)
            ->subject('SLA Escalation: Ticket #' . $this->ticket->ticket_no)
            ->line("A ticket has breached or is nearing SLA limits.")
            ->line('Ticket No: ' . $this->ticket->ticket_no)
            ->line('Subject: ' . $this->ticket->subject)
            ->line('Created: ' . $this->ticket->created_at->diffForHumans())
            ->line('Please take appropriate action.');
    }
}
