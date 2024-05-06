package servlets;

import java.io.File;
import mundo.Jugador;
import mundo.GestionarJugadores;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(name = "sv_EditarJugador", urlPatterns = {"/sv_EditarJugador"})
@MultipartConfig
public class sv_EditarJugador extends HttpServlet {

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
            int idJugador = Integer.parseInt(request.getParameter("idJugador"));
            String nuevoNombre = request.getParameter("nombre");
            int nuevaEdad = Integer.parseInt(request.getParameter("edad"));
            double nuevaAltura = Double.parseDouble(request.getParameter("altura"));
            double nuevoPeso = Double.parseDouble(request.getParameter("peso"));
            double nuevoSalario = Double.parseDouble(request.getParameter("salario"));
            String nuevaPosicion = request.getParameter("posicion");

            Part imagenPart = request.getPart("foto");
            String nuevaFoto = null; // Variable para almacenar la nueva ruta de la foto

            if (imagenPart != null && imagenPart.getSize() > 0) { // Si se envió una nueva imagen
                String imagenFileName = Paths.get(imagenPart.getSubmittedFileName()).getFileName().toString();
                String uploadDir = getServletContext().getRealPath("/") + "images/";
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdirs();
                }

                nuevaFoto = uploadDir + imagenFileName;
                try (InputStream input = imagenPart.getInputStream()) {
                    Files.copy(input, Paths.get(nuevaFoto), StandardCopyOption.REPLACE_EXISTING);
                }
            }

            HttpSession session = request.getSession();
            GestionarJugadores gesJugadores = new GestionarJugadores();

            // Editar el jugador
            Jugador j = gesJugadores.buscarJugador(idJugador, getServletContext());
            if (j != null) {
                if (nuevaFoto == null) { // Si no se envió una nueva imagen, mantener la existente
                    nuevaFoto = j.getFoto();
                }
                gesJugadores.editarJugador(idJugador, nuevoNombre, nuevaEdad, nuevaAltura, nuevoPeso, nuevoSalario, nuevaPosicion, nuevaFoto, getServletContext());
                session.setAttribute("mensaje", "El jugador se editó correctamente");
            } else {
                session.setAttribute("mensaje", "No se encontró el jugador con ID: " + idJugador);
            }
            response.sendRedirect("plantilla.jsp");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("mensaje", "ID del jugador es inválido");
            response.sendRedirect("plantilla.jsp");
        } catch (IOException | ServletException e) {
            request.getSession().setAttribute("mensaje", "Error al modificar el jugador: " + e.getMessage());
            response.sendRedirect("plantilla.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
