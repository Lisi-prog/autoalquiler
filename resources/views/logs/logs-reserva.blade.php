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
                            Logs Reserva
                        </h4>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <div class="table-responsive">
                                <table id="tabla_sucursal" class="table table-sm table-hover">
                                    <thead style="background-color: #4e73df;">
                                        <tr>
                                            <th class="text-center" style="color:#fff;">ID Log</th>
                                            <th class="text-center" style="color:#fff;">ID Reserva</th>
                                            <th class="text-center" style="color:#fff;">Fecha Inicio</th>
                                            <th class="text-center" style="color:#fff;">Fecha Fin</th>
                                            <th class="text-center" style="color:#fff;">Sucursal Retiro</th>
                                            <th class="text-center" style="color:#fff;">Sucursal Devolución</th>
                                            <th class="text-center" style="color:#fff;">ID Cliente</th>
                                            <th class="text-center" style="color:#fff;">ID Vehículo</th>
                                            <th class="text-center" style="color:#fff;">Movimiento</th>
                                            <th class="text-center" style="color:#fff;">Fecha Movimiento</th>
                                            <th class="text-center" style="color:#fff;">Usuario</th>
                                            <th class="text-center" style="color:#fff;">Usuario DB</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach ($logs as $l)
                                            <tr>
                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{$l->id_log ?? '-'}}
                                                </td>

                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{$l->id_reserva ?? '-'}}
                                                </td>

                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{$l->fecha_inicio ?? '-'}}
                                                </td>

                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{$l->fecha_fin ?? '-'}}
                                                </td>

                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{$l->sucursal_retiro ?? '-'}}
                                                </td>

                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{$l->sucursal_devolucion ?? '-'}}
                                                </td>

                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{$l->id_cliente ?? '-'}}
                                                </td>

                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{$l->id_vehiculo ?? '-'}}
                                                </td>

                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{$l->mov ?? '-'}}
                                                </td>

                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{\Carbon\Carbon::parse($l->fecha_mov)->format('Y-m-d H:i')}}
                                                </td>

                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{$l->usuario ?? '-'}}
                                                </td>

                                                <td class="text-center" style="vertical-align: middle;">
                                                    {{$l->usuario_db ?? '-'}}
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
</div>
@endsection

@section('scripts')
<script>
    $(document).ready(function () { 
        $('#tabla_sucursal').DataTable({
            order: [[13, 'desc']],
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
    });
</script>
@endsection