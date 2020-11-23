<?php

namespace App\Model;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class Device extends Model
{
    protected $fillable = [
       'imei', 'plateNo', 'alarm', 'email', 'lat', 'lng', 'phoneNumber', 'name', 'userId', 'isArm', 'gps', 'gyro', 'wifi', 'powerSupply', 'number1', 'number2', 'number3', 'number4', 'number5', 'engine', 'battery'
    ];

    public function getCreatedAtAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }
}
