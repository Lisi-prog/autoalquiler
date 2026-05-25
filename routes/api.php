<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\TipoVehiculoController;
use App\Http\Controllers\Api\TallerController;
use App\Http\Controllers\Api\TarifaController;
use App\Http\Controllers\Api\MantenimientoController;
use App\Http\Controllers\Api\SucursalController;
use App\Http\Controllers\Api\VehiculoController;
use App\Http\Controllers\Api\ReservaController;
use App\Http\Controllers\Api\AlquilerController;
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

    Route::post('/taller', [TallerController::class, 'store']);
    Route::put('/taller/{id}', [TallerController::class, 'update']);
    Route::delete('/taller/{id}', [TallerController::class, 'destroy']);

    Route::post('/tarifa', [TarifaController::class, 'store']);
    Route::put('/tarifa/{id}', [TarifaController::class, 'update']);
    Route::delete('/tarifa/{id}', [TarifaController::class, 'destroy']);

    Route::post('/mantenimiento', [MantenimientoController::class, 'store']);
    Route::put('/mantenimiento/{id}', [MantenimientoController::class, 'update']);
    Route::patch('/mantenimiento/{id}', [MantenimientoController::class, 'finalizar']);
    Route::delete('/mantenimiento/{id}', [MantenimientoController::class, 'destroy']);

    Route::post('/sucursal', [SucursalController::class, 'store']);
    Route::put('/sucursal/{id}', [SucursalController::class, 'update']);
    Route::delete('/sucursal/{id}', [SucursalController::class, 'destroy']);

    Route::post('/vehiculo', [VehiculoController::class, 'store']);
    Route::put('/vehiculo/{id}', [VehiculoController::class, 'update']);
    Route::delete('/vehiculo/{id}', [VehiculoController::class, 'destroy']);

    Route::post('/reserva', [ReservaController::class, 'store']);
    Route::put('/reserva/{id}', [ReservaController::class, 'update']);
    Route::patch('/reserva/{id}', [ReservaController::class, 'generarDesdeReserva']);
    Route::delete('/reserva/{id}', [ReservaController::class, 'destroy']);

    Route::post('/alquiler', [AlquilerController::class, 'store']);
    Route::put('/alquiler/{id}', [AlquilerController::class, 'update']);
    Route::patch('/alquiler/{id}', [AlquilerController::class, 'finalizar']);
    Route::delete('/alquiler/{id}', [AlquilerController::class, 'destroy']);
});

Route::post('/login', [AuthController::class, 'login']);