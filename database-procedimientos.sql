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