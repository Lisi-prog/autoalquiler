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
            usuario_db
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