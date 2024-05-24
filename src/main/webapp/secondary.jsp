<%-- 
    Document   : secondary
    Created on : 7/05/2024, 12:08:20 a. m.
    Author     : darka
--%>

<%@page import="mundo.GestionarJugadores"%>
<%@page import="mundo.Jugador"%>
<%@page import="mundo.GestionarEquipos"%>
<%@page import="mundo.Equipo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <a class="menu-toggle rounded" href="#"><i class="fas fa-bars"></i></a>
        <nav id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li class="sidebar-brand"><a href="primary.jsp">Primary</a></li>
                <li class="sidebar-nav-item"><a href="plantilla.jsp">plantilla</a></li>
                <li class="sidebar-nav-item"><a href="#about">Visualización</a></li>
                <li class="sidebar-nav-item"><a href="#services">Services</a></li>
                <li class="sidebar-nav-item"><a href="#portfolio">Portfolio</a></li>
                <li class="sidebar-nav-item"><a href="#contact">Contact</a></li>
            </ul>
        </nav>
        <!-- Header-->
        <header class="masthead d-flex align-items-center">
            <div class="container px-4 px-lg-5 text-center">
                <h1 class="mb-1">Informacion de equipos</h1>
                <h3 class="mb-5"><em>revisa toda la informacion sobre los diferentes equipos</em></h3>
                <a class="btn btn-success btn-xl" href="#about">Click Aqui!!</a>
            </div>
        </header>
        <br><br>

        <!-- Desplegable para escoger equipo -->
        <div class="container text-center">
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
                    <h3>Jugadores</h3>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Edad</th>
                                <th>Posición</th>
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
            </div>
        </div>

        <!-- Modales -->
        <%
            for (Jugador jugador : jugadores) {
                String traerImagen = jugador.getFoto();
        %>
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
                        <p>Edad: <%= jugador.getEdad()%></p>
                        <p>ID del Equipo: <%= jugador.getIdEquipo()%></p>
                        <!-- Agrega aquí el resto de los datos del jugador -->
                        <% if (traerImagen != null && !traerImagen.isEmpty()) {%>
                        <p><img src="<%= request.getContextPath() + "/" + jugador.getFoto()%>" alt="Imagen del Jugador" class="img-fluid"></p>
                            <% } else { %>
                        <p>No hay imagen disponible</p>
                        <% } %>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
        <%
            GestionarJugadores gesJugadores = new GestionarJugadores();
            ServletContext context1 = request.getServletContext();
            gesJugadores.cargarJugadoresDesdeArchivo(context1);
            List<Jugador> misJugadores = gesJugadores.getMisJugadores(context1);
        %>
        <% if (misJugadores != null && !misJugadores.isEmpty()) {
                for (Jugador j : misJugadores) {
                    String traerImagen = j.getFoto();
        %>                      
        <div class="modal fade" id="verModal3<%= j.getIdJugador()%>" tabindex="-1" aria-labelledby="verModalLabel<%= j.getIdJugador()%>" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="verModalLabel<%= j.getIdJugador()%>">Información del Jugador</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>ID: <%= j.getIdJugador()%></p>
                        <p>Nombre: <%= j.getNombre()%></p>
                        <p>Edad: <%= j.getEdad()%> años</p>
                        <p>Altura: <%= j.getAltura()%> m</p>
                        <p>Peso: <%= j.getPeso()%> Kg</p>
                        <p>Salario: <%= j.getSalario()%></p>
                        <p>Posición: <%= j.getPosicion()%></p>
                        <p>Id Equipo: <%= j.getIdEquipo()%></p>
                        <% if (traerImagen != null && !traerImagen.isEmpty()) {%>
                        <p><img src="<%= request.getContextPath() + "/" + j.getFoto()%>" alt="Foto del jugador" class="img-fluid"></p>
                            <% } else { %>
                        <p>No hay imagen disponible</p>
                        <% } %>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>

        <!-- Footer -->

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

                                            // Mostrar solo los jugadores del equipo seleccionado
                                            var jugadoresEquipo = document.querySelectorAll("[data-equipo='" + selectedEquipoId + "']");
                                            for (var j = 0; j < jugadoresEquipo.length; j++) {
                                                jugadoresEquipo[j].style.display = "";
                                            }
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
    </body>
</html>