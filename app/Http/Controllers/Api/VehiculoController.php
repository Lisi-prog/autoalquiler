<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Illuminate\Http\Request;
use Carbon\Carbon;

class VehiculoController extends Controller
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
            'patente' => 'required|string|max:10',
            'marca' => 'required|string|max:20',
            'modelo' => 'required|string|max:20',
            'detalle_confort' => 'nullable|string|max:500',
            'id_tipo_vehiculo' => 'required|integer',
            'id_sucursal' => 'required|integer'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_alta_vehiculo(?, ?, ?, ?, ?, ?, NULL, NULL)",
            [
                $request->patente,
                $request->marca,
                $request->modelo,
                $request->detalle_confort,
                $request->id_tipo_vehiculo,
                $request->id_sucursal
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
            'patente' => 'required|string|max:10',
            'marca' => 'required|string|max:20',
            'modelo' => 'required|string|max:20',
            'detalle_confort' => 'nullable|string|max:500',
            'id_tipo_vehiculo' => 'required|integer',
            'id_sucursal' => 'required|integer'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_modificar_vehiculo(?, ?, ?, ?, ?, ?, ?, NULL, NULL)",
            [
                $id,
                $request->patente,
                $request->marca,
                $request->modelo,
                $request->detalle_confort,
                $request->id_tipo_vehiculo,
                $request->id_sucursal
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
            "CALL sp_baja_vehiculo(?, NULL, NULL)",
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

}