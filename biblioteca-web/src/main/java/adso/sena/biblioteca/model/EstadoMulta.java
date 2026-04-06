package adso.sena.biblioteca.model;

public class EstadoMulta {

    private int idEstadoMulta;
    private String nombre;
    private String descripcion;

    public EstadoMulta() {}

    public EstadoMulta(int idEstadoMulta, String nombre, String descripcion) {
        this.idEstadoMulta = idEstadoMulta;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    // Getters y Setters
    public int getIdEstadoMulta() { return idEstadoMulta; }
    public void setIdEstadoMulta(int idEstadoMulta) { this.idEstadoMulta = idEstadoMulta; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    @Override
    public String toString() {
        return nombre;
    }
}