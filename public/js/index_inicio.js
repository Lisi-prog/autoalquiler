$(document).ready(function () { 
    
    document.getElementById("form-buscar-vehiculos").addEventListener("submit", function(event) {
        event.preventDefault();
        let sucReti = document.getElementById("sucursal_retiro").value;
        let sucDevo = document.getElementById("sucursal_devolucion").value;
        let fecIni = document.getElementById("fecha_retiro").value;
        let fecFin = document.getElementById("fecha_devolucion").value;
        let opMismaOfi = document.getElementById("mismaOficina").value;

        if (sucReti === "" && sucDevo === "" && fecIni === "" && fecFin === "") {
            alert("Debes completar al menos un campo.");
            event.preventDefault(); // Evita el envío del formulario
        }else{
            event.preventDefault();

            var url_php = $(this).attr("action"); 
            var type_method = $(this).attr("method"); 
            var form_data = $(this).serialize();
            let html = '';

            let divResult = document.getElementById('row-result-vehiculo');

            let bdResult = document.getElementById('');
           
            $("#loading").show();

            $.ajax({
                type: type_method,
                url: url_php,
                data: form_data,
                timeout: 60000, // 60 segundos de espera
                success: function(res) {
                    console.log(res);

                    divResult.hidden = false;

                    res.forEach(e => {
                        let ft = '';

                        e.fotos.forEach((ele, index) => {
                            ft += `
                                <div class="carousel-item ${index === 0 ? 'active' : ''}">
                                    <img src="${ele.ruta ?? '/img/sin-imagen.png'}"
                                        class="d-block w-100"
                                        alt="Sin Imagen">
                                </div>`;
                        });

                        html += `<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 mb-3">
                                    <div class="card shadow-sm mb-3">
                                        <div class="card-body">
                                            <div class="row align-items-center">
                                                <!-- Imagen -->
                                                <div id="carouselExampleControls${e.id_vehiculo}" class="col-md-2 text-center carousel slide" data-ride="carousel">
                                                    <div class="carousel-inner">
                                                        ${ft}
                                                    </div>
                                                    <a class="carousel-control-prev"
                                                    href="#carouselExampleControls${e.id_vehiculo}"
                                                    role="button"
                                                    data-slide="prev"><span class="carousel-control-prev-icon"></span>
                                                    </a>

                                                    <a class="carousel-control-next"
                                                    href="#carouselExampleControls${e.id_vehiculo}"
                                                    role="button"
                                                    data-slide="next"> <span class="carousel-control-next-icon"></span>
                                                    </a>
                                                </div>

                                                <!-- Datos principales -->
                                                <div class="col-md-5">
                                                    <h2 class="font-weight-bold mb-2">
                                                        ${e.marca} ${e.modelo}
                                                    </h2>

                                                    <div class="row mt-3">
                                                        <div class="col-6">
                                                            <p class="mb-1">
                                                                <i class="fas fa-info-circle"></i>
                                                                ${e.detalle_confort}
                                                            </p>
                                                        </div>
                                                    </div>

                                                    <div class="row mt-3">
                                                        <div class="col-6">
                                                            <p class="mb-1">
                                                                <i class="fas fa-lightbulb"></i>
                                                                ${e.tipo}
                                                            </p>
                                                        </div>
                                                    </div>

                                                    <hr>

                                                    <div>
                                                        <strong>Sucursal</strong>
                                                        <span class="ml-3">
                                                            ${e.sucursal}, ${e.departamento_sucursal}
                                                        </span>
                                                    </div>
                                                </div>

                                                <!-- Beneficios -->
                                                <div class="col-md-3 border-left">
                                                    <ul class="list-unstyled mb-0">
                                                        <li>
                                                            <i class="fas fa-star text-warning"></i>
                                                            Kilometraje ilimitado
                                                        </li>

                                                        <li>
                                                            <i class="fas fa-star text-warning"></i>
                                                            Seguro colisión (CDW)
                                                        </li>

                                                        <li>
                                                            <i class="fas fa-star text-warning"></i>
                                                            Seguro robo
                                                        </li>
                                                    </ul>
                                                </div>

                                                <!-- Precio -->
                                                <div class="col-md-2 text-center border-left">
                                                    <h1 class="font-weight-bold text-dark">
                                                        $ ${e.total}
                                                    </h1>

                                                    <button class="btn btn-lg btn-primary btn-block mt-3">
                                                        Reservar
                                                    </button>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>`;
                    });

                    divResult.innerHTML = html;
                },
                complete: function() {
                    $("#loading").hide(); // Oculta el loader cuando termina
                },
                error: function(jqXHR, textStatus) {
                    $("#loading").hide(); // Oculta el loader cuando termina
                    if (textStatus === "timeout") {
                        alert("La busqueda de vehiculos demoró demasiado y fue cancelada.");
                    } else {
                        alert("Error en la solicitud: " + textStatus);
                    }
                }
            });
        }
    });
});