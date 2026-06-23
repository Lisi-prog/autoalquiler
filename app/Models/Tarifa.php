<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tarifa extends Model
{
    protected $table = 'tarifa';

    protected $primaryKey = 'id_tarifa';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_tarifa',
        'precio_dia',
        'porcentaje_recargo_hora',
        'id_sucursal',
        'id_tipo_vehiculo'
    ];

    public function sucursal(){
        return $this->belongsTo(Sucursal::class, 'id_sucursal');
    }

    public function tipoVehiculo(){
        return $this->belongsTo(Tipo_vehiculo::class, 'id_tipo_vehiculo');
    }
}