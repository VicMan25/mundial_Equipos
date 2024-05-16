package mundo;
//Vm
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;

public class GestionarJugadores {

    private List<Jugador> misJugadores;

    public void agregarJugador(Jugador jugador, ServletContext context) throws IOException {
        cargarJugadoresDesdeArchivo(context); // Cargar jugadores antes de agregar uno nuevo
        misJugadores.add(jugador);
        guardarJugadoresEnArchivo(context);
    }

    public void eliminarJugador(int idJugador, ServletContext context) throws IOException {
        cargarJugadoresDesdeArchivo(context);
        if (misJugadores != null) {
            Jugador jugadorEliminar = null;
            for (Jugador j : misJugadores) {
                if (j.getIdJugador() == idJugador) {
                    jugadorEliminar = j;
                    break;
                }
            }
            if (jugadorEliminar != null) {
                misJugadores.remove(jugadorEliminar);
                guardarJugadoresEnArchivo(context);
            }
        }
    }

    public Jugador buscarJugador(int idJugador, ServletContext context) {
        cargarJugadoresDesdeArchivo(context);
        for (Jugador j : misJugadores) {
            if (j.getIdJugador() == idJugador) {
                return j;
            }
        }
        return null;
    }

    public List<Jugador> getMisJugadores(ServletContext context) {
        cargarJugadoresDesdeArchivo(context);
        return misJugadores;
    }

    public void cargarJugadoresDesdeArchivo(ServletContext context) {
    String relativePath = "/data/jugadores.txt";
    String absPath = context.getRealPath(relativePath);

    File archivo = new File(absPath);
    misJugadores = new ArrayList<>(); // Inicializamos la lista aquí

    if (archivo.exists()) {
        try (BufferedReader br = new BufferedReader(new FileReader(archivo))) {
            String linea;
            while ((linea = br.readLine()) != null) {
                String[] datos = linea.split(";");
                if (datos.length == 9) {
                    int idJugador = Integer.parseInt(datos[0]);
                    String nombre = datos[1];
                    int edad = Integer.parseInt(datos[2]);
                    double altura = Double.parseDouble(datos[3]);
                    double peso = Double.parseDouble(datos[4]);
                    double salario = Double.parseDouble(datos[5]);
                    String posicion = datos[6];
                    String foto = datos[7];
                    int idEquipo = Integer.parseInt(datos[8]);
                    
                    Jugador j = new Jugador(idJugador, nombre, edad, altura, peso, salario, posicion, foto, idEquipo);
                    misJugadores.add(j);
                } else {
                    System.err.println("Línea con datos insuficientes: " + linea);
                }
            }
        } catch (IOException e) {
            System.err.println("Error al cargar los jugadores desde el archivo: " + e.getMessage());
        }
    }
}


    public void guardarJugadoresEnArchivo(ServletContext context) {
        // Reutilizamos la ruta relativa del archivo
        String relativePath = "/data/jugadores.txt";
        String absPath = context.getRealPath(relativePath);

        File archivo = new File(absPath);
        if (!archivo.exists()) {
            try {
                archivo.createNewFile();
            } catch (IOException e) {
                System.err.println("Error al crear el archivo: " + e.getMessage());
            }
        }
        try (BufferedWriter pluma = new BufferedWriter(new FileWriter(archivo))) {
            for (Jugador j : misJugadores) {
                pluma.write(j.getIdJugador() + ";" + j.getNombre() + ";" + j.getEdad() + ";" + j.getAltura()+ ";" +j.getPeso()+ ";" +j.getSalario()+ ";" +j.getPosicion()+ ";" +j.getFoto() + ";" +j.getIdEquipo());
                pluma.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error al guardar los jugadores en el archivo: " + e.getMessage());
        }
    }

    public void editarJugador(int idJugador, String nuevoNombre, int nuevaEdad, double nuevaAltura, double nuevoPeso, double nuevoSalario, String nuevaPosicion, String nuevaFoto, ServletContext context) throws IOException {
        cargarJugadoresDesdeArchivo(context); // Cargar jugador antes de editar uno existente

        for (Jugador j : misJugadores) {
            if (j.getIdJugador() == idJugador) {
                // Se encontró el jugador, ahora se actualizan sus datos
                j.setNombre(nuevoNombre);
                j.setEdad(nuevaEdad);
                j.setAltura(nuevaAltura);
                j.setPeso(nuevoPeso);
                j.setSalario(nuevoSalario);
                j.setPosicion(nuevaPosicion);
                j.setFoto(nuevaFoto);
                // Guardar los cambios en el archivo
                guardarJugadoresEnArchivo(context);
                return; // Salir del método después de editar el jugador
            }
        }
        // Si llega aquí, significa que no se encontró el jugador con el ID especificado
        System.err.println("No se encontró el jugador con ID: " + idJugador);
    }

}
