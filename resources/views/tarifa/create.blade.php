@extends('layouts.app')

@section('titulo', 'Crear Tarifa')

@section('content')
<div class="container-fluid">

    <div class="row">
        <div class="col-md-5">

            <div class="card shadow mb-4">

                <div class="card-header py-3">
                    <h4 class="m-0 font-weight-bold text-primary text-center">
                        Nueva Tarifa
                    </h4>
                </div>

                <div class="card-body">

                    <form action="{{ route('tarifa.store') }}" method="POST" id="formTarifa">
                        @csrf

                        <div class="form-group">
                            <label for="precio_dia">
                                Precio por día
                            </label>
                            <input type="number"
                                   step="0.01"
                                   min="0"
                                   class="form-control"
                                   id="precio_dia"
                                   name="precio_dia"
                                   value="{{ old('precio_dia') }}"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="porcentaje_recargo_hora">
                                % Recargo por hora
                            </label>
                            <input type="number"
                                   step="0.01"
                                   min="0"
                                   class="form-control"
                                   id="porcentaje_recargo_hora"
                                   name="porcentaje_recargo_hora"
                                   value="{{ old('porcentaje_recargo_hora') }}"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="id_sucursal">
                                Sucursal
                            </label>
                            <select class="form-control"
                                    id="id_sucursal"
                                    name="id_sucursal"
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
                            <label for="id_tipo_vehiculo">
                                Tipo de vehículo
                            </label>
                            <select class="form-control"
                                    id="id_tipo_vehiculo"
                                    name="id_tipo_vehiculo"
                                    required>
                                <option value="">
                                    Seleccione un tipo
                                </option>

                                @foreach($tiposVehiculo as $tipo)
                                    <option value="{{ $tipo->id_tipo_vehiculo }}">
                                        {{ $tipo->nombre_tipo_vehiculo }}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <hr>

                        <div class="text-center">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save"></i> Guardar
                            </button>

                            <a href="{{ route('tarifa.index') }}"
                               class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Volver
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
    $('#formTarifa').submit(function(e) {
        e.preventDefault();

        $.ajax({
            url: "{{ route('tarifa.store') }}",
            method: "POST",
            data: $(this).serialize(),
            success: function(response) {

                alert(response.mensaje);

                window.location.href = "{{ route('tarifa.index') }}";
            },
            error: function(xhr) {

                alert(xhr.responseJSON.mensaje);
            }
        });
    });
</script>
@endsection