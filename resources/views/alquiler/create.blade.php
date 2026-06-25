@extends('layouts.app')

@section('titulo', 'Crear Alquiler')

@section('content')
<div class="container-fluid">

    <div class="row">
        <div class="col-md-4">

            <div class="card shadow mb-4">

                <div class="card-header py-3">
                    <h4 class="m-0 font-weight-bold text-primary text-center">
                        Nuevo Alquiler
                    </h4>
                </div>

                <div class="card-body">

                    <form action="{{ route('alquiler.store') }}"
                          method="POST"
                          id="formAlquiler">
                        @csrf

                        <div class="form-group">
                            <label for="fecha_inicio">
                                Fecha inicio
                            </label>
                            <input type="datetime-local"
                                   class="form-control"
                                   id="fecha_inicio"
                                   name="fecha_inicio"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="fecha_fin_prevista">
                                Fecha fin prevista
                            </label>
                            <input type="datetime-local"
                                   class="form-control"
                                   id="fecha_fin_prevista"
                                   name="fecha_fin_prevista"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="km_inicio">
                                Kilómetros iniciales
                            </label>
                            <input type="number"
                                   class="form-control"
                                   id="km_inicio"
                                   name="km_inicio"
                                   min="0"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="id_cliente">
                                Cliente
                            </label>
                            <select class="form-control"
                                    id="id_cliente"
                                    name="id_cliente"
                                    required>

                                <option value="">
                                    Seleccione un cliente
                                </option>

                                @foreach($clientes as $cliente)
                                    <option value="{{ $cliente->id_cliente }}">
                                        {{ $cliente->nombre_completo }}
                                    </option>
                                @endforeach

                            </select>
                        </div>

                        <div class="form-group">
                            <label for="id_vehiculo">
                                Vehículo
                            </label>
                            <select class="form-control"
                                    id="id_vehiculo"
                                    name="id_vehiculo"
                                    required>

                                <option value="">
                                    Seleccione un vehículo
                                </option>

                                @foreach($vehiculos as $vehiculo)
                                    <option value="{{ $vehiculo->id_vehiculo }}">
                                        {{ $vehiculo->patente }}
                                    </option>
                                @endforeach

                            </select>
                        </div>

                        <div class="form-group">
                            <label for="sucursal_retiro">
                                Sucursal de retiro
                            </label>
                            <select class="form-control"
                                    id="sucursal_retiro"
                                    name="sucursal_retiro"
                                    required>

                                <option value="">
                                    Seleccione una sucursal
                                </option>

                                @foreach($sucursales as $sucursal)
                                    <option value="{{ $sucursal->id_sucursal }}">
                                        {{ $sucursal->nombre_sucursal }}
                                    </option>
                                @endforeach

                            </select>
                        </div>

                        <div class="form-group">
                            <label for="sucursal_devolucion">
                                Sucursal de devolución
                            </label>
                            <select class="form-control"
                                    id="sucursal_devolucion"
                                    name="sucursal_devolucion"
                                    required>

                                <option value="">
                                    Seleccione una sucursal
                                </option>

                                @foreach($sucursales as $sucursal)
                                    <option value="{{ $sucursal->id_sucursal }}">
                                        {{ $sucursal->nombre_sucursal }}
                                    </option>
                                @endforeach

                            </select>
                        </div>

                        {{-- <div class="form-group">
                            <label for="id_reserva">
                                Reserva asociada (opcional)
                            </label>
                            <select class="form-control"
                                    id="id_reserva"
                                    name="id_reserva">

                                <option value="">
                                    Sin reserva
                                </option>

                                @foreach($reservas as $reserva)
                                    <option value="{{ $reserva->id_reserva }}">
                                        Reserva #{{ $reserva->id_reserva }}
                                    </option>
                                @endforeach

                            </select>
                        </div> --}}

                        <hr>

                        <div class="text-center">
                            <button type="submit"
                                    class="btn btn-success">
                                <i class="fas fa-save"></i>
                                Guardar
                            </button>

                            <a href="{{ route('alquiler.index') }}"
                               class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i>
                                Volver
                            </a>
                        </div>

                    </form>

                </div>

            </div>

        </div>
    </div>

</div>
@endsection

@section('scripts')
<script>
    $('#formAlquiler').submit(function(e) {
        e.preventDefault();

        $.ajax({
            url: "{{ route('alquiler.store') }}",
            method: "POST",
            data: $(this).serialize(),

            success: function(response) {

                alert(response.mensaje);

                window.location.href =
                    "{{ route('alquiler.index') }}";
            },

            error: function(xhr) {

                alert(xhr.responseJSON.mensaje);
            }
        });
    });
</script>
@endsection