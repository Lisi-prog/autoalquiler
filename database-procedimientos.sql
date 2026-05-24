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

    -- Insert
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

    -- Delete
    DELETE FROM vehiculo
    WHERE id_vehiculo = p_id_vehiculo;

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