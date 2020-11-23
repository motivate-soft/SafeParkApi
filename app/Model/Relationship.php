<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Relationship extends Model
{
    protected $fillable = [
        'fromId', 'toId'
    ];
}
