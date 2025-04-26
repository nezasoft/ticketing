<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Twillio extends Model
{
    protected $table = "twillios";
    protected $fillable = ["company_id","twillio_sid","twillio_token","twillio_phone_no"];
    public $timestamps = false;

    public function company()
    {
        return $this->belongsTo(Company::class,"company_id");
    }
}
