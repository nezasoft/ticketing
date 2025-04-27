<?php

namespace App\Http\Controllers;

use App\Models\AuthUser;
use App\Services\BackendService;
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
            return $this->apiService->serviceResponse('error', 400, $validator->errors());
        }

        try {
            // Authenticate User
            $user = AuthUser::where('email', $request->email)->firstOrFail(); // Ensure a user is found

            if ($user && Hash::check($request->password, $user->password_hash)) {
                // Issue token
                $token = auth('api')->login($user); // Ensure 'api' guard is configured properly
                $expires_in = (int) (auth('api')->factory()->getTTL() * 60); // Fix the multiplication
                return response()->json([
                    'success' => true,
                    'message' => 'Authentication Successful!',
                    'access_token' => $token,
                    'token_type' => 'bearer',
                    'expires_in' => $expires_in,
                ]);
            }

            return $this->apiService->serviceResponse('error', 400, 'Invalid credentials supplied');

        } catch (\Exception $e) {
            \Log::error("Login error: " . $e->getMessage()); // Log the error message
            return $this->apiService->serviceResponse('error', 400, $e->getMessage());
        }
    }



    public function recover(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "Email"=> "required|email|exists:auth_users,email",
        ]);
        if ($validator->fails()) {
            return  $this->apiService->serviceResponse('error',400,$validator->errors());
        }

        $email = $request->input('Email');

        try
        {
            $status = Password::sendResetLink($request->only("Email"));

            if($status==Password::RESET_LINK_SENT)
            {
                //Retrieve the token from the password resets table
                $token = DB::table('password_reset_tokens')->where('email',$email)->value('token');//extract only the token value

                return $this->apiService->serviceResponse('success',200,'We have sent instructions on how to recover your password to your email');
            }
            return $this->apiService->serviceResponse('error',400,'There was a problem resetting your password!');


        }catch(\Exception $e)
        {
            return $this->apiService->serviceResponse('error',400,'There was a problem resetting your password!'.$e->getMessage());

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
}
