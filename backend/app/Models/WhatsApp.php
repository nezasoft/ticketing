<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class WhatsApp extends Model
{
    protected $table = 'whats_apps';
    protected $fillable = ['company_id','phone_no_id','display_phone_no','waba_id','default_message'];

    public $timestamps = false;

    public function company()
    {
        return $this->belongsTo(Company::class,'company_id');
    }
}
