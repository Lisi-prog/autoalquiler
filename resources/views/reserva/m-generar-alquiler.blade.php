<div class="modal" tabindex="-1" id="modalGenerarAlquiler">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Generar Alquiler</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="formGenerarAlquiler" method="POST">
            @csrf
            @method('PATCH')

            <input type="hidden" id="reserva_id" name="reserva_id">

            <div class="modal-body">
                <label class="form-label">Kilometraje inicial</label>
                <input type="number" name="km_inicio" class="form-control" id="km_inicio" required>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    Cancelar
                </button>

                <button type="submit" class="btn btn-success">
                    Generar
                </button>
            </div>
        </form>
    </div>
  </div>
</div>