@extends('layouts.app')

@section('titulo', 'Inicio')

@section('content')
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Content Row -->
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            @include('layouts.loanding')
            <div class="card shadow mb-4">
                <div class="card-body">
                    <div class="position-relative mb-4">
                        <h4 class="text-center mb-0">
                            Vehiculos
                        </h4>

                        <a href="{{ route('vehiculo.create') }}"
                        class="btn btn-primary position-absolute"
                        style="right: 0; top: 50%; transform: translateY(-50%);">
                            <i class="fas fa-plus"></i> Crear
                        </a>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <table id="tabla_vehiculo" class="table table-sm table-hover">
                                <thead style="background-color: #4e73df;">
                                    <th class='text-center' style="color:#fff;">Cod.</th>
                                    <th class='text-center' style="color:#fff;">Patente</th>
                                    <th class='text-center' style="color:#fff;">Marca</th>
                                    <th class='text-center' style="color:#fff;">Modelo</th>
                                    <th class='text-center' style="color:#fff;">Detalle</th>
                                    <th class='text-center' style="color:#fff;">Estado</th>
                                    <th class='text-center' style="color:#fff;">Tipo</th>
                                    <th class='text-center' style="color:#fff;">Sucursal</th>
                                    <th class='text-center' style="color:#fff;">Acciones</th>
                                </thead>
                                <tbody>     
                                    @foreach ($vehiculos as $v)
                                        <tr>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$v->id_vehiculo}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$v->patente}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$v->marca}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$v->modelo}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$v->detalle_confort}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$v->getEstado()}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$v->tipo->nombre_tipo_vehiculo}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$v->sucursal->nombre_sucursal}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">
                                                <a href="{{ route('vehiculo.edit', $v->id_vehiculo) }}" class="btn btn-warning">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button class="btn btn-danger btn-eliminar"
                                                        data-id="{{ $v->id_vehiculo }}">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script>
    $(document).ready(function () { 
        $('#tabla_vehiculo').DataTable({
            order: [],
            language: {
                    lengthMenu: 'Mostrar _MENU_ registros por pagina',
                    zeroRecords: 'No se ha encontrado registros',
                    info: 'Mostrando pagina _PAGE_ de _PAGES_',
                    infoEmpty: 'No se ha encontrado registros',
                    infoFiltered: '(Filtrado de _MAX_ registros totales)',
                    search: 'Buscar:',
                    paginate:{
                        first:"Prim.",
                        last: "Ult.",
                        previous: 'Ant.',
                        next: 'Sig.',
                    },
                }
        });

        $('.btn-eliminar').click(function() {

            if (!confirm('¿Está seguro que dar de BAJA el vehiculo?')) {
                return;
            }

            let id = $(this).data('id');

            $.ajax({
                url: '/vehiculo/' + id,
                type: 'DELETE',
                data: {
                    _token: '{{ csrf_token() }}'
                },
                success: function(response) {
                    location.reload();
                }
            });
        });
    });
</script>
@endsection