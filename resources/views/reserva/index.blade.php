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
                            Reservas
                        </h4>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <table id="tabla_vehiculo" class="table table-sm table-hover">
                                <thead style="background-color: #4e73df;">
                                    <th class='text-center' style="color:#fff;">Cod.</th>
                                    <th class='text-center' style="color:#fff;">Fecha Inicio</th>
                                    <th class='text-center' style="color:#fff;">Fecha Fin</th>
                                    <th class='text-center' style="color:#fff;">Sucursal Retiro</th>
                                    <th class='text-center' style="color:#fff;">Sucursal Devolucion</th>
                                    <th class='text-center' style="color:#fff;">Cliente</th>
                                    <th class='text-center' style="color:#fff;">Vehiculo</th>
                                    <th class='text-center' style="color:#fff;">Estado</th>
                                    <th class='text-center' style="color:#fff;">Acciones</th>
                                </thead>
                                <tbody>     
                                    @foreach ($reservas as $r)
                                        <tr>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$r->id_reserva ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$r->fecha_inicio ? \Carbon\Carbon::parse($r->fecha_inicio)->format('d/m/Y') : '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$r->fecha_fin ? \Carbon\Carbon::parse($r->fecha_fin)->format('d/m/Y') : '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$r->sucursalRetiro->nombre_sucursal ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$r->sucursalDevolucion->nombre_sucursal  ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$r->cliente->nombre_completo ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$r->vehiculo->patente ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$r->getEstado() ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">-
                                                {{-- <a href="{{ route('reserva.edit', $r->id_reserva) }}" class="btn btn-warning">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button class="btn btn-danger btn-eliminar"
                                                        data-id="{{ $r->id_reserva }}">
                                                    <i class="fas fa-trash"></i>
                                                </button> --}}
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