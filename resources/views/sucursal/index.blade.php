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
                            Sucursales
                        </h4>

                        <a href="{{ route('sucursal.create') }}"
                        class="btn btn-primary position-absolute"
                        style="right: 0; top: 50%; transform: translateY(-50%);">
                            <i class="fas fa-plus"></i> Crear
                        </a>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <table id="tabla_sucursal" class="table table-sm table-hover">
                                <thead style="background-color: #4e73df;">
                                    <th class='text-center' style="color:#fff;">Cod.</th>
                                    <th class='text-center' style="color:#fff;">Nombre</th>
                                    <th class='text-center' style="color:#fff;">Direccion</th>
                                    <th class='text-center' style="color:#fff;">Departamento</th>
                                    <th class='text-center' style="color:#fff;">Acciones</th>
                                </thead>
                                <tbody>     
                                    @foreach ($sucursales as $s)
                                        <tr>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$s->id_sucursal}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$s->nombre_sucursal}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$s->direccion_sucursal}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$s->departamento->nombre_departamento}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">
                                                <a href="{{ route('sucursal.edit', $s->id_sucursal) }}" class="btn btn-warning">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button class="btn btn-danger btn-eliminar"
                                                        data-id="{{ $s->id_sucursal }}">
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
        $('#tabla_sucursal').DataTable({
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

            if (!confirm('¿Está seguro que desea ELIMINAR la sucursal?')) {
                return;
            }

            let id = $(this).data('id');

            $.ajax({
                url: '/sucursal/' + id,
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