package adso.sena.biblioteca.model;

import java.time.LocalDate;

public class Prestamo {

    private int idPrestamo;
    private Libro libro;
    private Usuario usuario;
    private LocalDate fechaPrestamo;
    private LocalDate fechaDevolucionEsperada;
    private LocalDate fechaDevolucionReal;
    private EstadoPrestamo estadoPrestamo;

    public Prestamo() {}

    public Prestamo(Libro libro, Usuario usuario, LocalDate fechaDevolucionEsperada) {
        this.libro = libro;
        this.usuario = usuario;
        this.fechaPrestamo = LocalDate.now();
        this.fechaDevolucionEsperada = fechaDevolucionEsperada;
        this.estadoPrestamo = new EstadoPrestamo(1, "activo", "Préstamo en curso");
    }

    // Getters y Setters
    public int getIdPrestamo() { return idPrestamo; }
    public void setIdPrestamo(int idPrestamo) { this.idPrestamo = idPrestamo; }

    public Libro getLibro() { return libro; }
    public void setLibro(Libro libro) { this.libro = libro; }

    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }

    public LocalDate getFechaPrestamo() { return fechaPrestamo; }
    public void setFechaPrestamo(LocalDate fechaPrestamo) { this.fechaPrestamo = fechaPrestamo; }

    public LocalDate getFechaDevolucionEsperada() { return fechaDevolucionEsperada; }
    public void setFechaDevolucionEsperada(LocalDate fechaDevolucionEsperada) { this.fechaDevolucionEsperada = fechaDevolucionEsperada; }

    public LocalDate getFechaDevolucionReal() { return fechaDevolucionReal; }
    public void setFechaDevolucionReal(LocalDate fechaDevolucionReal) { this.fechaDevolucionReal = fechaDevolucionReal; }

    public EstadoPrestamo getEstadoPrestamo() { return estadoPrestamo; }
    public void setEstadoPrestamo(EstadoPrestamo estadoPrestamo) { this.estadoPrestamo = estadoPrestamo; }

    @Override
    public String toString() {
        return "Préstamo #" + idPrestamo + " - " + libro.getTitulo() + " a " + usuario.getNombreCompleto();
    }
}