<?php

use Illuminate\Support\Facades\Broadcast;

/*
|--------------------------------------------------------------------------
| Broadcast Channels
|--------------------------------------------------------------------------
|
| Here you may register all of the event broadcasting channels that your
| application supports. The given channel authorization callbacks are
| used to check if an authenticated user can listen to the channel.
|
*/

//Broadcast::channel('chat', function ($user) {
//    return Auth::check();
//});
Broadcast::channel('App.User.{from_user_id}.{to_user_id}', function ($user, $from_user_id, $to_user_id) {
    return (int) $user->id === (int) $from_user_id || (int) $user->id === (int) $to_user_id;
});
