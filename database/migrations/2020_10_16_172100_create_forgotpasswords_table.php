<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateForgotpasswordsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('forgotpasswords', function (Blueprint $table) {
            $table->id();
            $table->string('userId');
            $table->string('verifyCode');
            $table->integer('sessionTime');
            $table->integer('attemptNum');
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
        Schema::dropIfExists('forgotpasswords');
    }
}
