package servlets;

import java.io.File;
import mundo.Equipo;
import mundo.GestionarEquipos;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.RequestDispatcher;
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
            String nuevaImagenBandera = null;

            HttpSession session = request.getSession();
            GestionarEquipos gestionarEquipos = new GestionarEquipos();

            String uploadDir = getServletContext().getRealPath("/") + "images" + File.separator;

            if (imagenPart != null && imagenPart.getSize() > 0) {
                String imagenFileName = Paths.get(imagenPart.getSubmittedFileName()).getFileName().toString();
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdirs();
                }

                nuevaImagenBandera = "images/" + imagenFileName;
                try (InputStream input = imagenPart.getInputStream()) {
                    Files.copy(input, Paths.get(uploadDir + imagenFileName), StandardCopyOption.REPLACE_EXISTING);
                } catch (IOException e) {
                    System.err.println("Error al subir la imagen: " + e.getMessage());
                    nuevaImagenBandera = null;
                }
            }

            Equipo equipo = gestionarEquipos.buscarEquipo(idEquipo, getServletContext());
            if (equipo != null) {
                gestionarEquipos.editarEquipo(idEquipo, nuevoPais, nuevoDirector, nuevaImagenBandera, getServletContext());
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("error", "No se encontró el equipo con ID: " + idEquipo);
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
        } catch (NumberFormatException e) {
            System.err.println("Error al editar el equipo: " + e.getMessage());
            request.setAttribute("error", "No se proporcionó un ID válido");
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
