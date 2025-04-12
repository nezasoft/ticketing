<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Webklex\IMAP\ClientManager;
use App\Models\Email;
use App\Jobs\ProcessEmailMessage;

class FetchEmails extends Command
{
    protected $signature = 'emails:fetch';
    protected $description = 'Fetch incoming emails from multiple accounts and queue them for processing';

    public function handle()
    {
        // Retrieve all email settings from the database.
        $emailAccounts = Email::all();

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

            // Create a new ClientManager instance and create an account on the fly.
            $clientManager = new ClientManager();
            // Using a dynamic account key; here we use the account name.
            $accountKey = $setting->email_name;
            // Add the configuration dynamically.
            $client = $clientManager->make([
                $accountKey => $config,
            ]);

            try {
                // Connect to the IMAP server for this account.
                $client->getAccount($accountKey)->connect();

                // Get all folders of this account.
                $folders = $client->getAccount($accountKey)->getFolders();
                foreach ($folders as $folder) {
                    // Optionally, you may want to filter folders (e.g., only INBOX or similar).
                    if ($folder->name !== $setting->default_folder) {
                        continue;
                    }
                    // Retrieve unseen emails.
                    $messages = $folder->query()->unseen()->get();
                    foreach ($messages as $message) {
                        // Extract email data.
                        $sender = $message->getFrom()[0]->mail;
                        $subject = $message->getSubject();
                        $body = $message->getTextBody();

                        // Optionally add more metadata like folder name or account info.
                        $payload = [
                            'sender'        => $sender,
                            'subject'       => $subject,
                            'body'          => $body,
                            'account_name'  => $accountKey,
                        ];

                        // Dispatch a job to process the email.
                        ProcessEmailMessage::dispatch($payload['sender'], $payload['subject'], $payload['body']);
                        // Mark the email as seen.
                        $message->setFlag('Seen');
                    }
                }

                $this->info("Emails fetched and queued successfully for account: {$accountKey}");
            } catch (\Exception $e) {
                $this->error("Error processing account: {$accountKey}. Error: " . $e->getMessage());
            }
        }
    }
}
