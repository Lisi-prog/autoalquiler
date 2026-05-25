CREATE OR REPLACE FUNCTION fn_obtener_mensaje(
    p_codigo_mensaje INTEGER
)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE
    v_mensaje VARCHAR;
BEGIN

    SELECT 
        mensaje INTO v_mensaje
        FROM mensaje
        WHERE codigo_mensaje= p_codigo_mensaje;

    RETURN v_mensaje;

EXCEPTION
    WHEN OTHERS THEN
        RETURN 'Error desconocido';
END;
$$;

CREATE OR REPLACE FUNCTION fn_vehiculo_disponible(
    p_id_vehiculo INT,
    p_fecha_inicio TIMESTAMP,
    p_fecha_fin TIMESTAMP,
    p_id_reserva_excluir INT DEFAULT NULL
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_actual INT;
BEGIN

    -- Validar existencia vehículo
    IF NOT EXISTS (
        SELECT 1
        FROM vehiculo
        WHERE id_vehiculo = p_id_vehiculo
    ) THEN
        RETURN FALSE;
    END IF;

    -- Obtener último estado
    SELECT id_estado_vehiculo
    INTO v_estado_actual
    FROM vehiculo_x_estado
    WHERE id_vehiculo = p_id_vehiculo
    ORDER BY fecha_estado DESC
    LIMIT 1;

    -- Disponible o reservado
    IF v_estado_actual NOT IN (1,2) THEN
        RETURN FALSE;
    END IF;

    -- Reservas superpuestas
    IF EXISTS (
        SELECT 1
        FROM reserva
        WHERE id_vehiculo = p_id_vehiculo
        AND (
            p_id_reserva_excluir IS NULL
            OR id_reserva <> p_id_reserva_excluir
        )
        AND (
            p_fecha_inicio BETWEEN fecha_inicio AND fecha_fin
            OR p_fecha_fin BETWEEN fecha_inicio AND fecha_fin
            OR (
                p_fecha_inicio <= fecha_inicio
                AND p_fecha_fin >= fecha_fin
            )
        )
    ) THEN
        RETURN FALSE;
    END IF;

    -- Alquileres superpuestos
    IF EXISTS (
        SELECT 1
        FROM alquiler
        WHERE id_vehiculo = p_id_vehiculo
        AND (
            p_fecha_inicio BETWEEN fecha_inicio AND fecha_fin_prevista
            OR p_fecha_fin BETWEEN fecha_inicio AND fecha_fin_prevista
            OR (
                p_fecha_inicio <= fecha_inicio
                AND p_fecha_fin >= fecha_fin_prevista
            )
        )
    ) THEN
        RETURN FALSE;
    END IF;

    RETURN TRUE;

END;
$$;

CREATE OR REPLACE FUNCTION fn_vehiculo_disponible_modificacion(
    p_id_reserva INT,
    p_id_vehiculo INT,
    p_fecha_inicio TIMESTAMP,
    p_fecha_fin TIMESTAMP
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_actual INT;
BEGIN

    -- Validar vehículo
    IF NOT EXISTS (
        SELECT 1
        FROM vehiculo
        WHERE id_vehiculo = p_id_vehiculo
    ) THEN
        RETURN FALSE;
    END IF;

    -- Último estado
    SELECT ve.id_estado_vehiculo
    INTO v_estado_actual
    FROM vehiculo_x_estado ve
    WHERE ve.id_vehiculo = p_id_vehiculo
    ORDER BY ve.fecha_estado DESC
    LIMIT 1;

    -- Debe estar disponible o reservado
    IF v_estado_actual NOT IN (1, 2) THEN
        RETURN FALSE;
    END IF;

    -- Reservas superpuestas
    IF EXISTS (
        SELECT 1
        FROM reserva r
        WHERE r.id_vehiculo = p_id_vehiculo
        AND r.id_reserva <> p_id_reserva
        AND (
            p_fecha_inicio BETWEEN r.fecha_inicio AND r.fecha_fin
            OR p_fecha_fin BETWEEN r.fecha_inicio AND r.fecha_fin
            OR (
                p_fecha_inicio <= r.fecha_inicio
                AND p_fecha_fin >= r.fecha_fin
            )
        )
    ) THEN
        RETURN FALSE;
    END IF;

    -- Alquileres superpuestos
    IF EXISTS (
        SELECT 1
        FROM alquiler a
        WHERE a.id_vehiculo = p_id_vehiculo
        AND (
            p_fecha_inicio BETWEEN a.fecha_inicio AND a.fecha_fin_prevista
            OR p_fecha_fin BETWEEN a.fecha_inicio AND a.fecha_fin_prevista
            OR (
                p_fecha_inicio <= a.fecha_inicio
                AND p_fecha_fin >= a.fecha_fin_prevista
            )
        )
    ) THEN
        RETURN FALSE;
    END IF;

    RETURN TRUE;

END;
$$;