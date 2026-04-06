package adso.sena.biblioteca.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Multa {

    private int idMulta;
    private Prestamo prestamo;
    private BigDecimal monto;
    private LocalDate fechaGeneracion;
    private LocalDate fechaPago;
    private EstadoMulta estadoMulta;

    public Multa() {}

    public Multa(Prestamo prestamo, BigDecimal monto) {
        this.prestamo = prestamo;
        this.monto = monto;
        this.fechaGeneracion = LocalDate.now();
        this.estadoMulta = new EstadoMulta(1, "pendiente", "Multa sin pagar");
    }

    // Getters y Setters
    public int getIdMulta() { return idMulta; }
    public void setIdMulta(int idMulta) { this.idMulta = idMulta; }

    public Prestamo getPrestamo() { return prestamo; }
    public void setPrestamo(Prestamo prestamo) { this.prestamo = prestamo; }

    public BigDecimal getMonto() { return monto; }
    public void setMonto(BigDecimal monto) { this.monto = monto; }

    public LocalDate getFechaGeneracion() { return fechaGeneracion; }
    public void setFechaGeneracion(LocalDate fechaGeneracion) { this.fechaGeneracion = fechaGeneracion; }

    public LocalDate getFechaPago() { return fechaPago; }
    public void setFechaPago(LocalDate fechaPago) { this.fechaPago = fechaPago; }

    public EstadoMulta getEstadoMulta() { return estadoMulta; }
    public void setEstadoMulta(EstadoMulta estadoMulta) { this.estadoMulta = estadoMulta; }

    @Override
    public String toString() {
        return "Multa de $" + monto + " - Préstamo #" + (prestamo != null ? prestamo.getIdPrestamo() : "N/A");
    }
}