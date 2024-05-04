package mundo;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import mundo.Equipo;

public class GestionarEquipos {

    private List<Equipo> misEquipos;
    private static final String ARCHIVO_EQUIPOS = "data/equipos.txt";

    public GestionarEquipos() {
        misEquipos = new ArrayList<>();
        cargarEquiposDesdeArchivo();
    }

    public void agregarEquipo(Equipo equipo) throws IOException {
        misEquipos.add(equipo);
        guardarEquiposEnArchivo();
    }

    public void eliminarEquipo(int idEquipo) throws IOException {
        Equipo equipoAEliminar = null;
        for (Equipo equipo : misEquipos) {
            if (equipo.getIdEquipo() == idEquipo) {
                equipoAEliminar = equipo;
                break;
            }
        }
        if (equipoAEliminar!= null) {
            misEquipos.remove(equipoAEliminar);
            guardarEquiposEnArchivo();
        }
    }

    public Equipo buscarEquipo(int idEquipo) {
        for (Equipo equipo : misEquipos) {
            if (equipo.getIdEquipo() == idEquipo) {
                return equipo;
           }
        }
        return null;
    }

    public List<Equipo> getMisEquipos() {
        return misEquipos;
    }

    private void cargarEquiposDesdeArchivo() {
        File archivo = new File(ARCHIVO_EQUIPOS);
        if (archivo.exists()) {
            try (BufferedReader br = new BufferedReader(new FileReader(archivo))) {
                String linea;
                while ((linea = br.readLine()) != null) {
                    String[] datos = linea.split(";");
                    int idEquipo = Integer.parseInt(datos[0]);
                    String pais = datos[1];
                    String director = datos[2];
                    String imagenBandera = datos[3];
                    Equipo equipo = new Equipo(idEquipo, pais, director, imagenBandera);
                    misEquipos.add(equipo);
                }
            } catch (IOException e) {
                System.err.println("Error al cargar los equipos desde el archivo: " + e.getMessage());
            }
        }
    }

    public void guardarEquiposEnArchivo() throws IOException {
        File archivo = new File(ARCHIVO_EQUIPOS);
        if (!archivo.exists()) {
            archivo.createNewFile();
        }
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(archivo))) {
            for (Equipo e : misEquipos) {
                bw.write(e.getIdEquipo() + ";" + e.getPais() + ";" + e.getDirector() + ";" + e.getImagenBandera());
                bw.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error al guardar los equipos en el archivo: " + e.getMessage());
        }
    }
}