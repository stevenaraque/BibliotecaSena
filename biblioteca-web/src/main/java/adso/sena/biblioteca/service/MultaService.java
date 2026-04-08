package adso.sena.biblioteca.service;

import adso.sena.biblioteca.dao.MultaDAO;
import adso.sena.biblioteca.model.Multa;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class MultaService {

    private final MultaDAO multaDAO = new MultaDAO();

    public List<Multa> listarTodas() {
        try {
            return multaDAO.listarTodas();
        } catch (SQLException e) {
            System.err.println("Error al listar multas: " + e.getMessage());
            return new ArrayList<>();  // lista vacía en lugar de null
        }
    }

    public boolean registrar(int idPrestamo, BigDecimal monto) {
        try {
            return multaDAO.registrar(idPrestamo, monto);
        } catch (SQLException e) {
            System.err.println("Error al registrar multa: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(int idMulta, int idPrestamo, BigDecimal monto,
                               LocalDate fechaPago, int idEstado) {
        try {
            return multaDAO.actualizar(idMulta, idPrestamo, monto, fechaPago, idEstado);
        } catch (SQLException e) {
            System.err.println("Error al actualizar multa: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminar(int idMulta) {
        try {
            return multaDAO.eliminar(idMulta);
        } catch (SQLException e) {
            System.err.println("Error al eliminar multa: " + e.getMessage());
            return false;
        }
    }

    public int contarMultasPendientes() {
        try {
            return multaDAO.contarPendientes();
        } catch (Exception e) {
            return 0;
        }
    }

    public int contarTodas() {
        try {
            return multaDAO.contarTodas();
        } catch (Exception e) {
            return 0;
        }
    }

    public double totalDeudaPendiente() {
        try {
            return multaDAO.totalMultasPendientes();
        } catch (Exception e) {
            return 0;
        }
    }
    public List<Multa> listarPorUsuario(int idUsuario) {
    try {
        return multaDAO.listarPorUsuario(idUsuario);
    } catch (SQLException e) {
        System.err.println("Error al listar multas por usuario: " + e.getMessage());
        return new ArrayList<>();
    }
}
    public List<Multa> buscarPorUsuarioOLibro(String criterio) throws SQLException {
    return multaDAO.buscarPorUsuarioOLibro(criterio);
}
}