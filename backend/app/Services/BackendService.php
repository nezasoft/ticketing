<?php
namespace App\Services;
use App\Models\Template;
use App\Models\TemplateType;
class BackendService {

    const SUCCESS_MESSAGE = 'Request processed successfully!';
    const FAILED_MESSAGE = 'Failed to process your request. Please try again!';
    const SUCCESS_FLAG = true;
    const FAILED_FLAG = false;

    public function serviceResponse($response_type= '',$response_code= '',$response_message= '', $data=[])
    {
        return response()->json([
            'success' => $response_type,
            'message'   => $response_message,
            'data'=> $data,
        ], $response_code);
    }

    public function sendEmail($email, $template, array $data)
    {

        $template = $this->emailTemplate($template);

        if(!$template)
        {
            return $this->serviceResponse('error',400,'Email Template not found!');
        }
        $body = $this->replacePlaceholders($template->message, $data);
        $mailer = new EmailService();
        $sent = $mailer->sendmail($email, $template->subject, $body);
        return $sent ? true : false;
    }

    public function emailTemplate($template_type)
    {
        $template = Template::with('template_type')->whereHas('template_type', function ($query) use ($template_type) {
        $query->where('name', $template_type);
        })->first();
        if(!$template){
            return false;
        }
        return $template;
    }

    public function replacePlaceholders($text, array $data)
    {
        foreach ($data as $key => $value) {
            $text = str_replace('{{'.$key.'}}', $value, $text);
        }
        return $text;
    }






}
?>
