@extends('layouts.app')

@section('titulo', 'Crear Vehiculo')

@section('content')
<div class="container-fluid">

    <div class="row ">
        <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">

            <div class="card shadow mb-4">

                <div class="card-header py-3">
                    <h4 class="m-0 font-weight-bold text-primary text-center">
                        Nuevo Vehiculo
                    </h4>
                </div>

                <div class="card-body">

                    <form action="{{ route('vehiculo.store') }}"
                        method="POST"
                        enctype="multipart/form-data"
                        id="formVehiculo">

                        @csrf

                        <div class="form-group">
                            <label for="patente">Patente</label>
                            <input type="text"
                                class="form-control"
                                id="patente"
                                name="patente"
                                required>
                        </div>

                        <div class="form-group">
                            <label for="marca">Marca</label>
                            <input type="text"
                                class="form-control"
                                id="marca"
                                name="marca"
                                required>
                        </div>

                        <div class="form-group">
                            <label for="modelo">Modelo</label>
                            <input type="text"
                                class="form-control"
                                id="modelo"
                                name="modelo"
                                required>
                        </div>

                        <div class="form-group">
                            <label for="detalle_confort">Detalle de confort</label>
                            <textarea class="form-control"
                                    id="detalle_confort"
                                    name="detalle_confort"
                                    rows="4"></textarea>
                        </div>

                        <div class="form-group">
                            <label for="id_tipo_vehiculo">Tipo de vehículo</label>
                            <select class="form-control"
                                    id="id_tipo_vehiculo"
                                    name="id_tipo_vehiculo"
                                    required>

                                <option value="">
                                    Seleccione un tipo
                                </option>

                                @foreach($tipos as $t)
                                    <option value="{{ $t->id_tipo_vehiculo }}">
                                        {{ $t->nombre_tipo_vehiculo }}
                                    </option>
                                @endforeach

                            </select>
                        </div>

                        <div class="form-group">
                            <label for="id_sucursal">Sucursal</label>
                            <select class="form-control"
                                    id="id_sucursal"
                                    name="id_sucursal"
                                    required>

                                <option value="">
                                    Seleccione una sucursal
                                </option>

                                @foreach($sucursales as $s)
                                    <option value="{{ $s->id_sucursal }}">
                                        {{ $s->nombre_sucursal }}
                                    </option>
                                @endforeach

                            </select>
                        </div>

                        <div class="form-group">
                            <label for="imagenes">
                                Imágenes del vehículo
                            </label>

                            <input type="file"
                                class="form-control"
                                id="imagenes"
                                name="imagenes[]"
                                multiple
                                accept="image/*">
                        </div>

                        <hr>

                        <div class="text-center">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save"></i> Guardar
                            </button>

                            <a href="{{ route('vehiculo.index') }}"
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
    $('#imagenes').on('change', function() {

        if (this.files.length > 5) {

            alert('Solo puede seleccionar hasta 5 imágenes.');

            this.value = '';
        }
    });

    $('#formVehiculo').submit(function(e) {

        e.preventDefault();

        let formData = new FormData(this);

        $.ajax({
            url: $(this).attr('action'),
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,

            success: function(response) {

                alert(response.mensaje);

                window.location.href = "{{ route('vehiculo.index') }}";
            },

            error: function(xhr) {

                if (xhr.responseJSON?.mensaje) {
                    alert(xhr.responseJSON.mensaje);
                } else {
                    alert('Ocurrió un error al guardar el vehículo.');
                }
            }
        });

    });
</script>
@endsection