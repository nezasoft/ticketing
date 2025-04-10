<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerType extends Model
{
    protected $table = 'customer_types';

    public $timestamps = false;

    protected $fillable = ['name'];

    // Relationships
    public function slaRules()
    {
        return $this->hasMany(SlaRule::class, 'customer_type_id');
    }
}

