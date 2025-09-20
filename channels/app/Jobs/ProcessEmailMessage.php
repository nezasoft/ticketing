<?php

namespace App\Jobs;


use App\Services\ChannelManagerService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class ProcessEmailMessage implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $sender;
    protected $to;
    protected $subject;
    protected $body;
    

    /**
     * Create a new job instance.
     *
     * @param  string  $sender
     * @param  array  $to
     * @param  string  $subject
     * @param  string  $body
     * @return void
     */
    public function __construct(string $sender, string $subject, string $body, array $to)
    {
        $this->sender = $sender;
        $this->to = $to;
        $this->subject = $subject;
        $this->body = $body;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        // unique id for tracing this job in logs
        $jobId = (string) Str::uuid();
        // Normalize recipient: allow string or array, ensure array
        $recipients = $this->to;
        if (!is_array($recipients)) {
            // If single email string, convert to array; if CSV string, split
            if (is_string($recipients) && strpos($recipients, ',') !== false) {
                $recipients = array_map('trim', explode(',', $recipients));
            } elseif (is_string($recipients) && strlen(trim($recipients)) > 0) {
                $recipients = [trim($recipients)];
            } else {
                $recipients = [];
            }
        }

        // Filter invalid/empty entries
        $recipients = array_values(array_filter($recipients, fn($r) => is_string($r) && strlen($r)));
        if (empty($recipients)) {
            // Throwing will allow the job to be retried or moved to failed depending on your queue config
            throw new \Exception("No recipients provided for email from {$this->sender}");
        }

        $endpoint = config('services.channel_manager.email_endpoint', 'http://localhost/ticketing/channels/api/channels/email');

        $payload = [
            'sender'    => $this->sender,
            'recipient' => $recipients,      // must match what your API expects
            'subject'   => $this->subject,
            'body'      => $this->body,
            // optionally include account info/message uid if you store it
            // 'account_name' => $this->accountName ?? null,
            // 'message_uid' => $this->messageUid ?? null,
        ];

        try {
            // Use asJson + Accept header, set timeout and retry for transient errors
            $response = Http::withHeaders([
                    'Accept' => 'application/json',
                ])
                ->timeout(15)          // seconds
                ->retry(3, 100)        // 3 attempts, 100ms between retries
                ->asJson()
                ->post($endpoint, $payload);
            // Log response body (try to decode JSON; fallback to string)
            $body = null;
            try {
                $body = $response->json();
            } catch (\Throwable $t) {
                $body = $response->body();
            }
            if ($response->successful()) {
                // Optionally: mark original IMAP message seen here (see note below)
                return;
            }

            // Non-successful — log details and throw to allow queue retry/failure handling
            Log::error("[Job:$jobId] Channel Manager rejected request", [
                'sender' => $this->sender,
                'subject' => $this->subject,
                'status' => $response->status(),
                'response' => $body,
            ]);

            // You can throw a custom exception or include response details
            throw new \Exception("Channel Manager API call failed with status: " . $response->status());

        } catch (\Throwable $e) {
            // Connection/timeout/etc
            Log::error("[Job:$jobId] Exception while sending to Channel Manager", [
                'sender' => $this->sender,
                'subject' => $this->subject,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ]);

            // rethrow so Laravel can retry or move to failed jobs table
            throw $e;
        }
    }

}

