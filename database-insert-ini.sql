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
    (140, 'El vehículo no se encuentra disponible para cambiar de sucursal'),
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
(2, 'DISPONIBLE'),
(3, 'ALQUILADO'),
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

CREATE ROLE cliente;
CREATE ROLE empleado;
CREATE ROLE gerente;

GRANT SELECT ON reserva TO cliente;
GRANT SELECT ON alquiler TO cliente;
GRANT SELECT ON factura TO cliente;
GRANT SELECT ON detalle_factura TO cliente;

GRANT SELECT, INSERT, UPDATE ON reserva TO empleado;
GRANT SELECT, INSERT, UPDATE ON alquiler TO empleado;

GRANT SELECT, INSERT, UPDATE, DELETE ON vehiculo TO gerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON mantenimiento TO gerente;
GRANT SELECT ON reserva TO gerente;
GRANT SELECT ON alquiler TO gerente;
GRANT SELECT ON factura TO gerente;

CREATE USER gino WITH PASSWORD '123';
GRANT empleado TO gino;

CREATE USER gian WITH PASSWORD '123';
GRANT gerente TO gian;

CREATE USER rodrigo WITH PASSWORD '123';
GRANT cliente TO rodrigo;