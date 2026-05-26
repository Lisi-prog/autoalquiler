CREATE OR REPLACE FUNCTION fn_alquileres_vencidos()
RETURNS TABLE (
    id_alquiler INT,
    id_vehiculo INT,
    patente VARCHAR,
    fecha_fin_prevista TIMESTAMP,
    horas_atraso NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN

    RETURN QUERY
    SELECT
        a.id_alquiler,
        v.id_vehiculo,
        v.patente,
        a.fecha_fin_prevista,

        ROUND(
            EXTRACT(EPOCH FROM (
                CURRENT_TIMESTAMP - a.fecha_fin_prevista
            )) / 3600,
            2
        ) AS horas_atraso

    FROM alquiler a
    INNER JOIN vehiculo v
        ON v.id_vehiculo = a.id_vehiculo

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