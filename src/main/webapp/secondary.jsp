<%@page import="mundo.GestionarJugadores"%>
<%@page import="mundo.Jugador"%>
<%@page import="mundo.GestionarEquipos"%>
<%@page import="mundo.Equipo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="lib/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Equipos</title>

        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Simple line icons-->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.5.5/css/simple-line-icons.min.css" rel="stylesheet" />
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="recursosTwo/css/styles.css" rel="stylesheet" />

        <!-- Estilos personalizados -->
        <style>
            .masthead {
                background-image: url('recursos/assets/img/ImgSVG/copa-america.jpg');
                /* Otras propiedades de estilo para el encabezado */
            }

            .callout {
                background-image: url('recursos/assets/img/ImgSVG/imagenenequipos.jpg');
                /* Otras propiedades de estilo para la sección callout */
            }

            .bordered-box {
                border: 1px solid #007bff; /* Color del borde */
                padding: 20px; /* Espacio interior */
                border-radius: 5px; /* Bordes redondeados */
                margin: 10px 0; /* Espacio exterior */
            }
        </style>
    </head>
    <body id="page-top">
        <!-- Opciones en el navegador -->
        <nav class="navbar navbar-expand-lg bg-primary text-uppercase fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="primary.jsp">Inicio</a>
                <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu <i class="fas fa-bars"></i>
                </button>
            </div>
        </nav>
        <!-- Header-->
        <header class="masthead d-flex align-items-center">
            <div class="container px-4 px-lg-5 text-center">
                <h1 class="mb-1">Informacion de equipos</h1>
                <h3 class="mb-5"><em>revisa toda la informacion sobre los diferentes equipos</em></h3>
                <a class="btn btn-primary btn-outline-dark" href="https://copaamerica.com">
                    <i class="fas fa-download me-2"></i>
                    Justo Aqui!
                </a>
            </div>
        </header>
        <br><br>

        <!-- Desplegable para escoger equipo -->
        <div class="container text-center" id="lista">
            <select id="selectEquipo" class="form-select mb-3 border border-primary mx-auto" aria-label="Seleccionar equipo" style="width: auto;">
                <option selected disabled>Selecciona un equipo</option>
                <%
                    ServletContext context = getServletContext();
                    GestionarEquipos gestionarEquipos = new GestionarEquipos();
                    List<Equipo> equipos = gestionarEquipos.getMisEquipos(context);
                    for (Equipo equipo : equipos) {
                %>
                <option value="<%= equipo.getIdEquipo()%>"><%= equipo.getPais()%></option>
                <%
                    }
                %>
            </select>
        </div>

        <div class="container">
            <!-- Columnas para mostrar jugadores e información -->
            <div class="row">
                <!-- Columna izquierda: Jugadores -->
                <div class="col-lg-6 text-center bordered-box">
                    <h3>Jugadores filtrados</h3>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Edad</th>
                                <th>Posición</th>
                                <th>Salario</th>
                                <th>Ver</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                GestionarJugadores gestionarJugadores = new GestionarJugadores();
                                List<Jugador> jugadores = gestionarJugadores.getMisJugadores(context);
                                for (Jugador jugador : jugadores) {
                            %>
                            <tr class="jugador" data-equipo="<%= jugador.getIdEquipo()%>">
                                <td><%= jugador.getNombre()%></td>
                                <td><%= jugador.getEdad()%></td>
                                <td><%= jugador.getPosicion()%></td>
                                <td><%= jugador.getSalario()%></td>
                                <td>
                                    <a href="#" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#verModal<%= jugador.getIdJugador()%>"><i class="fa fa-eye"></i></a>
                                    <a href="#" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#verModal2<%= jugador.getIdJugador()%>"><i class="fa fa-edit"></i></a>
                                    <a href="sv_EliminarJugador?id=<%= jugador.getIdJugador()%>" class="btn btn-danger" onclick="return confirm('¿Estás seguro de eliminar este jugador?')"><i class="fa fa-trash"></i></a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                            
                </div>

                <!-- Columna derecha: Información del Jugador -->
                <div class="col-lg-6 text-center bordered-box">
                    <h3>Jugadores Copa America 2024</h3>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Edad</th>
                                <th>Altura</th>
                                <th>Peso</th>
                                <th>Salario</th>
                                <th>Posición</th>
                                <th>Foto</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Jugador jugador : jugadores) {
                                    String traerImagen = jugador.getFoto();
                            %>
                            <tr class="jugador-info" data-equipo="<%= jugador.getIdEquipo()%>">
                                <td><%= jugador.getIdJugador()%></td>
                                <td><%= jugador.getNombre()%></td>
                                <td><%= jugador.getEdad()%></td>
                                <td><%= jugador.getAltura()%></td>
                                <td><%= jugador.getPeso()%></td>
                                <td><%= jugador.getSalario()%></td>
                                <td><%= jugador.getPosicion()%></td>
                                <td>
                                    <% if (traerImagen != null && !traerImagen.isEmpty()) {%>
                                    <img src="<%= request.getContextPath() + "/" + traerImagen%>" alt="Imagen del Jugador" class="img-fluid" style="width: 50px; height: auto;">
                                    <% } else { %>
                                    <p>No hay imagen disponible</p>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Modales para ver y editar jugadores -->
        <% if (jugadores != null && !jugadores.isEmpty()) {
                for (Jugador jugador : jugadores) {
                    String traerImagen = jugador.getFoto();
        %>    
        <!-- Modal Ver Jugador -->
        <div class="modal fade" id="verModal<%= jugador.getIdJugador()%>" tabindex="-1" aria-labelledby="verModalLabel<%= jugador.getIdJugador()%>" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="verModalLabel<%= jugador.getIdJugador()%>">Información del Jugador</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>ID: <%= jugador.getIdJugador()%></p>
                        <p>Nombre: <%= jugador.getNombre()%></p>
                        <p>Edad: <%= jugador.getEdad()%> años</p>
                        <p>Altura: <%= jugador.getAltura()%> mts</p>
                        <p>Peso: <%=jugador.getPeso()%> kg</p>
                        <p>Posición: <%=jugador.getPosicion()%></p>
                        <p>Salario: <%=jugador.getSalario()%> $E</p>

                        <% if (traerImagen != null && !traerImagen.isEmpty()) {%>
                        <p><img src="<%= request.getContextPath() + "/" + jugador.getFoto()%>" alt="Imagen del Jugador" class="img-fluid"></p>
                            <% } else { %>
                        <p>No hay imagen disponible</p>
                        <% }%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal Editar Jugador -->
        <div class="modal fade" id="verModal2<%= jugador.getIdJugador()%>" tabindex="-1" aria-labelledby="verModal2Label<%= jugador.getIdJugador()%>" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="verModal2Label<%= jugador.getIdJugador()%>">Editar Jugador con ID: <%= jugador.getIdJugador()%></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sv_EditarJugador" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="id" value="<%= jugador.getIdJugador()%>">
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre:</label>
                                <input type="text" name="nombre" value="<%= jugador.getNombre()%>" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="edad" class="form-label">Edad:</label>
                                <input type="text" name="edad" value="<%= jugador.getEdad()%>" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="altura" class="form-label">Altura:</label>
                                <input type="text" name="altura" value="<%= jugador.getAltura()%>" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="peso" class="form-label">Peso:</label>
                                <input type="number" name="peso" value="<%= jugador.getPeso()%>" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="salario" class="form-label">Salario:</label>
                                <input type="text" name="salario" value="<%= jugador.getSalario()%>" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="posicion" class="form-label">Posición:</label>
                                <input type="text" name="posicion" value="<%= jugador.getPosicion()%>" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="foto" class="form-label">Foto:</label>
                                <input type="file" name="foto" id="imagen" class="form-control" accept="image/*">
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-success btn-block">Guardar Cambios</button>
                                <button type="button" class="btn btn-danger btn-block" data-bs-dismiss="modal">Cancelar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>

        <!-- Footer -->
        <section class="page-section bg-primary text-white mb-0" id="about">
            <div class="container">
                <!-- About Section Heading-->
                <h2 class="page-section-heading text-center text-uppercase text-white">Salarios</h2>
                <!-- Icon Divider-->
                <div class="divider-custom divider-light">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <!-- About Section Content-->
                <div class="row">
                    <div class="col-lg-4 ms-auto"><p class="lead">Esta es una lista de los jugadores que participarán en la Copa América 2024 con su respectivo director técnico que harán parte de esta fiesta de fútbol.</p></div>
                    <div class="col-lg-4 me-auto"><p class="lead">Si alguien tiene o requiere algún tipo de consulta sobre el salario de los jugadores, ¡con gusto hicimos un apartado especialmente para ello!</p></div>
                </div>
                <!-- About Section Button-->
                <div class="text-center mt-4">
                    <a class="btn btn-xl btn-outline-light" href="#" data-bs-toggle="modal" data-bs-target="#salarioModal">
                        <i class="fas fa-download me-2"></i>
                        Calcular Salario!
                    </a>
                </div>
            </div>
            <br><br>
        </section>

        <!-- Modal Calcular Salario -->
        <div class="modal fade" id="salarioModal" tabindex="-1" aria-labelledby="salarioModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="salarioModalLabel">Calcular Salario Anual del Jugador</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="mb-3">
                                <label for="jugador" class="form-label">Jugador</label>
                                <select id="jugador" class="form-select">
                                    <option selected disabled>Selecciona un jugador</option>
                                    <%
                                        for (Jugador jugador : jugadores) {
                                    %>
                                    <option value="<%= jugador.getIdJugador()%>"><%= jugador.getNombre()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="salario" class="form-label">Salario Mensual</label>
                                <input type="number" class="form-control" id="salario" placeholder="Salario mensual">
                            </div>
                            <div class="mb-3">
                                <label for="meses" class="form-label">Meses a calcular</label>
                                <input type="number" class="form-control" id="meses" placeholder="Número de meses">
                            </div>
                            <div class="mb-3">
                                <button type="button" class="btn btn-primary" onclick="calcularSalario()">Calcular</button>
                            </div>
                        </form>
                        <div id="resultado"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>



        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="recursosTwo/js/scripts.js"></script>

        <!-- JavaScript para filtrar jugadores -->
        <script>
                                    function filtrarJugadores() {
                                        var selectEquipo = document.getElementById("selectEquipo");
                                        var selectedEquipoId = selectEquipo.value;
                                        var jugadores = document.getElementsByClassName("jugador");

                                        // Ocultar todos los jugadores
                                        for (var i = 0; i < jugadores.length; i++) {
                                            jugadores[i].style.display = "none";
                                        }

                                        // Mostrar solo los jugadores del equipo seleccionado y calcular el salario total
                                        var jugadoresEquipo = document.querySelectorAll("[data-equipo='" + selectedEquipoId + "']");
                                        var salarioTotal = 0;
                                        for (var j = 0; j < jugadoresEquipo.length; j++) {
                                            jugadoresEquipo[j].style.display = "";
                                            var salario = parseFloat(jugadoresEquipo[j].getAttribute("data-salario"));
                                            if (!isNaN(salario)) {
                                                salarioTotal += salario;
                                            }
                                        }

                                        // Actualizar el texto con el salario total
                                        document.getElementById("totalSalario").innerText = salarioTotal.toFixed(2);
                                    }

                                    // Agregar un listener para detectar cambios en la selección del desplegable
                                    document.getElementById("selectEquipo").addEventListener("change", filtrarJugadores);

                                    // Filtrar los jugadores cuando se cargue la página
                                    window.onload = function () {
                                        if (document.getElementById("selectEquipo").value !== "Selecciona un equipo") {
                                            filtrarJugadores();
                                        }
                                    };
        </script>   

        <script>
            function calcularSalario() {
                const salario = document.getElementById('salario').value;
                const meses = document.getElementById('meses').value;
                const resultado = salario * meses;
                document.getElementById('resultado').innerText = 'El salario total es: $' + resultado;
            }
        </script>
        <%@include file="lib/footer.jsp" %>
    </body>
</html>