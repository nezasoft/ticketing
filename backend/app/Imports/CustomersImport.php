<?php

namespace App\Imports;

use App\Models\Customer;
use Maatwebsite\Excel\Concerns\ToModel;

class CustomersImport implements ToModel
{
    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    protected $companyId;

    public function __construct($companyId)
    {
        $this->companyId = $companyId;
    }
    public function model(array $row)
    {
        return new Customer([
            'name' => $row[0],
            'email' => $row[1],
            'phone' => $row[2],
            'client_no' => $row[3],
            'account_no' => $row[4],
            'company_id' => $this->companyId,
        ]);
    }
}
