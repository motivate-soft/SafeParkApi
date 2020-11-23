<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Forgotpassword extends Model
{
    protected $fillable = [
        'sessionTime', 'verifyCode', 'userId', 'attemptNum'
    ];
}
