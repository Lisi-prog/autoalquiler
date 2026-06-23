<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
    protected $table = 'cliente';

    protected $primaryKey = 'id_cliente';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_cliente',
        'nombre_completo',
        'dni',
        'telefono',
        'id_user'
    ];

    public function reservas(){
        return $this->hasMany(Reserva::class, 'id_reserva');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'id_user', 'id');
    }
}