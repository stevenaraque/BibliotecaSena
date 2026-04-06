package adso.sena.biblioteca.model;

public class EstadoPrestamo {

    private int idEstadoPrestamo;
    private String nombre;
    private String descripcion;

    public EstadoPrestamo() {}

    public EstadoPrestamo(int idEstadoPrestamo, String nombre, String descripcion) {
        this.idEstadoPrestamo = idEstadoPrestamo;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    // Getters y Setters
    public int getIdEstadoPrestamo() { return idEstadoPrestamo; }
    public void setIdEstadoPrestamo(int idEstadoPrestamo) { this.idEstadoPrestamo = idEstadoPrestamo; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    @Override
    public String toString() {
        return nombre;
    }
}