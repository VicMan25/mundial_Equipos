<%@page import="mundo.Equipo"%>
<%@page import="mundo.Jugador"%>
<%@page import="java.util.List"%>
<%@include file="lib/header.jsp" %>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Mundial de Futbol</a>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Regresar al Inicio</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container p-4">
    <div class="card card-body">
        <h1 class="text-center mb-4">Mundial de Futbol</h1> <!-- Titulo  -->
        <div class="row">
            <!-- Columna izquierda -->
            <div class="col-md-4">
                <div class="card card-body">
                    <h5 class="text-center mb-3">Agregar Jugador</h5> 
                    <form action="sv_AgregarJugador" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="id">Id:</label>  
                            <input type="text" name="idJugador" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="placa">Nombre:</label>  
                            <input type="text" name="nombre" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="marca">Edad:</label>  
                            <input type="text" name="edad" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="marca">Altura</label>  
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
                            <input type="text" name="posicion" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <input type="file" name="foto" id="imagen" class="form-control" accept="image/*" required>
                        </div>
                        <div class="d-grid">
                            <input type="submit" name="agregar" value="Agregar Jugador" class="btn btn-success btn-block">
                        </div>
                    </form>
                </div>
            </div>
            <!-- Columna derecha -->
            <div class="col-md-8">
                <div class="card card-body">
                    <h5 class="text-center mb-3">Listado de Jugadores</h5>
                    <table class="table table-striped" style="margin: 0 auto;">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>NOMBRE</th>
                                <th>EDAD</th>
                                <th>POSICIÓN</th>
                                <th>ACCIONES</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Jugador> listaJugadores = (List<Jugador>) request.getSession().getAttribute("listaJugadores");
                                if (listaJugadores != null && !listaJugadores.isEmpty()) {
                                    for (Jugador j : listaJugadores) {%>
                            <tr>
                                <td><%= j.getIdJugador()%></td>
                                <td><%= j.getNombre()%></td>
                                <td><%= j.getEdad()%></td>
                                <td><%= j.getPosicion()%></td>
                                <td>
                                    <a href="#" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#verModa3<%= j.getIdJugador()%>"><i class="fa fa-eye"></i></a>
                                    <a href="#" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#verModal2<%= j.getIdJugador()%>"><i class="fa fa-edit"></i></a>
                                    <a href="sv_EliminarJugador?id=<%= j.getIdJugador()%>" class="btn btn-danger" onclick="return confirm('¿Estás seguro de eliminar este jugador?')"><i class="fa fa-trash"></i></a>
                                </td>
                            </tr>
                            <% }
                            } else { %>
                            <tr align="center">
                                <td colspan="6">No hay jugadores en este equipo.</td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>

<% if (listaJugadores != null && !listaJugadores.isEmpty()) {
        for (Jugador j : listaJugadores) {
            String traerImagen = j.getFoto();
%>                      
<div class="modal fade" id="verModa3<%= j.getIdJugador()%>" tabindex="-1" aria-labelledby="verModalLabel<%= j.getIdJugador()%>" aria-hidden="true">
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
                <% if (traerImagen != null && !traerImagen.isEmpty()) {%>
                <p><img src="<%= request.getContextPath() + "/" + j.getFoto()%>" alt="Foto del jugador" class="img-fluid"></p>
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
    <div class="modal fade" id="verModal2<%= j.getIdJugador()%>" tabindex="-1" aria-labelledby="verModal2Label<%= j.getIdJugador()%>" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="verModal2Label<%= j.getIdJugador()%>">Editar Jugador con ID: <%= j.getIdJugador()%></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="sv_EditarJugador" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="idJugador" value="<%= j.getIdJugador() %>">
                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre:</label>
                            <input type="text" name="nombre" value="<%= j.getNombre() %>" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="edad" class="form-label">Edad:</label>
                            <input type="text" name="edad" value="<%= j.getEdad() %>" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="altura" class="form-label">Altura:</label>
                            <input type="text" name="altura" value="<%= j.getAltura() %>" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="peso" class="form-label">Peso:</label>
                            <input type="text" name="peso" value="<%= j.getPeso() %>" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="salario" class="form-label">Salario:</label>
                            <input type="text" name="salario" value="<%= j.getSalario() %>" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="posicion" class="form-label">Posición:</label>
                            <input type="text" name="posicion" value="<%= j.getPosicion() %>" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="foto" class="form-label">Foto del jugador:</label>
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

<%
    List<Equipo> listaEquipos = (List<Equipo>) request.getSession().getAttribute("listaEquipos");
    if (listaEquipos != null && !listaEquipos.isEmpty()) {
        for (Equipo e : listaEquipos) {%>
<div class="container mt-4">
    <div class="alert alert-success text-center" role="alert">
        <h1><%= e.getPais()%></h1>
    </div>
</div>

<% }
    } %>


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
        var autoToast = new bootstrap.Toast(document.getElementById('autoToast'));
        autoToast.show();
    }, 0);
</script>

<%@include file="lib/footer.jsp" %>
