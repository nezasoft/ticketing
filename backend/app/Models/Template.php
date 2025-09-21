<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Template extends Model
{
    protected $table = "templates";

    public function Type()
    {
        return $this->belongsTo(TemplateType::class,"type","id");
    }
    public function TemplateType()
    {
        return $this->belongsTo(TemplateType::class,"type","id");
    }
}
