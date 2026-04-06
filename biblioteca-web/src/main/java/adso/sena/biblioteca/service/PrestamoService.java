package adso.sena.biblioteca.service;

import adso.sena.biblioteca.dao.PrestamoDAO;
import adso.sena.biblioteca.model.Prestamo;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PrestamoService {

    private final PrestamoDAO prestamoDAO = new PrestamoDAO();

    public List<Prestamo> listarTodos(String buscar) {
        try {
            return prestamoDAO.listarTodos(buscar);
        } catch (SQLException e) {
            System.err.println("Error al listar préstamos: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public List<Prestamo> listarTodos() {
        return listarTodos(null);
    }

    public List<Prestamo> listarPorUsuario(int idUsuario) {
        try {
            return prestamoDAO.listarPorUsuario(idUsuario);
        } catch (SQLException e) {
            System.err.println("Error al listar préstamos por usuario: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public boolean registrar(int idLibro, int idUsuario, LocalDate fechaDevolucion) {
        try {
            return prestamoDAO.insertar(idLibro, idUsuario, fechaDevolucion);
        } catch (SQLException e) {
            System.err.println("Error al registrar préstamo: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(int idPrestamo, int idLibro, int idUsuario,
                               LocalDate fechaEsperada, LocalDate fechaReal, String estado) {
        try {
            return prestamoDAO.actualizar(idPrestamo, idLibro, idUsuario, fechaEsperada, fechaReal, estado);
        } catch (SQLException e) {
            System.err.println("Error al actualizar préstamo: " + e.getMessage());
            return false;
        }
    }

    public boolean devolver(int idPrestamo) {
        try {
            return prestamoDAO.devolver(idPrestamo);
        } catch (SQLException e) {
            System.err.println("Error al devolver préstamo: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int idPrestamo) {
        try {
            return prestamoDAO.eliminar(idPrestamo);
        } catch (SQLException e) {
            System.err.println("Error al eliminar préstamo: " + e.getMessage());
            return false;
        }
    }

    public int contarTodos() {
        try {
            return prestamoDAO.contarTodos();
        } catch (Exception e) {
            return 0;
        }
    }
}