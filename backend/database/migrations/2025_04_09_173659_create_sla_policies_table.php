<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSlaPoliciesTable extends Migration
{
    public function up()
    {
        Schema::create('sla_policies', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name',100)->nullable();
            $table->integer('response_time_min')->nullable();
            $table->integer('resolve_time_min')->nullable();
            $table->tinyInteger('is_default')->nullable();
            $table->timestamps();  // optional timestamps
        });
    }

    public function down()
    {
        Schema::dropIfExists('sla_policies');
    }
}
