@extends('layouts.app')

@section('titulo', 'Crear Sucursal')

@section('content')
<div class="container-fluid">

    <div class="row ">
        <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">

            <div class="card shadow mb-4">

                <div class="card-header py-3">
                    <h4 class="m-0 font-weight-bold text-primary text-center">
                        Nueva Sucursal
                    </h4>
                </div>

                <div class="card-body">

                    <form action="{{ route('sucursal.update', $s->id_sucursal) }}" method="POST" id="formSucursal">
                        @method('PUT')
                        @csrf

                        <div class="form-group">
                            <label for="nombre_sucursal">
                                Nombre de la sucursal
                            </label>
                            <input type="text"
                                   class="form-control"
                                   id="nombre_sucursal"
                                   name="nombre_sucursal"
                                   value="{{ $s->nombre_sucursal }}"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="direccion_sucursal">
                                Dirección
                            </label>
                            <input type="text"
                                   class="form-control"
                                   id="direccion_sucursal"
                                   name="direccion_sucursal"
                                   value="{{ $s->direccion_sucursal}}"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="id_departamento">
                                Departamento
                            </label>
                            <select class="form-control"
                                    id="id_departamento"
                                    name="id_departamento"
                                    required>
                                <option value="">
                                    Seleccione un departamento
                                </option>

                                @foreach($departamentos as $d)
                                    <option value="{{ $d->id_departamento }}" {{$s->id_departamento == $d->id_departamento ? 'selected' : null}}>
                                        {{ $d->nombre_departamento }}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <hr>

                        <div class="text-center">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save"></i> Guardar
                            </button>

                            <a href="{{ route('sucursal.index') }}"
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
    $('#formSucursal').submit(function(e) {
        e.preventDefault();

        $.ajax({
            url: $(this).attr('action'),
            type: 'POST',
            data: $(this).serialize(),
            success: function(response) {

                alert(response.mensaje);

                window.location.href = "{{ route('sucursal.index') }}";
            },
            error: function(xhr) {

                alert(xhr.responseJSON.mensaje);
            }
        });
    });
</script>
@endsection