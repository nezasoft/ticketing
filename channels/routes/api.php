<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ChannelManagerController;

Route::post('webhooks/email', [ChannelManagerController::class, 'receiveEmail']);
Route::post('webhooks/whatsapp', [ChannelManagerController::class, 'receiveWhatsApp']);
Route::post('webhooks/chatbot', [ChannelManagerController::class, 'receiveChatbot']);
