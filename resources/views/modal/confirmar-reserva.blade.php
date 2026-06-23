<!-- Modal Reserva -->
<div class="modal fade" id="modalReserva" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Confirmar Reserva</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>

            <div class="modal-body">

                <input type="hidden" id="idVehiculoReserva">

                <div class="row">
                    <div class="col-md-6">
                        <strong>Vehículo</strong>
                        <p id="modalVehiculo"></p>
                    </div>

                    <div class="col-md-6">
                        <strong>Sucursal</strong>
                        <p id="modalSucursal"></p>
                    </div>

                    <div class="col-md-6">
                        <strong>Fecha Retiro</strong>
                        <p id="modalFechaInicio"></p>
                    </div>

                    <div class="col-md-6">
                        <strong>Fecha Devolución</strong>
                        <p id="modalFechaFin"></p>
                    </div>

                    <div class="col-md-12">
                        <strong>Total</strong>
                        <h3 id="modalTotal" class="text-primary"></h3>
                    </div>
                </div>

            </div>

            <div class="modal-footer">
                @auth
                <button
                    type="button"
                    class="btn btn-success"
                    id="btnConfirmarReserva">
                    Confirmar Reserva
                </button>
                @endauth

                <button
                    type="button"
                    class="btn btn-primary"
                    data-dismiss="modal">
                    Cerrar
                </button>
            </div>

        </div>
    </div>
</div>