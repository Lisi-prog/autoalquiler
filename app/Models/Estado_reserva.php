<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Estado_reserva extends Model
{
    protected $table = 'estado_reserva';

    protected $primaryKey = 'id_estado_reserva';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_estado_reserva',
        'nombre_estado_reserva'
    ];
}