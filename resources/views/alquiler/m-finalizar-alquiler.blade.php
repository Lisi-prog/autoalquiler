<div class="modal" tabindex="-1" id="modalFinalizarAlquiler">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Finalizar Alquiler</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="formFinalizarAlquiler" method="POST">
            @csrf
            @method('PATCH')

            <div class="modal-body">

                <div class="mb-3">
                    <label class="form-label">Fecha fin real</label>
                    <input type="date" name="fecha_fin_real" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Kilometraje final</label>
                    <input type="number" name="km_fin" class="form-control" min="0" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Sucursal devolución</label>
                    <select name="sucursal_devolucion" class="form-control" required>
                        @foreach($sucursales as $s)
                            <option value="{{ $s->id_sucursal }}">
                                {{ $s->nombre_sucursal }}
                            </option>
                        @endforeach
                    </select>
                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    Cancelar
                </button>

                <button type="submit" class="btn btn-danger">
                    Finalizar
                </button>
            </div>

        </form>
    </div>
  </div>
</div>