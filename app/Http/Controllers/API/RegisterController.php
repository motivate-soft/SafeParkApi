<?php

namespace App\Http\Controllers\API;

use App\Model\Dailyinfo;
use App\Model\Forgotpassword;
use App\Model\KitaGroupUser;
use App\Model\Kitasuper;
use App\Model\Relationship;
use App\Model\TempUser;
use App\Model\UserExtraEmail;
use App\Model\UserExtraKita;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller as Controller;
use App\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Mockery\Exception;
use Illuminate\Mail\Mailer;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\Mail;

use function PHPSTORM_META\type;

class RegisterController extends Controller
{
    /**
     * Register api
     *
     * @param Request $request
     * @return \Illuminate\Http\Response
     */
    protected $admin_email = 'support@simplevisor.ch';
    protected $mailer;
    protected $toEmail = "";

    public function __construct(Mailer $mailer)
    {
        $this->mailer = $mailer;
    }

    public function sendEmail($code, $userEmail)
    {

        $this->toEmail = $userEmail;
        $this->mailer->send('emails.lead', ['code'=>$code], function (Message $m){
            $m->from($this->admin_email)->to($this->toEmail)->subject('SimpleVisor');
        });
    }



    public function register(Request $request)
    {
        $response = [];

        try {

            $input = $request->all();

            //Validate requested data
            $validator = Validator::make($input, [
                'fullName' => 'required',
                'userName' => 'required|unique:users',
                'email' => 'required|email',
                'password' => 'required',
                'phone' => 'required',
                'userType' => 'required',
            ]);

            if($validator->fails()){
                $response['message'] = $validator->errors();
                $response['success'] = false;
                $response['messages'] = "Not Created";
                return response()->json($response);
            }

            $input['password'] = bcrypt($input['password']);

            $user = User::create($input);

            $response['success'] = true;
            $response['messages'] = "Register successfully";

        } catch (\Exception $e)
        {
            $response['success'] = false;
            $response['message'] = $e->getMessage();
        }

        return response()->json($response);
    }

    public function login(Request $request)
    {
        try {

            $loginData = $request->validate([
                'username' => 'required',
                'password' => 'required'
            ]);

            if (!auth()->attempt($loginData)) {
                return response(['success' => false,'message' => 'Invalid Credentials']);
            }

            $accessToken = auth()->user()->createToken('authToken')->accessToken;

            $data['success'] = true;

            $auth = Auth::user();
            $data['userId'] = $auth->id;//auth()->user()->id;
            $data['userType'] = $auth->userType;//auth()->user()->usertype;

            $data['access_token'] = $accessToken;
            return response()->json($data);

        } catch (\Exception $e)
        {
            $data['success'] = false;
            $data['message'] = $e->getMessage();
            return response()->json($data);
        }
    }

    public function forgotPassword(Request $request)
    {
        $data = [];
        $data['success'] = false;

        try {
            $loginData = $request->validate([
                'username' => 'required',
                'useremail' => 'required'
            ]);

            $user = User::where("username", $request->username)->where("email", $request->useremail)->first();

            if($user)
            {
                $data['success'] = true;
                $data['userId'] = $user->id;

                $arrayUsers = Forgotpassword::where("userId", $user->id)->get();

                foreach ($arrayUsers as $arrayUser)
                {
                    $arrayUser->delete();
                }

                $newForgot = new Forgotpassword();

                $newForgot->verifyCode = rand(10000000, 99999999);
                $newForgot->userId = $user->id;
                $newForgot->sessionTime = 30;
                $newForgot->attemptNum = 0;
                $newForgot->save();

                $this->sendEmail($newForgot->verifyCode, $user->email);

            }
            return response()->json($data);

        } catch (\Exception $e)
        {
            $data['message'] = $e->getMessage();
            return response()->json($data);
        }
    }

    public function verifyCode(Request $request)
    {
        $data = [];
        $data['success'] = "false" ;
        $data['message'] = "No Match" ;

        try {

            $loginData = $request->validate([
                'verifyCode' => 'required',
                'userId' => 'required'
            ]);

            $forgotUser = Forgotpassword::where("userId", $request->userId)->first();

            if($forgotUser)
            {
                $forgotUser->attemptNum += 1;

                if($forgotUser->verifyCode == $request->verifyCode)
                {
                    $data['success'] = "true" ;
                    $data['message'] = "Ok" ;
                    return response()->json($data);
                }

//                if($forgotUser->attemptNum > 5)
//                {
//                    $forgotUser->delete();
//                    $data['success'] = "warning";
//                    $data['message'] = "You have attempt more 5 times" ;
//                    return response()->json($data);
//                }

            }
            else{
                $data['message'] = "Not found inputed user" ;
            }

            return response()->json($data);

        } catch (\Exception $e)
        {
            $data['message'] = $e->getMessage();
            return response()->json($data);
        }
    }

    public function updatePassword(Request $request)
    {
        $data = [];
        $data['success'] = false;
        $data['message'] = "Didn't update";
        try {

            $loginData = $request->validate([
                'password' => 'required',
                'userId' => 'required'
            ]);

            $user = User::find($request->userId);

            if($user)
            {
                $user->password = bcrypt($request->password);
                $user->save();
                $data['success'] = true;
                $data['message'] = "Reset Password Successfully";
            }
            return response()->json($data);

        } catch (\Exception $e)
        {
            $data['message'] = $e->getMessage();
            return response()->json($data);
        }
    }
}
