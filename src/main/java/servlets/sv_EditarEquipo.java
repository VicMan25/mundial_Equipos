package servlets;

import mundo.Equipo;
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
        try{
            int nuevoId = Integer.parseInt(request.getParameter("id"));
            String nuevoPais = request.getParameter("pais");
            String nuevoDirector = request.getParameter("director");
            
            HttpSession session = request.getSession();
            List<Equipo> listaEquipos = (List<Equipo>) session.getAttribute("listaEquipos");
            
            if (listaEquipos == null) {
                session.setAttribute("mensaje", "La lista de equipos no fue encontrada en la sesión");
                response.sendRedirect("index.jsp");
                return;
            }
            
            for(Equipo e: listaEquipos){
                if (e.getIdEquipo() == nuevoId) {
                    e.setPais(nuevoPais);
                    e.setDirector(nuevoDirector);
                    
                    Part imagenPart = request.getPart("bandera");
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
                        e.setImagenBandera("uploads/" + imagenFileName);
                    }
                    break; 
                }
            }
            session.setAttribute("mensaje", "El equipo se edito correctamente");
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
