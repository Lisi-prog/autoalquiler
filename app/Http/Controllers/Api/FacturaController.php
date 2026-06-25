<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Illuminate\Http\Request;
use Carbon\Carbon;

use App\Models\Factura;
use App\Models\Alquiler;

use Barryvdh\DomPDF\Facade\Pdf;

class FacturaController extends Controller
{
    public function generarPdf($id)
    {
        $factura = Factura::with('detalles')
            ->where('id_alquiler', $id)
            ->first();

        if (!$factura) {
            return redirect()->back()->with('error', 'No se encontró la factura.');
        }

        $pdf = Pdf::loadView('factura.pdf', compact('factura'));

        return $pdf->stream(
            'factura_'.$factura->id_factura.'.pdf'
        );
    }
}