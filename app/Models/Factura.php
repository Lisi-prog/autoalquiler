<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Factura extends Model
{
    protected $table = 'factura';

    protected $primaryKey = 'id_factura';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_factura',
        'fecha_emision',
        'monto_base',
        'monto_recargo',
        'total',
        'id_alquiler'
    ];

    public function detalles()
    {
        return $this->hasMany(DetalleFactura::class, 'id_factura');
    }
}