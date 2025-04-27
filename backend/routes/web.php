<?php
namespace App\Http\Controllers;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});
Route::get('/login', function(){
    return response()->json(['error' => 'You need to be authenticated to perform this request']);
})->name('login');

Route::prefix('user')->controller(AuthController::class)->group(function () {
    Route::get('/reset/{token}', 'reset')->name('password.reset');
    Route::post('/reset', 'resetPassword')->name('resetPassword');
});
