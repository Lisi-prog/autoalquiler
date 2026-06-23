@extends('layouts.app')

@section('titulo', 'Inicio')

@section('content')
<style>
    .carousel-control-prev-icon,
    .carousel-control-next-icon {
        background-color: rgba(0,0,0,.6);
        /* border-radius: 50%;
        padding: 15px; */
    }
</style>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Content Row -->
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            @include('layouts.loanding')
            <form method="POST" action="{{ route('vehiculos.disponibles') }}" id="form-buscar-vehiculos">
            @csrf
            <div class="card shadow mb-4">
                <div class="card-body">
                    <h4 class="text-center mb-4">
                        AutoGest
                    </h4>
                    <div class="row">
                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                            <label for="sucursal_retiro">
                                Sucursal de retiro
                            </label>
                            <select class="form-control" id="sucursal_retiro" name="sucursal_retiro" required>
                                <option value="">Seleccione una sucursal</option>
                                @foreach($sucursales as $sucursal)
                                    <option value="{{ $sucursal->id_sucursal}}">
                                        {{ $sucursal->nombre_sucursal}}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" hidden id="opcion-suc-dev">
                            <label for="sucursal_devolucion">
                                Sucursal de devolución
                            </label>
                            <select class="form-control" id="sucursal_devolucion" name="sucursal_devolucion">
                                <option value="">Seleccione una sucursal</option>
                                @foreach($sucursales as $sucursal)
                                    <option value="{{ $sucursal->id_sucursal}}">
                                        {{ $sucursal->nombre_sucursal}}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <!-- Fecha retiro -->
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                            <label for="fecha_retiro">
                                Fecha de retiro
                            </label>
                            <input
                                type="datetime-local"
                                class="form-control"
                                id="fecha_retiro"
                                name="fecha_retiro"
                                required>
                        </div>

                        <!-- Fecha devolución -->
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                            <label for="fecha_devolucion">
                                Fecha de devolución
                            </label>
                            <input
                                type="datetime-local"
                                class="form-control"
                                id="fecha_devolucion"
                                name="fecha_devolucion"
                                required>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 text-center">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-search"></i>
                                Buscar vehículos disponibles
                            </button>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                            <div class="d-flex flex-wrap gap-3">
                                <div class="form-check mb-0">
                                    <input class="form-check-input" type="checkbox" name="misma_oficina" id="mismaOficina" value="1" checked>
                                    <label class="form-check-label text-muted" for="mismaOficina" style="font-size: 0.85rem;">
                                        Devolución en la misma oficina.
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </form>
        </div>
    </div>

    <div class="row" id="row-result-vehiculo" hidden>
    </div>
</div>
@include('modal.confirmar-reserva')
@endsection

@section('scripts')
<script src="{{ asset('js\index_inicio.js') }}?v={{ filemtime(public_path('js\index_inicio.js')) }}"></script>
<script>
    const user = @json(auth()->check()
        ? auth()->user()->cliente?->id_cliente
        : null);

    console.log(user);
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {

        const mismaOficina = document.getElementById('mismaOficina');
        const opcionSucDev = document.getElementById('opcion-suc-dev');
        const sucursalDevolucion = document.getElementById('sucursal_devolucion');

        mismaOficina.addEventListener('change', function () {

            if (this.checked) {
                opcionSucDev.hidden = true;
                sucursalDevolucion.required = false;
                sucursalDevolucion.value = '';
            } else {
                opcionSucDev.hidden = false;
                sucursalDevolucion.required = true
            }

        });

    });
</script>
@endsection