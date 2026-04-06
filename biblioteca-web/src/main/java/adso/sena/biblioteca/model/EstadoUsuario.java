package adso.sena.biblioteca.model;

public class EstadoUsuario {

    private int idEstadoUsuario;
    private String nombre;
    private String descripcion;

    // Constructor vacío
    public EstadoUsuario() {
    }

    // Constructor principal
    public EstadoUsuario(int idEstadoUsuario, String nombre, String descripcion) {
        this.idEstadoUsuario = idEstadoUsuario;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    // Getters y Setters
    public int getIdEstadoUsuario() {
        return idEstadoUsuario;
    }

    public void setIdEstadoUsuario(int idEstadoUsuario) {
        this.idEstadoUsuario = idEstadoUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @Override
    public String toString() {
        return nombre;
    }
}