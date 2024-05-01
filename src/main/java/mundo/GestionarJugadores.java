package mundo;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class GestionarJugadores {

    private List<Jugador> listaJugadores;

    public GestionarJugadores(List<Jugador> misJugadores) {
        this.listaJugadores = new ArrayList<>();
    }
    public void agregarJugador(int idJugador, String nombre, int edad, double altura, double peso, double salario, String posicion, String foto) {
        Jugador nuevoJugador = new Jugador(idJugador, nombre, edad, altura, peso, salario, posicion, foto);
        listaJugadores.add(nuevoJugador);
    }

    public List<Jugador> getListaJugadores() {
        return listaJugadores;
    }
    
    public void editarJugador(int nuevoId, String nuevoNombre, int nuevaEdad, double nuevaAltura, double nuevoPeso, double nuevoSalario, String nuevaPosicion, String nuevaFoto) {
        for (Jugador j : listaJugadores) {
            if (j.getIdJugador()== nuevoId) {
                j.setNombre(nuevoNombre);
                j.setEdad(nuevaEdad);
                j.setAltura(nuevaAltura);
                j.setPeso(nuevoPeso);
                j.setSalario(nuevoSalario);
                j.setPosicion(nuevaPosicion);
                j.setFoto(nuevaFoto);
                break; 
            }
        }
    }
   
    public void eliminarJugadir(int idEliminar) {
    Iterator<Jugador> iterator = listaJugadores.iterator();
    while (iterator.hasNext()) {
        Jugador j = iterator.next();
        if (j.getIdJugador() == idEliminar) {
            iterator.remove();
            break;
        }
        }
    }
}