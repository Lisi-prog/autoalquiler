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
}