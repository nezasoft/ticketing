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
    Route::post('/login', 'login')->name('login');
    Route::post('/register', 'register')->name('user.register');
});

Route::middleware(['auth:api'])->group(function () {
    Route::prefix('email')->controller(AuthController::class)->group(function () {
        Route::post('/create', 'create')->name('email.create');

    });

    Route::prefix('settings')->controller(SettingsController::class)->group(function () {
        Route::get('/priorities','getPriorities')->name('settings.priorities');
        Route::get('/ticket_types','getTicketTypes')->name('settings.ticket_types');
        Route::get('/status','getTicketStatus')->name('settings.status');
        Route::get('/notification_types','getNotificationTypes')->name('settings.notification_types');

    });
    Route::prefix('contacts')->controller(ChannelContactController::class)->group(function () {
        Route::post('/list','getContactList')->name('contacts.list');
        Route::post('/create','createChanneContact')->name('contacts.create');
        Route::post('/edit','updateChannelContact')->name('contacts.edit');
    });
});



