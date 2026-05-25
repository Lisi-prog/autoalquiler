CREATE TABLE log_sucursal (
    id_log INT PRIMARY KEY,
    id_sucursal INT,
    nombre_sucursal VARCHAR(50) NOT NULL,
    direccion_sucursal VARCHAR(100),
    id_departamento INT,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);

CREATE TABLE log_tipo_vehiculo (
    id_log INT PRIMARY KEY,
    id_tipo_vehiculo INT,
    nombre_tipo_vehiculo VARCHAR(50) NOT NULL,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);

CREATE TABLE log_taller (
    id_log SERIAL PRIMARY KEY,
    id_taller INT,
    nombre_taller VARCHAR(50) NOT NULL,
    direccion_taller VARCHAR(100),
    telefono_taller VARCHAR(30),
    id_departamento INT,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);


CREATE TABLE log_vehiculo (
    id_log SERIAL PRIMARY KEY,
    id_vehiculo INT,
    patente VARCHAR(10),
    marca VARCHAR(20),
    modelo VARCHAR(20),
    detalle_confort VARCHAR(500),
    id_tipo_vehiculo INT,
    id_sucursal INT,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);

CREATE TABLE log_mantenimiento (
    id_log SERIAL PRIMARY KEY
    id_mantenimiento INT,
    fecha_envio DATE,
    fecha_devolucion DATE,
    id_vehiculo INT,
    id_taller INT,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);

CREATE TABLE log_tarifa (
    id_log SERIAL PRIMARY KEY,
    id_tarifa INT,
    precio_dia NUMERIC(10,2),
    porcentaje_recargo_hora NUMERIC(10,2),
    id_sucursal INT,
    id_tipo_vehiculo INT,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);

CREATE TABLE log_reserva (
    id_log SERIAL PRIMARY KEY,
    id_reserva INT,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP NOT NULL,
    sucursal_retiro INT NOT NULL,
    sucursal_devolucion INT,
    id_cliente INT NOT NULL,
    id_vehiculo INT NOT NULL,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);

CREATE TABLE log_alquiler (
    id_log SERIAL PRIMARY KEY,
    id_alquiler INT,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin_prevista TIMESTAMP NOT NULL,
    fecha_fin_real TIMESTAMP,
    km_inicio INT NOT NULL,
    km_fin INT,
    sucursal_retiro INT NOT NULL,
    sucursal_devolucion INT,
    id_reserva INT,
    id_cliente INT,
    id_vehiculo INT,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);

CREATE TABLE log_factura (
    id_log SERIAL PRIMARY KEY,
    id_factura INT,
    fecha_emision TIMESTAMP NOT NULL,
    monto_base NUMERIC(10,2),
    monto_recargo NUMERIC(10,2),
    total NUMERIC(10,2),
    id_alquiler INT NOT NULL,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);

CREATE TABLE log_detalle_factura (
    id_log SERIAL PRIMARY KEY,
    id_detalle_factura INT,
    codigo INT,
    descripcion VARCHAR(100),
    precio_unitario NUMERIC(10,2),
    subtotal NUMERIC(10,2),
    id_factura INT,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);

CREATE TABLE log_alquiler_x_estado (
    id_log INT,
    id_alquiler INT NOT NULL,
    id_estado_alquiler INT NOT NULL,
    fecha_estado TIMESTAMP NOT NULL,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);

CREATE TABLE log_reserva_x_estado (
    id_log SERIAL PRIMARY KEY,
    id_reserva INT,
    id_estado_reserva INT,
    fecha_estado TIMESTAMP NOT NULL,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);

CREATE TABLE log_vehiculo_x_estado (
    id_log SERIAL PRIMARY KEY,
    id_veh_x_est INT,
    id_vehiculo INT NOT NULL,
    id_estado_vehiculo INT NOT NULL,
    fecha_estado TIMESTAMP,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int,
    usuario_db VARCHAR(50)
);