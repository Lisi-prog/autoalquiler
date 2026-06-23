<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\Tarifa;

class TarifaController extends Controller
{
    function __construct()
    {
    }
    
    public function index(Request $request)
    {
        $tarifas = Tarifa::orderBy('id_tarifa', 'desc')->get();
        return view('tarifa.index', compact('tarifas')); 
    }

    public function create()
    {
    }

    public function store(Request $request)
    {       
        $request->validate([
            'precio_dia' => 'required|numeric|min:0.01',
            'porcentaje_recargo_hora' => 'required|numeric|min:0',
            'id_sucursal' => 'required|integer',
            'id_tipo_vehiculo' => 'required|integer'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_alta_tarifa(?, ?, ?, ?, NULL, NULL)",
            [
                $request->precio_dia,
                $request->porcentaje_recargo_hora,
                $request->id_sucursal,
                $request->id_tipo_vehiculo
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
            'precio_dia' => 'required|numeric|min:0.01',
            'porcentaje_recargo_hora' => 'required|numeric|min:0',
            'id_sucursal' => 'required|integer',
            'id_tipo_vehiculo' => 'required|integer'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_modificar_tarifa(?, ?, ?, ?, ?, NULL, NULL)",
            [
                $id,
                $request->precio_dia,
                $request->porcentaje_recargo_hora,
                $request->id_sucursal,
                $request->id_tipo_vehiculo
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
            "CALL sp_baja_tarifa(?, NULL, NULL)",
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