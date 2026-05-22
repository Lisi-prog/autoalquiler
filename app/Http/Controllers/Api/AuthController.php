<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class AuthController extends Controller
{

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
            'device' => 'required'
        ]);

        $user = User::where('email', $request->email)->first();

        if (! $user || ! Hash::check($request->password, $user->password)) {
            return response()->json([
                'message' => 'Credenciales inválidas'
            ], 401);
        }

        $token = $user->createToken($request->device)->plainTextToken;

        return response()->json([
            'token' => $token,
            'message' => 'Success'
        ]);
    }
    
    public function validateLogin(Request $request)
    {
        return $request->validate([
        'email' => 'required|email',
        'password' => 'required',
        'device' => 'required'
        ]);
    }
}