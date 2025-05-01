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
    Route::post('/create', 'create')->name('user.create');
    Route::post('/code', 'sendVerificationCode')->name('user.code');
    Route::post('/verify', 'verifyEmail')->name('user.verify');
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
        Route::get('/roles','getRoles')->name('settings.roles');


    });
    Route::prefix('contacts')->controller(ChannelContactController::class)->group(function () {
        Route::post('/list','getContactList')->name('contacts.list');
        Route::post('/create','createChanneContact')->name('contacts.create');
        Route::post('/edit','updateChannelContact')->name('contacts.edit');
        Route::post('/delete','deleteChannelContact')->name('contacts.delete');
    });
    Route::prefix('user')->controller(AuthController::class)->group(function () {
        Route::post('/edit', 'edit')->name('user.edit');
    });
    Route::prefix('department')->controller(DepartmentController::class)->group(function () {
        Route::post('/list', 'index')->name('department.index');
        Route::post('/create', 'create')->name('department.create');
        Route::post('/edit', 'edit')->name('department.edit');
        Route::post('/delete', 'delete')->name('department.delete');
    });
    Route::prefix('customer')->controller(CustomerController::class)->group(function () {
        Route::post('/list', 'index')->name('customer.list');
        Route::post('/create', 'create')->name('customer.create');
        Route::post('/edit', 'edit')->name('customer.edit');
        Route::post('/import', 'import')->name('customer.import');
    });
    Route::prefix('email')->controller(EmailController::class)->group(function () {
        Route::post('/list', 'index')->name('email.list');
        Route::post('/create', 'create')->name('email.create');
        Route::post('/edit', 'edit')->name('email.edit');
    });
});



