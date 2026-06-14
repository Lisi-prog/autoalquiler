<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Sucursal extends Model
{
    protected $table = 'sucursal';

    protected $primaryKey = 'id_sucursal';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_sucursal',
        'nombre_sucursal',
        'direccion_sucursal',
        'id_departamento'
    ];

}