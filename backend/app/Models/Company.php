<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Company extends Model
{
    protected $table = "companies";
    protected $fillable = ["name","email","phone","website","phy_add","client_no","company_logo","active","days"];

    public function docs()
    {
        return $this->hasMany(BusinessDocument::class);
    }
}
