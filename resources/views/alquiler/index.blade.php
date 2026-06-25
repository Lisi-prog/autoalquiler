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
                            Alquiler
                        </h4>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <table id="tabla_vehiculo" class="table table-sm table-hover">
                                <thead style="background-color: #4e73df;">
                                    <th class='text-center' style="color:#fff;">Cod.</th>
                                    <th class='text-center' style="color:#fff;">Fecha Inicio</th>
                                    <th class='text-center' style="color:#fff;">Fecha Fin Prevista</th>
                                    <th class='text-center' style="color:#fff;">Fecha Fin Real</th>
                                    <th class='text-center' style="color:#fff;">Km. Inicio</th>
                                    <th class='text-center' style="color:#fff;">Km. Fin</th>
                                    <th class='text-center' style="color:#fff;">Sucursal Retiro</th>
                                    <th class='text-center' style="color:#fff;">Sucursal Devolucion</th>
                                    <th class='text-center' style="color:#fff;">Reserva</th>
                                    <th class='text-center' style="color:#fff;">Cliente</th>
                                    <th class='text-center' style="color:#fff;">Vehiculo</th>
                                    <th class='text-center' style="color:#fff;">Estado</th>
                                    <th class='text-center' style="color:#fff;">Acciones</th>
                                </thead>
                                <tbody>     
                                    @foreach ($alquileres as $a)
                                        <tr>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$a->id_alquiler ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$a->fecha_inicio ? \Carbon\Carbon::parse($a->fecha_inicio)->format('d/m/Y') : '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$a->fecha_fin_prevista ? \Carbon\Carbon::parse($a->fecha_fin_prevista)->format('d/m/Y') : '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$a->fecha_fin_real ? \Carbon\Carbon::parse($a->fecha_fin_real)->format('d/m/Y') : '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$a->km_inicio ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$a->km_fin ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$a->sucursalRetiro->nombre_sucursal ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$a->sucursalDevolucion->nombre_sucursal  ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$a->id_reserva ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$a->cliente->nombre_completo ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$a->vehiculo->patente ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">{{$a->getEstado() ?? '-'}}</td>
                                            <td class= 'text-center' style="vertical-align: middle;">
                                                @switch($a->getIdEstado())
                                                    @case(1)
                                                        <button
                                                            type="button"
                                                            class="btn btn-danger btn-finalizar"
                                                            data-id="{{ $a->id_alquiler }}"
                                                            data-toggle="modal"
                                                            data-target="#modalFinalizarAlquiler">
                                                            <i class="fas fa-flag-checkered"></i>
                                                        </button>
                                                        @break
                                                    @case(2)
                                                        <a href="{{ route('factura.pdf', $a->id_alquiler) }}"
                                                            class="btn btn-primary"
                                                            target="_blank">
                                                            <i class="fas fa-file-pdf"></i>
                                                        </a>
                                                        @break
                                                @endswitch
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
@include('alquiler.m-finalizar-alquiler')
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

        let alquilerId = null;

        document.querySelectorAll('.btn-finalizar').forEach(btn => {
            btn.addEventListener('click', function () {
                alquilerId = this.dataset.id;

                const form = document.getElementById('formFinalizarAlquiler');

                form.action = `/alquiler/${alquilerId}/finalizar`;
            });
        });

        $('#formFinalizarAlquiler').submit(function (e) {
            e.preventDefault();

            let url = $(this).attr('action');

            $.ajax({
                url: url,
                type: 'POST',
                data: {
                    _token: '{{ csrf_token() }}',
                    _method: 'PATCH',
                    fecha_fin_real: $('input[name="fecha_fin_real"]').val(),
                    km_fin: $('input[name="km_fin"]').val(),
                    sucursal_devolucion: $('select[name="sucursal_devolucion"]').val()
                },
                success: function (response) {
                    alert(response.mensaje);

                    $('#modalFinalizarAlquiler').modal('hide'); // Bootstrap 4
                    location.reload();
                },
                error: function (xhr) {
                    let msg = xhr.responseJSON?.mensaje ?? 'Error';
                    alert(msg);
                }
            });
        });
    });
</script>
@endsection