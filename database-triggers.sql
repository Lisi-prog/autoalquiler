CREATE OR REPLACE FUNCTION fn_log_sucursal()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario INT;
    v_id_log INT;
BEGIN

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
            usuario
        )
        VALUES (
            v_id_log,
            NEW.id_sucursal,
            NEW.nombre_sucursal,
            NEW.direccion_sucursal,
            NEW.id_departamento,
            'I',
            v_usuario
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
            usuario
        )
        VALUES (
            v_id_log,
            OLD.id_sucursal,
            OLD.nombre_sucursal,
            OLD.direccion_sucursal,
            OLD.id_departamento,
            'AU',
            v_usuario
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
            usuario
        )
        VALUES (
            v_id_log,
            NEW.id_sucursal,
            NEW.nombre_sucursal,
            NEW.direccion_sucursal,
            NEW.id_departamento,
            'DU',
            v_usuario
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
            usuario
        )
        VALUES (
            v_id_log,
            OLD.id_sucursal,
            OLD.nombre_sucursal,
            OLD.direccion_sucursal,
            OLD.id_departamento,
            'D',
            v_usuario
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

CREATE OR REPLACE FUNCTION fn_log_tipo_vehiculo()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario INT;
    v_id_log INT;
BEGIN

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
            usuario
        )
        VALUES (
            v_id_log,
            NEW.id_tipo_vehiculo,
            NEW.nombre_tipo_vehiculo,
            'I',
            v_usuario
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
            usuario
        )
        VALUES (
            v_id_log,
            OLD.id_tipo_vehiculo,
            OLD.nombre_tipo_vehiculo,
            'AU',
            v_usuario
        );

        -- Después del update
        v_id_log := nextval('seq_log_tipo_vehiculo');

        INSERT INTO log_tipo_vehiculo (
            id_log,
            id_tipo_vehiculo,
            nombre_tipo_vehiculo,
            mov,
            usuario
        )
        VALUES (
            v_id_log,
            NEW.id_tipo_vehiculo,
            NEW.nombre_tipo_vehiculo,
            'DU',
            v_usuario
        );

        RETURN NEW;

    -- DELETE
    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO log_tipo_vehiculo (
            id_log,
            id_tipo_vehiculo,
            nombre_tipo_vehiculo,
            mov,
            usuario
        )
        VALUES (
            v_id_log,
            OLD.id_tipo_vehiculo,
            OLD.nombre_tipo_vehiculo,
            'D',
            v_usuario
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