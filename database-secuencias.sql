CREATE SEQUENCE seq_log_sucursal
START 1
INCREMENT 1;

CREATE SEQUENCE seq_log_tipo_vehiculo
START 1
INCREMENT 1;

CREATE SEQUENCE seq_log_vehiculo
START 1
INCREMENT 1;

CREATE SEQUENCE seq_log_reserva
START 1
INCREMENT 1;

CREATE SEQUENCE seq_log_alquiler
START 1
INCREMENT 1;

CREATE SEQUENCE seq_log_alquiler_x_estado
START 1
INCREMENT 1;

CREATE SEQUENCE seq_log_reserva_x_estado
START 1
INCREMENT 1;

CREATE SEQUENCE seq_log_vehiculo_x_estado
START 1
INCREMENT 1;

CREATE SEQUENCE seq_log_detalle_factura
START 1
INCREMENT 1;

CREATE SEQUENCE seq_log_factura
START 1
INCREMENT 1;

ALTER TABLE tipo_vehiculo
ADD CONSTRAINT uq_tipo_vehiculo
UNIQUE(nombre_tipo_vehiculo);

ALTER TABLE estado_vehiculo
ADD CONSTRAINT uq_estado_vehiculo
UNIQUE(nombre_estado_vehiculo);

ALTER TABLE estado_reserva
ADD CONSTRAINT uq_estado_reserva
UNIQUE(nombre_estado_reserva);

ALTER TABLE vehiculo
ADD CONSTRAINT uq_patente
UNIQUE(patente);