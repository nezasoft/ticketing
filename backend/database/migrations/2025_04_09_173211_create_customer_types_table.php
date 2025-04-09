<?php


use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCustomerTypeTable extends Migration
{
    public function up()
    {
        Schema::create('customer_type', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name',45)->nullable();
        });
    }

    public function down()
    {
        Schema::dropIfExists('customer_type');
    }
}
