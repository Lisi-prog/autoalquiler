<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Illuminate\Http\Request;
use Carbon\Carbon;

class SucursalController extends Controller
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
            'nombre_sucursal' => 'required|string|max:50',
            'direccion_sucursal' => 'nullable|string|max:100',
            'id_departamento' => 'required|integer'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_alta_sucursal(?, ?, ?, NULL, NULL)",
            [
                $request->nombre_sucursal,
                $request->direccion_sucursal,
                $request->id_departamento
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
            'nombre_sucursal' => 'required|string|max:50',
            'direccion_sucursal' => 'nullable|string|max:100',
            'id_departamento' => 'required|integer'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_modificar_sucursal(?, ?, ?, ?, NULL, NULL)",
            [
                $id,
                $request->nombre_sucursal,
                $request->direccion_sucursal,
                $request->id_departamento
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
            "CALL sp_baja_sucursal(?, NULL, NULL)",
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