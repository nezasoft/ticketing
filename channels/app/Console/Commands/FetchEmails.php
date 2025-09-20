<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Email;
use App\Jobs\ProcessEmailMessage;
use Illuminate\Support\Facades\Log;
use Webklex\IMAP\Facades\Client;

class FetchEmails extends Command
{
    protected $signature = 'emails:fetch';
    protected $description = 'Fetch incoming emails from multiple accounts and queue them for processing';

    public function handle()
    {
        $emailAccounts = Email::where('active', 1)->get();
        if ($emailAccounts->isEmpty()) {
            Log::warning("No email settings found.");
            $this->info('No email settings found.');
            return;
        }

        foreach ($emailAccounts as $setting) {
            $config = [
                'host'          => $setting->fetching_host,
                'port'          => $setting->fetching_port,
                'encryption'    => $setting->fetching_encryption,
                'validate_cert' => true,
                'username'      => $setting->username,
                'password'      => $setting->password,
                'protocol'      => $setting->fetching_protocol
            ];

            try {
                $client = Client::make($config);
                $client->connect();
                $folders = $client->getFolders();

                foreach ($folders as $folder) {
                    if ($folder->name !== $setting->folder) {
                        continue;
                    }
                    $messages = $folder->query()->unseen()->get();
                    foreach ($messages as $message) {
                        try {
                            $sender  = $message->getFrom()[0]->mail ?? null;
                            $subject = $message->getSubject();
                            $body = $message->getTextBody();
                            // fallback if no plain text body
                            if (empty($body)) {
                                $body = $message->getHTMLBody(true); // true = strip HTML tags
                            }
                            if (empty($body)) {
                                $body = '(No message body)';
                            }

                            // Parse recipients
                            $to_emails  = collect($message->getTo()?->all() ?? [])->map(fn($to) => (string) $to)->filter()->values()->all();
                            $cc_emails  = collect($message->getCc()?->all() ?? [])->map(fn($cc) => (string) $cc)->filter()->values()->all();
                            $bcc_emails = collect($message->getBcc()?->all() ?? [])->map(fn($bcc) => (string) $bcc)->filter()->values()->all();
                            $payload = [
                                'sender'       => $sender,
                                'to'           => $to_emails,
                                'cc'           => $cc_emails,
                                'bcc'          => $bcc_emails,
                                'subject'      => $subject,
                                'body'         => $body,
                                'account_name' => $setting->email_name,
                            ];

                            ProcessEmailMessage::dispatch(
                                $payload['sender'],
                                $payload['subject'],
                                $payload['body'],
                                $payload['to']
                            );

                            $message->setFlag('Seen');
                        } catch (\Exception $msgEx) {
                            Log::error("Error while processing message: " . $msgEx->getMessage());
                        }
                    }
                }

                $this->info("Emails fetched and queued for account: {$setting->name}");
            } catch (\Exception $e) {
                $this->error("Error for account {$setting->name}: " . $e->getMessage());
                Log::error("Error for account {$setting->name}: " . $e->getMessage());
            }
        }
    }


    

}
