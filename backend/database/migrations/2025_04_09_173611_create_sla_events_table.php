<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSlaEventsTable extends Migration
{
    public function up()
    {
        Schema::create('sla_events', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('ticket_id');
            $table->unsignedInteger('event_type_id');
            $table->unsignedInteger('status_id');
            $table->dateTime('due_date')->nullable();
            $table->dateTime('met_at')->nullable();
            $table->timestamps();

            //$table->foreign('ticket_id')->references('id')->on('tickets')->onDelete('cascade');
           // $table->foreign('event_type_id')->references('id')->on('event_types')->onDelete('cascade');
           // $table->foreign('status_id')->references('id')->on('status')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('sla_events');
    }
}
