<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Departamento extends Model
{
    protected $table = 'departamento';

    protected $primaryKey = 'id_departamento';

    public $timestamps = false;

    public $incrementing = true;

    protected $fillable = [ 
        'id_departamento',
        'nombre_departamento',
        'id_provincia'
    ];

    public function sucursales()
    {
        return $this->hasMany(Sucursal::class, 'id_departamento');
    }
}