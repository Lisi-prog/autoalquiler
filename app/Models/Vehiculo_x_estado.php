<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Vehiculo_x_estado extends Model
{
    protected $table = 'vehiculo_x_estado';

    protected $primaryKey = 'id_veh_x_est';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [
        'id_veh_x_est',
        'id_vehiculo',
        'id_estado_vehiculo',
        'fecha_estado'
    ];

    public function vehiculo(){
        return $this->belongsTo(Vehiculo::class, 'id_vehiculo');
    }

    public function estado(){
        return $this->belongsTo(Estado_vehiculo::class, 'id_estado_vehiculo');
    }
}