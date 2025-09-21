<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use App\Services\EmailService;
use Illuminate\Support\Facades\Log;
use Throwable;

class SendEmailJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public $to;
    public $subject;
    public $body;
    public $cc;
    public $bcc;
    public $attachments; // array of path => friendlyName

    // Job retry & timeout settings
    public $tries = 3;
    public $timeout = 120;

    /**
     * Create a new job instance.
     *
     * @param string $to
     * @param string $subject
     * @param string $body
     * @param array $cc
     * @param array $bcc
     * @param array $attachments  // e.g. ['/full/path/to/file.pdf' => 'Invoice.pdf']
     */
    public function __construct($to, $subject, $body, $cc = [], $bcc = [], $attachments = [])
    {
        $this->to = $to;
        $this->subject = $subject;
        $this->body = $body;
        $this->cc = $cc;
        $this->bcc = $bcc;
        $this->attachments = $attachments;
    }

    /**
     * Execute the job.
     */
    public function handle(EmailService $emailService)
    {
        Log::info('SendEmailJob started', ['to' => $this->to]);

        $success = $emailService->sendEmailMessage(
            $this->to,
            $this->subject,
            $this->body,
            $this->cc,
            $this->bcc,
            $this->attachments
        );

        if (! $success) {
            Log::error('SendEmailJob: EmailService returned false', ['to' => $this->to]);
            // Throw so Laravel treats this as a failed attempt and retries per $tries
            throw new \Exception("Failed to send email to {$this->to}");
        }

        Log::info('SendEmailJob completed successfully', ['to' => $this->to]);
    }

    /**
     * The job failed.
     */
    public function failed(Throwable $exception)
    {
        // Called when the job has failed permanently (after retries)
        Log::error('SendEmailJob failed', [
            'to' => $this->to,
            'exception' => $exception->getMessage(),
        ]);

        // Optional: persist a failed-mail record to DB or notify admins
    }
}
