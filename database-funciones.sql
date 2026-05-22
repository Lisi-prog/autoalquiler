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
