<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DetalleFactura extends Model
{
    protected $table = 'detalle_factura';

    protected $primaryKey = 'id_detalle_factura';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_detalle_factura',
        'codigo',
        'descripcion',
        'precio_unitario',
        'subtotal',
        'id_factura'
    ];

    public function factura()
    {
        return $this->belongsTo(Factura::class, 'id_factura');
    }
}