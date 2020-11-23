<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDevicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('devices', function (Blueprint $table) {
            $table->id();
            $table->string("imei");
            $table->string("name");
            $table->string("plateNo");
            $table->string("phoneNumber");
            $table->string("email");
            $table->string("userId");
            $table->string("isArm");
            $table->string("gps");
            $table->string("gyro");
            $table->string("wifi_1");
            $table->float("lat", 10);
            $table->float("lng", 10);
            $table->string("wifi_2");
            $table->string("wifi_3");
            $table->float("battery")->nullable();
            $table->string("engine")->nullable();
            $table->string("alarm")->default("0");
            $table->string("wifi");
            $table->string("powerSupply");
            $table->string("number1")->nullable();
            $table->string("number2")->nullable();
            $table->string("number3")->nullable();
            $table->string("number4")->nullable();
            $table->string("number5")->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('devices');
    }
}
