-- Jobs 1: Generación masiva de facturas: Recorrer todos los alquileres finalizados que aún no poseen factura.
CREATE OR REPLACE PROCEDURE jb_generar_facturas_masivas()
LANGUAGE plpgsql
AS $$
DECLARE
    reg RECORD;
    v_contador INT := 0;

    cur CURSOR FOR
        SELECT *
        FROM alquiler
        WHERE fecha_fin_real IS NOT NULL
          AND id_alquiler NOT IN (
                SELECT id_alquiler
                FROM factura
          );
BEGIN

    OPEN cur;

    LOOP

        FETCH cur INTO reg;
        EXIT WHEN NOT FOUND;

        BEGIN

            INSERT INTO factura(
                fecha_emision,
                monto_base,
                monto_recargo,
                total,
                id_alquiler
            )
            VALUES(
                CURRENT_TIMESTAMP,
                1000,
                0,
                1000,
                reg.id_alquiler
            );

            v_contador := v_contador + 1;

            -- Punto de control cada 20 operaciones
            IF v_contador % 20 = 0 THEN
                COMMIT;
                RAISE NOTICE 'Checkpoint: % facturas procesadas',
                    v_contador;
            END IF;

        EXCEPTION
            WHEN OTHERS THEN

                RAISE NOTICE
                    'Error en alquiler %',
                    reg.id_alquiler;

        END;

    END LOOP;

    CLOSE cur;

    -- Guardar las últimas pendientes
    COMMIT;

END;
$$;
-- -------------------------------

-- Jobs 2: Actualización masiva de estados de reservas vencidas: Una reserva ya pasó su fecha de inicio y/o nunca se convirtió en alquiler, entonces se marca automáticamente como vencida.
CREATE OR REPLACE PROCEDURE jb_cancelar_reservas_vencidas()
LANGUAGE plpgsql
AS $$
DECLARE

    reg RECORD;
    v_contador INT := 0;

    cur CURSOR FOR
        SELECT r.id_reserva
        FROM reserva r
        WHERE r.fecha_inicio < CURRENT_TIMESTAMP;

BEGIN

    OPEN cur;

    LOOP

        FETCH cur INTO reg;

        EXIT WHEN NOT FOUND;

        BEGIN

            INSERT INTO reserva_x_estado(
                id_reserva,
                id_estado_reserva,
                fecha_estado
            )
            VALUES(
                reg.id_reserva,
                3,
                CURRENT_TIMESTAMP
            );

            v_contador := v_contador + 1;

            -- Punto de control cada 20 registros
            IF v_contador % 20 = 0 THEN

                COMMIT;

                RAISE NOTICE
                    'Checkpoint alcanzado: % reservas procesadas',
                    v_contador;

            END IF;

        EXCEPTION
            WHEN OTHERS THEN

                RAISE NOTICE
                    'Error en reserva %',
                    reg.id_reserva;

        END;

    END LOOP;

    CLOSE cur;

    -- Confirmar las últimas pendientes
    COMMIT;

END;
$$;
-- -------------------------------