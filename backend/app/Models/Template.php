<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Template extends Model
{
    protected $table = "templates";

    public function template_type()
    {
        return $this->belongsTo(TemplateType::class,"type","id");
    }
}
