<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTicketAssignmentsTable extends Migration
{
    public function up()
    {
        Schema::create('ticket_assignments', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('ticket_id');
            $table->unsignedInteger('user_id');
             $table->unsignedInteger('assigning_user_id');
            $table->string('remarks');
            $table->timestamps();

            /*$table->foreign('ticket_id')->references('id')->on('tickets')->onDelete('cascade');
            $table->foreign('user_id')->references('id')->on('auth_users')->onDelete('cascade');*/
        });
    }

    public function down()
    {
        Schema::dropIfExists('ticket_assignments');
    }
}
