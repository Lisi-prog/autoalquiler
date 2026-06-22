<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Illuminate\Http\Request;
use Carbon\Carbon;

use App\Models\Sucursal;

class LogsController extends Controller
{
    public function log_alquiler_index(Request $request)
    {        
        $logs = collect(DB::select('SELECT * FROM log_alquiler ORDER BY fecha_mov DESC'));

        return view('logs.logs-alquiler', compact('logs'));
    }

    public function log_alquiler_x_estado_index(Request $request)
    {        
       $logs = DB::table('log_alquiler_x_estado')
                ->orderBy('fecha_mov', 'desc')
                ->get();

        return view('logs.logs-estado-alquiler', compact('logs'));
    }

    public function log_detalle_factura_index(Request $request)
    {        
       $logs = DB::table('log_detalle_factura')
                ->orderBy('fecha_mov', 'desc')
                ->get();

        return view('logs.logs-detalle-factura', compact('logs'));
    }

    public function log_factura_index(Request $request)
    {        
       $logs = DB::table('log_factura')
                ->orderBy('fecha_mov', 'desc')
                ->get();

        return view('logs.logs-factura', compact('logs'));
    }

    public function log_mantenimiento_index(Request $request)
    {        
       $logs = DB::table('log_mantenimiento')
                ->orderBy('fecha_mov', 'desc')
                ->get();

        return view('logs.logs-mantenimiento', compact('logs'));
    }

    public function log_reserva_index(Request $request)
    {        
       $logs = DB::table('log_reserva')
                ->orderBy('fecha_mov', 'desc')
                ->get();

        return view('logs.logs-reserva', compact('logs'));
    }

    public function log_reserva_x_estado_index(Request $request)
    {        
       $logs = DB::table('log_reserva_x_estado')
                ->orderBy('fecha_mov', 'desc')
                ->get();

        return view('logs.logs-reserva-estado', compact('logs'));
    }

    public function log_sucursal_index(Request $request)
    {        
       $logs = DB::table('log_sucursal')
                ->orderBy('fecha_mov', 'desc')
                ->get();

        return view('logs.logs-sucursal', compact('logs'));
    }

    public function log_taller_index(Request $request)
    {        
       $logs = DB::table('log_taller')
                ->orderBy('fecha_mov', 'desc')
                ->get();

        return view('logs.logs-taller', compact('logs'));
    }

    public function log_tarifa_index(Request $request)
    {        
       $logs = DB::table('log_tarifa')
                ->orderBy('fecha_mov', 'desc')
                ->get();

        return view('logs.logs-tarifa', compact('logs'));
    }

    public function log_tipo_vehiculo_index(Request $request)
    {        
       $logs = DB::table('log_tipo_vehiculo')
                ->orderBy('fecha_mov', 'desc')
                ->get();

        return view('logs.logs-tipo-vehiculo', compact('logs'));
    }

    public function log_vehiculo_index(Request $request)
    {        
       $logs = DB::table('log_vehiculo')
                ->orderBy('fecha_mov', 'desc')
                ->get();

        return view('logs.logs-vehiculo', compact('logs'));
    }

    public function log_vehiculo_x_estado_index(Request $request)
    {        
       $logs = DB::table('log_vehiculo_x_estado')
                ->orderBy('fecha_mov', 'desc')
                ->get();

        return view('logs.logs-vehiculo-estado', compact('logs'));
    }
}