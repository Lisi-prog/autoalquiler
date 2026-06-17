<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tipo_vehiculo extends Model
{
    protected $table = 'tipo_vehiculo';

    protected $primaryKey = 'id_tipo_vehiculo';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_tipo_vehiculo',
        'nombre_tipo_vehiculo'
    ];

    public function vehiculos()
    {
        return $this->hasMany(Vehiculo::class, 'id_tipo_vehiculo');
    }
}