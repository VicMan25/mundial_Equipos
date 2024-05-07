<%@ page import="java.util.List" %>
<%@ page import="mundo.GestionarEquipos" %>
<%@ page import="mundo.Equipo" %>
<%@ page import="java.io.IOException" %>
<%@include file="lib/header.jsp" %>

<div class="container p-4">
    <div class="card card-body">
        <h1 class="text-center mb-4">Mundial de Futbol</h1>
        <div class="row">
            <div class="col-md-4">
                <div class="card card-body">
                    <h5 class="text-center mb-3">Agregar Equipo</h5> 
                    <form action="sv_AgregarEquipo" method="post" enctype="multipart/form-data">
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
                </div>
            </div>
            <div class="col-md-8">
                <div class="card card-body">
                    <h5 class="text-center mb-3">Listado de Equipos</h5>
                    <table class="table table-striped" style="margin: 0 auto;">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>PAIS</th>
                                <th>DIRECTOR</th>
                                <th>ACCIONES</th>
                            </tr>
                        </thead>
                        <%
                        GestionarEquipos gesEquipos = new GestionarEquipos();
                        ServletContext context = request.getServletContext();
                        gesEquipos.cargarEquiposDesdeArchivo(context);
                        List<Equipo> misEquipos = gesEquipos.getMisEquipos(context);

                        if (misEquipos != null) {
                            for (Equipo equipo : misEquipos) {
                        %>
                        <tr>
                            <td><%= equipo.getIdEquipo() %></td>
                            <td><%= equipo.getPais() %></td>
                            <td><%= equipo.getDirector() %></td>
                            <td>
                                <a href="#" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#verModal<%= equipo.getIdEquipo() %>"><i class="fa fa-eye"></i></a>
                                <a href="#" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#verModal2<%= equipo.getIdEquipo() %>"><i class="fa fa-edit"></i></a>
                                <a href="sv_EliminarEquipo?id=<%= equipo.getIdEquipo() %>" class="btn btn-danger" onclick="return confirm('¿Estás seguro de eliminar este equipo?')"><i class="fa fa-trash"></i></a>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr align="center">
                            <td colspan="4">No hay equipos registrados</td>
                        </tr>
                        <%
                        }
                        %>
                    </table>

                </div>
            </div>
        </div>
    </div>
</div>

<% if (misEquipos != null && !misEquipos.isEmpty()) {
    for (Equipo e : misEquipos) {
        String traerImagen = e.getImagenBandera(); 
%>
<div class="modal fade" id="verModal<%= e.getIdEquipo() %>" tabindex="-1" aria-labelledby="verModalLabel<%= e.getIdEquipo() %>" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="verModalLabel<%= e.getIdEquipo() %>">Información del Equipo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>ID: <%= e.getIdEquipo() %></p>
                <p>Pais: <%= e.getPais() %></p>
                <p>Director: <%= e.getDirector() %></p>
                <% if (traerImagen != null && !traerImagen.isEmpty()) { %>
                <p><img src="<%= request.getContextPath() + "/" + e.getImagenBandera()%>" alt="Imagen de la Bandera" class="img-fluid"></p>
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

<div class="modal fade" id="verModal2<%= e.getIdEquipo()%>" tabindex="-1" aria-labelledby="verModal2Label<%= e.getIdEquipo()%>" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="verModal2Label<%= e.getIdEquipo()%>">Editar Equipo: <%= e.getPais()%></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="sv_EditarEquipo" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="idEquipo">ID:</label>
                        <input type="text" class="form-control" id="id" name="id" value="<%= e.getIdEquipo()%>" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="pais">Pais:</label>
                        <input type="text" class="form-control" id="pais" name="pais" value="<%= e.getPais()%>">
                    </div>
                    <div class="mb-3">
                        <label for="director">Director:</label>
                        <input type="text" class="form-control" id="director" name="director" value="<%= e.getDirector()%>">
                    </div>
                    <div class="mb-3">
                        <label for="bandera">Imagen de Bandera:</label>
                        <input type="file" class="form-control" id="bandera" name="bandera">
                    </div>
                    <div class="mb-2">
                        <a href="plantilla.jsp" class="btn btn-success btn-block">Modificar Plantilla Del Equipo</a>
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                </form>
            </div>
        </div>
    </div>
</div>

<% } } %>

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
