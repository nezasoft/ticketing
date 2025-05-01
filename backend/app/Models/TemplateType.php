<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TemplateType extends Model
{
    protected $table ="template_types";

    public function templates()
    {
        return $this->hasMany(Template::class);
    }
}
