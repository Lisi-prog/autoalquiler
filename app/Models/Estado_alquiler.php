<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Estado_alquiler extends Model
{
    protected $table = 'estado_alquiler';

    protected $primaryKey = 'id_estado_alquiler';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_estado_alquiler',
        'nombre_estado_alquiler'
    ];
}