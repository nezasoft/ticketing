<?php
namespace App\Http\Controllers;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::prefix('user')->controller(AuthController::class)->group(function () {
    Route::get('/reset/{token}', 'reset')->name('password.reset');
    Route::post('/reset', 'resetPassword')->name('resetPassword');
});
