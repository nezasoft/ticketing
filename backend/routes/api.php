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

Route::post('/channels/email', [ChannelManagerController::class, 'receiveEmail']);
Route::post('/channels/portal', [ChannelManagerController::class, 'receiveWebPortal']);
Route::post('/channels/whatsapp', [ChannelManagerController::class, 'receiveWhatsApp']);
Route::get('/channels/fetch-emails', [EmailFetchController::class, 'fetch']);


Route::prefix('user')->controller(AuthController::class)->group(function () {
    Route::post('/recover', 'recover')->name('user.recover');
    Route::post('/login', 'login')->name('login');
    Route::post('/create', 'create')->name('user.create');
    Route::post('/code', 'sendVerificationCode')->name('user.code');
    Route::post('/verify', 'verifyEmail')->name('user.verify');
});

Route::middleware(['auth:api'])->group(function () {
    /*Route::prefix('email')->controller(AuthController::class)->group(function () {
        Route::post('/create', 'create')->name('email.create');

    });*/

    Route::prefix('settings')->controller(SettingsController::class)->group(function () {
        Route::get('/priorities','getPriorities')->name('settings.priorities');
        Route::get('/ticket_types','getTicketTypes')->name('settings.ticket_types');
        Route::get('/status','getTicketStatus')->name('settings.status');
        Route::get('/notification_types','getNotificationTypes')->name('settings.notification_types');
        Route::get('/roles','getRoles')->name('settings.roles');
        Route::post('/all','getAllSettings')->name('settings.all');
    });
    Route::prefix('contacts')->controller(ChannelContactController::class)->group(function () {
        Route::post('/list','getContactList')->name('contacts.list');
        Route::post('/create','createChanneContact')->name('contacts.create');
        Route::post('/edit','updateChannelContact')->name('contacts.edit');
        Route::post('/delete','deleteChannelContact')->name('contacts.delete');
    });
    Route::prefix('users')->controller(AuthController::class)->group(function () {
        Route::post('/edit', 'edit')->name('user.edit');
        Route::post('/show', 'show')->name('user.show');
        Route::post('/create', 'create')->name('user.create');
        Route::post('/delete', 'delete')->name('user.delete');
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
        Route::post('/show', 'show')->name('email.show');
        Route::post('/delete', 'delete')->name('email.delete');
    });
    Route::prefix('notification')->controller(NotificationController::class)->group(function () {
        Route::post('/list', 'index')->name('notification.list');
        Route::post('/create', 'create')->name('notification.create');
        Route::post('/edit', 'edit')->name('notification.edit');
    });
    Route::prefix('slapolicy')->controller(SLAPolicyController::class)->group(function () {
        Route::post('/list', 'index')->name('slapolicy.list');
        Route::post('/create', 'create')->name('slapolicy.create');
        Route::post('/edit', 'edit')->name('slapolicy.edit');
        Route::post('/delete', 'delete')->name('slapolicy.delete');
    });
    Route::prefix('slarule')->controller(SLARuleController::class)->group(function () {
        Route::post('/list', 'index')->name('slarule.list');
        Route::post('/create', 'create')->name('slarule.create');
        Route::post('/edit', 'edit')->name('slarule.edit');
        Route::post('/delete', 'delete')->name('slarule.delete');
    });
     Route::prefix('tickets')->controller(TicketController::class)->group(function () {
        Route::post('/list', 'index')->name('tickets.list');
        Route::post('/show', 'show')->name('tickets.show');
        Route::post('/create', 'create')->name('tickets.create');
        Route::post('/edit', 'edit')->name('tickets.edit');
        Route::post('/reply', 'reply')->name('tickets.reply');
        Route::post('/assign', 'assign')->name('tickets.assign');
        Route::post('/resolve', 'resolveTicket')->name('tickets.resolve');
        Route::post('/close', 'closeTicket')->name('tickets.close');
    });
    Route::prefix('integration')->controller(IntegrationController::class)->group(function () {
        Route::post('/list', 'index')->name('integration.list');
        Route::post('/create', 'create')->name('integration.create');
        Route::post('/edit', 'edit')->name('integration.edit');
        Route::post('/delete', 'delete')->name('integration.delete');

    });
    Route::prefix('templates')->controller(TemplateController::class)->group(function () {
        Route::post('/list', 'index')->name('templates.list');
        Route::post('/create', 'create')->name('templates.create');
        Route::post('/edit', 'edit')->name('templates.edit');
        Route::post('/delete', 'delete')->name('templates.delete');

    });

       Route::prefix('slaevents')->controller(SLAEventController::class)->group(function () {
        Route::post('/list', 'index')->name('slaevents.list');


    });
});



