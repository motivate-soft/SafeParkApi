<?php

namespace App\Http\Controllers\API;

use App\Model\Alert;
use App\Model\Device;
use App\Model\Vehicle;
use App\Model\Wifi;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller as Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class DeviceController extends Controller
{
    public function addDevice(Request $request)
    {
        $response = [];

        try {

            $input = $request->all();

            //Validate requested data
            $validator = Validator::make($input, [
                'name' => 'required',
                'plateNo' => 'required',
                'email' => 'required|email',
                'phoneNumber' => 'required',
                'imei' => 'required',
                'userId' => 'required'
            ]);

            if($validator->fails()){
                $response['success'] = false;
                $response['messages'] = "Not Created";
                return response()->json($response);
            }

            $input['gyro'] = "0";
            $input['gps'] = "0";
            $input['wifi'] = "0";
            $input['powerSupply'] = "0";
            $input['isArm'] = "0";

            $input['number1'] = "";
            $input['number2'] = "";
            $input['number3'] = "";
            $input['number4'] = "";
            $input['number5'] = "";

            $device = Device::create($input);

            $response['success'] = true;
            $response['messages'] = "Add Device successfully";

        } catch (\Exception $e)
        {
            $response['success'] = false;
            $response['message'] = $e->getMessage();
        }

        return response()->json($response);
    }

    public function getAllDevices(Request $request)
    {
        $userId = $request->currentUserId;
        $allDevices = Device::where("userId", $userId)->get();
        return $allDevices;
    }

    public function getTotalDevices()
    {
        $allDevices = Device::all();
        return $allDevices;
    }

    public function getDriver(Request $request)
    {
        $lat = $request->lat;
        $lng = $request->lng;
        $driver = Device::where("lat", "LIKE", "%".$lat."%")->where("lng", "LIKE", "%".$lng."%")->first();

        return $driver;
    }

    public function getAllAlerts(Request $request)
    {
        $vehicleId = $request->vehicleId;
        $plateNo = Device::find($vehicleId)->plateNo;
        $allAlerts = Alert::where("plateNo", $plateNo)->get();
        return $allAlerts;
    }

    public function deleteDevice(Request $request)
    {
        $deviceId = $request->deviceId;

        $device = Device::find($deviceId);
        $device->delete();
        $res['message'] = "Delete device";
        return json_encode($res);
    }

    public function editDevice(Request $request)
    {
        $deviceId = $request->deviceId;
        $device = Device::find($deviceId);

        $device->name = $request->name;
        $device->phoneNumber = $request->phoneNumber;
        $device->plateNo = $request->plateNo;
        $device->imei = $request->imei;
        $device->email = $request->email;
        $device->save();

        $res['message'] = "Update Device Successfully";

        return json_encode($res);
    }

    public function updateVehicleData(Request $request)
    {

        try {
            $allInputs =$request->all();
            $vehicleId = $allInputs['vehicleId'];

            $device = Device::find($vehicleId);

            $device->gyro = $allInputs['gyro'];
            $device->gps = $allInputs['gps'];
            $device->wifi = $allInputs['wifi'];
            $device->powerSupply = $allInputs['powerSupply'];
            $number1 = "";
            $number2 = "";
            $number3 = "";
            $number4 = "";
            $number5 = "";

            if($allInputs['number1'] != "" && $allInputs['number1']) {
                $number1 = $allInputs['number1'];
            }

            if($allInputs['number2'] != "" && $allInputs['number2']) {
                $number2 = $allInputs['number2'];
            }

            if($allInputs['number3'] != "" && $allInputs['number3']) {
                $number3 = $allInputs['number3'];
            }

            if($allInputs['number4'] != "" && $allInputs['number4']) {
                $number4 = $allInputs['number4'];
            }

            if($allInputs['number5'] != "" && $allInputs['number5']) {
                $number5 = $allInputs['number5'];
            }

            $device->number1 = $number1;
            $device->number2 = $number2;
            $device->number3 = $number3;
            $device->number4 = $number4;
            $device->number5 = $number5;

            $device->save();

            $data['success'] = true;
            $data['message'] = "Update Info Successfully";

            return response()->json($data);

        } catch (\Exception $e)
        {
            $data['success'] = false;
            $data['message'] = $e->getMessage();
            return response()->json($data);
        }

    }

    public function updateArm(Request $request)
    {

        try {
            $allInputs =$request->all();
            $vehicleId = $allInputs['vehicleId'];

            $vehicle = Device::find($vehicleId);

            $vehicle->isArm = $allInputs['isArm'];

            $newAlert = new Alert();
            $newAlert->plateNo = $vehicle->plateNo;
            $newAlert->state = $vehicle->isArm;
            $newAlert->save();

            $vehicle->save();

            $data['success'] = true;
            $data['message'] = "Update Info Successfully";

            return response()->json($data);

        } catch (\Exception $e)
        {
            $data['success'] = false;
            $data['message'] = $e->getMessage();
            return response()->json($data);
        }
    }

    public function turnOnOff(Request $request)
    {

        try {
            $vehicleId = $request['vehicleId'];

            $vehicle = Device::find($vehicleId);

            if($vehicle->engine == 0) {
                $vehicle->engine = 1;
            }
            else {
                $vehicle->engine = 0;
            }
            $vehicle->save();

            $data['success'] = true;
            $data['message'] = "Update Info Successfully";

            return response()->json($data);

        } catch (\Exception $e)
        {
            $data['success'] = false;
            $data['message'] = $e->getMessage();
            return response()->json($data);
        }
    }

    public function emergency(Request $request)
    {

        try {
            $vehicleId = $request['vehicleId'];

            $vehicle = Device::find($vehicleId);

            if($vehicle->alarm == 0) {
                $vehicle->alarm = 1;
            }
            else {
                $vehicle->alarm = 0;
            }
            $vehicle->save();

            $data['success'] = true;
            $data['message'] = "Update Info Successfully";

            return response()->json($data);

        } catch (\Exception $e)
        {
            $data['success'] = false;
            $data['message'] = $e->getMessage();
            return response()->json($data);
        }
    }

    public function addWifi(Request $request)
    {

        try {
            $vehicleId = $request['vehicleId'];
            $wifi = $request['wifi'];
            $password = $request['password'];

            if(!$password)
            {
                $data['success'] = false;
                $data['message'] = "Password is required";
                return response()->json($data);
            }

            $newVehicle = Vehicle::where("deviceId", $vehicleId)->where("ssid", $wifi)->first();

            if(!$newVehicle)
            {
                $newVehicle = new Vehicle();
                $newVehicle->ssid = $wifi;
                $newVehicle->state = "0";
                $newVehicle->deviceId = $vehicleId;
                $newVehicle->password = $password;
            }
            else{
                $newVehicle->password = $password;
            }

            $newVehicle->save();

            $data['success'] = true;
            $data['message'] = "Add Wifi";

            return response()->json($data);

        } catch (\Exception $e)
        {
            $data['success'] = false;
            $data['message'] = $e->getMessage();
            return response()->json($data);
        }
    }

    public function deleteWifi(Request $request)
    {

        try {
            $vehicleId = $request['vehicleId'];

            $vehicle = Vehicle::find($vehicleId);

            $vehicle->delete();

            $data['success'] = true;
            $data['message'] = "Delete Selected wifi";

            return response()->json($data);

        } catch (\Exception $e)
        {
            $data['success'] = false;
            $data['message'] = $e->getMessage();
            return response()->json($data);
        }
    }

    public function changeVehicleState(Request $request)
    {

        try {
            $vehicleId = $request['vehicleId'];

            $vehicle = Vehicle::find($vehicleId);
            if($vehicle->state == 1)
            {
                $vehicle->state = 0;
            }
            else
            {
                $vehicle->state = 1;
            }

            $vehicle->save();
            $data['success'] = true;
            $data['message'] = "Success";
            return response()->json($data);

        } catch (\Exception $e)
        {
            $data['success'] = false;
            $data['message'] = $e->getMessage();
            return response()->json($data);
        }
    }

    public function connectState(Request $request)
    {
        try {
            $vehicleId = $request['ssid'];
            $vehicle = Vehicle::where("ssid", $vehicleId)->first();
            $vehicle->state = 1;
            $vehicle->save();
            $data['success'] = true;
            $data['message'] = "Success";
            return response()->json($data);

        } catch (\Exception $e)
        {
            $data['success'] = false;
            $data['message'] = $e->getMessage();
            return response()->json($data);
        }
    }

    public function allWifies()
    {
        $allWifies = Wifi::all();
        return response()->json($allWifies);
    }

    public function getSelectedVehicles(Request $request)
    {
        $vehicleId = $request->vehicleId;
        $selectedVehicles = Vehicle::where("deviceId", $vehicleId)->get();
        return $selectedVehicles;
    }
}
