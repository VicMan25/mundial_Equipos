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
import mundo.Jugador;
import mundo.GestionarJugadores;

@WebServlet(name = "sv_EliminarJugador", urlPatterns = {"/sv_EliminarJugador"})
@MultipartConfig
public class sv_EliminarJugador extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idEliminar = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession(true);

        // Obtener la lista de juagdores del contexto de aplicación
        GestionarJugadores gesJugadores = new GestionarJugadores();
        List<Jugador> listaJugadores = gesJugadores.getMisJugadores(request.getServletContext());

        if (listaJugadores == null) {
            session.setAttribute("mensaje", "No hay jugadores para eliminar");
            response.sendRedirect("plantilla.jsp");
            return;
        }

        boolean jugadorEliminado = false;
        for (Jugador j : listaJugadores) {
            if (j.getIdJugador() == idEliminar) {
                // Eliminar el jugador de la lista
                try {
                    gesJugadores.eliminarJugador(idEliminar, request.getServletContext());
                    jugadorEliminado = true;
                } catch (IOException ex) {
                    session.setAttribute("mensaje", "Error al eliminar el jugador: " + ex.getMessage());
                }
                break;
            }
        }

        if (jugadorEliminado) {
            session.setAttribute("mensaje", "El jugador de ID: " + idEliminar + " se ha eliminado correctamente.");
        } else {
            session.setAttribute("mensaje", "No se encontró el jugador con ID: " + idEliminar);
        }

        response.sendRedirect("plantilla.jsp");
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
