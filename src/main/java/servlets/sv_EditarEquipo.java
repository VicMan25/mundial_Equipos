package servlets;

import java.io.File;
import mundo.Equipo;
import mundo.GestionarEquipos;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(name = "sv_EditarEquipo", urlPatterns = {"/sv_EditarEquipo"})
@MultipartConfig
public class sv_EditarEquipo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idEquipo = Integer.parseInt(request.getParameter("id"));
            String nuevoPais = request.getParameter("pais");
            String nuevoDirector = request.getParameter("director");

            Part imagenPart = request.getPart("bandera");
            String nuevaImagenBandera = null; // Variable para almacenar la nueva ruta de la imagen

            if (imagenPart != null && imagenPart.getSize() > 0) { // Si se envió una nueva imagen
                String imagenFileName = Paths.get(imagenPart.getSubmittedFileName()).getFileName().toString();
                String uploadDir = getServletContext().getRealPath("/") + "images/";
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdirs();
                }

                nuevaImagenBandera = uploadDir + imagenFileName;
                try (InputStream input = imagenPart.getInputStream()) {
                    Files.copy(input, Paths.get(nuevaImagenBandera), StandardCopyOption.REPLACE_EXISTING);
                }
            }

            HttpSession session = request.getSession();
            GestionarEquipos gestionarEquipos = new GestionarEquipos();

            // Editar el equipo
            Equipo equipo = gestionarEquipos.buscarEquipo(idEquipo, getServletContext());
            if (equipo != null) {
                if (nuevaImagenBandera == null) { // Si no se envió una nueva imagen, mantener la existente
                    nuevaImagenBandera = equipo.getImagenBandera();
                }
                gestionarEquipos.editarEquipo(idEquipo, nuevoPais, nuevoDirector, nuevaImagenBandera, getServletContext());
                session.setAttribute("mensaje", "El equipo se editó correctamente");
            } else {
                session.setAttribute("mensaje", "No se encontró el equipo con ID: " + idEquipo);
            }
            response.sendRedirect("index.jsp");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("mensaje", "ID del equipo es inválido");
            response.sendRedirect("index.jsp");
        } catch (IOException | ServletException e) {
            request.getSession().setAttribute("mensaje", "Error al modificar el equipo: " + e.getMessage());
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
