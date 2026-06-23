<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Alquiler_x_estado extends Model
{
    protected $table = 'alquiler_x_estado';

    protected $primaryKey = 'id_veh_x_est';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [
        'id_alquiler',
        'id_estado_alquiler',
        'fecha_estado'
    ];

    public function alquiler(){
        return $this->belongsTo(Alquiler::class, 'id_alquiler');
    }

    public function estado(){
        return $this->belongsTo(Estado_alquiler::class, 'id_estado_alquiler');
    }
}