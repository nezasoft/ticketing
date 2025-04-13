<?php

use App\Http\Controllers\ChannelManagerController;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\Route;

Route::get('/test', function () {
    return 'API route working';
});

Route::post('webhooks/email', [ChannelManagerController::class, 'receiveEmail']);

