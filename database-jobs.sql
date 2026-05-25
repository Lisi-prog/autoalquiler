CREATE OR REPLACE PROCEDURE sp_verificar_alquileres_vencidos()
LANGUAGE plpgsql
AS $$
BEGIN

    INSERT INTO alquiler_x_estado(
        id_alquiler,
        id_estado_alquiler,
        fecha_estado
    )
    SELECT
        a.id_alquiler,
        3,
        CURRENT_TIMESTAMP
    FROM alquiler a
    WHERE a.fecha_fin_prevista < CURRENT_TIMESTAMP
    AND a.fecha_fin_real IS NULL
    AND (
        SELECT axe.id_estado_alquiler
        FROM alquiler_x_estado axe
        WHERE axe.id_alquiler = a.id_alquiler
        ORDER BY axe.fecha_estado DESC
        LIMIT 1
    ) = 1;

END;
$$;