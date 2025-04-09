<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAuthUsersTable extends Migration
{
    public function up()
    {
        Schema::create('auth_users', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name',100);
            $table->string('email',100);
            $table->binary('password_hash')->nullable();
            $table->string('phone',45)->nullable();
            $table->unsignedInteger('dept_id');
            $table->tinyInteger('status')->nullable();
            $table->timestamps();

            // Foreign key: department (if table exists)
            $table->foreign('dept_id')->references('id')->on('department')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('auth_users');
    }
}
