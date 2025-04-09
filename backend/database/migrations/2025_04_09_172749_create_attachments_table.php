<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAttachmentsTable extends Migration
{
    public function up()
    {
        Schema::create('attachments', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('ticket_id');
            $table->unsignedInteger('user_id');
            $table->string('file_name', 45)->nullable();
            $table->string('file_path', 200)->nullable();
            $table->timestamps();

            // Foreign key constraints (optional, if referenced tables exist)
            $table->foreign('ticket_id')->references('id')->on('ticket')->onDelete('cascade');
            $table->foreign('user_id')->references('id')->on('auth_users')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('attachments');
    }
}
