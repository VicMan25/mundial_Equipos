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
                    <h5 class="text-center mb-3">Agregar Jugador</h5> 
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

<%-- Mensaje de Hola Mundo --%>
<div class="container mt-4">
    <div class="alert alert-success" role="alert">
        ¡Hola Mundo!
    </div>
</div>

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
