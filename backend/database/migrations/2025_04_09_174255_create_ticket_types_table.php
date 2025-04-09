<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTicketTypeTable extends Migration
{
    public function up()
    {
        Schema::create('ticket_type', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name',45)->nullable();
        });
    }

    public function down()
    {
        Schema::dropIfExists('ticket_type');
    }
}
