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
import mundo.Equipo;
import mundo.GestionarEquipos;

@WebServlet(name = "sv_AgregarEquipo", urlPatterns = {"/sv_AgregarEquipo"})
@MultipartConfig
public class sv_AgregarEquipo extends HttpServlet {

    public static GestionarEquipos gesEquipos = new GestionarEquipos();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idEquipo = Integer.parseInt(request.getParameter("idEquipo"));
            String pais = request.getParameter("pais");
            String director = request.getParameter("director");

            // Verificar si el ID ya existe en la lista
            List<Equipo> listaEquipos = gesEquipos.getMisEquipos(getServletContext());
            if (listaEquipos!= null) {
                for (Equipo e : listaEquipos) {
                    if (e.getIdEquipo() == idEquipo) {
                        // El ID ya existe, mostrar un mensaje de error y redireccionar
                        request.getSession().setAttribute("mensaje", "El ID del equipo ya está en uso.");
                        response.sendRedirect("index.jsp");
                        return; // Salir del método doPost
                    }
                }
            }

            // Si el ID no está duplicado, proceder a agregar el equipo
            Part imagenPart = request.getPart("bandera");
            if (imagenPart == null || imagenPart.getSize() == 0) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No se ha enviado la imagen");
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

            Equipo nuevoEquipo = new Equipo(idEquipo, pais, director, "images/" + imagenFileName);

            gesEquipos.agregarEquipo(nuevoEquipo, getServletContext());


            request.getSession().setAttribute("mensaje", "Equipo agregado correctamente.");
            response.sendRedirect("index.jsp");
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
