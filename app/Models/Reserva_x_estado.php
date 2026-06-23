<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Reserva_x_estado extends Model
{
    protected $table = 'reserva_x_estado';

    protected $primaryKey = 'id_veh_x_est';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [
        'id_reserva',
        'id_estado_reserva',
        'fecha_estado'
    ];

    public function reserva(){
        return $this->belongsTo(Reserva::class, 'id_reserva');
    }

    public function estado(){
        return $this->belongsTo(Estado_reserva::class, 'id_estado_reserva');
    }
}