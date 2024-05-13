<%@page import="mundo.GestionarEquipos"%>
<%@page import="mundo.Equipo"%>
<%@page import="java.util.List"%>
<%@include file="lib/header.jsp" %>


<!DOCTYPE html>
<html lang="en">

    <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="#page-top">Inicio</a>
                <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#portfolio">Crear</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#about">Estadios</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#contact">Lista</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <br><br>
        <!-- Masthead-->
        <header class="masthead bg-primary text-white text-center">
            <div class="container d-flex align-items-center flex-column">

                <!-- Imagenes de inicio -->
                <img class="masthead-avatar mb-5 col-lg-12" src="recursos/assets/img/ImgSVG/coparusa.svg" alt="..." />

                <!-- Masthead Heading-->
                <h1 class="masthead-heading text-uppercase mb-0">Copa America</h1>

                <!-- Icon Divider-->
                <div class="divider-custom divider-light">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>

                <!-- Autores en apartado de inicio-->
                <p class="masthead-subheading font-weight-light mb-0">Sergio Morillo - Victor velazquez</p>
                <br><br>
            </div>
        </header>

        <!-- Portfolio Section-->
        <section class="page-section portfolio" id="portfolio">
            <div class="container">
                <br><br>
                <!-- Portfolio Section Heading-->
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">Creación</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <!-- Formularios centrados y control de navegación -->
                <div class="row justify-content-center">
                    <div class="col-md-8 col-lg-8 mb-5">
                        <!-- Formulario de creación de equipo -->
                        <div id="formCrearEquipo">
                            <h5 class="text-center mb-3">Agregar Equipo</h5>
                            <form action="sv_AgregarEquipo" method="post" enctype="multipart/form-data">
                                <!-- Contenido del formulario de creación de equipo -->
                                <div class="mb-3">
                                    <label for="idEquipo">Id:</label>  
                                    <input type="text" name="idEquipo" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="pais">Pais:</label>  
                                    <input type="text" name="pais" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="director">Director:</label>  
                                    <input type="text" name="director" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <input type="file" name="bandera" id="imagen" class="form-control" accept="image/*" required>
                                </div>
                                <div class="d-grid">
                                    <input type="submit" name="agregar" value="Agregar Equipo" class="btn btn-success btn-block">
                                </div>
                            </form>
                            <button class="btn btn-primary btn-block mt-3" onclick="mostrarFormulario('formCrearJugador')">Crear Jugador</button>
                        </div>
                        <!-- Formulario de creación de jugador -->
                        <div id="formCrearJugador" style="display: none;">
                            <h5 class="text-center mb-3">Agregar Jugador</h5>
                            <form action="sv_AgregarJugador" method="post" enctype="multipart/form-data">
                                <!-- Contenido del formulario de creación de jugador -->
                                <div class="mb-3">
                                    <label for="id">Id:</label>  
                                    <input type="text" name="idJugador" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="nombre">Nombre:</label>  
                                    <input type="text" name="nombre" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="marca">Edad:</label>  
                                    <input type="text" name="edad" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="marca">Altura:</label>  
                                    <input type="text" name="altura" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="marca">Peso:</label>  
                                    <input type="text" name="peso" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="marca">Salario:</label>  
                                    <input type="text" name="salario" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="marca">Posición:</label>  
                                    <select name="posicion" class="form-control" required>
                                        <option value="ARQ">ARQ</option>
                                        <option value="DEF">DEF</option>
                                        <option value="CEN">CEN</option>
                                        <option value="DEL">DEL</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="marca">Equipo:</label>  
                                    <select name="Equipo" class="form-control" required>
                                        <option value="Colombia">Colombia</option>
                                        <option value="Argentina">Argentina</option>
                                        <option value="Peru">Perú</option>
                                        <option value="Chile">Chile</option>
                                        <option value="Canada">Canadá</option>
                                        <option value="Ecuador">Ecuador</option>
                                        <option value="Venezuela">Venezuela</option>
                                        <option value="Jamaica">Jamaica</option>
                                        <option value="Estados Unidos">Estados Unidos</option>
                                        <option value="Uruguay">Uruguay</option>
                                        <option value="Panama">Panama</option>
                                        <option value="Bolivia">Bolivia</option>
                                        <option value="Brasil">Brasil</option>
                                        <option value="Paraguay">Paraguay</option>
                                        <option value="Costa Rica">Costa Rica</option>
                                        <option value="Mexico">México</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <input type="file" name="foto" id="imagen" class="form-control" accept="image/*" required>
                                </div>
                                <div class="d-grid">
                                    <input type="submit" name="agregar" value="Agregar Jugador" class="btn btn-success btn-block">
                                </div>
                            </form>
                            <button class="btn btn-primary btn-block mt-3" onclick="mostrarFormulario('formCrearEquipo')">Crear Equipo</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- About Section-->
        <section class="page-section bg-primary text-white mb-0" id="about">
            <div class="container">
                <br><br>
                <!-- About Section Heading-->
                <h2 class="page-section-heading text-center text-uppercase text-white">Estadios</h2>

                <!-- Icon Divider-->
                <div class="divider-custom divider-light">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>

                <!-- Informacion de Estadios -->
                <div class="row">
                    <div class="col-lg-6 ms-auto"><p class="lead">
                            ¡Bienvenidos a la emocionante página oficial de la Copa América! Aquí, en este escenario de pasión y talento futbolístico,
                            te sumergirás en la vibrante atmósfera del torneo más antiguo de selecciones en el mundo. Además, estaremos encantados de 
                            mostrarte algunos de los estadios emblemáticos donde se llevarán a cabo estos emocionantes encuentros. Prepárate para presenciar
                            partidos memorables en lugares llenos de historia y emoción futbolera. ¡La Copa América está a punto de comenzar, y tú estás 
                            invitado a vivir cada momento con nosotros!</p></div>
                    <div id="carouselExampleIndicators" class="carousel slide col-lg-6 me-auto " data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img class="d-block w-100" src="recursos/assets/img/ImgEST/Stadium1.jpg" alt="First slide" style="width: 400px; height: 400px;">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Allegiant Stadium</h5>
                                    <p>Las Vegas, Nevada</p>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img class="d-block w-100" src="recursos/assets/img/ImgEST/Stadium2.jpg" alt="Second slide" style="width: 400px; height: 400px;">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>AT&T Stadium, Arlington</h5>
                                    <p>Texas</p>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Bank of America Stadium, Charlotte</h5>
                                    <p>North Carolina</p>
                                </div>
                                <img class="d-block w-100" src="recursos/assets/img/ImgEST/Stadium3.jpg" alt="Third slide" style="width: 400px; height: 400px;">
                            </div>
                            <div class="carousel-item">
                                <img class="d-block w-100" src="recursos/assets/img/ImgEST/Stadium4.jpg" alt="fourth slide" style="width: 400px; height: 400px;">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Childrens Mercy Park, Kansas City</h5>
                                    <p>Kansas</p>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img class="d-block w-100" src="recursos/assets/img/ImgEST/Stadium5.jpg" alt="five slide" style="width: 400px; height: 400px;">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Exploria Stadium</h5>
                                    <p>Orlando, Florida</p>
                                </div>
                            </div>
                        </div>
                        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev" >
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>

                <!-- link copa America oficial-->
                <div class="text-center mt-4">
                    <a class="btn btn-xl btn-outline-light" href="https://copaamerica.com">
                        <i class="fas fa-download me-2"></i>
                        mas informacion!
                    </a>
                    <br><br>
                </div>
            </div>
        </section>

        <!-- Contact Section-->
        <section class="page-section" id="contact">
            <div class="container">
                <br><br>

                <!-- Contact Section Heading-->
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">Listado de equipos</h2>

                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>

                <!-- Lista de equipos y jugadres -->
                <div class="row justify-content-center"> <!-- Modificado justify-content-start a justify-content-center -->
                    <div class="col-md-8">
                        <div class="card card-body text-center"> <!-- Agregada la clase text-center -->
                            <h5 class="text-center mb-3">Listado de Equipos</h5>
                            <div class="row"> <!-- Nuevo div row para contener los equipos -->
                                <%
                                    GestionarEquipos gesEquipos = new GestionarEquipos();
                                    ServletContext context = request.getServletContext();
                                    gesEquipos.cargarEquiposDesdeArchivo(context);
                                    List<Equipo> misEquipos = gesEquipos.getMisEquipos(context);

                                    if (misEquipos != null) {
                                        int contador = 0; // Variable para contar equipos
                                        for (Equipo equipo : misEquipos) {
                                            if (contador % 3 == 0 && contador != 0) { // Si es múltiplo de 3 y no es el primer equipo, cierra el div row y abre uno nuevo
                                %>
                            </div>
                            <div class="row">
                                <% }%>
                                <div class="col-md-4"> <!-- Cambiado col-md-6 a col-md-4 para que cada equipo ocupe un tercio del ancho en dispositivos medianos -->
                                    <div class="equipo-container mb-4">
                                        <div class="row align-items-center">
                                            <div class="col-md-12 text-center"> <!-- Cambiado col-md-4 a col-md-12 para que ocupe todo el ancho -->
                                                <!-- Aquí va la foto del país -->
                                                <img src="<%= request.getContextPath() + "/" + equipo.getImagenBandera()%>" alt="Bandera de <%= equipo.getPais()%>" class="img-fluid">
                                            </div>
                                            <div class="col-md-12"> <!-- Cambiado col-md-8 a col-md-12 para que ocupe todo el ancho -->
                                                <!-- Aquí va la información del equipo -->
                                                <h6>ID: <%= equipo.getIdEquipo()%></h6>
                                                <p>País: <%= equipo.getPais()%></p>
                                                <p>Director: <%= equipo.getDirector()%></p>
                                                <div class="acciones">
                                                    <a href="#" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#verModal<%= equipo.getIdEquipo()%>"><i class="fa fa-eye"></i></a>
                                                    <a href="#" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#verModal2<%= equipo.getIdEquipo()%>"><i class="fa fa-edit"></i></a>
                                                    <a href="sv_EliminarEquipo?id=<%= equipo.getIdEquipo()%>" class="btn btn-danger" onclick="return confirm('¿Estás seguro de eliminar este equipo?')"><i class="fa fa-trash"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                        contador++;
                                    }
                                } else {
                                %>
                                <div align="center">
                                    <p>No hay equipos registrados</p>
                                </div>
                                <% } %>
                            </div> <!-- Cierre del div row -->
                        </div>
                    </div>
                </div>

                <!-- Enlace a la página de imágenes de equipos -->
                <div class="row justify-content-center mt-4">
                    <div class="col-md-8 text-center">
                        <a href="secondary.jsp">
                            <button class="btn btn-primary">Equipos</button>
                        </a>
                    </div>
                </div>

                <% if (misEquipos != null && !misEquipos.isEmpty()) {
                        for (Equipo e : misEquipos) {
                            String traerImagen = e.getImagenBandera();
                %>
        </section>




        <!-- Modal Ver Equipo -->
        <div class="modal fade" id="verModal<%= e.getIdEquipo()%>" tabindex="-1" aria-labelledby="verModalLabel<%= e.getIdEquipo()%>" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="verModalLabel<%= e.getIdEquipo()%>">Información del Equipo</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>ID: <%= e.getIdEquipo()%></p>
                        <p>Pais: <%= e.getPais()%></p>
                        <p>Director: <%= e.getDirector()%></p>
                        <% if (traerImagen != null && !traerImagen.isEmpty()) {%>
                        <p><img src="<%= request.getContextPath() + "/" + e.getImagenBandera()%>" alt="Imagen de la Bandera" class="img-fluid"></p>
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

        <!-- Modal Editar Equipo -->
        <div class="modal fade" id="verModal2<%= e.getIdEquipo()%>" tabindex="-1" aria-labelledby="verModal2Label<%= e.getIdEquipo()%>" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="verModal2Label<%= e.getIdEquipo()%>">Editar Equipo con ID: <%= e.getIdEquipo()%></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sv_EditarEquipo" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="id" value="<%= e.getIdEquipo()%>">
                            <div class="mb-3">
                                <label for="pais" class="form-label">Pais:</label>
                                <input type="text" name="pais" value="<%= e.getPais()%>" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="director" class="form-label">Director:</label>
                                <input type="text" name="director" value="<%= e.getDirector()%>" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="bandera" class="form-label">Imagen Bandera:</label>
                                <input type="file" name="bandera" id="imagen" class="form-control" accept="image/*">
                            </div>
                            <div class="mb-2">
                                <a href="plantilla.jsp" class="btn btn-success btn-block">Modificar Plantilla</a>
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

        <%
            String mensaje = (String) request.getSession().getAttribute("mensaje");
            if (mensaje != null && !mensaje.isEmpty()) {%>
        <div id="autoToast" class="toast position-fixed bottom-0 end-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header bg-warning text-dark">
                <strong class="me-auto">Notificación</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body bg-secondary text-light">
                <%= mensaje%>
            </div>
        </div>
        <%
                session.removeAttribute("mensaje");
            }
        %>                        
        <script>
            setTimeout(function () {
                autoToast.show();
            }, 0);
        </script>                                    
        <%@include file="lib/footer.jsp" %>
        <!-- Scripts al final del body para mejorar la carga de la página -->
        <!-- jQuery, Popper.js, Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <!-- Script para controlar la navegación entre formularios -->
        <script>
            function mostrarFormulario(idFormulario) {
                document.getElementById('formCrearEquipo').style.display = 'none';
                document.getElementById('formCrearJugador').style.display = 'none';
                document.getElementById(idFormulario).style.display = 'block';
            }
        </script>
    </body>
</html>