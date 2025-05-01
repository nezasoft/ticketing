<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EmailVerificationCode extends Model
{
    protected $table = "email_verification_codes";
    
    public $timestamps = true;

}
