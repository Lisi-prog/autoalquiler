CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre_completo VARCHAR(100),
    dni VARCHAR(10),
    telefono VARCHAR(30)
);

CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    email VARCHAR(200) UNIQUE NOT NULL,
    password VARCHAR(200) NOT NULL,
    id_cliente INT NOT NULL,
    CONSTRAINT fk_usuario_x_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);

CREATE TABLE provincia (
    id_provincia SERIAL PRIMARY KEY,
    nombre_provincia VARCHAR(100)
);

CREATE TABLE departamento (
    id_departamento SERIAL PRIMARY KEY,
    nombre_departamento VARCHAR(100),
    id_provincia INT,
    CONSTRAINT fk_departamento_x_provincia
        FOREIGN KEY (id_provincia)
        REFERENCES provincia(id_provincia)
);

CREATE TABLE sucursal (
    id_sucursal SERIAL PRIMARY KEY,
    nombre_sucursal VARCHAR(50) NOT NULL,
    direccion_sucursal VARCHAR(100),
    id_departamento INT,
    CONSTRAINT fk_sucursal_x_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES departamento(id_departamento)
);

CREATE TABLE tipo_vehiculo (
    id_tipo_vehiculo SERIAL PRIMARY KEY,
    nombre_tipo_vehiculo VARCHAR(50) NOT NULL UNIQUE
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
    nombre_estado_vehiculo VARCHAR(15) UNIQUE
);

CREATE TABLE vehiculo (
    id_vehiculo SERIAL PRIMARY KEY,
    patente VARCHAR(10) UNIQUE,
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
    nombre_estado_reserva VARCHAR(15) UNIQUE
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

CREATE TABLE estado_alquiler (
    id_estado_alquiler SERIAL PRIMARY KEY,
    nombre_estado_alquiler VARCHAR(15) UNIQUE
);

CREATE TABLE alquiler_x_estado (
    id_alquiler INT NOT NULL,
    id_estado_alquiler INT NOT NULL,
    fecha_estado TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_alquiler, id_estado_alquiler),

    CONSTRAINT fk_axe_x_alquiler
        FOREIGN KEY (id_alquiler)
        REFERENCES alquiler(id_alquiler),

    CONSTRAINT fk_axe_x_estado_reserv
        FOREIGN KEY (id_estado_alquiler)
        REFERENCES estado_alquiler(id_estado_alquiler)
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

CREATE TABLE mensaje (
    codigo_mensaje INTEGER PRIMARY KEY,
    mensaje VARCHAR(255)
);

INSERT INTO mensaje(codigo_mensaje, mensaje) VALUES
    (0, 'Operación realizada correctamente'),
    (100, 'El nombre no puede estar vacío'),
    (101, 'Ya existe un registro con esos datos'),
    (102, 'El registro no existe'),
    (103, 'No se puede eliminar porque está siendo utilizado'),
    (104, 'El departamento indicado no existe'),
    (105, 'La patente no puede estar vacía'),
    (106, 'La marca no puede estar vacía'),
    (107, 'El modelo no puede estar vacío'),
    (108, 'El tipo de vehículo no existe'),
    (109, 'La sucursal no existe'),
    (110, 'La fecha de inicio es obligatoria'),
    (111, 'La fecha de fin es obligatoria'),
    (112, 'La fecha de fin debe ser mayor a la fecha de inicio'),
    (113, 'El cliente no existe'),
    (114, 'El vehículo no existe'),
    (115, 'La sucursal de retiro no existe'),
    (116, 'La sucursal de devolución no existe'),
    (117, 'El vehículo ya se encuentra reservado en ese período'),
    (118, 'La fecha de inicio del alquiler es obligatoria'),
    (119, 'La fecha de fin prevista es obligatoria'),
    (120, 'La fecha de fin prevista debe ser mayor a la fecha de inicio'),
    (121, 'El kilometraje inicial es inválido'),
    (122, 'La reserva no existe'),
    (123, 'El kilometraje final no puede ser menor al inicial'),
    (124, 'La reserva no corresponde al cliente o vehículo indicado'),
    (125, 'El nombre del taller no puede estar vacío'),
    (126, 'El departamento no existe'),
    (127, 'La fecha de envío es obligatoria'),
    (128, 'La fecha de devolución no puede ser menor a la fecha de envío'),
    (129, 'El taller no existe'),
    (130, 'El vehículo no se encuentra disponible'),
    (131, 'El precio por día debe ser mayor a cero'),
    (132, 'El porcentaje de recargo por hora no puede ser negativo'),
    (133, 'La fecha de devolución es obligatoria'),
    (134, 'El mantenimiento ya fue finalizado'),
    (135, 'La fecha de finalización es obligatoria'),
    (136, 'El kilometraje final no puede ser menor al inicial'),
    (137, 'El alquiler no se encuentra activo'),
    (138, 'No existe una tarifa para el vehículo y sucursal'),
    (139, 'La reserva no puede convertirse en alquiler'),
    (500, 'Error interno del sistema');



INSERT INTO provincia (id_provincia, nombre_provincia)
VALUES (1, 'Misiones');

INSERT INTO departamento (nombre_departamento, id_provincia) VALUES
('Apóstoles', 1),
('Cainguás', 1),
('Candelaria', 1),
('Capital', 1),
('Concepción', 1),
('Eldorado', 1),
('General Manuel Belgrano', 1),
('Guaraní', 1),
('Iguazú', 1),
('Leandro N. Alem', 1),
('Libertador General San Martín', 1),
('Montecarlo', 1),
('Oberá', 1),
('San Ignacio', 1),
('San Javier', 1),
('San Pedro', 1),
('25 de Mayo', 1);

INSERT INTO estado_vehiculo(id_estado_vehiculo, nombre_estado_vehiculo) VALUES 
(1, 'EN ESPERA'),
(2, 'DISPONIBLE')
(3, 'ALQUILADO')
(4, 'MANTENIMIENTO')
(5, 'BAJA');

INSERT INTO estado_reserva VALUES
(1, 'Pendiente'),
(2, 'Confirmada'),
(3, 'Cancelada'),
(4, 'Finalizada'),
(5, 'Vencida');

INSERT INTO estado_alquiler VALUES
(1, 'Activo'),
(2, 'Finalizado'),
(3, 'Retrasado'),
(4, 'Cancelado');

