<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\LogsController;
use App\Http\Controllers\Api\SucursalController;
use App\Http\Controllers\Api\VehiculoController;
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
    Route::resource('vehiculo', VehiculoController::class);
// });

// Route::group(['middleware' => ['auth','role_or_permission:ADMIN']], function () {
    Route::get('logs/alquiler', [LogsController::class, 'log_alquiler_index'])->name('logs.alquiler');
// });

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
