<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Reserva extends Model
{
    protected $table = 'reserva';

    protected $primaryKey = 'id_reserva';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_reserva',
        'fecha_inicio',
        'fecha_fin',
        'sucursal_retiro',
        'sucursal_devolucion' ,
        'id_cliente',
        'id_vehiculo',
    ];

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
        return Reserva_x_estado::where('id_reserva', $this->id_reserva)->orderBy('fecha_estado', 'desc')->first()->estado->nombre_estado_reserva;
    }

    public function getIdEstado(){
        return Reserva_x_estado::where('id_reserva', $this->id_reserva)->orderBy('fecha_estado', 'desc')->first()->estado->id_estado_reserva;
    }
}