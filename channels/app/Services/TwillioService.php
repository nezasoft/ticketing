<?php
namespace App\Services;

use App\Models\Twillio;
use Twilio\Rest\Client as TwilioClient;
class TwillioService
{
    protected $twilio;
    protected $from;

    public function __construct($company_id)
    {
        $configs = Twillio::where("company_id", $company_id)->firstOrFail();
       
        $this->twilio = new TwilioClient($configs->twillio_sid, $configs->twillio_token);
        $this->from = $configs->twillio_phone_no;
    }

    public function sendMessage($to, $message)
    {
        return $this->twilio->messages->create(
            "whatsapp:+".$to, [
            'from' => "whatsapp:+".$this->from,
            'body' => $message
        ]);
    }


    
}
