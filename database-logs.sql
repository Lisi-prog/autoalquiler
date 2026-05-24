-- CREATE TABLE provincia (
--     id_provincia SERIAL PRIMARY KEY,
--     nombre_provincia VARCHAR(100)
-- );

-- CREATE TABLE departamento (
--     id_departamento SERIAL PRIMARY KEY,
--     nombre_departamento VARCHAR(100),
--     id_provincia INT,
--     CONSTRAINT fk_departamento_x_provincia
--         FOREIGN KEY (id_provincia)
--         REFERENCES provincia(id_provincia)
-- );

CREATE TABLE log_sucursal (
    id_log INT PRIMARY KEY,
    id_sucursal INT,
    nombre_sucursal VARCHAR(50) NOT NULL,
    direccion_sucursal VARCHAR(100),
    id_departamento INT,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int
);

CREATE TABLE log_tipo_vehiculo (
    id_log INT PRIMARY KEY,
    id_tipo_vehiculo INT,
    nombre_tipo_vehiculo VARCHAR(50) NOT NULL,
    mov varchar(2),
    fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario int
);

CREATE TABLE taller (
    id_taller SERIAL PRIMARY KEY,
    nombre_taller VARCHAR(50) NOT NULL,
    direccion_taller VARCHAR(100),
    telefono_taller VARCHAR(30),
    id_departamento INT,
    CONSTRAINT fk_taller_x_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES departamento(id_departamento)
);

CREATE TABLE estado_vehiculo (
    id_estado_vehiculo SERIAL PRIMARY KEY,
    nombre_estado_vehiculo VARCHAR(15)
);

CREATE TABLE vehiculo (
    id_vehiculo SERIAL PRIMARY KEY,
    patente VARCHAR(10),
    marca VARCHAR(20),
    modelo VARCHAR(20),
    detalle_confort VARCHAR(500),
    id_tipo_vehiculo INT,
    id_sucursal INT,

    CONSTRAINT fk_vehiculo_x_tipo_vehiculo
        FOREIGN KEY (id_tipo_vehiculo)
        REFERENCES tipo_vehiculo(id_tipo_vehiculo),

    CONSTRAINT fk_vehiculo_x_sucursal
        FOREIGN KEY (id_sucursal)
        REFERENCES sucursal(id_sucursal)
);

CREATE TABLE imagen_vehiculo (
    id_imagen_vehiculo SERIAL PRIMARY KEY,
    ruta_imagen VARCHAR(500),
    nombre_imagen VARCHAR(250),
    id_vehiculo INT,

    CONSTRAINT fk_imgveh_x_veh
        FOREIGN KEY (id_vehiculo)
        REFERENCES vehiculo(id_vehiculo)
);

CREATE TABLE vehiculo_x_estado (
    id_veh_x_est SERIAL PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    id_estado_vehiculo INT NOT NULL,
    fecha_estado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_vxe_x_veh
        FOREIGN KEY (id_vehiculo)
        REFERENCES vehiculo(id_vehiculo),

    CONSTRAINT fk_vxe_x_estado
        FOREIGN KEY (id_estado_vehiculo)
        REFERENCES estado_vehiculo(id_estado_vehiculo)
);

CREATE TABLE mantenimiento (
    id_mantenimiento SERIAL PRIMARY KEY,
    fecha_envio DATE,
    fecha_devolucion DATE,
    id_vehiculo INT,
    id_taller INT,

    CONSTRAINT fk_mant_x_veh
        FOREIGN KEY (id_vehiculo)
        REFERENCES vehiculo(id_vehiculo),

    CONSTRAINT fk_mant_x_taller
        FOREIGN KEY (id_taller)
        REFERENCES taller(id_taller)
);

CREATE TABLE tarifa (
    id_tarifa SERIAL PRIMARY KEY,
    precio_dia NUMERIC(10,2),
    porcentaje_recargo_hora NUMERIC(10,2),
    id_sucursal INT,
    id_tipo_vehiculo INT,

    CONSTRAINT fk_tarifa_x_tipo_vehiculo
        FOREIGN KEY (id_tipo_vehiculo)
        REFERENCES tipo_vehiculo(id_tipo_vehiculo),

    CONSTRAINT fk_tarifa_x_sucursal
        FOREIGN KEY (id_sucursal)
        REFERENCES sucursal(id_sucursal)
);

CREATE TABLE reserva (
    id_reserva SERIAL PRIMARY KEY,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP NOT NULL,
    sucursal_retiro INT NOT NULL,
    sucursal_devolucion INT,
    id_cliente INT NOT NULL,
    id_vehiculo INT NOT NULL,

    CONSTRAINT fk_reserv_x_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente),

    CONSTRAINT fk_reserv_x_veh
        FOREIGN KEY (id_vehiculo)
        REFERENCES vehiculo(id_vehiculo),

    CONSTRAINT fk_reserv_x_sucursal_retiro
        FOREIGN KEY (sucursal_retiro)
        REFERENCES sucursal(id_sucursal),

    CONSTRAINT fk_reserv_x_sucursal_dev
        FOREIGN KEY (sucursal_devolucion)
        REFERENCES sucursal(id_sucursal)
);

CREATE TABLE estado_reserva (
    id_estado_reserva SERIAL PRIMARY KEY,
    nombre_estado_reserva VARCHAR(15)
);

CREATE TABLE reserva_x_estado (
    id_reserva INT,
    id_estado_reserva INT,
    fecha_estado TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_reserva, id_estado_reserva),

    CONSTRAINT fk_rxe_x_reserv
        FOREIGN KEY (id_reserva)
        REFERENCES reserva(id_reserva),

    CONSTRAINT fk_rxe_x_estado_reserv
        FOREIGN KEY (id_estado_reserva)
        REFERENCES estado_reserva(id_estado_reserva)
);

CREATE TABLE alquiler (
    id_alquiler SERIAL PRIMARY KEY,
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

    CONSTRAINT fk_alquiler_x_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente),

    CONSTRAINT fk_alquiler_x_veh
        FOREIGN KEY (id_vehiculo)
        REFERENCES vehiculo(id_vehiculo),

    CONSTRAINT fk_alquiler_x_reserv
        FOREIGN KEY (id_reserva)
        REFERENCES reserva(id_reserva),

    CONSTRAINT fk_alquiler_x_sucursal_ret
        FOREIGN KEY (sucursal_retiro)
        REFERENCES sucursal(id_sucursal),

    CONSTRAINT fk_alquiler_x_sucursal_dev
        FOREIGN KEY (sucursal_devolucion)
        REFERENCES sucursal(id_sucursal)
);

CREATE TABLE alquiler_x_estado (
    id_alquiler INT NOT NULL,
    id_estado_reserva INT NOT NULL,
    fecha_estado TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_alquiler, id_estado_reserva),

    CONSTRAINT fk_axe_x_alquiler
        FOREIGN KEY (id_alquiler)
        REFERENCES alquiler(id_alquiler),

    CONSTRAINT fk_axe_x_estado_reserv
        FOREIGN KEY (id_estado_reserva)
        REFERENCES estado_reserva(id_estado_reserva)
);

CREATE TABLE factura (
    id_factura SERIAL PRIMARY KEY,
    fecha_emision TIMESTAMP NOT NULL,
    monto_base NUMERIC(10,2),
    monto_recargo NUMERIC(10,2),
    total NUMERIC(10,2),
    id_alquiler INT NOT NULL,

    CONSTRAINT fk_factura_x_alquiler
        FOREIGN KEY (id_alquiler)
        REFERENCES alquiler(id_alquiler)
);

CREATE TABLE detalle_factura (
    id_detalle_factura SERIAL PRIMARY KEY,
    codigo INT,
    descripcion VARCHAR(100),
    precio_unitario NUMERIC(10,2),
    subtotal NUMERIC(10,2),
    id_factura INT,

    CONSTRAINT fk_det_factura_x_factura
        FOREIGN KEY (id_factura)
        REFERENCES factura(id_factura)
);