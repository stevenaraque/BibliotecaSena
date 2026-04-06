package adso.sena.biblioteca.model;

import java.time.LocalDate;

public class Autor {
    private int idAutor;
    private String nombres;
    private String apellidos;
    private String nacionalidad;
    private LocalDate fechaNacimiento;

    // Constructor vacío
    public Autor() {}

    // Constructor con parámetros principales
    public Autor(String nombres, String apellidos, String nacionalidad, LocalDate fechaNacimiento) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.nacionalidad = nacionalidad;
        this.fechaNacimiento = fechaNacimiento;
    }

    // Getters y Setters
    public int getIdAutor() { return idAutor; }
    public void setIdAutor(int idAutor) { this.idAutor = idAutor; }

    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }

    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }

    public String getNacionalidad() { return nacionalidad; }
    public void setNacionalidad(String nacionalidad) { this.nacionalidad = nacionalidad; }

    public LocalDate getFechaNacimiento() { return fechaNacimiento; }
    public void setFechaNacimiento(LocalDate fechaNacimiento) { this.fechaNacimiento = fechaNacimiento; }
    
public String getNombreCompleto() {
    return nombres + " " + apellidos;
}

    @Override
    public String toString() {
        return nombres + " " + apellidos;
    }
}