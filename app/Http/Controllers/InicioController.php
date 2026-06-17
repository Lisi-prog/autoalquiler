<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Illuminate\Http\Request;
use Carbon\Carbon;

use App\Models\Sucursal;

class InicioController extends Controller
{
    function __construct()
    {
    }
    
    public function index(Request $request)
    {        
        $sucursales = Sucursal::orderBy('nombre_sucursal')->get();

        return view('inicio', compact('sucursales'));
    }

    public function create()
    {
    }

    public function store(Request $request)
    {        
    }
    
    public function show($id)
    {
    }
    
    public function edit($id)
    {
    }
    
    public function update(Request $request, $id)
    {
    }
    
    public function destroy($id)
    {
    }

    public function obtenerVehiculosDisponibles(Request $request)
    {
        // return $request;
        $vehiculos = [];
        $fotos = [];

        $vehiculosAbuscar = DB::select("SELECT
                                            v.id_vehiculo,
                                            v.patente,
                                            v.marca,
                                            v.modelo,
                                            v.detalle_confort,
                                            v.id_tipo_vehiculo,
                                            fn_calcular_monto_tarifa(:fecini, :fecfin, v.id_tipo_vehiculo, :sucursal) as monto,
                                            s.nombre_sucursal,
                                            tv.nombre_tipo_vehiculo,
                                            de.nombre_departamento
                                        FROM vehiculo v
                                        LEFT JOIN sucursal s on s.id_sucursal=v.id_sucursal
                                        LEFT JOIN tipo_vehiculo tv on tv.id_tipo_vehiculo=v.id_tipo_vehiculo
                                        LEFT JOIN departamento de on de.id_departamento=s.id_departamento
                                        WHERE v.id_sucursal = :sucursal
                                        AND fn_vehiculo_disponible(v.id_vehiculo, :fecini, :fecfin)", [
                                            'sucursal' => $request->sucursal_retiro,
                                            'fecini' => $request->fecha_retiro,
                                            'fecfin' => $request->fecha_devolucion
                                    ]);

        foreach ($vehiculosAbuscar as $ve) {
            $fotos = [];
            
            $fotosdb = DB::select("select iv.ruta_imagen, iv.nombre_imagen from imagen_vehiculo iv where iv.id_vehiculo = ?", [$ve->id_vehiculo]);

            foreach ($fotosdb  as $f) {
                $fotos[] = (object)['ruta'=>$f->ruta_imagen];
            }

            $vehiculos[] = (object)[
                'id_vehiculo' => $ve->id_vehiculo,
                'detalle_confort' => $ve->detalle_confort,
                'marca' => $ve->marca,
                'modelo' => $ve->modelo,
                'patente' => $ve->patente,
                'tipo' => $ve->nombre_tipo_vehiculo,
                'sucursal' => $ve->nombre_sucursal,
                'departamento_sucursal' => $ve->nombre_departamento,
                'total' => number_format($ve->monto, 2, ',', '.'),
                'fotos' => $fotos
            ];
        }

        return response()->json($vehiculos);
    }
    
}