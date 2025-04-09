<?php
// database/migrations/2025_04_09_000013_create_status_table.php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateStatusTable extends Migration
{
    public function up()
    {
        Schema::create('status', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name',45);
        });
    }

    public function down()
    {
        Schema::dropIfExists('status');
    }
}
