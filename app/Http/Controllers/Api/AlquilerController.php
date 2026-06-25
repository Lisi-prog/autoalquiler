<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Illuminate\Http\Request;
use Carbon\Carbon;

use App\Models\Alquiler;
use App\Models\Sucursal;
use App\Models\Cliente;
use App\Models\Vehiculo;


class AlquilerController extends Controller
{
    function __construct()
    {
    }
    
    public function index(Request $request)
    {        
        if (Auth::check() && Auth::user()->hasRole('CLIENTE')) {
            $alquileres = Alquiler::where('id_cliente', Auth::user()->cliente->id_cliente)
                ->orderBy('id_alquiler', 'desc')
                ->get();
        } else {
            $alquileres = Alquiler::orderBy('id_alquiler', 'desc')->get();
        }
        
        $sucursales = Sucursal::orderBy('nombre_sucursal')->get();
        return view('alquiler.index', compact('alquileres', 'sucursales')); 
    }

    public function create()
    {
        $clientes = Cliente::orderBy('nombre_completo')->get();
        $vehiculos = Vehiculo::orderBy('patente')->get();
        $sucursales = Sucursal::orderBy('nombre_sucursal')->get();
        return view('alquiler.create', compact('clientes', 'vehiculos', 'sucursales')); 
    }

    public function store(Request $request)
    {       
        $request->validate([
            'fecha_inicio' => 'required|date',
            'fecha_fin_prevista' => 'required|date',
            'km_inicio' => 'required|integer|min:0',
            'sucursal_retiro' => 'required|integer',
            'sucursal_devolucion' => 'nullable|integer',
            'id_reserva' => 'nullable|integer',
            'id_cliente' => 'required|integer',
            'id_vehiculo' => 'required|integer'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_alta_alquiler(?, ?, ?, ?, ?, ?, ?, ?, NULL, NULL)",
            [
                $request->fecha_inicio,
                $request->fecha_fin_prevista,
                $request->km_inicio,
                $request->sucursal_retiro,
                $request->sucursal_devolucion,
                $request->id_reserva,
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
            'fecha_fin_prevista' => 'required|date',
            'fecha_fin_real' => 'nullable|date',
            'km_inicio' => 'required|integer|min:0',
            'km_fin' => 'nullable|integer|min:0',
            'sucursal_retiro' => 'required|integer',
            'sucursal_devolucion' => 'nullable|integer',
            'id_cliente' => 'required|integer',
            'id_vehiculo' => 'required|integer'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_modificar_alquiler(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NULL, NULL)",
            [
                $id,
                $request->fecha_inicio,
                $request->fecha_fin_prevista,
                $request->fecha_fin_real,
                $request->km_inicio,
                $request->km_fin,
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
            "CALL sp_baja_alquiler(?, NULL, NULL)",
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

    public function finalizar(Request $request, $id)
    {
        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $request->validate([
            'fecha_fin_real' => 'required|date',
            'km_fin' => 'required|integer|min:0',
            'sucursal_devolucion' => 'required|integer'
        ]);

        $resultado = DB::select(
            "CALL sp_finalizar_alquiler(?, ?, ?, ?, NULL, NULL)",
            [
                $id,
                $request->fecha_fin_real,
                $request->km_fin,
                $request->sucursal_devolucion
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
}