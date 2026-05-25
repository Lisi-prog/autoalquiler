<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Illuminate\Http\Request;
use Carbon\Carbon;

class MantenimientoController extends Controller
{
    function __construct()
    {
    }
    
    public function index(Request $request)
    {        
    }

    public function create()
    {
    }

    public function store(Request $request)
    {       
        $request->validate([
            'fecha_envio' => 'required|date',
            'fecha_devolucion' => 'nullable|date',
            'id_vehiculo' => 'required|integer',
            'id_taller' => 'required|integer'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_alta_mantenimiento(?, ?, ?, ?, NULL, NULL)",
            [
                $request->fecha_envio,
                $request->fecha_devolucion,
                $request->id_vehiculo,
                $request->id_taller
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
            'fecha_envio' => 'required|date',
            'fecha_devolucion' => 'nullable|date',
            'id_vehiculo' => 'required|integer',
            'id_taller' => 'required|integer'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_modificar_mantenimiento(?, ?, ?, ?, ?, NULL, NULL)",
            [
                $id,
                $request->fecha_envio,
                $request->fecha_devolucion,
                $request->id_vehiculo,
                $request->id_taller
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
            "CALL sp_baja_mantenimiento(?, NULL, NULL)",
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
            'fecha_devolucion' => 'required|date'
        ]);

        $resultado = DB::select(
            "CALL sp_finalizar_mantenimiento(?, ?, NULL, NULL)",
            [
                $id,
                $request->fecha_devolucion
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