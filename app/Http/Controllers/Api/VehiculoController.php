<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Illuminate\Http\Request;
use Carbon\Carbon;

use App\Models\Sucursal;
use App\Models\Vehiculo;
use App\Models\Imagen_vehiculo;
use App\Models\Tipo_vehiculo;

class VehiculoController extends Controller
{
    function __construct()
    {
    }
    
    public function index(Request $request)
    {      
        $vehiculos = Vehiculo::orderBy('marca')->orderBy('modelo')->get();
        return view('vehiculo.index', compact('vehiculos'));    
    }

    public function create()
    {
        $tipos = Tipo_vehiculo::orderBy('nombre_tipo_vehiculo')->get();
        $sucursales = Sucursal::orderBy('nombre_sucursal')->get();
        return view('vehiculo.create', compact('tipos', 'sucursales'));
    }

    public function store(Request $request)
    {       
        $request->validate([
            'patente' => 'required|string|max:10',
            'marca' => 'required|string|max:20',
            'modelo' => 'required|string|max:20',
            'detalle_confort' => 'nullable|string|max:500',
            'id_tipo_vehiculo' => 'required|integer',
            'id_sucursal' => 'required|integer',
            'imagenes' => 'nullable|array|max:5',
            'imagenes.*' => 'image|mimes:jpg,jpeg,png,webp|max:2048'
        ]);

        DB::statement(
            "SET app.usuario = " . (int) auth()->id()
        );

        $resultado = DB::select(
            "CALL sp_alta_vehiculo(?, ?, ?, ?, ?, ?, NULL, NULL, NULL)",
            [
                $request->patente,
                $request->marca,
                $request->modelo,
                $request->detalle_confort,
                $request->id_tipo_vehiculo,
                $request->id_sucursal
            ]
        );

        $idVehiculo = $resultado[0]->p_id_vehiculo;
        $codigo = $resultado[0]->p_codigo;
        $mensaje = $resultado[0]->p_mensaje;

        if ($codigo != 0) {

            return response()->json([
                'success' => false,
                'codigo' => $codigo,
                'mensaje' => $mensaje
            ], 400);
        }

        // Eliminar espacios y convertir a mayúsculas
        $patente = strtoupper(
            preg_replace('/\s+/', '', $request->patente)
        );

        $contador = 1;

        foreach ($request->file('imagenes', []) as $imagen) {

            $extension = strtolower(
                $imagen->getClientOriginalExtension()
            );

            $nombre = $patente . '_' .
                    str_pad($contador, 3, '0', STR_PAD_LEFT) .
                    '.' .
                    $extension;

            $imagen->move(
                public_path('img/vehiculo'),
                $nombre
            );

            DB::select(
                "CALL sp_alta_imagen_vehiculo(?, ?, ?, NULL, NULL)",
                [
                    '/img/vehiculo/' . $nombre,
                    $nombre,
                    $idVehiculo
                ]
            );

            $contador++;
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