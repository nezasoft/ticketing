<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/test', function () {
    return 'API route working';
});

Route::prefix('user')->controller(AuthController::class)->group(function () {
    Route::post('/recover', 'recover')->name('user.recover');
    Route::post('/login', 'login')->name('user.login');
    Route::post('/register', 'register')->name('user.register');
});



