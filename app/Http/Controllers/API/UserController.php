<?php

namespace App\Http\Controllers\API;

use App\Model\Dailyinfo;
use App\Model\Group;
use App\Model\Kita;
use App\Model\KitaGroupUser;
use App\Model\KitaVGroup;
use App\Model\Relationship;
use App\Model\TempUser;
use App\Model\UserExtraEmail;
use App\Model\UserExtraKita;
use Carbon\Carbon;
use App\Http\Controllers\Controller as Controller;
use Illuminate\Http\Request;
use App\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Date;
use Illuminate\Support\Facades\DB;
use Mockery\Exception;
use function PHPSTORM_META\type;
use Validator;


class UserController extends Controller
{
    // FCM Register
    public function registerFCMToken(Request $request)
    {
        $response = [];
        try {
            $inputData = $request->all();

            $user = User::find($inputData['userId'])->update(
                [
                    'fcm_token' => $inputData['deviceToken'],
                ]);

            $response['state'] = $user;
            $response['message'] = "FCM token registered successfully.";
        } catch (\Exception $e)
        {
            $response['data'] = null;
            $response['state'] = false;
            $response['message'] = $e->getMessage();
        }

        return $response;
    }

    public function getUserData(Request $request)
    {
        $data = [];
        try {
            $userId = $request->currentUserId;
            $auth = User::find($userId);
            $data['status'] = true;
            $data['user'] = $auth;
        } catch (\Exception $e)
        {
            $data['status'] = false;
            $data['message'] = $e->getMessage();
        }

        return json_encode($data);
    }

    public function getAllClients(Request $request)
    {
        $data = [];
        try {
            $users = User::where("userType", "client")->get();
            $data['status'] = true;
            $data['users'] = $users;
        } catch (\Exception $e)
        {
            $data['status'] = false;
            $data['message'] = $e->getMessage();
        }

        return json_encode($data);
    }


//    public function toggleArm(Request $request)
//    {
//        $data = [];
//        try {
//            $userId = $request->currentUserId;
//            $auth = User::find($userId);
//
//            if($auth->isArm == "1") {
//                $auth->isArm = "0";
//            }
//            else {
//                $auth->isArm = "1";
//            }
//            $auth->save();
//
//            $data['status'] = true;
//            $data['user'] = $auth;
//
//        } catch (\Exception $e)
//        {
//            $data['status'] = false;
//            $data['message'] = $e->getMessage();
//        }
//        return json_encode($data);
//
//    }


//    // Get User type
//    public function getUsertype(Request $request)
//    {
//        $data = [];
//        try {
//
//            $auth = User::find($request->currentUserId);
//
//            $data['status'] = true;
//            $data['message'] = "success";
//            $data['user'] = $auth;
//
//            $data['kitaname'] = Kita::find($auth->kita)->kitaname;
//            $data['groupname'] = Group::find($auth->group)->groupname;
//
//            $data['relUsers'] = NULL;
//            if($auth->usertype == 0)
//            {
//                $data['relUsers'] = $this->getRelUsers(Auth::user()->id);
//            }
//
//            $data['kita'] = Kita::select('kitaname', 'id')->where('id', $auth->kita)->get();
//            $data['group'] = Group::select('groupname', 'id') ->where('id', $auth->group)->get();
//            $data['extraKitas'] = DB::select(DB::raw("SELECT `kitaname`, `kitas`.`id` as `k_Id` FROM `kitas` LEFT JOIN (select * from `user_extra_kitas`) as `extra_kitas` ON `kitas`.`id` = `extra_kitas`.`kita_id` WHERE `extra_kitas`.`user_id` = '".$auth->id."'"));
//
//        } catch (\Exception $e)
//        {
//            $data['status'] = false;
//            $data['message'] = $e->getMessage();
//        }
//        return response()->json($data);
//
//    }
    // Get Kita info by kita ID
    public function getKitaByID(Request $request)
    {
        $data = [];
        try {

            $kita = $request->kita;

            $data['message'] = "success";

            $data['adminCounter'] = User::where("kita", $kita)->where("usertype", "2")->count();
            $data['kinderCounter'] = User::where("kita", $kita)->where("usertype", "0")->count();
            $data['groupCounter'] = KitaVGroup::where("kita_id", $kita)->count();

            $data['kita'] = Kita::find($kita);

        } catch (\Exception $e)
        {
            $data['message'] = $e->getMessage();
        }

        return response()->json($data);
    }

    public function getUsersByKitaGroup(Request $request)
    {
        $data = [];
        try {

            $userId = $request->userId;
            $user = User::find($userId);
            $kita = $user->kita;
            $group = $user->group;
            $setDate = $request->selectedDate;

            $data['message'] = "success";
            $users = User::where("kita", $kita)->where("group", $group)->where("usertype", 0)->get();

            foreach($users as $user)
            {

                $dailyInfors = Dailyinfo::where("user_id", $user->id)->where("gotime", "<>", NULL)->where("reachtime", "<>", NULL)->where("set_date", "LIKE", "%".$setDate."%")->get();

                $normalTime = 0;
                $specialTime = 0;
                $additiveTime = 0;

                foreach($dailyInfors as $dailyInfor)
                {
                    $tempTime = $this->getDateMinutes($dailyInfor->reachtime) - $this->getDateMinutes($dailyInfor->gotime);

                    if($dailyInfor->daytype == "normal")
                    {
                        $normalTime += $tempTime;
                        continue;
                    }

                    if($dailyInfor->daytype == "special")
                    {
                        $specialTime += $tempTime;
                        continue;
                    }

                    $additiveTime += $tempTime;

                }
                $user->normalTime = $this->dateFormats($normalTime);
                $user->specialTime = $this->dateFormats($specialTime);
                $user->additiveTime = $this->dateFormats($additiveTime);
            }
            $data['users'] = $users;

        } catch (\Exception $e) {
            $data['message'] = $e->getMessage();
        }

        return response()->json($data);
    }

    public function dateFormats($numbers)
    {
        if($numbers == 0)
        {
            return " ";
        }

        $hours = floor($numbers/60);
        $minutes = $numbers % 60;
        return $hours . " hours and " . $minutes . " Minutes";
    }

    public function getDateMinutes($day)
    {
        $resultTime = 0;
        if(strripos($day, "M") > 0){
            $arrayDate = explode(" ", $day);
            $arrayTime = explode(":", $arrayDate[0]);

            $resultTime = $arrayTime[0] * 60 + $arrayTime[1];

            if($arrayDate[1] == "PM")
                $resultTime += 12 * 60;
        }
        else{
            $arrayTime = explode(":", $day);
            $resultTime = $arrayTime[0] * 60 + $arrayTime[1];
        }
        return $resultTime;
    }
    //function that get filtered admins by kita and group
    public function getAdminByKitaGroup(Request $request)
    {
        $data = [];
        try {

            $userId = $request->userId;
            $setDate = $request->setDate;
            $auth = User::find($userId);
            $kita = $auth->kita;
            $group = $auth->group;

            $allAdminsArray = User::where("usertype", "2")->where("kita", $kita)->where("group", $group)->pluck("id")->toArray();
            $selectedAdminsArray = KitaGroupUser::where("group_id", $group)->where("kita_id", $kita)->where("set_date", $setDate)->pluck("admin_id")->toArray();
            $selectedAdminsIntersect = array_intersect($allAdminsArray, $selectedAdminsArray);
            $selectedAdmins = User::wherein("id", $selectedAdminsIntersect)->pluck("id")->toArray();

            $data['message'] = "success";
            if($auth->usertype > 2)
            {
                $allAdmins = User::select('id', 'firstName', 'lastName')->where("usertype", "2")->where("kita", $kita)->get();
                $data['adminItems'] = $allAdmins;
            }
            else {
                $data['selectedAdminsName'] = User::select("firstName", "lastName")->wherein("id", $selectedAdminsIntersect)->get();
            }

            $data['selectedAdmins'] = $selectedAdmins;

        } catch (\Exception $e)
        {
            $data['message'] = $e->getMessage();
        }
        return response()->json($data);
    }

    //function that get daily infos by kita and group, date
    public function getDailyByKitaGroupDate(Request $request)
    {
        $res = [];

        try {
            $inputData = $request->all();

            $auth = User::find($inputData['userId']);
            $kita = $auth->kita;
            $group = $auth->group;

            $selectedDate = $request->sDate;
            $dayofweek = date('w', strtotime($selectedDate));
            // Active Count
            $count = null;
            $selectedUsers = null;

            switch ($dayofweek)
            {
                case 1:
                    $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `monday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " ORDER BY `status` DESC"));
                    $count = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `monday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " AND `status` = 'active'"));
                    break;

                case 2:
                    $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `tuesday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " ORDER BY `status` DESC"));
                    $count = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `tuesday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " AND `status` = 'active'"));
                    break;

                case 3:
                    $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `wednesday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " ORDER BY `status` DESC"));
                    $count = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `wednesday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " AND `status` = 'active'"));
                    break;

                case 4:
                    $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `thursday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " ORDER BY `status` DESC"));
                    $count = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `thursday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " AND `status` = 'active'"));
                    break;

                case 5:
                    $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `friday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " ORDER BY `status` DESC"));
                    $count = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `friday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " AND `status` = 'active'"));
                    break;

                default :
                    $selectedUsers = null;
            }

            $supplyUsers =  DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `usertype` = 0 AND `users`.`id` IN (SELECT `userId` FROM `temp_users` WHERE `temp_users`.`kita` = " . $kita ." AND `temp_users`.`group` = " . $group . " AND `temp_users`.`setDate` = '" . $selectedDate ."') ORDER BY `status`"));
            $supplyUsersCount = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `usertype` = 0 AND `users`.`id` IN (SELECT `userId` FROM `temp_users` WHERE `temp_users`.`kita` = " . $kita ." AND `temp_users`.`group` = " . $group . " AND `temp_users`.`setDate` = '" . $selectedDate. "') AND `status` = 'active'"));

            $message = "not match";
            if($supplyUsers)
            {
                $selectedUsers = array_merge($selectedUsers, $supplyUsers);
                $count = array_merge($count, $supplyUsersCount);
                $message = "there are some people";
            }
            $res['selectedUsers']= $selectedUsers;
            $res['count'] = $count;
            $res['message'] = $message;

        } catch (\Exception $e)
        {
            $res['count'] = 0;
            $res['selectedUsers'] = 0;
            $res['message'] = $e->getMessage();
        }

        return json_encode($res);
    }

    public function getDailyInfosForKinder(Request $request)
    {
        $res = [];

        try {
            $inputData = $request->all();
            $auth = User::find($inputData['userId']);
            $selectedDate = $inputData['sDate'];
            $res['status'] = true;
            $res['message'] = "success";
            $res['daily'] = Dailyinfo::where('user_id', $auth->id)->where('set_date', $selectedDate)->get();
        } catch (\Exception $e)
        {
            $res['status'] = false;
            $res['daily'] = [];
            $res['message'] = $e->getMessage();
        }

        return json_encode($res);
    }

    public function getNotUsersByKitaGroup(Request $request)
    {
        $res = [];

        try {

            $inputData = $request->all();
            $kita = $inputData['kita'];
            $group = $inputData['group'];
            $selectedDate = $inputData['setDate'];
            $dayofweek = date('w', strtotime($selectedDate));
            // Active Count
            $count = null;
            $selectedUsers = null;

            switch ($dayofweek)
            {
                case 1:
                    $selectedUsers = DB::select(DB::raw("SELECT * FROM `users` where `monday` <> 1 AND `usertype` = 0 AND `kita` =".$kita." AND `group` =".$group . " AND `id` NOT IN (SELECT `userId` FROM `temp_users` WHERE `temp_users`.`setDate` = '" . $selectedDate ."' AND `temp_users`.`kita` = " . $kita ." AND `temp_users`.`group` = ".$group.")"));
                    break;

                case 2:
                    $selectedUsers = DB::select(DB::raw("SELECT * FROM `users` where `tuesday` <> 1 AND `usertype` = 0 AND `kita` =".$kita." AND `group` =".$group . " AND `id` NOT IN (SELECT `userId` FROM `temp_users` WHERE `temp_users`.`setDate` = '" . $selectedDate ."' AND `temp_users`.`kita` = " . $kita ." AND `temp_users`.`group` = ".$group.")"));
                    break;

                case 3:
                    $selectedUsers = DB::select(DB::raw("SELECT * FROM `users` where `wednesday` <> 1 AND `usertype` = 0 AND `kita` =".$kita." AND `group` =".$group . " AND `id` NOT IN (SELECT `userId` FROM `temp_users` WHERE `temp_users`.`setDate` = '" . $selectedDate ."' AND `temp_users`.`kita` = " . $kita ." AND `temp_users`.`group` = ".$group.")"));
                    break;

                case 4:
                    $selectedUsers = DB::select(DB::raw("SELECT * FROM `users` where `thursday` <> 1 AND `usertype` = 0 AND `kita` =".$kita." AND `group` =".$group . " AND `id` NOT IN (SELECT `userId` FROM `temp_users` WHERE `temp_users`.`setDate` = '" . $selectedDate ."' AND `temp_users`.`kita` = " . $kita ." AND `temp_users`.`group` = ".$group.")"));
                    break;

                case 5:
                    $selectedUsers = DB::select(DB::raw("SELECT * FROM `users` where `friday` <> 1 AND `usertype` = 0 AND `kita` =".$kita." AND `group` =".$group . " AND `id` NOT IN (SELECT `userId` FROM `temp_users` WHERE `temp_users`.`setDate` = '" . $selectedDate ."' AND `temp_users`.`kita` = " . $kita ." AND `temp_users`.`group` = ".$group.")"));
                    break;

                default :
                    $selectedUsers = null;
            }

            $res['selectedUsers'] = $selectedUsers;

        } catch (\Exception $e)
        {
            $res['selectedUsers'] = 0;
        }



        return json_encode($res);
    }

    public function addSupplyUser(Request $request)
    {

        $res = [];
        try {

            $inputData = $request->all();
            $kita = $inputData['kita'];
            $group = $inputData['group'];
            $setDate = $inputData['setDate'];
            $id = $inputData['id'];
            $state = $inputData['state'];

            $res['message'] = "user is not valid";

            $user = TempUser::where("group", $group)->where("kita", $kita)->where("setDate", $setDate)->first();

            if($state == true)
            {
                $res['message'] = "already user exist";
                if(!$user)
                {
                    $res['message'] = "supply user";
                    $user = new TempUser();
                    $user->kita = $kita;
                    $user->group = $group;
                    $user->userId = $id;
                    $user->setDate = $setDate;
                    $user->save();
                }
            }
            else{

                if($user)
                {
                    $user->delete();
                    $res['message'] = "user is deleted";
                }
            }

        } catch (\Exception $e)
        {
            $res['message'] = $e->getMessage();
        }

        return json_encode($res);
    }

    /*
     *  Get user list For Archive page(gotime != null, reachtime != null)
    */
    public function getUsersByKitaGroupForArchive(Request $request)
    {

        $res = [];
        try {
            $reqData = $request->all();

            $auth = User:: find($reqData['userId']);
            $kita = $auth->kita;
            $group = $auth->group;

            $selectedDate = $reqData['sDate'];

            $dayofweek = date('w', strtotime($selectedDate));

            $selectedUsers = null;
            $weekday = 'Monday';
            $count = Dailyinfo::where('set_date', $selectedDate)->count();
            switch ($dayofweek)
            {
                case 1:
                    if($count > 0)
                        $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos`) as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `monday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " AND `set_date` = '" . $selectedDate . "' ORDER BY `status`"));
                    $weekday = 'Monday';
                    break;

                case 2:
                    if($count > 0)
                        $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos`) as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `tuesday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " AND `set_date` = '" . $selectedDate . "' ORDER BY `status`"));
                    $weekday = 'Tuesday';
                    break;

                case 3:
                    if($count > 0)
                        $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos`) as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `wednesday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " AND `set_date` = '" . $selectedDate . "' ORDER BY `status`"));
                    $weekday = 'Wednesday';
                    break;

                case 4:
                    if($count > 0)
                        $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos`) as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `thursday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " AND `set_date` = '" . $selectedDate . "' ORDER BY `status`"));
                    $weekday = 'Thursday';
                    break;

                case 5:
                    if($count > 0)
                        $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos`) as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `friday` = 1 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita . " AND `set_date` = '" . $selectedDate . "' ORDER BY `status`"));
                    $weekday = 'Friday';
                    break;

                default :
                    {
                        $selectedUsers = null;
                        $weekday = 'Holiday';
                    }
            }

            $res['selectedUsers']= $selectedUsers;
            $res['count'] = $count;
            $res['weekday'] = $weekday;
            $res['set_date'] = $selectedDate;
            $res['message'] = "Success";

        } catch (\Exception $e)
        {
            $res['message'] = $e->getMessage();
            $res['selectedUsers']= null;
            $res['count'] = 0;
            $res['weekday'] = "Monday";
            $res['set_date'] = null;
        }

        return json_encode($res);
    }

    public function getAdminUser(Request $request)
    {

        $response = [];
        try {
            //Validate requested data
            $validator = Validator::make($request->all(), [
                'kita'=>'required'
            ]);

            if($validator->fails()){

                $response['success'] = false;
                $response['message'] = $validator->errors();
                $response['data'] = null;

                return $response;
            }

            $input = $request->all();

            $users = User::where('kita', $input['kita'])->where('usertype', '2')->get();

            $response['data'] = $users;
            $response['success'] = true;
            $response['message'] = "User registered successfully.";

        } catch (\Exception $e)
        {
            $response['success'] = false;
            $response['message'] = $e->getMessage();
        }

        return $response;
    }

    public function getStudentUsers(Request $request)
    {
        $response = [];
        try {
            $inputData = $request->all();

            $users = User::where('kita', $inputData['kita'])->where("group", $inputData['group'])->where('usertype', '0')->get();

            $response['data'] = $users;
            $response['success'] = true;
            $response['message'] = "User registered successfully.";
        } catch (\Exception $e)
        {
            $response['data'] = null;
            $response['success'] = false;
            $response['message'] = $e->getMessage();
        }

        return $response;
    }

    public function getUsersForKinderEv(Request $request)
    {
        $response = [];

        try {
            //Validate requested data
            $validator = Validator::make($request->all(), [
                'userId'=>'required'
            ]);

            if($validator->fails()){

                $response['success'] = false;
                $response['message'] = $validator->errors();
                $response['data'] = null;

                return $response;
            }

            $input = $request->all();
            $auth = User::find($input['userId']);
            $kita = $auth->kita;
            $group = $auth->group;

            $users = User::where('kita', $kita)->where('group', $group)->where('usertype', '0')->get();

            $response['data'] = $users;
            $response['success'] = true;
            $response['message'] = "User registered successfully.";

        } catch (\Exception $e)
        {
            $response['data'] = null;
            $response['success'] = false;
            $response['message'] = $e->getMessage();
        }

        return $response;
    }

    // To edit user's details
    public function checkingPwd(Request $request, $id)
    {
        $data = [];

        try {

            //Get request data
            $input = $request->all();

            //Validate requested data
            $validator = Validator::make($input, [
                'id' => 'required',
                'password' => 'required'
            ]);

            $user = null;
            if ($validator->fails()) {
                $message = $validator->errors();
                $response['status'] = false;
                $response['message'] = $message;
                return $response;
            }

            $user = User::find($id);
            $hasher = app('hash');

            if ($hasher->check($input['password'], $user->password)) {
                $data['message'] = 'Existed';
                $data['status'] = true;
            }
            else{
                $data['message'] = 'No Existed';
                $data['status'] = false;
            }

        } catch (\Exception $e)
        {
            $data['status'] = false;
            $data['message'] = $e->getMessage();
        }

        //Call function for response data
        return response()->json($data);
    }
    //////////////////////////////////////////////

    // Update user's profile with Avatar
    public function update(Request $request, $id)
    {
        $data = [];

        try {

            //Get request data
            $input = $request->all();

            //Validate requested data
            $validator = Validator::make($input, [
                'id' => 'required',
                'firstName' => 'required',
                'lastName' => 'required',
                'email' => 'required|email',
                'username' => 'required',
                'birthdate' => 'required',
                'zip' => 'required',
                'city' => 'required',
                'phone' => 'required',
                'usertype' => 'required'
            ]);

            $user = null;
            if ($validator->fails()) {
                $message = $validator->errors();
                $response['status'] = false;
                $response['message'] = $message;
                return $response;
            }

            //Update user
            if ($input['password'] != null && $input['password'] != '') {
                $input['password'] = bcrypt($input['password']);

                $user = User::find($id)->update(
                    [
                        'firstName' => $input['firstName'],
                        'lastName' => $input['lastName'],
                        'username' => $input['username'],
                        'email' => $input['email'],
                        'birthdate' => $input['birthdate'],
                        'zip' => $input['zip'],
                        'city' => $input['city'],
                        'phone' => $input['phone'],
                        'usertype' => $input['usertype'],
                        'password' => $input['password']
                    ]);
            } else {
                $user = User::find($id)->update(
                    [
                        'firstName' => $input['firstName'],
                        'lastName' => $input['lastName'],
                        'username' => $input['username'],
                        'email' => $input['email'],
                        'birthdate' => $input['birthdate'],
                        'zip' => $input['zip'],
                        'city' => $input['city'],
                        'phone' => $input['phone'],
                        'usertype' => $input['usertype']
                    ]);
            }
            $data['user'] = $user;
            $data['message'] = 'User updated successfully.';
            $data['status'] = true;

        } catch (\Exception $e) {
            $data['user'] = null;
            $data['status'] = false;
            $data['message'] = $e->getMessage();
        }

        //Call function for response data
        return response()->json($data);
    }

    //////////////////////////////////////////////
    public function updateAdmin(Request $request, $id)
    {
        $data = [];

        try {

            //Get request data
            $input = $request->all();

            //Validate requested data
            $validator = Validator::make($input, [
                'id' => 'required',
                'firstName' => 'required',
                'lastName' => 'required',
                'email' => 'required|email',
                'username' => 'required',
                'birthdate' => 'required',
                'zip' => 'required',
                'city' => 'required',
                'phone' => 'required',
                'usertype' => 'required'
            ]);

            $user = null;
            if ($validator->fails()) {
                $message = $validator->errors();
                $response['status'] = false;
                $response['message'] = $message;
                return $response;
            }

            //Update user
            if($input['password'] != null && $input['password'] != '')
            {
                $input['password'] = bcrypt($input['password']);

                $user = User::find($id)->update(
                    [
                        'firstName' => $input['firstName'],
                        'lastName' => $input['lastName'],
                        'username' => $input['username'],
                        'email' => $input['email'],
                        'monday' => $input['monday'],
                        'tuesday' => $input['tuesday'],
                        'friday' => $input['friday'],
                        'wednesday' => $input['wednesday'],
                        'thursday' => $input['thursday'],
                        'birthdate' => $input['birthdate'],
                        'zip' => $input['zip'],
                        'city' => $input['city'],
                        'phone' => $input['phone'],
                        'usertype' => $input['usertype'],
                        'password' => $input['password']
                    ]);
            }

            else
            {
                $user = User::find($id)->update(
                    [
                        'firstName' => $input['firstName'],
                        'lastName' => $input['lastName'],
                        'username' => $input['username'],
                        'email' => $input['email'],
                        'birthdate' => $input['birthdate'],
                        'zip' => $input['zip'],
                        'city' => $input['city'],
                        'phone' => $input['phone'],
                        'usertype' => $input['usertype'],
                        'monday' => $input['monday'],
                        'tuesday' => $input['tuesday'],
                        'friday' => $input['friday'],
                        'wednesday' => $input['wednesday'],
                        'thursday' => $input['thursday'],
                    ]);
            }
            $data['user'] = $user;
            $data['message'] = 'User updated successfully.';
            $data['status'] = true;
        } catch (\Exception $e)
        {
            $data['user'] = null;
            $data['status'] = false;
            $data['message'] = $e->getMessage();
        }

        //Call function for response data
        return response()->json($data);
    }
    //////////////////////////////////////////////

    public function destroy($id)
    {
        $data = [];
        try {
            User::find($id)->delete();
            $data['message'] = 'Deleted successfully.';
            $data['status'] = true;
        } catch (\Exception $e)
        {
            $data['status'] = false;
            $data['message'] = $e->getMessage();
        }

        //Call function for response data
        return response()->json($data);
    }

    public function getNotMembers(Request $request)
    {
        $res = [];
        try {

            $kita = $request->kita;
            $group = $request->group;
            $selectedDate = $request->sDate;
            $dayofweek = date('w', strtotime($selectedDate));
            // Active Count
            $count = Dailyinfo::where('set_date', $selectedDate)->where('status', 'active')->count();
            $selectedUsers = null;
            switch ($dayofweek)
            {
                case 1:
                    $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `monday` = 0 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita));
                    break;
                case 2:
                    $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `tuesday` = 0 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita));
                    break;
                case 3:
                    $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `wednesday` = 0 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita));
                    break;
                case 4:
                    $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `thursday` = 0 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita));
                    break;
                case 5:
                    $selectedUsers = DB::select(DB::raw("SELECT *, `users`.`id` as `u_Id` FROM `users` LEFT JOIN (select * from `dailyinfos` where `set_date` = '" .$selectedDate. "') as `dailyinfoss` ON `users`.`id` = `dailyinfoss`.`user_id` where `friday` = 0 AND `usertype` = 0 AND `group` = ".$group." AND `kita` = ".$kita));
                    break;
                default :
                    $selectedUsers = null;
            }

            $res['selectedUsers']= $selectedUsers;
            $res['count'] = $count;
            $res['message'] = "Success";
        } catch (\Exception $e)
        {
            $res['selectedUsers']= null;
            $res['count'] = 0;
            $res['message'] = $e->getMessage();
        }


        return json_encode($res);
    }

    // Setting profile
    public function uploadPhoto(Request $request){

        $data = [];

        try {

            $auth = Auth::user();

            $input = $request->all();

            $data['imageName'] = "user_".time().".png";
            $image = str_replace(' ', '+', $input['file']);

            $short_path = "\images\\user\\" . $data['imageName'];
            $data['path'] = public_path().$short_path;

            file_put_contents($data['path'], base64_decode($image));
//        Storage::disk('local')->put($png_url, base64_decode($image));
            $data['path'] = $short_path;

            $changed = DB::table('users')
                ->where('id', $auth->id)
                ->update(['profileImagePath' => $short_path]);

            $data['status'] = $changed;
            $data['message'] = 'Image uploaded successfully';

        } catch (\Exception $e)
        {
            $data['status'] = false;
            $data['message'] = $e->getMessage();
        }

        return response()->json($data);
    }

    public function getallusers(Request $request){
        $data = [];

        try {

            $auth = Auth::user();

            $data['allUsers'] = User::select("firstName", "lastName", "id")->where("id", "<>", $auth->id)->where("usertype", "0")->get();

            $data['status'] = true;
            $data['message'] = 'success';

        } catch (\Exception $e)
        {
            $data['status'] = false;
            $data['message'] = $e->getMessage();
        }

        return $data;
    }

    public function getRelUsersArray($id)
    {
        $relUsersArray = Relationship::where("fromId", $id)->pluck("toId")->toArray();
        return $relUsersArray;
    }


    public function getRelUsers($id)
    {
        $relUsers = $this->getRelUsersArray($id);
        array_push($relUsers, $id);
        $users = User::where("usertype", 0)->whereIn("id", $relUsers)->get();
        return $users;
    }

}
