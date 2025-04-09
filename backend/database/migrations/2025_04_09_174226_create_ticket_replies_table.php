<?php


use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTicketReplyTable extends Migration
{
    public function up()
    {
        Schema::create('ticket_reply', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('ticket_id');
            $table->unsignedInteger('user_id');
            $table->mediumText('reply_message')->nullable();
            $table->dateTime('reply_at');
            $table->timestamps();

            $table->foreign('ticket_id')->references('id')->on('ticket')->onDelete('cascade');
            $table->foreign('user_id')->references('id')->on('auth_users')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('ticket_reply');
    }
}
