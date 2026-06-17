<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Estado_vehiculo extends Model
{
    protected $table = 'estado_vehiculo';

    protected $primaryKey = 'id_estado_vehiculo';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_estado_vehiculo',
        'nombre_estado_vehiculo'
    ];
}