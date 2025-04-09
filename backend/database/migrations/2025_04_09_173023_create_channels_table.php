<?php


use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateChannelTable extends Migration
{
    public function up()
    {
        Schema::create('channel', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name', 45)->nullable();
            // Charset and collation can be set in config if needed.
        });
    }

    public function down()
    {
        Schema::dropIfExists('channel');
    }
}
