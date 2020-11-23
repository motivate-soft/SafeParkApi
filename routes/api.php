<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API RoutesuploadUserPicture
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group([
    'middleware' => ['api' ,'cors']
], function ($router) {
    Route::post('login', 'API\RegisterController@login');
    Route::post('register', 'API\RegisterController@register');
    Route::post('forgotPassword', 'API\RegisterController@forgotPassword');
    Route::post('updatePassword', 'API\RegisterController@updatePassword');
    Route::post('verifyCode', 'API\RegisterController@verifyCode');
//    Route::post('signup', 'API\RegisterController@register');
});

Route::group([
//    'middleware' => ['auth:api', 'last.activity']
], function () {

    //User page Controller
    Route::get('getUserData', 'API\UserController@getUserData');
    Route::get('getAllClients', 'API\UserController@getAllClients');

    //Device page Controller
    Route::post('add_device', 'API\DeviceController@addDevice');
    Route::get('getAllDevices', 'API\DeviceController@getAllDevices');
    Route::get('getTotalDevices', 'API\DeviceController@getTotalDevices');
    Route::get('getAllAlerts', 'API\DeviceController@getAllAlerts');
    Route::post('editDevice', 'API\DeviceController@editDevice');
    Route::post('deleteDevice', 'API\DeviceController@deleteDevice');
    Route::post('updateVehicleData', 'API\DeviceController@updateVehicleData');
    Route::post('updateArm', 'API\DeviceController@updateArm');
    Route::get('turn-on-off', 'API\DeviceController@turnOnOff');
    Route::get('emergency', 'API\DeviceController@emergency');
    Route::post('addWifi', 'API\DeviceController@addWifi');
    Route::post('deleteWifi', 'API\DeviceController@deleteWifi');
    Route::post('changeVehicleState', 'API\DeviceController@changeVehicleState');
    Route::post('connectState', 'API\DeviceController@connectState');
    Route::get('getAllWifies', 'API\DeviceController@allWifies');
    Route::get('getSelectedVehicles', 'API\DeviceController@getSelectedVehicles');
    Route::post('getDriver', 'API\DeviceController@getDriver');
    //

});