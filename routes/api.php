<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\TipoVehiculoController;
use App\Http\Controllers\Api\AuthController;

Route::get('/test', function () {
    return response()->json([
        'ok' => true
    ]);
    // LOGKM_OB_OBRA
});

Route::group(['middleware' => ['auth:sanctum']], function(){
    Route::post('/tipo-vehiculos', [TipoVehiculoController::class, 'store']);
    Route::put('/tipo-vehiculos/{id}', [TipoVehiculoController::class, 'update']);
    Route::delete('/tipo-vehiculos/{id}', [TipoVehiculoController::class, 'destroy']);
});

Route::post('/login', [AuthController::class, 'login']);