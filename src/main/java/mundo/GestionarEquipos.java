package mundo;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;

public class GestionarEquipos {

    private List<Equipo> misEquipos;

    public void agregarEquipo(Equipo equipo, ServletContext context) throws IOException {
        cargarEquiposDesdeArchivo(context); // Cargar equipos antes de agregar uno nuevo
        misEquipos.add(equipo);
        guardarEquiposEnArchivo(context);
    }

    public void eliminarEquipo(int idEquipo, ServletContext context) throws IOException {
        cargarEquiposDesdeArchivo(context);
        if (misEquipos != null) {
            Equipo equipoAEliminar = null;
            for (Equipo e : misEquipos) {
                if (e.getIdEquipo() == idEquipo) {
                    equipoAEliminar = e;
                    break;
                }
            }
            if (equipoAEliminar != null) {
                misEquipos.remove(equipoAEliminar);
                guardarEquiposEnArchivo(context);
            }
        }
    }

    public Equipo buscarEquipo(int idEquipo, ServletContext context) {
        cargarEquiposDesdeArchivo(context);
        for (Equipo e : misEquipos) {
            if (e.getIdEquipo() == idEquipo) {
                return e;
            }
        }
        return null;
    }

    public List<Equipo> getMisEquipos(ServletContext context) {
        cargarEquiposDesdeArchivo(context);
        return misEquipos;
    }

    public void cargarEquiposDesdeArchivo(ServletContext context) {
        // Reutilizamos la ruta relativa del archivo
        String relativePath = "/data/equipos.txt";
        String absPath = context.getRealPath(relativePath);

        File archivo = new File(absPath);
        misEquipos = new ArrayList<>(); // Inicializamos la lista aquí

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

    public void guardarEquiposEnArchivo(ServletContext context) {
        // Reutilizamos la ruta relativa del archivo
        String relativePath = "/data/equipos.txt";
        String absPath = context.getRealPath(relativePath);

        File archivo = new File(absPath);
        if (!archivo.exists()) {
            try {
                archivo.createNewFile();
            } catch (IOException e) {
                System.err.println("Error al crear el archivo: " + e.getMessage());
            }
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

    public void editarEquipo(int idEquipo, String nuevoPais, String nuevoDirector, String nuevaImagenBandera, ServletContext context) throws IOException {
        if (nuevoPais == null || nuevoPais.isEmpty() || nuevoDirector == null || nuevoDirector.isEmpty()) {
            throw new IllegalArgumentException("Invalid input");
        }

        Equipo equipo = buscarEquipo(idEquipo, context);
        if (equipo == null) {
            System.err.println("No se encontró el equipo con ID: " + idEquipo);
            return;
        }

        equipo.setPais(nuevoPais);
        equipo.setDirector(nuevoDirector);

        if (nuevaImagenBandera != null && !nuevaImagenBandera.isEmpty()) {
            File imagenFile = new File(context.getRealPath("/"), nuevaImagenBandera);
            if (imagenFile.exists()) {
                equipo.setImagenBandera(nuevaImagenBandera);
            } else {
                System.err.println("La imagen proporcionada no existe: " + nuevaImagenBandera);
            }
        }
        guardarEquiposEnArchivo(context);
    }

}
