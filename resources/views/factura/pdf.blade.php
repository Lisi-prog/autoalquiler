<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Factura #{{ $factura->id_factura }}</title>

    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 12px;
            color: #333;
            margin: 30px;
        }

        .header {
            text-align: center;
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0;
            font-size: 24px;
        }

        .header p {
            margin: 5px 0;
        }

        .info {
            width: 100%;
            margin-bottom: 20px;
        }

        .info td {
            padding: 5px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .table th {
            background-color: #4e73df;
            color: white;
            padding: 10px;
            border: 1px solid #ddd;
        }

        .table td {
            padding: 8px;
            border: 1px solid #ddd;
        }

        .text-right {
            text-align: right;
        }

        .totales {
            margin-top: 20px;
            width: 40%;
            margin-left: auto;
        }

        .totales td {
            padding: 6px;
        }

        .totales .label {
            font-weight: bold;
        }

        .totales .total {
            font-size: 16px;
            font-weight: bold;
            border-top: 2px solid #000;
        }

        .footer {
            margin-top: 40px;
            text-align: center;
            color: #777;
            font-size: 10px;
        }
    </style>
</head>
<body>

    <div class="header">
        <h1>FACTURA</h1>
        <p>N° {{ str_pad($factura->id_factura, 8, '0', STR_PAD_LEFT) }}</p>
    </div>

    <table class="info">
        <tr>
            <td>
                <strong>Fecha Emisión:</strong><br>
                {{ \Carbon\Carbon::parse($factura->fecha_emision)->format('d/m/Y H:i') }}
            </td>

            <td>
                <strong>Alquiler:</strong><br>
                #{{ $factura->id_alquiler }}
            </td>
        </tr>
    </table>

    <table class="table">
        <thead>
            <tr>
                <th width="10%">Código</th>
                <th width="50%">Descripción</th>
                <th width="20%">Precio Unitario</th>
                <th width="20%">Subtotal</th>
            </tr>
        </thead>
        <tbody>
            @foreach($factura->detalles as $detalle)
                <tr>
                    <td class="text-right">
                        {{ $detalle->codigo }}
                    </td>

                    <td>
                        {{ $detalle->descripcion }}
                    </td>

                    <td class="text-right">
                        $ {{ number_format($detalle->precio_unitario, 2, ',', '.') }}
                    </td>

                    <td class="text-right">
                        $ {{ number_format($detalle->subtotal, 2, ',', '.') }}
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>

    <table class="totales">
        <tr>
            <td class="label">Monto Base:</td>
            <td class="text-right">
                $ {{ number_format($factura->monto_base, 2, ',', '.') }}
            </td>
        </tr>

        <tr>
            <td class="label">Recargo:</td>
            <td class="text-right">
                $ {{ number_format($factura->monto_recargo, 2, ',', '.') }}
            </td>
        </tr>

        <tr>
            <td class="label total">TOTAL:</td>
            <td class="text-right total">
                $ {{ number_format($factura->total, 2, ',', '.') }}
            </td>
        </tr>
    </table>

    <div class="footer">
        Documento generado automáticamente por el Sistema de Gestión de Alquileres.
    </div>

</body>
</html>