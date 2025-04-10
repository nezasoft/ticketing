<?php


use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateChannelContactsTable extends Migration
{
    public function up()
    {
        Schema::create('channel_contacts', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('channel_id');
            $table->string('email',45)->nullable();
            $table->string('phone',45)->nullable();
            $table->timestamps();

            //$table->foreign('channel_id')->references('id')->on('channels')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('channel_contacts');
    }
}
