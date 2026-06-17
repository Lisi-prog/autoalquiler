<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Imagen_vehiculo extends Model
{
    protected $table = 'imagen_vehiculo';

    protected $primaryKey = 'id_imagen_vehiculo';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_imagen_vehiculo',
        'ruta_imagen',
        'nombre_imagen',
        'id_vehiculo'
    ];

    public function vehiculo(){
        return $this->belongsTo(Vehiculo::class, 'id_vehiculo');
    }
}