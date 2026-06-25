<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Vehiculo extends Model
{
    protected $table = 'vehiculo';

    protected $primaryKey = 'id_vehiculo';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_vehiculo',
        'patente',
        'marca',
        'modelo',
        'detalle_confort',
        'id_tipo_vehiculo',
        'id_sucursal'
    ];

    public function tipo(){
        return $this->belongsTo(Tipo_vehiculo::class, 'id_tipo_vehiculo');
    }

    public function sucursal(){
        return $this->belongsTo(Sucursal::class, 'id_sucursal');
    }

    public function imagenes()
    {
        return $this->hasMany(Imagen_vehiculo::class, 'id_vehiculo');
    }

    public function getEstado(){
        return Vehiculo_x_estado::where('id_vehiculo', $this->id_vehiculo)->orderBy('fecha_estado', 'desc')->first()->estado->nombre_estado_vehiculo;
    }

    public function getIdEstado(){
        return Vehiculo_x_estado::where('id_vehiculo', $this->id_vehiculo)->orderBy('fecha_estado', 'desc')->first()->estado->id_estado_vehiculo;
    }
}