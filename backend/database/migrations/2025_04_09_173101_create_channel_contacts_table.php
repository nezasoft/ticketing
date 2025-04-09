<?php


use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateChannelContactTable extends Migration
{
    public function up()
    {
        Schema::create('channel_contact', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('channel_id');
            $table->string('email',45)->nullable();
            $table->string('phone',45)->nullable();
            $table->dateTime('date_created')->nullable();
            $table->dateTime('date_updated')->nullable();

            $table->foreign('channel_id')->references('id')->on('channel')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('channel_contact');
    }
}
