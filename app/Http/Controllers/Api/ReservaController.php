<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Illuminate\Http\Request;
use Carbon\Carbon;

use App\Models\Reserva;

class ReservaController extends Controller
{
    function __construct()
    {
    }
    
    public function index(Request $request)
    {
        if (Auth::check() && Auth::user()->hasRole('CLIENTE')) {
            $reservas = Reserva::where('id_cliente', Auth::user()->cliente->id_cliente)
                ->orderBy('id_reserva', 'desc')
                ->get();
        } else {
            $reservas = Reserva::orderBy('id_reserva', 'desc')->get();
        }
        return view('reserva.index', compact('reservas'));         
    }

    public function create()
    {
    }

    public function store(Request $request)
    {       
        $request->validate([
            'fecha_inicio' => 'required|date',
            'fecha_fin' => 'required|date',
            'sucursal_retiro' => 'required|integer',
            'sucursal_devolucion' => 'nullable|integer',
            'id_cliente' => 'required|integer',
            'id_vehiculo' => 'required|integer'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_alta_reserva(?, ?, ?, ?, ?, ?, NULL, NULL)",
            [
                $request->fecha_inicio,
                $request->fecha_fin,
                $request->sucursal_retiro,
                $request->sucursal_devolucion ?? $request->sucursal_retiro,
                $request->id_cliente,
                $request->id_vehiculo
            ]
        );

        $codigo = $resultado[0]->p_codigo;
        $mensaje = $resultado[0]->p_mensaje;

        if ($codigo != 0) {

            return response()->json([
                'success' => false,
                'codigo' => $codigo,
                'mensaje' => $mensaje
            ], 400);
        }

        return response()->json([
            'success' => true,
            'codigo' => $codigo,
            'mensaje' => $mensaje
        ], 201);
                     
    }
    
    public function show($id)
    {
    }
    
    public function edit($id)
    {
    }
    
    public function update(Request $request, $id)
    {                        
        $request->validate([
            'fecha_inicio' => 'required|date',
            'fecha_fin' => 'required|date',
            'sucursal_retiro' => 'required|integer',
            'sucursal_devolucion' => 'nullable|integer',
            'id_cliente' => 'required|integer',
            'id_vehiculo' => 'required|integer'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_modificar_reserva(?, ?, ?, ?, ?, ?, ?, NULL, NULL)",
            [
                $id,
                $request->fecha_inicio,
                $request->fecha_fin,
                $request->sucursal_retiro,
                $request->sucursal_devolucion,
                $request->id_cliente,
                $request->id_vehiculo
            ]
        );

        $codigo = $resultado[0]->p_codigo;
        $mensaje = $resultado[0]->p_mensaje;

        if ($codigo != 0) {

            return response()->json([
                'success' => false,
                'codigo' => $codigo,
                'mensaje' => $mensaje
            ], 400);
        }

        return response()->json([
            'success' => true,
            'codigo' => $codigo,
            'mensaje' => $mensaje
        ], 200);
    }
    
    public function destroy($id)
    {
        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );
        
        $resultado = DB::select(
            "CALL sp_baja_reserva(?, NULL, NULL)",
            [$id]
        );

        $codigo = $resultado[0]->p_codigo;
        $mensaje = $resultado[0]->p_mensaje;

        if ($codigo != 0) {

            return response()->json([
                'success' => false,
                'codigo' => $codigo,
                'mensaje' => $mensaje
            ], 400);
        }

        return response()->json([
            'success' => true,
            'codigo' => $codigo,
            'mensaje' => $mensaje
        ], 200);
    }

    public function generarDesdeReserva(Request $request, $id)
    {
        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $request->validate([
            'km_inicio' => 'required|integer|min:0'
        ]);

        $resultado = DB::select(
            "CALL sp_generar_alquiler_desde_reserva(?, ?, NULL, NULL)",
            [
                $id,
                $request->km_inicio
            ]
        );

        $codigo = $resultado[0]->p_codigo;
        $mensaje = $resultado[0]->p_mensaje;

        if ($codigo != 0) {

            return response()->json([
                'success' => false,
                'codigo' => $codigo,
                'mensaje' => $mensaje
            ], 400);
        }

        return response()->json([
            'success' => true,
            'codigo' => $codigo,
            'mensaje' => $mensaje
        ], 201);
    }
}