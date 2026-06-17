CREATE OR REPLACE FUNCTION fn_log_sucursal()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario INT;
    v_id_log INT;
    v_usuario_db VARCHAR(50);
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Usuario enviado desde Laravel
    v_usuario := current_setting('app.usuario', true)::INT;

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        v_id_log := nextval('seq_log_sucursal');

        INSERT INTO log_sucursal (
            id_log,
            id_sucursal,
            nombre_sucursal,
            direccion_sucursal,
            id_departamento,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            NEW.id_sucursal,
            NEW.nombre_sucursal,
            NEW.direccion_sucursal,
            NEW.id_departamento,
            'I',
            v_usuario,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes del update
        v_id_log := nextval('seq_log_sucursal');

        INSERT INTO log_sucursal (
            id_log,
            id_sucursal,
            nombre_sucursal,
            direccion_sucursal,
            id_departamento,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            OLD.id_sucursal,
            OLD.nombre_sucursal,
            OLD.direccion_sucursal,
            OLD.id_departamento,
            'AU',
            v_usuario,
            v_usuario_db
        );

        -- Después del update
        v_id_log := nextval('seq_log_sucursal');

        INSERT INTO log_sucursal (
            id_log,
            id_sucursal,
            nombre_sucursal,
            direccion_sucursal,
            id_departamento,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            NEW.id_sucursal,
            NEW.nombre_sucursal,
            NEW.direccion_sucursal,
            NEW.id_departamento,
            'DU',
            v_usuario,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        v_id_log := nextval('seq_log_sucursal');

        INSERT INTO log_sucursal (
            id_log,
            id_sucursal,
            nombre_sucursal,
            direccion_sucursal,
            id_departamento,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            OLD.id_sucursal,
            OLD.nombre_sucursal,
            OLD.direccion_sucursal,
            OLD.id_departamento,
            'D',
            v_usuario,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;
END;
$$;

CREATE TRIGGER tr_log_sucursal
AFTER INSERT OR UPDATE OR DELETE
ON sucursal
FOR EACH ROW
EXECUTE FUNCTION fn_log_sucursal();
-- ------------------
-- Tipo Vehiculo
CREATE OR REPLACE FUNCTION fn_log_tipo_vehiculo()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario INT;
    v_id_log INT;
    v_usuario_db VARCHAR(50);
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Obtener usuario desde Laravel
    v_usuario := current_setting('app.usuario', true)::INT;

    -- Obtener ID del log
    v_id_log := nextval('seq_log_tipo_vehiculo');

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        INSERT INTO log_tipo_vehiculo (
            id_log,
            id_tipo_vehiculo,
            nombre_tipo_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            NEW.id_tipo_vehiculo,
            NEW.nombre_tipo_vehiculo,
            'I',
            v_usuario,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes del update
        v_id_log := nextval('seq_log_tipo_vehiculo');

        INSERT INTO log_tipo_vehiculo (
            id_log,
            id_tipo_vehiculo,
            nombre_tipo_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            OLD.id_tipo_vehiculo,
            OLD.nombre_tipo_vehiculo,
            'AU',
            v_usuario,
            v_usuario_db
        );

        -- Después del update
        v_id_log := nextval('seq_log_tipo_vehiculo');

        INSERT INTO log_tipo_vehiculo (
            id_log,
            id_tipo_vehiculo,
            nombre_tipo_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            NEW.id_tipo_vehiculo,
            NEW.nombre_tipo_vehiculo,
            'DU',
            v_usuario,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_tipo_vehiculo (
            id_log,
            id_tipo_vehiculo,
            nombre_tipo_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            OLD.id_tipo_vehiculo,
            OLD.nombre_tipo_vehiculo,
            'D',
            v_usuario,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;
END;
$$;

CREATE TRIGGER tr_log_tipo_vehiculo
AFTER INSERT OR UPDATE OR DELETE
ON tipo_vehiculo
FOR EACH ROW
EXECUTE FUNCTION fn_log_tipo_vehiculo();

-- -------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_log_vehiculo()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario INT;
    v_id_log INT;
    v_usuario_db VARCHAR(50);
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Usuario enviado desde Laravel
    v_usuario := current_setting('app.usuario', true)::INT;

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        v_id_log := nextval('seq_log_vehiculo');

        INSERT INTO log_vehiculo (
            id_log,
            id_vehiculo,
            patente,
            marca,
            modelo,
            detalle_confort,
            id_tipo_vehiculo,
            id_sucursal,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            NEW.id_vehiculo,
            NEW.patente,
            NEW.marca,
            NEW.modelo,
            NEW.detalle_confort,
            NEW.id_tipo_vehiculo,
            NEW.id_sucursal,
            'I',
            v_usuario,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes del update
        v_id_log := nextval('seq_log_vehiculo');

        INSERT INTO log_vehiculo (
            id_log,
            id_vehiculo,
            patente,
            marca,
            modelo,
            detalle_confort,
            id_tipo_vehiculo,
            id_sucursal,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            OLD.id_vehiculo,
            OLD.patente,
            OLD.marca,
            OLD.modelo,
            OLD.detalle_confort,
            OLD.id_tipo_vehiculo,
            OLD.id_sucursal,
            'AU',
            v_usuario,
            v_usuario_db
        );

        -- Después del update
        v_id_log := nextval('seq_log_vehiculo');

        INSERT INTO log_vehiculo (
            id_log,
            id_vehiculo,
            patente,
            marca,
            modelo,
            detalle_confort,
            id_tipo_vehiculo,
            id_sucursal,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            NEW.id_vehiculo,
            NEW.patente,
            NEW.marca,
            NEW.modelo,
            NEW.detalle_confort,
            NEW.id_tipo_vehiculo,
            NEW.id_sucursal,
            'DU',
            v_usuario,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        v_id_log := nextval('seq_log_vehiculo');

        INSERT INTO log_vehiculo (
            id_log,
            id_vehiculo,
            patente,
            marca,
            modelo,
            detalle_confort,
            id_tipo_vehiculo,
            id_sucursal,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            OLD.id_vehiculo,
            OLD.patente,
            OLD.marca,
            OLD.modelo,
            OLD.detalle_confort,
            OLD.id_tipo_vehiculo,
            OLD.id_sucursal,
            'D',
            v_usuario,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;
END;
$$;

CREATE TRIGGER tr_log_vehiculo
AFTER INSERT OR UPDATE OR DELETE
ON vehiculo
FOR EACH ROW
EXECUTE FUNCTION fn_log_vehiculo();

-- Reserva
CREATE OR REPLACE FUNCTION fn_log_reserva()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario INT;
    v_id_log INT;
    v_usuario_db VARCHAR(50);
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Usuario desde Laravel
    v_usuario := current_setting('app.usuario', true)::INT;

    -- ID log
    v_id_log := nextval('seq_log_reserva');

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        INSERT INTO log_reserva (
            id_log,
            id_reserva,
            fecha_inicio,
            fecha_fin,
            sucursal_retiro,
            sucursal_devolucion,
            id_cliente,
            id_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            NEW.id_reserva,
            NEW.fecha_inicio,
            NEW.fecha_fin,
            NEW.sucursal_retiro,
            NEW.sucursal_devolucion,
            NEW.id_cliente,
            NEW.id_vehiculo,
            'I',
            v_usuario,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes Update
        INSERT INTO log_reserva (
            id_log,
            id_reserva,
            fecha_inicio,
            fecha_fin,
            sucursal_retiro,
            sucursal_devolucion,
            id_cliente,
            id_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            nextval('seq_log_reserva'),
            OLD.id_reserva,
            OLD.fecha_inicio,
            OLD.fecha_fin,
            OLD.sucursal_retiro,
            OLD.sucursal_devolucion,
            OLD.id_cliente,
            OLD.id_vehiculo,
            'AU',
            v_usuario,
            v_usuario_db
        );

        -- Después Update
        INSERT INTO log_reserva (
            id_log,
            id_reserva,
            fecha_inicio,
            fecha_fin,
            sucursal_retiro,
            sucursal_devolucion,
            id_cliente,
            id_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            nextval('seq_log_reserva'),
            NEW.id_reserva,
            NEW.fecha_inicio,
            NEW.fecha_fin,
            NEW.sucursal_retiro,
            NEW.sucursal_devolucion,
            NEW.id_cliente,
            NEW.id_vehiculo,
            'DU',
            v_usuario,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_reserva (
            id_log,
            id_reserva,
            fecha_inicio,
            fecha_fin,
            sucursal_retiro,
            sucursal_devolucion,
            id_cliente,
            id_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES (
            v_id_log,
            OLD.id_reserva,
            OLD.fecha_inicio,
            OLD.fecha_fin,
            OLD.sucursal_retiro,
            OLD.sucursal_devolucion,
            OLD.id_cliente,
            OLD.id_vehiculo,
            'D',
            v_usuario,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;
END;
$$;

CREATE TRIGGER tr_log_reserva
AFTER INSERT OR UPDATE OR DELETE
ON reserva
FOR EACH ROW
EXECUTE FUNCTION fn_log_reserva();

-- Alquiler
-- Función trigger
CREATE OR REPLACE FUNCTION fn_log_alquiler()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario_app INT;
    v_usuario_db VARCHAR(50);
    v_id_log INT;
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Usuario Laravel
    BEGIN
        v_usuario_app := current_setting('app.usuario', true)::INT;
    EXCEPTION
        WHEN OTHERS THEN
            v_usuario_app := NULL;
    END;

    -- ID log
    v_id_log := nextval('seq_log_alquiler');

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        INSERT INTO log_alquiler(
            id_log,
            id_alquiler,
            fecha_inicio,
            fecha_fin_prevista,
            fecha_fin_real,
            km_inicio,
            km_fin,
            sucursal_retiro,
            sucursal_devolucion,
            id_reserva,
            id_cliente,
            id_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_alquiler,
            NEW.fecha_inicio,
            NEW.fecha_fin_prevista,
            NEW.fecha_fin_real,
            NEW.km_inicio,
            NEW.km_fin,
            NEW.sucursal_retiro,
            NEW.sucursal_devolucion,
            NEW.id_reserva,
            NEW.id_cliente,
            NEW.id_vehiculo,
            'I',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes update
        INSERT INTO log_alquiler(
            id_log,
            id_alquiler,
            fecha_inicio,
            fecha_fin_prevista,
            fecha_fin_real,
            km_inicio,
            km_fin,
            sucursal_retiro,
            sucursal_devolucion,
            id_reserva,
            id_cliente,
            id_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_alquiler,
            OLD.fecha_inicio,
            OLD.fecha_fin_prevista,
            OLD.fecha_fin_real,
            OLD.km_inicio,
            OLD.km_fin,
            OLD.sucursal_retiro,
            OLD.sucursal_devolucion,
            OLD.id_reserva,
            OLD.id_cliente,
            OLD.id_vehiculo,
            'AU',
            v_usuario_app,
            v_usuario_db
        );

        -- Nuevo ID log
        v_id_log := nextval('seq_log_alquiler');

        -- Después update
        INSERT INTO log_alquiler(
            id_log,
            id_alquiler,
            fecha_inicio,
            fecha_fin_prevista,
            fecha_fin_real,
            km_inicio,
            km_fin,
            sucursal_retiro,
            sucursal_devolucion,
            id_reserva,
            id_cliente,
            id_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_alquiler,
            NEW.fecha_inicio,
            NEW.fecha_fin_prevista,
            NEW.fecha_fin_real,
            NEW.km_inicio,
            NEW.km_fin,
            NEW.sucursal_retiro,
            NEW.sucursal_devolucion,
            NEW.id_reserva,
            NEW.id_cliente,
            NEW.id_vehiculo,
            'DU',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_alquiler(
            id_log,
            id_alquiler,
            fecha_inicio,
            fecha_fin_prevista,
            fecha_fin_real,
            km_inicio,
            km_fin,
            sucursal_retiro,
            sucursal_devolucion,
            id_reserva,
            id_cliente,
            id_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_alquiler,
            OLD.fecha_inicio,
            OLD.fecha_fin_prevista,
            OLD.fecha_fin_real,
            OLD.km_inicio,
            OLD.km_fin,
            OLD.sucursal_retiro,
            OLD.sucursal_devolucion,
            OLD.id_reserva,
            OLD.id_cliente,
            OLD.id_vehiculo,
            'D',
            v_usuario_app,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;

END;
$$;

CREATE TRIGGER trg_log_alquiler
AFTER INSERT OR UPDATE OR DELETE
ON alquiler
FOR EACH ROW
EXECUTE FUNCTION fn_log_alquiler();

-- Alquiler_x_estado
CREATE OR REPLACE FUNCTION fn_log_alquiler_x_estado()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario_app INT;
    v_usuario_db VARCHAR(50);
    v_id_log INT;
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Usuario Laravel
    BEGIN
        v_usuario_app := current_setting('app.usuario', true)::INT;
    EXCEPTION
        WHEN OTHERS THEN
            v_usuario_app := NULL;
    END;

    -- Obtener ID log
    v_id_log := nextval('seq_log_alquiler_x_estado');

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        INSERT INTO log_alquiler_x_estado(
            id_log,
            id_alquiler,
            id_estado_alquiler,
            fecha_estado,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_alquiler,
            NEW.id_estado_alquiler,
            NEW.fecha_estado,
            'I',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes del update
        INSERT INTO log_alquiler_x_estado(
            id_log,
            id_alquiler,
            id_estado_alquiler,
            fecha_estado,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_alquiler,
            OLD.id_estado_alquiler,
            OLD.fecha_estado,
            'AU',
            v_usuario_app,
            v_usuario_db
        );

        -- Nuevo ID log
        v_id_log := nextval('seq_log_alquiler_x_estado');

        -- Después del update
        INSERT INTO log_alquiler_x_estado(
            id_log,
            id_alquiler,
            id_estado_alquiler,
            fecha_estado,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_alquiler,
            NEW.id_estado_alquiler,
            NEW.fecha_estado,
            'DU',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_alquiler_x_estado(
            id_log,
            id_alquiler,
            id_estado_alquiler,
            fecha_estado,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_alquiler,
            OLD.id_estado_alquiler,
            OLD.fecha_estado,
            'D',
            v_usuario_app,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;

END;
$$;

CREATE TRIGGER trg_log_alquiler_x_estado
AFTER INSERT OR UPDATE OR DELETE
ON alquiler_x_estado
FOR EACH ROW
EXECUTE FUNCTION fn_log_alquiler_x_estado();

-- Reserva_x_estado
CREATE OR REPLACE FUNCTION fn_log_reserva_x_estado()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario_app INT;
    v_usuario_db VARCHAR(50);
    v_id_log INT;
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Usuario Laravel
    BEGIN
        v_usuario_app := current_setting('app.usuario', true)::INT;
    EXCEPTION
        WHEN OTHERS THEN
            v_usuario_app := NULL;
    END;

    -- ID log
    v_id_log := nextval('seq_log_reserva_x_estado');

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        INSERT INTO log_reserva_x_estado(
            id_log,
            id_reserva,
            id_estado_reserva,
            fecha_estado,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_reserva,
            NEW.id_estado_reserva,
            NEW.fecha_estado,
            'I',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes update
        INSERT INTO log_reserva_x_estado(
            id_log,
            id_reserva,
            id_estado_reserva,
            fecha_estado,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_reserva,
            OLD.id_estado_reserva,
            OLD.fecha_estado,
            'AU',
            v_usuario_app,
            v_usuario_db
        );

        -- Nuevo ID
        v_id_log := nextval('seq_log_reserva_x_estado');

        -- Después update
        INSERT INTO log_reserva_x_estado(
            id_log,
            id_reserva,
            id_estado_reserva,
            fecha_estado,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_reserva,
            NEW.id_estado_reserva,
            NEW.fecha_estado,
            'DU',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_reserva_x_estado(
            id_log,
            id_reserva,
            id_estado_reserva,
            fecha_estado,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_reserva,
            OLD.id_estado_reserva,
            OLD.fecha_estado,
            'D',
            v_usuario_app,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;

END;
$$;

CREATE TRIGGER trg_log_reserva_x_estado
AFTER INSERT OR UPDATE OR DELETE
ON reserva_x_estado
FOR EACH ROW
EXECUTE FUNCTION fn_log_reserva_x_estado();

-- Vehiculo_x_estado
CREATE OR REPLACE FUNCTION fn_log_vehiculo_x_estado()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario_app INT;
    v_usuario_db VARCHAR(50);
    v_id_log INT;
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Usuario Laravel
    BEGIN
        v_usuario_app := current_setting('app.usuario', true)::INT;
    EXCEPTION
        WHEN OTHERS THEN
            v_usuario_app := NULL;
    END;

    -- ID log
    v_id_log := nextval('seq_log_vehiculo_x_estado');

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        INSERT INTO log_vehiculo_x_estado(
            id_log,
            id_veh_x_est,
            id_vehiculo,
            id_estado_vehiculo,
            fecha_estado,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_veh_x_est,
            NEW.id_vehiculo,
            NEW.id_estado_vehiculo,
            NEW.fecha_estado,
            'I',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes update
        INSERT INTO log_vehiculo_x_estado(
            id_log,
            id_veh_x_est,
            id_vehiculo,
            id_estado_vehiculo,
            fecha_estado,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_veh_x_est,
            OLD.id_vehiculo,
            OLD.id_estado_vehiculo,
            OLD.fecha_estado,
            'AU',
            v_usuario_app,
            v_usuario_db
        );

        -- Nuevo ID log
        v_id_log := nextval('seq_log_vehiculo_x_estado');

        -- Después update
        INSERT INTO log_vehiculo_x_estado(
            id_log,
            id_veh_x_est,
            id_vehiculo,
            id_estado_vehiculo,
            fecha_estado,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_veh_x_est,
            NEW.id_vehiculo,
            NEW.id_estado_vehiculo,
            NEW.fecha_estado,
            'DU',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_vehiculo_x_estado(
            id_log,
            id_veh_x_est,
            id_vehiculo,
            id_estado_vehiculo,
            fecha_estado,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_veh_x_est,
            OLD.id_vehiculo,
            OLD.id_estado_vehiculo,
            OLD.fecha_estado,
            'D',
            v_usuario_app,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;

END;
$$;

CREATE TRIGGER trg_log_vehiculo_x_estado
AFTER INSERT OR UPDATE OR DELETE
ON vehiculo_x_estado
FOR EACH ROW
EXECUTE FUNCTION fn_log_vehiculo_x_estado();

-- Detalle_factura
CREATE OR REPLACE FUNCTION fn_log_detalle_factura()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario_app INT;
    v_usuario_db VARCHAR(50);
    v_id_log INT;
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Usuario Laravel
    BEGIN
        v_usuario_app := current_setting('app.usuario', true)::INT;
    EXCEPTION
        WHEN OTHERS THEN
            v_usuario_app := NULL;
    END;

    -- ID log
    v_id_log := nextval('seq_log_detalle_factura');

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        INSERT INTO log_detalle_factura(
            id_log,
            id_detalle_factura,
            codigo,
            descripcion,
            precio_unitario,
            subtotal,
            id_factura,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_detalle_factura,
            NEW.codigo,
            NEW.descripcion,
            NEW.precio_unitario,
            NEW.subtotal,
            NEW.id_factura,
            'I',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes update
        INSERT INTO log_detalle_factura(
            id_log,
            id_detalle_factura,
            codigo,
            descripcion,
            precio_unitario,
            subtotal,
            id_factura,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_detalle_factura,
            OLD.codigo,
            OLD.descripcion,
            OLD.precio_unitario,
            OLD.subtotal,
            OLD.id_factura,
            'AU',
            v_usuario_app,
            v_usuario_db
        );

        -- Nuevo ID log
        v_id_log := nextval('seq_log_detalle_factura');

        -- Después update
        INSERT INTO log_detalle_factura(
            id_log,
            id_detalle_factura,
            codigo,
            descripcion,
            precio_unitario,
            subtotal,
            id_factura,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_detalle_factura,
            NEW.codigo,
            NEW.descripcion,
            NEW.precio_unitario,
            NEW.subtotal,
            NEW.id_factura,
            'DU',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_detalle_factura(
            id_log,
            id_detalle_factura,
            codigo,
            descripcion,
            precio_unitario,
            subtotal,
            id_factura,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_detalle_factura,
            OLD.codigo,
            OLD.descripcion,
            OLD.precio_unitario,
            OLD.subtotal,
            OLD.id_factura,
            'D',
            v_usuario_app,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;

END;
$$;

CREATE TRIGGER trg_log_detalle_factura
AFTER INSERT OR UPDATE OR DELETE
ON detalle_factura
FOR EACH ROW
EXECUTE FUNCTION fn_log_detalle_factura();

-- Factura
CREATE OR REPLACE FUNCTION fn_log_factura()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario_app INT;
    v_usuario_db VARCHAR(50);
    v_id_log INT;
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Usuario Laravel
    BEGIN
        v_usuario_app := current_setting('app.usuario', true)::INT;
    EXCEPTION
        WHEN OTHERS THEN
            v_usuario_app := NULL;
    END;

    -- ID log
    v_id_log := nextval('seq_log_factura');

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        INSERT INTO log_factura(
            id_log,
            id_factura,
            fecha_emision,
            monto_base,
            monto_recargo,
            total,
            id_alquiler,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_factura,
            NEW.fecha_emision,
            NEW.monto_base,
            NEW.monto_recargo,
            NEW.total,
            NEW.id_alquiler,
            'I',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes update
        INSERT INTO log_factura(
            id_log,
            id_factura,
            fecha_emision,
            monto_base,
            monto_recargo,
            total,
            id_alquiler,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_factura,
            OLD.fecha_emision,
            OLD.monto_base,
            OLD.monto_recargo,
            OLD.total,
            OLD.id_alquiler,
            'AU',
            v_usuario_app,
            v_usuario_db
        );

        -- Nuevo ID log
        v_id_log := nextval('seq_log_factura');

        -- Después update
        INSERT INTO log_factura(
            id_log,
            id_factura,
            fecha_emision,
            monto_base,
            monto_recargo,
            total,
            id_alquiler,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_factura,
            NEW.fecha_emision,
            NEW.monto_base,
            NEW.monto_recargo,
            NEW.total,
            NEW.id_alquiler,
            'DU',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_factura(
            id_log,
            id_factura,
            fecha_emision,
            monto_base,
            monto_recargo,
            total,
            id_alquiler,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_factura,
            OLD.fecha_emision,
            OLD.monto_base,
            OLD.monto_recargo,
            OLD.total,
            OLD.id_alquiler,
            'D',
            v_usuario_app,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;

END;
$$;

CREATE TRIGGER trg_log_factura
AFTER INSERT OR UPDATE OR DELETE
ON factura
FOR EACH ROW
EXECUTE FUNCTION fn_log_factura();

-- Taller
-- Función trigger
CREATE OR REPLACE FUNCTION fn_log_taller()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario_app INT;
    v_usuario_db VARCHAR(50);
    v_id_log INT;
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Usuario Laravel
    BEGIN
        v_usuario_app := current_setting('app.usuario', true)::INT;
    EXCEPTION
        WHEN OTHERS THEN
            v_usuario_app := NULL;
    END;

    -- ID log
    v_id_log := nextval('seq_log_taller');

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        INSERT INTO log_taller(
            id_log,
            id_taller,
            nombre_taller,
            direccion_taller,
            telefono_taller,
            id_departamento,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_taller,
            NEW.nombre_taller,
            NEW.direccion_taller,
            NEW.telefono_taller,
            NEW.id_departamento,
            'I',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes update
        INSERT INTO log_taller(
            id_log,
            id_taller,
            nombre_taller,
            direccion_taller,
            telefono_taller,
            id_departamento,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_taller,
            OLD.nombre_taller,
            OLD.direccion_taller,
            OLD.telefono_taller,
            OLD.id_departamento,
            'AU',
            v_usuario_app,
            v_usuario_db
        );

        -- Nuevo ID log
        v_id_log := nextval('seq_log_taller');

        -- Después update
        INSERT INTO log_taller(
            id_log,
            id_taller,
            nombre_taller,
            direccion_taller,
            telefono_taller,
            id_departamento,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_taller,
            NEW.nombre_taller,
            NEW.direccion_taller,
            NEW.telefono_taller,
            NEW.id_departamento,
            'DU',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_taller(
            id_log,
            id_taller,
            nombre_taller,
            direccion_taller,
            telefono_taller,
            id_departamento,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_taller,
            OLD.nombre_taller,
            OLD.direccion_taller,
            OLD.telefono_taller,
            OLD.id_departamento,
            'D',
            v_usuario_app,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;

END;
$$;

CREATE TRIGGER trg_log_taller
AFTER INSERT OR UPDATE OR DELETE
ON taller
FOR EACH ROW
EXECUTE FUNCTION fn_log_taller();

-- -------------------------------------
-- Mantenimiento
-- Función trigger
CREATE OR REPLACE FUNCTION fn_log_mantenimiento()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario_app INT;
    v_usuario_db VARCHAR(50);
    v_id_log INT;
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Usuario Laravel
    BEGIN
        v_usuario_app := current_setting('app.usuario', true)::INT;
    EXCEPTION
        WHEN OTHERS THEN
            v_usuario_app := NULL;
    END;

    -- ID log
    v_id_log := nextval('seq_log_mantenimiento');

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        INSERT INTO log_mantenimiento(
            id_log,
            id_mantenimiento,
            fecha_envio,
            fecha_devolucion,
            id_vehiculo,
            id_taller,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_mantenimiento,
            NEW.fecha_envio,
            NEW.fecha_devolucion,
            NEW.id_vehiculo,
            NEW.id_taller,
            'I',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes update
        INSERT INTO log_mantenimiento(
            id_log,
            id_mantenimiento,
            fecha_envio,
            fecha_devolucion,
            id_vehiculo,
            id_taller,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_mantenimiento,
            OLD.fecha_envio,
            OLD.fecha_devolucion,
            OLD.id_vehiculo,
            OLD.id_taller,
            'AU',
            v_usuario_app,
            v_usuario_db
        );

        -- Nuevo ID log
        v_id_log := nextval('seq_log_mantenimiento');

        -- Después update
        INSERT INTO log_mantenimiento(
            id_log,
            id_mantenimiento,
            fecha_envio,
            fecha_devolucion,
            id_vehiculo,
            id_taller,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_mantenimiento,
            NEW.fecha_envio,
            NEW.fecha_devolucion,
            NEW.id_vehiculo,
            NEW.id_taller,
            'DU',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_mantenimiento(
            id_log,
            id_mantenimiento,
            fecha_envio,
            fecha_devolucion,
            id_vehiculo,
            id_taller,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_mantenimiento,
            OLD.fecha_envio,
            OLD.fecha_devolucion,
            OLD.id_vehiculo,
            OLD.id_taller,
            'D',
            v_usuario_app,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;

END;
$$;

-- Trigger
CREATE TRIGGER trg_log_mantenimiento
AFTER INSERT OR UPDATE OR DELETE
ON mantenimiento
FOR EACH ROW
EXECUTE FUNCTION fn_log_mantenimiento();

-- -------------------------------------
-- tarifa
CREATE OR REPLACE FUNCTION fn_log_tarifa()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario_app INT;
    v_usuario_db VARCHAR(50);
    v_id_log INT;
BEGIN

    -- Usuario PostgreSQL
    v_usuario_db := current_user;

    -- Usuario Laravel
    BEGIN
        v_usuario_app := current_setting('app.usuario', true)::INT;
    EXCEPTION
        WHEN OTHERS THEN
            v_usuario_app := NULL;
    END;

    -- ID log
    v_id_log := nextval('seq_log_tarifa');

    -- INSERT
    IF TG_OP = 'INSERT' THEN

        INSERT INTO log_tarifa(
            id_log,
            id_tarifa,
            precio_dia,
            porcentaje_recargo_hora,
            id_sucursal,
            id_tipo_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_tarifa,
            NEW.precio_dia,
            NEW.porcentaje_recargo_hora,
            NEW.id_sucursal,
            NEW.id_tipo_vehiculo,
            'I',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- UPDATE
    ELSIF TG_OP = 'UPDATE' THEN

        -- Antes update
        INSERT INTO log_tarifa(
            id_log,
            id_tarifa,
            precio_dia,
            porcentaje_recargo_hora,
            id_sucursal,
            id_tipo_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_tarifa,
            OLD.precio_dia,
            OLD.porcentaje_recargo_hora,
            OLD.id_sucursal,
            OLD.id_tipo_vehiculo,
            'AU',
            v_usuario_app,
            v_usuario_db
        );

        -- Nuevo ID log
        v_id_log := nextval('seq_log_tarifa');

        -- Después update
        INSERT INTO log_tarifa(
            id_log,
            id_tarifa,
            precio_dia,
            porcentaje_recargo_hora,
            id_sucursal,
            id_tipo_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            NEW.id_tarifa,
            NEW.precio_dia,
            NEW.porcentaje_recargo_hora,
            NEW.id_sucursal,
            NEW.id_tipo_vehiculo,
            'DU',
            v_usuario_app,
            v_usuario_db
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_tarifa(
            id_log,
            id_tarifa,
            precio_dia,
            porcentaje_recargo_hora,
            id_sucursal,
            id_tipo_vehiculo,
            mov,
            usuario,
            usuario_db
        )
        VALUES(
            v_id_log,
            OLD.id_tarifa,
            OLD.precio_dia,
            OLD.porcentaje_recargo_hora,
            OLD.id_sucursal,
            OLD.id_tipo_vehiculo,
            'D',
            v_usuario_app,
            v_usuario_db
        );

        RETURN OLD;

    END IF;

    RETURN NULL;

END;
$$;

CREATE TRIGGER trg_log_tarifa
AFTER INSERT OR UPDATE OR DELETE
ON tarifa
FOR EACH ROW
EXECUTE FUNCTION fn_log_tarifa();