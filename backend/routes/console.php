<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');
// Register your custom command first
//Schedule::command(CheckTicketSLA::class)->everyMinute();
//Check expired SLAs and send department heads notifications
Schedule::command('app:check-ticket-s-l-a')->hourly(); // You can change this to ->hourly(), ->daily(), etc.
Schedule::command('emails:fetch')->hourly();