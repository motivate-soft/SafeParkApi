<?php

use App\Model\Relationship;
use App\User;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});
//
//Route::get('/updateUser', function(){
//    $user = User::find(29);
//    $user->password = bcrypt('admin1234');
//    $user->save();
//});
