package servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.MultipartConfig;
import mundo.Equipo;

@WebServlet(name = "sv_EliminarEquipo", urlPatterns = {"/sv_EliminarEquipo"})
@MultipartConfig
public class sv_EliminarEquipo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idEliminar = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession(true);
        List<Equipo> listaEquipos = (List<Equipo>) session.getAttribute("listaEquipos");
        
        if (listaEquipos == null) {
                session.setAttribute("mensaje", "No hay motos para eliminar");
                response.sendRedirect("index.jsp");
                return;
            }
        
        boolean equipoEliminado = false;
            for (Equipo e : listaEquipos) {
                if (e.getIdEquipo() == idEliminar) {
                    listaEquipos.remove(e);
                    equipoEliminado = true;
                    break;
                }
            }
         
        
        if (equipoEliminado) {
            session.setAttribute("mensaje", "El equipo de ID: " +idEliminar+" se ha eliminado correctamente.");
        } else {
            session.setAttribute("mensaje", "No se encontró el equipo con ID: " + idEliminar);
        }
        
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}