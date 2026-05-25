-- Sucursal
CREATE OR REPLACE PROCEDURE sp_alta_sucursal(
    IN p_nombre_sucursal VARCHAR,
    IN p_direccion_sucursal VARCHAR,
    IN p_id_departamento INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación nombre
    IF p_nombre_sucursal IS NULL
       OR TRIM(p_nombre_sucursal) = '' THEN

        p_codigo := 100;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Validación departamento
    IF NOT EXISTS (
        SELECT 1
        FROM departamento
        WHERE id_departamento = p_id_departamento
    ) THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Insert
    INSERT INTO sucursal(
        nombre_sucursal,
        direccion_sucursal,
        id_departamento
    )
    VALUES(
        TRIM(p_nombre_sucursal),
        TRIM(p_direccion_sucursal),
        p_id_departamento
    );

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN unique_violation THEN

        p_codigo := 101;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_modificar_sucursal(
    IN p_id_sucursal INT,
    IN p_nombre_sucursal VARCHAR,
    IN p_direccion_sucursal VARCHAR,
    IN p_id_departamento INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM sucursal
        WHERE id_sucursal = p_id_sucursal
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Validación nombre
    IF p_nombre_sucursal IS NULL
       OR TRIM(p_nombre_sucursal) = '' THEN

        p_codigo := 100;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Validación departamento
    IF NOT EXISTS (
        SELECT 1
        FROM departamento
        WHERE id_departamento = p_id_departamento
    ) THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Update
    UPDATE sucursal
    SET nombre_sucursal = TRIM(p_nombre_sucursal),
        direccion_sucursal = TRIM(p_direccion_sucursal),
        id_departamento = p_id_departamento
    WHERE id_sucursal = p_id_sucursal;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN unique_violation THEN

        p_codigo := 101;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_baja_sucursal(
    IN p_id_sucursal INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM sucursal
        WHERE id_sucursal = p_id_sucursal
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Delete
    DELETE FROM sucursal
    WHERE id_sucursal = p_id_sucursal;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN foreign_key_violation THEN

        p_codigo := 103;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;
-- --------------------

-- Cliente
-- --------------------

-- Tipo Vehiculo
CREATE OR REPLACE PROCEDURE sp_alta_tipo_vehiculo(
    IN p_nombre_tipo_vehiculo VARCHAR,
    OUT p_codigo INTEGER,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    IF p_nombre_tipo_vehiculo IS NULL 
       OR TRIM(p_nombre_tipo_vehiculo) = '' THEN
        
        p_codigo := 100;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    INSERT INTO tipo_vehiculo(nombre_tipo_vehiculo)
    VALUES(TRIM(p_nombre_tipo_vehiculo));

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN unique_violation THEN

        p_codigo := 101;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_modificar_tipo_vehiculo(
    IN p_id_tipo_vehiculo INT,
    IN p_nombre_tipo_vehiculo VARCHAR,
    OUT p_codigo INTEGER,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM tipo_vehiculo
        WHERE id_tipo_vehiculo = p_id_tipo_vehiculo
    ) THEN
        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Validación nombre
    IF p_nombre_tipo_vehiculo IS NULL 
       OR TRIM(p_nombre_tipo_vehiculo) = '' THEN

        p_codigo := 100;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Update
    UPDATE tipo_vehiculo
    SET nombre_tipo_vehiculo = TRIM(p_nombre_tipo_vehiculo)
    WHERE id_tipo_vehiculo = p_id_tipo_vehiculo;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN unique_violation THEN
        p_codigo := 101;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN
        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_baja_tipo_vehiculo(
    IN p_id_tipo_vehiculo INT,
    OUT p_codigo INTEGER,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM tipo_vehiculo
        WHERE id_tipo_vehiculo = p_id_tipo_vehiculo
    ) THEN
        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Delete
    DELETE FROM tipo_vehiculo
    WHERE id_tipo_vehiculo = p_id_tipo_vehiculo;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN foreign_key_violation THEN
        p_codigo := 103;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN
        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);
END;
$$;

-- --------------------

-- Vehiculo
CREATE OR REPLACE PROCEDURE sp_alta_vehiculo(
    IN p_patente VARCHAR,
    IN p_marca VARCHAR,
    IN p_modelo VARCHAR,
    IN p_detalle_confort VARCHAR,
    IN p_id_tipo_vehiculo INT,
    IN p_id_sucursal INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_vehiculo INT;
BEGIN

    -- Validación patente
    IF p_patente IS NULL
       OR TRIM(p_patente) = '' THEN

        p_codigo := 105;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Validación marca
    IF p_marca IS NULL
       OR TRIM(p_marca) = '' THEN

        p_codigo := 106;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Validación modelo
    IF p_modelo IS NULL
       OR TRIM(p_modelo) = '' THEN

        p_codigo := 107;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Validación tipo vehículo
    IF NOT EXISTS (
        SELECT 1
        FROM tipo_vehiculo
        WHERE id_tipo_vehiculo = p_id_tipo_vehiculo
    ) THEN

        p_codigo := 108;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Validación sucursal
    IF NOT EXISTS (
        SELECT 1
        FROM sucursal
        WHERE id_sucursal = p_id_sucursal
    ) THEN

        p_codigo := 109;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Insert vehículo
    INSERT INTO vehiculo(
        patente,
        marca,
        modelo,
        detalle_confort,
        id_tipo_vehiculo,
        id_sucursal
    )
    VALUES(
        UPPER(TRIM(p_patente)),
        TRIM(p_marca),
        TRIM(p_modelo),
        TRIM(p_detalle_confort),
        p_id_tipo_vehiculo,
        p_id_sucursal
    )
    RETURNING id_vehiculo
    INTO v_id_vehiculo;

    -- Estado inicial del vehículo
    INSERT INTO vehiculo_x_estado(
        id_vehiculo,
        id_estado_vehiculo
    )
    VALUES(
        v_id_vehiculo,
        1
    );

    -- Operación exitosa
    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN unique_violation THEN

        p_codigo := 101;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_modificar_vehiculo(
    IN p_id_vehiculo INT,
    IN p_patente VARCHAR,
    IN p_marca VARCHAR,
    IN p_modelo VARCHAR,
    IN p_detalle_confort VARCHAR,
    IN p_id_tipo_vehiculo INT,
    IN p_id_sucursal INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM vehiculo
        WHERE id_vehiculo = p_id_vehiculo
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Validaciones
    IF p_patente IS NULL
       OR TRIM(p_patente) = '' THEN

        p_codigo := 105;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    IF p_marca IS NULL
       OR TRIM(p_marca) = '' THEN

        p_codigo := 106;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    IF p_modelo IS NULL
       OR TRIM(p_modelo) = '' THEN

        p_codigo := 107;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Validación tipo vehículo
    IF NOT EXISTS (
        SELECT 1
        FROM tipo_vehiculo
        WHERE id_tipo_vehiculo = p_id_tipo_vehiculo
    ) THEN

        p_codigo := 108;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Validación sucursal
    IF NOT EXISTS (
        SELECT 1
        FROM sucursal
        WHERE id_sucursal = p_id_sucursal
    ) THEN

        p_codigo := 109;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Update
    UPDATE vehiculo
    SET patente = UPPER(TRIM(p_patente)),
        marca = TRIM(p_marca),
        modelo = TRIM(p_modelo),
        detalle_confort = TRIM(p_detalle_confort),
        id_tipo_vehiculo = p_id_tipo_vehiculo,
        id_sucursal = p_id_sucursal
    WHERE id_vehiculo = p_id_vehiculo;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN unique_violation THEN

        p_codigo := 101;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_baja_vehiculo(
    IN p_id_vehiculo INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM vehiculo
        WHERE id_vehiculo = p_id_vehiculo
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;
    END IF;

    -- Baja desde el estado
    INSERT INTO vehiculo_x_estado(
        id_vehiculo,
        id_estado_vehiculo
    )
    VALUES(
        p_id_vehiculo,
        5
    );

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN foreign_key_violation THEN

        p_codigo := 103;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;
-- --------------------

-- Reserva

CREATE OR REPLACE PROCEDURE sp_alta_reserva(
    IN p_fecha_inicio TIMESTAMP,
    IN p_fecha_fin TIMESTAMP,
    IN p_sucursal_retiro INT,
    IN p_sucursal_devolucion INT,
    IN p_id_cliente INT,
    IN p_id_vehiculo INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_reserva INT;
BEGIN

    -- Validación fecha inicio
    IF p_fecha_inicio IS NULL THEN

        p_codigo := 110;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación fecha fin
    IF p_fecha_fin IS NULL THEN

        p_codigo := 111;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación rango fechas
    IF p_fecha_fin <= p_fecha_inicio THEN

        p_codigo := 112;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación cliente
    IF NOT EXISTS (
        SELECT 1
        FROM cliente
        WHERE id_cliente = p_id_cliente
    ) THEN

        p_codigo := 113;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación vehículo
    IF NOT EXISTS (
        SELECT 1
        FROM vehiculo
        WHERE id_vehiculo = p_id_vehiculo
    ) THEN

        p_codigo := 114;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación sucursal retiro
    IF NOT EXISTS (
        SELECT 1
        FROM sucursal
        WHERE id_sucursal = p_sucursal_retiro
    ) THEN

        p_codigo := 115;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación sucursal devolución
    IF p_sucursal_devolucion IS NOT NULL
       AND NOT EXISTS (
            SELECT 1
            FROM sucursal
            WHERE id_sucursal = p_sucursal_devolucion
       ) THEN

        p_codigo := 116;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación disponibilidad vehículo
    IF NOT fn_vehiculo_disponible(
        p_id_vehiculo,
        p_fecha_inicio,
        p_fecha_fin
    ) THEN

        p_codigo := 117;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Insert
    INSERT INTO reserva(
        fecha_inicio,
        fecha_fin,
        sucursal_retiro,
        sucursal_devolucion,
        id_cliente,
        id_vehiculo
    )
    VALUES(
        p_fecha_inicio,
        p_fecha_fin,
        p_sucursal_retiro,
        p_sucursal_devolucion,
        p_id_cliente,
        p_id_vehiculo
    )
    RETURNING id_reserva
    INTO v_id_reserva;

    -- Estado inicial de la reserva
    INSERT INTO reserva_x_estado(
        id_reserva,
        id_estado_reserva
    )
    VALUES(
        v_id_reserva,
        1
    );

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_modificar_reserva(
    IN p_id_reserva INT,
    IN p_fecha_inicio TIMESTAMP,
    IN p_fecha_fin TIMESTAMP,
    IN p_sucursal_retiro INT,
    IN p_sucursal_devolucion INT,
    IN p_id_cliente INT,
    IN p_id_vehiculo INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia reserva
    IF NOT EXISTS (
        SELECT 1
        FROM reserva
        WHERE id_reserva = p_id_reserva
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación fecha inicio
    IF p_fecha_inicio IS NULL THEN

        p_codigo := 110;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación fecha fin
    IF p_fecha_fin IS NULL THEN

        p_codigo := 111;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación rango fechas
    IF p_fecha_fin <= p_fecha_inicio THEN

        p_codigo := 112;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación cliente
    IF NOT EXISTS (
        SELECT 1
        FROM cliente
        WHERE id_cliente = p_id_cliente
    ) THEN

        p_codigo := 113;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación vehículo
    IF NOT EXISTS (
        SELECT 1
        FROM vehiculo
        WHERE id_vehiculo = p_id_vehiculo
    ) THEN

        p_codigo := 114;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación sucursal retiro
    IF NOT EXISTS (
        SELECT 1
        FROM sucursal
        WHERE id_sucursal = p_sucursal_retiro
    ) THEN

        p_codigo := 115;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación sucursal devolución
    IF p_sucursal_devolucion IS NOT NULL
       AND NOT EXISTS (
            SELECT 1
            FROM sucursal
            WHERE id_sucursal = p_sucursal_devolucion
       ) THEN

        p_codigo := 116;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación disponibilidad vehículo
    IF NOT fn_vehiculo_disponible_modificacion(
        p_id_reserva,
        p_id_vehiculo,
        p_fecha_inicio,
        p_fecha_fin
    ) THEN

        p_codigo := 117;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Update
    UPDATE reserva
    SET fecha_inicio = p_fecha_inicio,
        fecha_fin = p_fecha_fin,
        sucursal_retiro = p_sucursal_retiro,
        sucursal_devolucion = p_sucursal_devolucion,
        id_cliente = p_id_cliente,
        id_vehiculo = p_id_vehiculo
    WHERE id_reserva = p_id_reserva;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_baja_reserva(
    IN p_id_reserva INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM reserva
        WHERE id_reserva = p_id_reserva
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Baja de un reserva en el estado
    INSERT INTO reserva_x_estado(
        id_reserva,
        id_estado_reserva
    )
    VALUES(
        p_id_reserva,
        3
    );

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN foreign_key_violation THEN

        p_codigo := 103;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

-- Alquiler
CREATE OR REPLACE PROCEDURE sp_alta_alquiler(
    IN p_fecha_inicio TIMESTAMP,
    IN p_fecha_fin_prevista TIMESTAMP,
    IN p_km_inicio INT,
    IN p_sucursal_retiro INT,
    IN p_sucursal_devolucion INT,
    IN p_id_reserva INT,
    IN p_id_cliente INT,
    IN p_id_vehiculo INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_alquiler INT;
BEGIN

    -- Validación fecha inicio
    IF p_fecha_inicio IS NULL THEN

        p_codigo := 118;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación fecha fin prevista
    IF p_fecha_fin_prevista IS NULL THEN

        p_codigo := 119;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación rango fechas
    IF p_fecha_fin_prevista <= p_fecha_inicio THEN

        p_codigo := 120;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación kilómetros
    IF p_km_inicio IS NULL
       OR p_km_inicio < 0 THEN

        p_codigo := 121;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación cliente
    IF NOT EXISTS (
        SELECT 1
        FROM cliente
        WHERE id_cliente = p_id_cliente
    ) THEN

        p_codigo := 113;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación vehículo
    IF NOT EXISTS (
        SELECT 1
        FROM vehiculo
        WHERE id_vehiculo = p_id_vehiculo
    ) THEN

        p_codigo := 114;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación sucursal retiro
    IF NOT EXISTS (
        SELECT 1
        FROM sucursal
        WHERE id_sucursal = p_sucursal_retiro
    ) THEN

        p_codigo := 115;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación sucursal devolución
    IF p_sucursal_devolucion IS NOT NULL
       AND NOT EXISTS (
            SELECT 1
            FROM sucursal
            WHERE id_sucursal = p_sucursal_devolucion
       ) THEN

        p_codigo := 116;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación reserva
    IF p_id_reserva IS NOT NULL
       AND NOT EXISTS (
            SELECT 1
            FROM reserva
            WHERE id_reserva = p_id_reserva
       ) THEN

        p_codigo := 122;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación disponibilidad vehículo
    IF NOT fn_vehiculo_disponible(
        p_id_vehiculo,
        p_fecha_inicio,
        p_fecha_fin_prevista,
        p_id_reserva
    ) THEN

        p_codigo := 117;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Insert alquiler
    INSERT INTO alquiler(
        fecha_inicio,
        fecha_fin_prevista,
        km_inicio,
        sucursal_retiro,
        sucursal_devolucion,
        id_reserva,
        id_cliente,
        id_vehiculo
    )
    VALUES(
        p_fecha_inicio,
        p_fecha_fin_prevista,
        p_km_inicio,
        p_sucursal_retiro,
        p_sucursal_devolucion,
        p_id_reserva,
        p_id_cliente,
        p_id_vehiculo
    )
    RETURNING id_alquiler
    INTO v_id_alquiler;

    --Insert estado
    INSERT INTO alquiler_x_estado(
        id_alquiler,
        id_estado_alquiler
    )
    VALUES(
        v_id_alquiler,
        1
    );

    -- Cambiar estado vehículo
    -- INSERT INTO vehiculo_x_estado(
    --     id_vehiculo,
    --     id_estado_vehiculo,
    --     fecha_estado
    -- )
    -- VALUES(
    --     p_id_vehiculo,
    --     3,
    --     CURRENT_TIMESTAMP
    -- );

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_modificar_alquiler(
    IN p_id_alquiler INT,
    IN p_fecha_inicio TIMESTAMP,
    IN p_fecha_fin_prevista TIMESTAMP,
    IN p_fecha_fin_real TIMESTAMP,
    IN p_km_inicio INT,
    IN p_km_fin INT,
    IN p_sucursal_retiro INT,
    IN p_sucursal_devolucion INT,
    IN p_id_cliente INT,
    IN p_id_vehiculo INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM alquiler
        WHERE id_alquiler = p_id_alquiler
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación rango fechas
    IF p_fecha_fin_prevista <= p_fecha_inicio THEN

        p_codigo := 120;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación km final
    IF p_km_fin IS NOT NULL
       AND p_km_fin < p_km_inicio THEN

        p_codigo := 123;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Update
    UPDATE alquiler
    SET fecha_inicio = p_fecha_inicio,
        fecha_fin_prevista = p_fecha_fin_prevista,
        fecha_fin_real = p_fecha_fin_real,
        km_inicio = p_km_inicio,
        km_fin = p_km_fin,
        sucursal_retiro = p_sucursal_retiro,
        sucursal_devolucion = p_sucursal_devolucion,
        id_cliente = p_id_cliente,
        id_vehiculo = p_id_vehiculo
    WHERE id_alquiler = p_id_alquiler;

    -- Si finalizó → vehículo disponible
    IF p_fecha_fin_real IS NOT NULL THEN

        INSERT INTO vehiculo_x_estado(
            id_vehiculo,
            id_estado_vehiculo,
            fecha_estado
        )
        VALUES(
            p_id_vehiculo,
            1,
            CURRENT_TIMESTAMP
        );

    END IF;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_baja_alquiler(
    IN p_id_alquiler INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_vehiculo INT;
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM alquiler
        WHERE id_alquiler = p_id_alquiler
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Obtener vehículo
    SELECT id_vehiculo
    INTO v_id_vehiculo
    FROM alquiler
    WHERE id_alquiler = p_id_alquiler;

    -- Delete
    DELETE FROM alquiler
    WHERE id_alquiler = p_id_alquiler;

    -- Vehículo disponible
    INSERT INTO vehiculo_x_estado(
        id_vehiculo,
        id_estado_vehiculo,
        fecha_estado
    )
    VALUES(
        v_id_vehiculo,
        1,
        CURRENT_TIMESTAMP
    );

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN foreign_key_violation THEN

        p_codigo := 103;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;
-- ----------------------------------------------------------------
-- Taller
CREATE OR REPLACE PROCEDURE sp_alta_taller(
    IN p_nombre_taller VARCHAR,
    IN p_direccion_taller VARCHAR,
    IN p_telefono_taller VARCHAR,
    IN p_id_departamento INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación nombre
    IF p_nombre_taller IS NULL
       OR TRIM(p_nombre_taller) = '' THEN

        p_codigo := 125;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación departamento
    IF p_id_departamento IS NOT NULL
       AND NOT EXISTS (
            SELECT 1
            FROM departamento
            WHERE id_departamento = p_id_departamento
       ) THEN

        p_codigo := 126;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Insert
    INSERT INTO taller(
        nombre_taller,
        direccion_taller,
        telefono_taller,
        id_departamento
    )
    VALUES(
        TRIM(p_nombre_taller),
        TRIM(p_direccion_taller),
        TRIM(p_telefono_taller),
        p_id_departamento
    );

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN unique_violation THEN

        p_codigo := 101;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_modificar_taller(
    IN p_id_taller INT,
    IN p_nombre_taller VARCHAR,
    IN p_direccion_taller VARCHAR,
    IN p_telefono_taller VARCHAR,
    IN p_id_departamento INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM taller
        WHERE id_taller = p_id_taller
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación nombre
    IF p_nombre_taller IS NULL
       OR TRIM(p_nombre_taller) = '' THEN

        p_codigo := 125;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación departamento
    IF p_id_departamento IS NOT NULL
       AND NOT EXISTS (
            SELECT 1
            FROM departamento
            WHERE id_departamento = p_id_departamento
       ) THEN

        p_codigo := 126;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Update
    UPDATE taller
    SET nombre_taller = TRIM(p_nombre_taller),
        direccion_taller = TRIM(p_direccion_taller),
        telefono_taller = TRIM(p_telefono_taller),
        id_departamento = p_id_departamento
    WHERE id_taller = p_id_taller;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN unique_violation THEN

        p_codigo := 101;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_baja_taller(
    IN p_id_taller INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM taller
        WHERE id_taller = p_id_taller
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Delete
    DELETE FROM taller
    WHERE id_taller = p_id_taller;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN foreign_key_violation THEN

        p_codigo := 103;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

-- ----------------------------------------------------
-- Mantenimiento
CREATE OR REPLACE PROCEDURE sp_alta_mantenimiento(
    IN p_fecha_envio DATE,
    IN p_fecha_devolucion DATE,
    IN p_id_vehiculo INT,
    IN p_id_taller INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_actual INT;
BEGIN

    -- Validación fecha envío
    IF p_fecha_envio IS NULL THEN

        p_codigo := 127;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación fechas
    IF p_fecha_devolucion IS NOT NULL
       AND p_fecha_devolucion < p_fecha_envio THEN

        p_codigo := 128;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación vehículo
    IF NOT EXISTS (
        SELECT 1
        FROM vehiculo
        WHERE id_vehiculo = p_id_vehiculo
    ) THEN

        p_codigo := 114;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación taller
    IF NOT EXISTS (
        SELECT 1
        FROM taller
        WHERE id_taller = p_id_taller
    ) THEN

        p_codigo := 129;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Obtener estado actual vehículo
    SELECT id_estado_vehiculo
    INTO v_estado_actual
    FROM vehiculo_x_estado
    WHERE id_vehiculo = p_id_vehiculo
    ORDER BY fecha_estado DESC
    LIMIT 1;

    -- Validar disponible
    IF v_estado_actual <> 2 THEN

        p_codigo := 130;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Insert mantenimiento
    INSERT INTO mantenimiento(
        fecha_envio,
        fecha_devolucion,
        id_vehiculo,
        id_taller
    )
    VALUES(
        p_fecha_envio,
        p_fecha_devolucion,
        p_id_vehiculo,
        p_id_taller
    );

    -- Cambiar estado vehículo a mantenimiento
    -- INSERT INTO vehiculo_x_estado(
    --     id_vehiculo,
    --     id_estado_vehiculo,
    --     fecha_estado
    -- )
    -- VALUES(
    --     p_id_vehiculo,
    --     3,
    --     CURRENT_TIMESTAMP
    -- );

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_modificar_mantenimiento(
    IN p_id_mantenimiento INT,
    IN p_fecha_envio DATE,
    IN p_fecha_devolucion DATE,
    IN p_id_vehiculo INT,
    IN p_id_taller INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM mantenimiento
        WHERE id_mantenimiento = p_id_mantenimiento
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación fecha envío
    IF p_fecha_envio IS NULL THEN

        p_codigo := 127;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación fechas
    IF p_fecha_devolucion IS NOT NULL
       AND p_fecha_devolucion < p_fecha_envio THEN

        p_codigo := 128;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación vehículo
    IF NOT EXISTS (
        SELECT 1
        FROM vehiculo
        WHERE id_vehiculo = p_id_vehiculo
    ) THEN

        p_codigo := 114;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación taller
    IF NOT EXISTS (
        SELECT 1
        FROM taller
        WHERE id_taller = p_id_taller
    ) THEN

        p_codigo := 129;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Update
    UPDATE mantenimiento
    SET fecha_envio = p_fecha_envio,
        fecha_devolucion = p_fecha_devolucion,
        id_vehiculo = p_id_vehiculo,
        id_taller = p_id_taller
    WHERE id_mantenimiento = p_id_mantenimiento;

    -- Si volvió del taller → disponible
    IF p_fecha_devolucion IS NOT NULL THEN

        INSERT INTO vehiculo_x_estado(
            id_vehiculo,
            id_estado_vehiculo,
            fecha_estado
        )
        VALUES(
            p_id_vehiculo,
            1,
            CURRENT_TIMESTAMP
        );

    END IF;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_baja_mantenimiento(
    IN p_id_mantenimiento INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM mantenimiento
        WHERE id_mantenimiento = p_id_mantenimiento
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Delete
    DELETE FROM mantenimiento
    WHERE id_mantenimiento = p_id_mantenimiento;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN foreign_key_violation THEN

        p_codigo := 103;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_finalizar_mantenimiento(
    IN p_id_mantenimiento INT,
    IN p_fecha_devolucion DATE,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_vehiculo INT;
    v_fecha_envio DATE;
BEGIN

    -- Validar existencia
    IF NOT EXISTS (
        SELECT 1
        FROM mantenimiento
        WHERE id_mantenimiento = p_id_mantenimiento
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validar fecha devolución
    IF p_fecha_devolucion IS NULL THEN

        p_codigo := 133;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Obtener datos mantenimiento
    SELECT
        id_vehiculo,
        fecha_envio
    INTO
        v_id_vehiculo,
        v_fecha_envio
    FROM mantenimiento
    WHERE id_mantenimiento = p_id_mantenimiento;

    -- Validar fecha
    IF p_fecha_devolucion < v_fecha_envio THEN

        p_codigo := 128;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validar ya finalizado
    IF EXISTS (
        SELECT 1
        FROM mantenimiento
        WHERE id_mantenimiento = p_id_mantenimiento
        AND fecha_devolucion IS NOT NULL
    ) THEN

        p_codigo := 134;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Actualizar mantenimiento
    UPDATE mantenimiento
    SET fecha_devolucion = p_fecha_devolucion
    WHERE id_mantenimiento = p_id_mantenimiento;

    -- Cambiar estado vehículo a disponible
    -- INSERT INTO vehiculo_x_estado(
    --     id_vehiculo,
    --     id_estado_vehiculo,
    --     fecha_estado
    -- )
    -- VALUES(
    --     v_id_vehiculo,
    --     1,
    --     CURRENT_TIMESTAMP
    -- );

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;
-- ----------------------------------------------------
-- Tarifa
CREATE OR REPLACE PROCEDURE sp_alta_tarifa(
    IN p_precio_dia NUMERIC,
    IN p_porcentaje_recargo_hora NUMERIC,
    IN p_id_sucursal INT,
    IN p_id_tipo_vehiculo INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación precio día
    IF p_precio_dia IS NULL
       OR p_precio_dia <= 0 THEN

        p_codigo := 131;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación recargo
    IF p_porcentaje_recargo_hora IS NULL
       OR p_porcentaje_recargo_hora < 0 THEN

        p_codigo := 132;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación sucursal
    IF NOT EXISTS (
        SELECT 1
        FROM sucursal
        WHERE id_sucursal = p_id_sucursal
    ) THEN

        p_codigo := 109;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación tipo vehículo
    IF NOT EXISTS (
        SELECT 1
        FROM tipo_vehiculo
        WHERE id_tipo_vehiculo = p_id_tipo_vehiculo
    ) THEN

        p_codigo := 108;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Insert
    INSERT INTO tarifa(
        precio_dia,
        porcentaje_recargo_hora,
        id_sucursal,
        id_tipo_vehiculo
    )
    VALUES(
        p_precio_dia,
        p_porcentaje_recargo_hora,
        p_id_sucursal,
        p_id_tipo_vehiculo
    );

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN unique_violation THEN

        p_codigo := 101;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

CREATE OR REPLACE PROCEDURE sp_modificar_tarifa(
    IN p_id_tarifa INT,
    IN p_precio_dia NUMERIC,
    IN p_porcentaje_recargo_hora NUMERIC,
    IN p_id_sucursal INT,
    IN p_id_tipo_vehiculo INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- Validación existencia
    IF NOT EXISTS (
        SELECT 1
        FROM tarifa
        WHERE id_tarifa = p_id_tarifa
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación precio día
    IF p_precio_dia IS NULL
       OR p_precio_dia <= 0 THEN

        p_codigo := 131;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación recargo
    IF p_porcentaje_recargo_hora IS NULL
       OR p_porcentaje_recargo_hora < 0 THEN

        p_codigo := 132;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación sucursal
    IF NOT EXISTS (
        SELECT 1
        FROM sucursal
        WHERE id_sucursal = p_id_sucursal
    ) THEN

        p_codigo := 109;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validación tipo vehículo
    IF NOT EXISTS (
        SELECT 1
        FROM tipo_vehiculo
        WHERE id_tipo_vehiculo = p_id_tipo_vehiculo
    ) THEN

        p_codigo := 108;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Update
    UPDATE tarifa
    SET precio_dia = p_precio_dia,
        porcentaje_recargo_hora = p_porcentaje_recargo_hora,
        id_sucursal = p_id_sucursal,
        id_tipo_vehiculo = p_id_tipo_vehiculo
    WHERE id_tarifa = p_id_tarifa;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN unique_violation THEN

        p_codigo := 101;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN foreign_key_violation THEN

        p_codigo := 104;
        p_mensaje := fn_obtener_mensaje(p_codigo);

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

-- Finalizar Alquiler
CREATE OR REPLACE PROCEDURE sp_finalizar_alquiler(
    IN p_id_alquiler INT,
    IN p_fecha_fin_real TIMESTAMP,
    IN p_km_fin INT,
    IN p_sucursal_devolucion INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_fecha_inicio TIMESTAMP;
    v_fecha_fin_prevista TIMESTAMP;
    v_km_inicio INT;
    v_id_vehiculo INT;
    v_id_factura INT;

    v_id_tipo_vehiculo INT;

    v_precio_dia NUMERIC(10,2);
    v_recargo_hora NUMERIC(10,2);

    v_dias_alquiler INT;
    v_horas_recargo INT;

    v_monto_base NUMERIC(10,2);
    v_monto_recargo NUMERIC(10,2);
    v_total NUMERIC(10,2);

    v_estado_actual INT;
BEGIN

    -- Validar existencia alquiler
    IF NOT EXISTS (
        SELECT 1
        FROM alquiler
        WHERE id_alquiler = p_id_alquiler
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Validar fecha fin real
    IF p_fecha_fin_real IS NULL THEN

        p_codigo := 135;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Obtener alquiler
    SELECT
        fecha_inicio,
        fecha_fin_prevista,
        km_inicio,
        id_vehiculo
    INTO
        v_fecha_inicio,
        v_fecha_fin_prevista,
        v_km_inicio,
        v_id_vehiculo
    FROM alquiler
    WHERE id_alquiler = p_id_alquiler;

    -- Validar km
    IF p_km_fin < v_km_inicio THEN

        p_codigo := 136;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Estado actual alquiler
    SELECT id_estado_alquiler
    INTO v_estado_actual
    FROM alquiler_x_estado
    WHERE id_alquiler = p_id_alquiler
    ORDER BY fecha_estado DESC
    LIMIT 1;

    -- Validar activo
    IF v_estado_actual <> 1 THEN

        p_codigo := 137;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Obtener tipo vehículo
    SELECT id_tipo_vehiculo
    INTO v_id_tipo_vehiculo
    FROM vehiculo
    WHERE id_vehiculo = v_id_vehiculo;

    -- Obtener tarifa
    SELECT
        precio_dia,
        porcentaje_recargo_hora
    INTO
        v_precio_dia,
        v_recargo_hora
    FROM tarifa
    WHERE id_tipo_vehiculo = v_id_tipo_vehiculo
    AND id_sucursal = p_sucursal_devolucion
    LIMIT 1;

    -- Validar tarifa
    IF v_precio_dia IS NULL THEN

        p_codigo := 138;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Calcular días
    v_dias_alquiler := CEIL(
        EXTRACT(EPOCH FROM (
            p_fecha_fin_real - v_fecha_inicio
        )) / 86400
    );

    IF v_dias_alquiler <= 0 THEN
        v_dias_alquiler := 1;
    END IF;

    -- Monto base
    v_monto_base := v_dias_alquiler * v_precio_dia;

    -- Horas atraso
    IF p_fecha_fin_real > v_fecha_fin_prevista THEN

        v_horas_recargo := CEIL(
            EXTRACT(EPOCH FROM (
                p_fecha_fin_real - v_fecha_fin_prevista
            )) / 3600
        );

    ELSE

        v_horas_recargo := 0;

    END IF;

    -- Recargo
    v_monto_recargo :=
        (v_precio_dia * (v_recargo_hora / 100))
        * v_horas_recargo;

    -- Total
    v_total := v_monto_base + v_monto_recargo;

    -- Actualizar alquiler
    UPDATE alquiler
    SET fecha_fin_real = p_fecha_fin_real,
        km_fin = p_km_fin,
        sucursal_devolucion = p_sucursal_devolucion
    WHERE id_alquiler = p_id_alquiler;

    -- Estado finalizado
    INSERT INTO alquiler_x_estado(
        id_alquiler,
        id_estado_alquiler,
        fecha_estado
    )
    VALUES(
        p_id_alquiler,
        2,
        CURRENT_TIMESTAMP
    );

    -- Vehículo disponible
    -- INSERT INTO vehiculo_x_estado(
    --     id_vehiculo,
    --     id_estado_vehiculo,
    --     fecha_estado
    -- )
    -- VALUES(
    --     v_id_vehiculo,
    --     1,
    --     CURRENT_TIMESTAMP
    -- );

    -- Crear factura
    INSERT INTO factura(
        fecha_emision,
        monto_base,
        monto_recargo,
        total,
        id_alquiler
    )
    VALUES(
        CURRENT_TIMESTAMP,
        v_monto_base,
        v_monto_recargo,
        v_total,
        p_id_alquiler
    )
    RETURNING id_factura
    INTO v_id_factura;

    -- Detalle base
    INSERT INTO detalle_factura(
        codigo,
        descripcion,
        precio_unitario,
        subtotal,
        id_factura
    )
    VALUES(
        1,
        'Alquiler de vehículo',
        v_precio_dia,
        v_monto_base,
        v_id_factura
    );

    -- Detalle recargo
    IF v_monto_recargo > 0 THEN

        INSERT INTO detalle_factura(
            codigo,
            descripcion,
            precio_unitario,
            subtotal,
            id_factura
        )
        VALUES(
            2,
            'Recargo por atraso',
            v_monto_recargo,
            v_monto_recargo,
            v_id_factura
        );

    END IF;

    p_codigo := 0;
    p_mensaje := fn_obtener_mensaje(p_codigo);

EXCEPTION

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;

-- Reserva a Alquiler
CREATE OR REPLACE PROCEDURE sp_generar_alquiler_desde_reserva(
    IN p_id_reserva INT,
    IN p_km_inicio INT,
    OUT p_codigo INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_fecha_inicio TIMESTAMP;
    v_fecha_fin TIMESTAMP;
    v_sucursal_retiro INT;
    v_sucursal_devolucion INT;
    v_id_cliente INT;
    v_id_vehiculo INT;

    v_estado_reserva INT;
BEGIN

    -- Validar existencia reserva
    IF NOT EXISTS (
        SELECT 1
        FROM reserva
        WHERE id_reserva = p_id_reserva
    ) THEN

        p_codigo := 102;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Estado actual reserva
    SELECT id_estado_reserva
    INTO v_estado_reserva
    FROM reserva_x_estado
    WHERE id_reserva = p_id_reserva
    ORDER BY fecha_estado DESC
    LIMIT 1;

    -- Validar pendiente/confirmada
    IF v_estado_reserva <> 1 THEN

        p_codigo := 139;
        p_mensaje := fn_obtener_mensaje(p_codigo);
        RETURN;

    END IF;

    -- Obtener datos reserva
    SELECT
        fecha_inicio,
        fecha_fin,
        sucursal_retiro,
        sucursal_devolucion,
        id_cliente,
        id_vehiculo
    INTO
        v_fecha_inicio,
        v_fecha_fin,
        v_sucursal_retiro,
        v_sucursal_devolucion,
        v_id_cliente,
        v_id_vehiculo
    FROM reserva
    WHERE id_reserva = p_id_reserva;

    -- Reutilizar alta alquiler
    CALL sp_alta_alquiler(
        v_fecha_inicio,
        v_fecha_fin,
        p_km_inicio,
        v_sucursal_retiro,
        v_sucursal_devolucion,
        p_id_reserva,
        v_id_cliente,
        v_id_vehiculo,
        p_codigo,
        p_mensaje
    );

    -- Si falló
    IF p_codigo <> 0 THEN
        RETURN;
    END IF;

    -- Cambiar estado reserva → finalizada/usada
    INSERT INTO reserva_x_estado(
        id_reserva,
        id_estado_reserva,
        fecha_estado
    )
    VALUES(
        p_id_reserva,
        2,
        CURRENT_TIMESTAMP
    );

EXCEPTION

    WHEN OTHERS THEN

        p_codigo := 500;
        p_mensaje := fn_obtener_mensaje(p_codigo);

END;
$$;