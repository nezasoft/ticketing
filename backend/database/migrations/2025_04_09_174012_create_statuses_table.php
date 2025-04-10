<?php
// database/migrations/2025_04_09_000013_create_status_table.php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateStatusesTable extends Migration
{
    public function up()
    {
        Schema::create('statuses', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name',45);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('statuses');
    }
}
