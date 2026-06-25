<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Alquiler extends Model
{
    protected $table = 'alquiler';

    protected $primaryKey = 'id_alquiler';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_alquiler',
        'fecha_inicio' ,
        'fecha_fin_prevista',
        'fecha_fin_real',
        'km_inicio',
        'km_fin',
        'sucursal_retiro',
        'sucursal_devolucion',
        'id_reserva',
        'id_cliente',
        'id_vehiculo'
    ];

    public function reserva(){
        return $this->belongsTo(Reserva::class, 'id_reserva');
    }

    public function vehiculo(){
        return $this->belongsTo(Vehiculo::class, 'id_vehiculo');
    }

    public function cliente(){
        return $this->belongsTo(Cliente::class, 'id_cliente');
    }

    public function sucursalRetiro(){
        return $this->belongsTo(Sucursal::class, 'sucursal_retiro');
    }

    public function sucursalDevolucion(){
        return $this->belongsTo(Sucursal::class, 'sucursal_devolucion');
    }

    public function getEstado(){
        return Alquiler_x_estado::where('id_alquiler', $this->id_alquiler)->orderBy('fecha_estado', 'desc')->first()->estado->nombre_estado_alquiler;
    }

    public function getIdEstado(){
        return Alquiler_x_estado::where('id_alquiler', $this->id_alquiler)->orderBy('fecha_estado', 'desc')->first()->estado->id_estado_alquiler;
    }
}