<?php


use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePriorityTable extends Migration
{
    public function up()
    {
        Schema::create('priority', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name',45)->nullable();
        });
    }

    public function down()
    {
        Schema::dropIfExists('priority');
    }
}
