<?php
namespace App\Http\Controllers;

use Illuminate\Support\Facades\Artisan;
use Illuminate\Http\Request;

class EmailFetchController extends Controller
{
    public function fetch(Request $request)
    {
        if ($request->get('token') !== env('CRON_SECRET')) {
            abort(403, 'Unauthorized');
        }

        Artisan::call('emails:fetch');
        return response()->json([
            'status' => 'success',
            'message' => Artisan::output(),
        ]);
    }

}
