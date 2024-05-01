
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import mundo.Equipo;

public class GestionarEquipos {

    private List<Equipo> listaEquipos;

    public GestionarEquipos(List<Equipo> misEquipos) {
        this.listaEquipos = misEquipos != null ? misEquipos : new ArrayList<>();
        cargarEquiposDesdeArchivo(); // Cargar equipos al inicializar la clase
    }

    public void agregarEquipo(int id, String pais, String director, String bandera) {
        Equipo nuevoEquipo = new Equipo(id, pais, director, bandera);
        listaEquipos.add(nuevoEquipo);
        guardarEquiposEnArchivo(); // Guardar equipos después de agregar uno nuevo
    }

    public List<Equipo> getListaEquipos() {
        return listaEquipos;
    }

    public void editarEquipo(int nuevoId, String nuevoPais, String nuevoDirector, String nuevaBandera) {
        for (Equipo e : listaEquipos) {
            if (e.getIdEquipo() == nuevoId) {
                e.setPais(nuevoPais);
                e.setDirector(nuevoDirector);
                e.setImagenBandera(nuevaBandera);
                break;
            }
        }
        guardarEquiposEnArchivo(); // Guardar equipos después de editar uno existente
    }

    public void eliminarEquipo(int idEliminar) {
        listaEquipos.removeIf(e -> e.getIdEquipo() == idEliminar);
        guardarEquiposEnArchivo(); // Guardar equipos después de eliminar uno
    }

    private void cargarEquiposDesdeArchivo() {
        String filePath = "equipos.txt"; // Ruta del archivo
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            listaEquipos.clear(); // Limpiar la lista antes de cargar desde el archivo
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                int id = Integer.parseInt(parts[0]);
                String pais = parts[1];
                String director = parts[2];
                String bandera = parts[3];
                listaEquipos.add(new Equipo(id, pais, director, bandera));
            }
        } catch (IOException | NumberFormatException e) {
            // Manejo de errores
        }
    }

    private void guardarEquiposEnArchivo() {
        String filePath = "equipos.txt"; // Ruta del archivo
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Equipo equipo : listaEquipos) {
                writer.write("Listado de equipos: \n");
                writer.write(equipo.getIdEquipo() + "," + equipo.getPais() + "," + equipo.getDirector() + "," + equipo.getImagenBandera() + "\n");
                writer.write("================================= \n");
                
            }
        } catch (IOException e) {
            // Manejo de errores
        }
    }
}
