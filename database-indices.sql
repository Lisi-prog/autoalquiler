CREATE INDEX idx_reserva_vehiculo
ON reserva(id_vehiculo);

CREATE INDEX idx_alquiler_vehiculo
ON alquiler(id_vehiculo);

CREATE INDEX idx_estado_vehiculo
ON vehiculo_x_estado(id_vehiculo);