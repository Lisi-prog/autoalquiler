-- Jobs 1: Generación masiva de facturas: Recorrer todos los alquileres finalizados que aún no poseen factura.
CREATE OR REPLACE PROCEDURE jb_generar_facturas_masivas()
LANGUAGE plpgsql
AS $$
DECLARE
    reg RECORD;

    v_monto_base NUMERIC(10,2);
    v_monto_recargo NUMERIC(10,2);
    v_total NUMERIC(10,2);

    v_id_factura INT;

    v_contador INT := 0;

    cur CURSOR FOR
        SELECT a.id_alquiler
        FROM alquiler a
        WHERE a.fecha_fin_real IS NOT NULL
          AND NOT EXISTS (
                SELECT 1
                FROM factura f
                WHERE f.id_alquiler = a.id_alquiler
          );
BEGIN

    OPEN cur;

    LOOP

        FETCH cur INTO reg;
        EXIT WHEN NOT FOUND;

        BEGIN

            -- Obtener importes calculados
            SELECT
                monto_base,
                monto_recargo,
                total
            INTO
                v_monto_base,
                v_monto_recargo,
                v_total
            FROM fn_calcular_factura_alquiler(
                reg.id_alquiler
            );

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
                reg.id_alquiler
            )
            RETURNING id_factura
            INTO v_id_factura;

            -- Detalle alquiler
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
                v_monto_base,
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

            v_contador := v_contador + 1;

            -- Checkpoint cada 20 facturas
            IF MOD(v_contador, 20) = 0 THEN

                COMMIT;

                RAISE NOTICE
                    'Checkpoint: % facturas generadas',
                    v_contador;

            END IF;

        EXCEPTION
            WHEN OTHERS THEN

                RAISE NOTICE
                    'Error al generar factura para alquiler %',
                    reg.id_alquiler;

        END;

    END LOOP;

    CLOSE cur;

    COMMIT;

    RAISE NOTICE
        'Proceso finalizado. Facturas generadas: %',
        v_contador;

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