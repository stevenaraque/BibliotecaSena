package adso.sena.biblioteca.model;

public class Editorial {
    private int idEditorial;
    private String nombre;
    private String pais;
    private String sitioWeb;

    public Editorial() {}

    public Editorial(String nombre, String pais, String sitioWeb) {
        this.nombre = nombre;
        this.pais = pais;
        this.sitioWeb = sitioWeb;
    }

    // Getters y Setters
    public int getIdEditorial() { return idEditorial; }
    public void setIdEditorial(int idEditorial) { this.idEditorial = idEditorial; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getPais() { return pais; }
    public void setPais(String pais) { this.pais = pais; }

    public String getSitioWeb() { return sitioWeb; }
    public void setSitioWeb(String sitioWeb) { this.sitioWeb = sitioWeb; }

    @Override
    public String toString() {
        return nombre;
    }
}