<?php


use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTicketsTable extends Migration
{
    public function up()
    {
        Schema::create('ticket', function (Blueprint $table) {
            $table->increments('id');
            $table->string('ticket_no',45);
            $table->unsignedInteger('customer_id')->nullable();
            $table->unsignedInteger('priority_id');
            $table->unsignedInteger('channel_id');
            $table->string('subject',200)->nullable();
            $table->string('phone',20)->nullable();
            $table->string('email',20)->nullable();
            $table->unsignedInteger('status_id');
            $table->mediumText('description')->nullable();
            $table->dateTime('first_response_at')->nullable();
            $table->dateTime('resolved_at')->nullable();
            $table->timestamps();

            /*$table->foreign('priority_id')->references('id')->on('priority')->onDelete('cascade');
            $table->foreign('channel_id')->references('id')->on('channels')->onDelete('cascade');
            $table->foreign('status_id')->references('id')->on('status')->onDelete('cascade');*/
            //customer_id foreign key is omitted as the "customer" table is not provided.
        });
    }

    public function down()
    {
        Schema::dropIfExists('tickets');
    }
}
