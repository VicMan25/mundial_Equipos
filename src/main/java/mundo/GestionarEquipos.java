package mundo;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class GestionarEquipos {

    private List<Equipo> listaEquipos;

    public GestionarEquipos(List<Equipo> misEquipos) {
        this.listaEquipos = new ArrayList<>();
    }
    
    public void agregarEquipo(int id, String pais, String director, String bandera) {
        Equipo nuevoEquipo = new Equipo(id, pais, director, bandera);
        listaEquipos.add(nuevoEquipo);
    }

    public List<Equipo> getListaEquipos() {
        return listaEquipos;
    }
    
    public void editarEquipo(int nuevoId, String nuevoPais, String nuevoDirector, String nuevaBandera) {
        for (Equipo e : listaEquipos) {
            if (e.getIdEquipo()== nuevoId) {
                e.setPais(nuevoPais);
                e.setDirector(nuevoDirector);
                e.setImagenBandera(nuevaBandera);
                break; 
            }
        }
    }
   
    public void eliminarEquipo(int idEliminar) {
    Iterator<Equipo> iterator = listaEquipos.iterator();
    while (iterator.hasNext()) {
        Equipo e = iterator.next();
        if (e.getIdEquipo() == idEliminar) {
            iterator.remove();
            break;
        }
        }
    }
}