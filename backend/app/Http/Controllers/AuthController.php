<?php

namespace App\Http\Controllers;

use App\Models\AuthUser;
use App\Models\EmailVerificationCode;
use App\Services\BackendService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Facades\Validator;

use Hash;
use DB;
class AuthController extends Controller
{
    protected $apiService;

    public function __construct(BackendService $apiservice)
    {
        $this->apiService = $apiservice;
    }


    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "email" => "required|email|exists:auth_users,email",
            "password" => "required|string|max:255"
        ]);

        if ($validator->fails()) {
            return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG, 200, $validator->errors());
        }

        try {
            // Authenticate User
            $user = AuthUser::where('email', $request->email)->firstOrFail(); // Ensure a user is found

            if ($user && Hash::check($request->password, $user->password_hash)) {
                // Issue token
                $token = auth('api')->login($user); // Ensure 'api' guard is configured properly
                $expires_in = (int) (auth('api')->factory()->getTTL() * 60); // Fix the multiplication
                $created_at = Carbon::parse($user->created_at);
                $created_at = $created_at->format('jS M Y g:i a');
                $updated_at = Carbon::parse($user->updated_at);
                $updated_at = $updated_at->format('jS M Y g:i a');
                return response()->json([
                    'success' => true,
                    'message' => 'Authentication Successful!',
                    'data'=> [
                        'token' => $token,
                        'token_type' => 'bearer',
                        'expires_in' => $expires_in,
                        'user'=> [
                        'id' => $user->id,
                        'name' => $user->name,
                        'email' => $user->email,
                        'phone' => $user->phone,
                        'company_id' => $user->company_id,
                        'dept_id' =>$user->dept_id,
                        'created_at'=> $created_at,
                        'updated_at' => $updated_at,
                        'change_password' => $user->change_password,
                        'role_id' => $user->role_id
                    ]

                    ]
                    
                ]);
            }

            return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG, 200, 'Invalid email / password');

        } catch (\Exception $e) {
            \Log::error("Login error: " . $e->getMessage()); // Log the error message
            return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG, 200, $e->getMessage());
        }
    }
    public function recover(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "email"=> "required|email|exists:auth_users,email",
        ]);
        if ($validator->fails()) {
            return  $this->apiService->serviceResponse($this->apiService::FAILED_FLAG,200,$validator->errors());
        }
        $email = $request->input('email');
        try
        {
            $status = Password::sendResetLink($request->only("email"));
            if($status==Password::RESET_LINK_SENT)
            {
                //Retrieve the token from the password resets table
                $token = DB::table('password_reset_tokens')->where('email',$email)->value('token');//extract only the token value
                return $this->apiService->serviceResponse($this->apiService::SUCCESS_FLAG,200,'We have sent instructions on how to recover your password to your email');
            }
            return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG,200,'There was a problem resetting your password!');

        }catch(\Exception $e)
        {
            return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG,200,'There was a problem resetting your password!'.$e->getMessage());

        }
    }

    public function reset(Request $request, $token=null)
    {
        return view('user.reset')->with([
            'token' => $token,
            'email' => $request->email,
        ]);

    }

     //Method to enable user change their password
     public function resetPassword(Request $request)
     {
     $request->validate([
         'token'    => 'required',
         'email'    => 'required|email|exists:password_reset_tokens,email',
         'password' => 'required|confirmed|min:8',
     ]);
     // Retrieve the password reset record for the given email
     $resetRecord = DB::table('password_reset_tokens')->where('email', $request->email)->first();
     if (!$resetRecord) {
         return back()->withErrors(['error' => 'No password reset request found for this email.']);
     }
     //Check token expiration
     $tokenExpiration = 60; // minutes

     if (now()->diffInMinutes($resetRecord->created_at) > $tokenExpiration || !Hash::check($request->token, $resetRecord->token)) {
         return back()->withErrors(['error' => 'The token has expired. Please request a new one.']);
     }
     // Update the user's password
     $user = AuthUser::where('email', $request->email)->first();
     $user->password_hash = Hash::make($request->password);
     $user->save();
     // Delete the used reset record to invalidate the token
     DB::table('password_reset_tokens')->where('email', $request->email)->delete();
     return back()->with('success', 'Your password has been updated successfully!');
     }

     public function edit(Request $request)
     {
        $messages = ['phone.regex' => 'The phone number must be in international format (e.g., +14155552671).'];
        $validator = Validator::make($request->all(), [
            "email" => "required|email|email",
            "name" => "required|string|max:255",
            "phone" => [
            'required',
            'regex:/^[1-9]\d{1,14}$/'
            ],
            "company_id" => "required|integer|min:1",
            "dept_id" => "required|integer|min:1",
            "user_id" => "required|integer|min:1",
            "role_id" => "required|integer|exists:roles,id",
            "status" => "required|integer",
        ],$messages);
        if ($validator->fails()) {
            return $this->apiService->serviceResponse('error', 200, $validator->errors());
        }
        $user = AuthUser::find($request->user_id);
        if($user)
        {
            $user->name = $request->name;
            $user->email = $request->email;
            $user->phone = $request->phone;
            $user->dept_id = $request->dept_id;
            $user->status = $request->status;
            $user->role_id = $request->role_id;

            if($user->save())
            {
                return $this->apiService->serviceResponse($this->apiService::SUCCESS_FLAG,200, 'Request processed successfully');
            }

        }
        return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG,200, 'No record found for user');

     }

     public function create(Request $request)
     {
        $messages = ['phone.regex' => 'The phone number must be in international format (e.g., +14155552671).'];
        $validator = Validator::make($request->all(), [
            "email" => "required|email|unique:auth_users,email",
            "name" => "required|string|max:255",
            "phone" => [
            'required',
            'regex:/^[1-9]\d{1,14}$/'
            ],
            "company_id" => "required|integer|min:1",
            "dept_id" => "required|integer|min:1",
            "role_id" => "required|integer|exists:roles,id"
        ],$messages);
        if ($validator->fails()) {
            return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG, 200, $validator->errors());
        }
        $password = $this->generateRandomPassword();
        $user = new AuthUser();
        $user ->email = $request->email;
        $user->name = $request->name;
        $user->phone = $request->phone;
        $user->company_id = $request->company_id;
        $user->dept_id = $request->dept_id;
        $user->password_hash = Hash::make($password);
        $user->role_id = $request->role_id;

        if($user->save())
        {
            //Send user their default credentials
            $data = [
                "name"=> $request->name,
                "email"=> $request->email,
                "password" => $password
            ];
            $template ="registration-password";

            if($this->apiService->sendEmail($request->email,$template, $data))
            {
                return $this->apiService->serviceResponse($this->apiService::SUCCESS_FLAG,200,"User account created successfully!");
            }

        }
        return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG,200,"User account not created please try again");

     }

     public function verifyEmail(Request $request)
     {
        $validator = Validator::make($request->all(), [
            "email" => "required|email|exists:email_verification_codes",
            "code"=> "required|integer|min:1",
        ]);
        if ($validator->fails()) {
            return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG, 200, $validator->errors());
        }

      $code = EmailVerificationCode::where('email',$request->email)->where('code', $request->code)->first();
      if($code)
      {
        $expiration = 4; //4 Minutes max
        //confirm is code is still valid and not
        if (now()->diffInMinutes($code->created_at) > $expiration) {
            return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG,200,'The verification has expired. Please request a new one');
        }
        //Delete code
        $code->delete();
        return $this->apiService->serviceResponse($this->apiService::SUCCESS_FLAG,200,'Email verification successful!');
      }
      return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG,200,'Email verification failed!');
     }

     public function sendVerificationCode(Request $request)
     {
        $validator = Validator::make($request->all(), [
            "email" => "required|email",
            "name"=> "required|string|max:255",
        ]);

        if ($validator->fails()) {
            return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG, 200, $validator->errors());
        }

        $verification_code = $this->generateRandomNumber();
        $name = $request->name;

        $array = explode(" ",$name);
        $name = $array[0] ?? $name;

        $code = new EmailVerificationCode();
        $code->email = $request->email;
        $code->code = $verification_code;


        if($code->save())
        {
            //Send code to email
            $data = ["code"=>$verification_code,"name"=>$name];
            $template = "email-verification";
            if($this->apiService->sendEmail($request->email,$template, $data))
            {
                return $this->apiService->serviceResponse($this->apiService::SUCCESS_FLAG,200,"Verification code sent to your email");
            }
        }

        return $this->apiService->serviceResponse($this->apiService::FAILED_FLAG,200,"Error sending verification code. Please try again!!!");

     }

     public function generateRandomPassword()
     {
        $characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%&*';
        $password = collect(str_split($characters))->shuffle()->take(12)->implode('');
        return $password;
     }

     public function generateRandomNumber()
     {
        return random_int(100000, 999999);


     }
}
