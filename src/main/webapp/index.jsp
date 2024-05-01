<%@page import="mundo.Equipo"%>
<%@page import="java.util.List"%>
<%@include file="lib/header.jsp" %>


<div class="container p-4">
    <div class="card card-body">
        <h1 class="text-center mb-4">Mundial de Futbol</h1> <!-- Titulo  -->
        <div class="row">
            <!-- Columna izquierda -->
            <div class="col-md-4">
                <div class="card card-body">
                    <h5 class="text-center mb-3">Agregar Equipo</h5> 
                    <form action="sv_AgregarEquipo" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="id">Id:</label>  
                            <input type="text" name="idEquipo" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="placa">Pais:</label>  
                            <input type="text" name="pais" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="marca">Director</label>  
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
            <!-- Columna derecha -->
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
                        <tbody>
                            <%
                            List<Equipo> listaEquipos = (List<Equipo>) request.getSession().getAttribute("listaEquipos");
                                    if (listaEquipos != null && !listaEquipos.isEmpty()) {
                                        for (Equipo e : listaEquipos) { %>
                                        <tr>
                                            <td><%= e.getIdEquipo() %></td>
                                            <td><%= e.getPais() %></td>
                                            <td><%= e.getDirector() %></td>
                                            <td>
                                                <a href="#" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#verModal<%= e.getIdEquipo() %>"><i class="fa fa-eye"></i></a>
                                                <a href="#" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#verModal2<%= e.getIdEquipo() %>"><i class="fa fa-edit"></i></a>
                                                <a href="sv_EliminarEquipo?id=<%= e.getIdEquipo() %>" class="btn btn-danger" onclick="return confirm('¿Estás seguro de eliminar este equipo?')"><i class="fa fa-trash"></i></a>
                                            </td>
                                        </tr>
                                        <% }
                                    } else { %>
                                        <tr align="center">
                                            <td colspan="6">No hay equipos registrados</td>
                                        </tr>
                                    <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
  
<% if (listaEquipos != null && !listaEquipos.isEmpty()) {
    for (Equipo e : listaEquipos) {
        String traerImagen = e.getImagenBandera(); 
%>
    <!-- Modal Ver Equipo -->
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
                        <input type="hidden" name="id" value="<%= e.getIdEquipo() %>">
                        <div class="mb-3">
                            <label for="placa" class="form-label">Placa:</label>
                            <input type="text" name="pais" value="<%= e.getPais() %>" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="marca" class="form-label">Marca:</label>
                            <input type="text" name="director" value="<%= e.getDirector() %>" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="bandera" class="form-label">Imagen Bandera:</label>
                            <input type="file" name="bandera" id="imagen" class="form-control" accept="image/*">
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
if (mensaje != null && !mensaje.isEmpty()) { %>
<div id="autoToast" class="toast position-fixed bottom-0 end-0" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header bg-warning text-dark">
        <strong class="me-auto">Notificación</strong>
        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body bg-secondary text-light">
        <%= mensaje %>
    </div>
</div>
<% 
    session.removeAttribute("mensaje");
}
%>                        
<script>
    setTimeout(function() {
        var autoToast = new bootstrap.Toast(document.getElementById('autoToast'));
        autoToast.show();
    }, 0); 
</script>                                    
<%@include file="lib/footer.jsp" %>
