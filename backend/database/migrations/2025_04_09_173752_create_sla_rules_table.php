<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSlaRulesTable extends Migration
{
    public function up()
    {
        Schema::create('sla_rules', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('sla_policy_id');
            $table->unsignedInteger('customer_type_id');
            $table->unsignedInteger('priority_id');
            $table->unsignedInteger('channel_id');

            //$table->foreign('sla_policy_id')->references('id')->on('sla_policies')->onDelete('cascade');
            //$table->foreign('customer_type_id')->references('id')->on('customer_types')->onDelete('cascade');
            //$table->foreign('priority_id')->references('id')->on('priorities')->onDelete('cascade');
           // $table->foreign('channel_id')->references('id')->on('channels')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('sla_rules');
    }
}
