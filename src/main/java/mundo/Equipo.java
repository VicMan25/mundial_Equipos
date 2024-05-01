package mundo;

public class Equipo {
   
    private int idEquipo;
    private String pais;
    private String director;
    private String imagenBandera;
    
    public Equipo() {
    }

    public Equipo(int id, String nombreEquipo, String director, String imagenBandera) {
        this.idEquipo = id;
        this.pais = nombreEquipo;
        this.director = director;
        this.imagenBandera = imagenBandera;
    }

    public int getIdEquipo() {
        return idEquipo;
    }

    public void setIdEquipo(int idEquipo) {
        this.idEquipo = idEquipo;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getImagenBandera() {
        return imagenBandera;
    }

    public void setImagenBandera(String imagenBandera) {
        this.imagenBandera = imagenBandera;
    }
}
