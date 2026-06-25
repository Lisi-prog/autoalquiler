<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\LogsController;
use App\Http\Controllers\Api\SucursalController;
use App\Http\Controllers\Api\VehiculoController;
use App\Http\Controllers\Api\ReservaController;
use App\Http\Controllers\Api\AlquilerController;
use App\Http\Controllers\Api\TarifaController;
use App\Http\Controllers\Api\FacturaController;
use Illuminate\Support\Facades\Route;

// Route::get('/', function () {
//     return view('welcome');
// });

Route::get('/', [InicioController::class, 'index'])->name('home');
Route::post('vehiculos/disponibles', [InicioController::class, 'obtenerVehiculosDisponibles'])->name('vehiculos.disponibles');

Route::get('/dashboard', function () {
    return redirect()->route('home');
})->middleware(['auth', 'verified'])->name('dashboard');

// Route::group(['middleware' => ['auth','role_or_permission:ADMIN|GERENTE']], function () {
    Route::resource('sucursal', SucursalController::class);
    Route::post('/vehiculo/activar/{id}', [VehiculoController::class, 'activar_vehiculo'])->name('vehiculo.activar');
    Route::resource('vehiculo', VehiculoController::class);
    Route::resource('reserva', ReservaController::class);
    Route::resource('alquiler', AlquilerController::class);
    Route::resource('tarifa', TarifaController::class);
// });

// Route::group(['middleware' => ['auth','role_or_permission:ADMIN']], function () {
    Route::get('logs/alquiler', [LogsController::class, 'log_alquiler_index'])->name('logs.alquiler');
    Route::get('logs/alquilerxestado', [LogsController::class, 'log_alquiler_x_estado_index'])->name('logs.alquiler.estado');
    Route::get('logs/detalle-factura', [LogsController::class, 'log_detalle_factura_index'])->name('logs.detalle.factura');
    Route::get('logs/factura', [LogsController::class, 'log_factura_index'])->name('logs.factura');
    Route::get('logs/mantenimiento', [LogsController::class, 'log_mantenimiento_index'])->name('logs.mantenimiento');
    Route::get('logs/reserva', [LogsController::class, 'log_reserva_index'])->name('logs.reserva');
    Route::get('logs/reserva-estado', [LogsController::class, 'log_reserva_x_estado_index'])->name('logs.reserva.estado');
    Route::get('logs/sucursal', [LogsController::class, 'log_sucursal_index'])->name('logs.sucursal');
    Route::get('logs/taller', [LogsController::class, 'log_taller_index'])->name('logs.taller');
    Route::get('logs/tarifa', [LogsController::class, 'log_tarifa_index'])->name('logs.tarifa');
    Route::get('logs/tipo-vehiculo', [LogsController::class, 'log_tipo_vehiculo_index'])->name('logs.tipo.vehiculo');
    Route::get('logs/vehiculo', [LogsController::class, 'log_vehiculo_index'])->name('logs.vehiculo');
    Route::get('logs/vehiculo-estado', [LogsController::class, 'log_vehiculo_x_estado_index'])->name('logs.vehiculo.estado');
// });

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

Route::patch('/reserva/{id}/generar', [ReservaController::class, 'generarDesdeReserva'])
    ->middleware('auth');

Route::patch('/alquiler/{id}/finalizar', [AlquilerController::class, 'finalizar'])->middleware('auth');

Route::get('/alquiler/{id}/factura/pdf', [FacturaController::class, 'generarPdf'])->middleware('auth')->name('factura.pdf');

require __DIR__.'/auth.php';
