package servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.annotation.MultipartConfig;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import mundo.Jugador;


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
        try{
            
            int nuevoIdJugador = Integer.parseInt(request.getParameter("idJugador"));
            String nuevoNombre = request.getParameter("nombre");
            int nuevaEdad = Integer.parseInt(request.getParameter("edad"));
            double nuevaAltura = Double.parseDouble(request.getParameter("altura"));
            double nuevoPeso = Double.parseDouble(request.getParameter("peso"));
            double nuevoSalario = Double.parseDouble(request.getParameter("salario"));
            String nuevaPosicion = request.getParameter("posicion");
            
            HttpSession session = request.getSession();
            List<Jugador> listaJugadores = (List<Jugador>) session.getAttribute("listaJugadores");
            
            if (listaJugadores == null) {
                session.setAttribute("mensaje", "La lista de jugadores no fue encontrada en la sesión");
                response.sendRedirect("plantilla.jsp");
                return;
            }
            
            for(Jugador j: listaJugadores){
                if (j.getIdJugador() == nuevoIdJugador) {
                    j.setNombre(nuevoNombre);
                    j.setEdad(nuevaEdad);
                    j.setAltura(nuevaAltura);
                    j.setPeso(nuevoPeso);
                    j.setSalario(nuevoSalario);
                    j.setPosicion(nuevaPosicion);
                    
                    Part imagenPart = request.getPart("foto");
                    if (imagenPart != null && imagenPart.getSize() > 0) {
                        String imagenFileName = Paths.get(imagenPart.getSubmittedFileName()).getFileName().toString();
                        String uploadDir = getServletContext().getRealPath("/") + "uploads/";
                        File uploadDirFile = new File(uploadDir);
                        if (!uploadDirFile.exists()) {
                            uploadDirFile.mkdirs(); 
                        }
                        String imagenPath = uploadDir + imagenFileName;
                        try (InputStream input = imagenPart.getInputStream()) {
                            Files.copy(input, Paths.get(imagenPath), StandardCopyOption.REPLACE_EXISTING);
                        }
                        j.setFoto("uploads/" + imagenFileName);
                    }
                    break; 
                }
            }
            session.setAttribute("mensaje", "El jugador se edito correctamente");
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
