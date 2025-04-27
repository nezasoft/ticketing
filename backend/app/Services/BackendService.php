<?php
namespace App\Services;

class BackendService {
    
    public function serviceResponse($response_type= '',$response_code= '',$response_message= '')
    {
        return response()->json([
            $response_type => 'true',
            'message'   => $response_message,
        ], $response_code);
    }

}
?>
