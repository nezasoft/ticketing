<?php
namespace App\Services;

use Illuminate\Support\Facades\Log;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use App\Jobs\SendEmailJob;

class EmailService
{

    public function sendEmailMessage($to, $subject, $body, $cc = [], $bcc = [], $attachments = [])
    {
        $mail = new PHPMailer(true);
        $configs = BackendService::getIntegrationConfigs();
        try {
            // Server settings
            $mail->isSMTP();
            $mail->Host       = $configs['RT_MAIL_HOST']['value'] ?? env('MAIL_HOST');
            $mail->SMTPAuth   = true;
            $mail->Username   = $configs['RT_MAIL_USERNAME']['value'] ?? env('MAIL_USERNAME');
            $mail->Password   = $configs['RT_MAIL_PASSWORD']['value'] ?? env('MAIL_PASSWORD');
            $mail->SMTPSecure = $configs['RT_MAIL_ENCRYPTION']['value'] ?? env('MAIL_ENCRYPTION', 'tls');
            $mail->Port       = $configs['RT_MAIL_PORT']['value'] ?? env('MAIL_PORT');
            // Recipients
            $mail->setFrom(
                $configs['RT_MAIL_FROM_ADDRESS']['value'] ?? env('MAIL_FROM_ADDRESS'),
                $configs['RT_MAIL_FROM_NAME']['value'] ?? env('MAIL_FROM_NAME')
            );
            $mail->addAddress($to);
            // CC
            foreach ($cc as $ccAddress) {
                $mail->addCC($ccAddress);
            }
            // BCC
            foreach ($bcc as $bccAddress) {
                $mail->addBCC($bccAddress);
            }
            // Attachments
            foreach ($attachments as $filePath => $fileName) {
                $mail->addAttachment($filePath, $fileName); // ['path/to/file.pdf' => 'Invoice.pdf']
            }
            // Content
            $mail->isHTML(true);
            $mail->Subject = $subject;
            $mail->Body    = $body;
            $mail->AltBody = strip_tags($body);

            $mail->send();
            return true;
        } catch (Exception $e) {
            Log::error("Mail failed. Exception: {$e->getMessage()}, PHPMailer Error: {$mail->ErrorInfo}");
            return false;
        }
    }

 /**
     * Queue an email to be sent by a background worker.
     *
     * $attachments must be an array of path => name (strings) — not UploadedFile objects.
     */
    public function queueEmailMessage($to, $subject, $body, $cc = [], $bcc = [], $attachments = [], $delaySeconds = 0)
    {
        // dispatch the job to the default queue (or specify ->onQueue('emails'))
        if ($delaySeconds > 0) {
            SendEmailJob::dispatch($to, $subject, $body, $cc, $bcc, $attachments)
                ->delay(now()->addSeconds($delaySeconds));
        } else {
            SendEmailJob::dispatch($to, $subject, $body, $cc, $bcc, $attachments);
        }

        Log::info('Email queued', ['to' => $to, 'subject' => $subject]);
        return true;
    }


}
