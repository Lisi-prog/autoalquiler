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

CREATE OR REPLACE FUNCTION fn_calcular_monto_tarifa(
    p_fecha_inicio TIMESTAMP,
    p_fecha_fin TIMESTAMP,
    p_id_tipo_vehiculo INT,
    p_id_sucursal INT
)
RETURNS NUMERIC(10,2)
LANGUAGE plpgsql
AS
$$
DECLARE
    v_precio_dia NUMERIC(10,2);
    v_cantidad_dias INTEGER;
BEGIN
    IF p_fecha_fin < p_fecha_inicio THEN
        RAISE EXCEPTION 'La fecha de fin no puede ser menor a la fecha de inicio';
    END IF;

    SELECT
        precio_dia
    INTO
        v_precio_dia
    FROM tarifa
    WHERE id_tipo_vehiculo = p_id_tipo_vehiculo
    AND id_sucursal = p_id_sucursal
    LIMIT 1;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'No existe tarifa para el tipo de vehículo % en la sucursal %',
            p_id_tipo_vehiculo,
            p_id_sucursal;
    END IF;

    -- Incluye el día de inicio
    v_cantidad_dias := (p_fecha_fin::date - p_fecha_inicio::date) + 1;

    RETURN v_cantidad_dias * v_precio_dia;
END;
$$;

CREATE OR REPLACE FUNCTION fn_calcular_factura_alquiler(
    p_id_alquiler INT
)
RETURNS TABLE(
    monto_base NUMERIC(10,2),
    monto_recargo NUMERIC(10,2),
    total NUMERIC(10,2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_fecha_inicio TIMESTAMP;
    v_fecha_fin_real TIMESTAMP;
    v_fecha_fin_prevista TIMESTAMP;

    v_id_vehiculo INT;
    v_id_tipo_vehiculo INT;
    v_sucursal_devolucion INT;

    v_precio_dia NUMERIC(10,2);
    v_recargo_hora NUMERIC(10,2);

    v_dias_alquiler INT;
    v_horas_recargo INT;
BEGIN

    -- Obtener datos del alquiler
    SELECT
        a.fecha_inicio,
        a.fecha_fin_real,
        a.fecha_fin_prevista,
        a.id_vehiculo,
        a.sucursal_devolucion
    INTO
        v_fecha_inicio,
        v_fecha_fin_real,
        v_fecha_fin_prevista,
        v_id_vehiculo,
        v_sucursal_devolucion
    FROM alquiler a
    WHERE a.id_alquiler = p_id_alquiler;

    -- Validar existencia
    IF NOT FOUND THEN
        RAISE EXCEPTION
            'No existe el alquiler %',
            p_id_alquiler;
    END IF;

    -- Obtener tipo de vehículo
    SELECT id_tipo_vehiculo
    INTO v_id_tipo_vehiculo
    FROM vehiculo
    WHERE id_vehiculo = v_id_vehiculo;

    IF v_id_tipo_vehiculo IS NULL THEN
        RAISE EXCEPTION
            'No existe tipo de vehículo para el vehículo %',
            v_id_vehiculo;
    END IF;

    -- Obtener tarifa según tipo y sucursal
    SELECT
        t.precio_dia,
        t.porcentaje_recargo_hora
    INTO
        v_precio_dia,
        v_recargo_hora
    FROM tarifa t
    WHERE t.id_tipo_vehiculo = v_id_tipo_vehiculo
      AND t.id_sucursal = v_sucursal_devolucion;

    -- Validar tarifa
    IF v_precio_dia IS NULL THEN
        RAISE EXCEPTION
            'No existe tarifa para tipo vehículo % y sucursal %',
            v_id_tipo_vehiculo,
            v_sucursal_devolucion;
    END IF;

    -- Calcular días de alquiler
    v_dias_alquiler := CEIL(
        EXTRACT(EPOCH FROM (
            v_fecha_fin_real - v_fecha_inicio
        )) / 86400
    );

    IF v_dias_alquiler <= 0 THEN
        v_dias_alquiler := 1;
    END IF;

    -- Monto base
    monto_base := v_dias_alquiler * v_precio_dia;

    -- Horas de atraso
    IF v_fecha_fin_real > v_fecha_fin_prevista THEN

        v_horas_recargo := CEIL(
            EXTRACT(EPOCH FROM (
                v_fecha_fin_real - v_fecha_fin_prevista
            )) / 3600
        );

    ELSE

        v_horas_recargo := 0;

    END IF;

    -- Monto recargo
    monto_recargo :=
        (v_precio_dia * (v_recargo_hora / 100))
        * v_horas_recargo;

    -- Total
    total := monto_base + monto_recargo;

    RETURN NEXT;

END;
$$;
