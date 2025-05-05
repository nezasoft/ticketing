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

class ProcessEmailMessage implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $sender;
    protected $to;
    protected $subject;
    protected $body;
    protected $channel;

    /**
     * Create a new job instance.
     *
     * @param  string  $sender
     * @param  array  $to
     * @param  string  $subject
     * @param  string  $body
     * @return void
     */
    public function __construct(string $sender, string $subject, string $body, array $to, ChannelManagerService $channelService)
    {
        $this->sender = $sender;
        $this->to = $to;
        $this->subject = $subject;
        $this->body = $body;
        $this->channel = $channelService;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {

        //Send Request to Channel Manager Endpoint
        $endpoint = config('services.channel_manager.email_endpoint', 'http://localhost:8000/api/channels/email');
        $payload = [
            'sender'  => $this->sender,
            'recipient'  => $this->to,
            'subject' => $this->subject,
            'body'    => $this->body,
        ];

        // Use Laravel's HTTP client to post to the endpoint.
        $response = Http::post($endpoint, $payload);
        // Optionally, handle response codes.
        if ($response->successful()) {
            Log::info("Email processed successfully for sender: {$this->sender}");
        } else {
            Log::error("Failed to process email for sender: {$this->sender}. Response: " . $response->body());
            // Optionally, you can throw an exception to allow automatic retries.
            throw new \Exception("Channel Manager API call failed with status: " . $response->status());
        }

    }
}

