package servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.ServletContext;
import mundo.GestionarEquipos;
import mundo.Jugador;
import mundo.GestionarJugadores;

@WebServlet(name = "sv_AgregarJugador", urlPatterns = {"/sv_AgregarJugador"})
@MultipartConfig
public class sv_AgregarJugador extends HttpServlet {

    public static GestionarJugadores gesJugadores = new GestionarJugadores();
    public static GestionarEquipos gesEquipos = new GestionarEquipos();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idJugador = Integer.parseInt(request.getParameter("idJugador"));
            String nombre = request.getParameter("nombre");
            int edad = Integer.parseInt(request.getParameter("edad"));
            double altura = Double.parseDouble(request.getParameter("altura"));
            double peso = Double.parseDouble(request.getParameter("peso"));
            double salario = Double.parseDouble(request.getParameter("salario"));
            String posicion = request.getParameter("posicion");
            int idEquipo = Integer.parseInt(request.getParameter("idEquipo"));

            // Verificar si el ID ya existe en la lista
            List<Jugador> listaJugadores = gesJugadores.getMisJugadores(getServletContext());
            if (listaJugadores!= null) {
                for (Jugador j : listaJugadores) {
                    if (j.getIdJugador() == idJugador) {
                        // El ID ya existe, mostrar un mensaje de error y redireccionar
                        request.getSession().setAttribute("mensaje", "El ID del jugador ya está en uso.");
                        response.sendRedirect("primary.jsp");
                        return; // Salir del método doPost
                    }
                }
            }

            // Si el ID no está duplicado, proceder a agregar el jugador
            Part imagenPart = request.getPart("foto");
            if (imagenPart == null || imagenPart.getSize() == 0) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No se ha enviado la foto");
                return;
            }

            String imagenFileName = Paths.get(imagenPart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/") + "images/";
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            String imagenPath = uploadDir + imagenFileName;
            try (InputStream input = imagenPart.getInputStream()) {
                Files.copy(input, Paths.get(imagenPath), StandardCopyOption.REPLACE_EXISTING);
            }

            Jugador nuevoJugador = new Jugador(idJugador, nombre, edad, altura, peso, salario, posicion, "images/" + imagenFileName, idEquipo);

            gesJugadores.agregarJugador(nuevoJugador, getServletContext());


            request.getSession().setAttribute("mensaje", "Jugador agregado correctamente.");
            response.sendRedirect("primary.jsp");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "El ID no es válido");
        } catch (IOException | ServletException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar la solicitud");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
