<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BusinessDocument extends Model
{
    protected $table ="business_docs";
    protected $fillable = [ 'document_name','document_no','document_value','company_id','doc_code'];

    public function company()
    {
        return $this->belongsTo(Company::class, 'company_id','id');
    }

}
