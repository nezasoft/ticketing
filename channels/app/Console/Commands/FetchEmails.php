<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Email;
use App\Jobs\ProcessEmailMessage;
use Webklex\IMAP\Facades\Client;

class FetchEmails extends Command
{
    protected $signature = 'emails:fetch';
    protected $description = 'Fetch incoming emails from multiple accounts and queue them for processing';

    public function handle()
    {
        // Retrieve all email settings from the database for active email accounts
        $emailAccounts = Email::where('active',1)->get();
        if ($emailAccounts->isEmpty()) {
            $this->info('No email settings found.');
            return;
        }

        // For each email setting, create an IMAP client instance and fetch emails.
        foreach ($emailAccounts as $setting) {
            // Build a configuration array for the current email setting.
            $config = [
                'host'          => $setting->fetching_host,
                'port'          => $setting->fetching_port,
                'encryption'    => $setting->fetching_encryption,
                'validate_cert' => true,
                'username'      => $setting->username,
                'password'      => $setting->password,
                'protocol'      => $setting->fetching_protocol
                //'protocol'      => 'imap' // or 'pop3'
            ];
        
            try {

                $client = Client::make($config);
                $client->connect();
                $folders = $client->getFolders();
                foreach ($folders as $folder) {
                    if ($folder->name !== $setting->default_folder) {
                        continue;
                    }

                    $messages = $folder->query()->unseen()->get();
                    foreach ($messages as $message) {
                        $sender = $message->getFrom()[0]->mail;
                        $subject = $message->getSubject();
                        $body = $message->getTextBody();
                        $to_emails  = array_map(fn($r) => $r->mail, $message->getTo());
                        $cc_emails  = array_map(fn($r) => $r->mail, $message->getCc());
                        $bcc_emails = array_map(fn($r) => $r->mail, $message->getBcc());
                        $payload = [
                            'sender' => $sender,
                            'to' => $to_emails,
                            'cc' => $cc_emails,
                            'bcc' => $bcc_emails,
                            'subject' => $subject,
                            'body' => $body,
                            'account_name' => $setting->email_name,
                        ];
                        ProcessEmailMessage::dispatch(
                            $payload['sender'],
                            $payload['subject'],
                            $payload['body'],
                            $payload['to']
                        );

                        $message->setFlag('Seen');
                    }
                }

                $this->info("Emails fetched and queued for account: {$setting->email_name}");
            } catch (\Exception $e) {
                $this->error("Error for account {$setting->email_name}: " . $e->getMessage());
            }
        }
    }
}
