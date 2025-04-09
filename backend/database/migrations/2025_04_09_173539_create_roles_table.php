<?php
// database/migrations/2025_04_09_000009_create_roles_table.php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRolesTable extends Migration
{
    public function up()
    {
        Schema::create('roles', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name',45)->nullable();
        });
    }

    public function down()
    {
        Schema::dropIfExists('roles');
    }
}
