<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTicketTypesTable extends Migration
{
    public function up()
    {
        Schema::create('ticket_types', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name',45)->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('ticket_types');

    }
}
