package adso.sena.biblioteca.service;

import adso.sena.biblioteca.dao.LibroDAO;
import adso.sena.biblioteca.model.Libro;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LibroService {
    private final LibroDAO libroDAO;

    public LibroService() {
        this.libroDAO = new LibroDAO();
    }

    public List<Libro> listarTodos() {
        try {
            return libroDAO.listarTodos();
        } catch (SQLException e) {
            System.err.println("Error al listar libros: " + e.getMessage());
            return null;
        }
    }

    public int registrar(Libro libro) {
        try {
            return libroDAO.insertar(libro);
        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) {
                throw new RuntimeException("El ISBN '" + libro.getIsbn() + "' ya está registrado en otro libro.");
            }
            System.err.println("Error al registrar libro: " + e.getMessage());
            return -1;
        }
    }

    public boolean asociarAutor(int idLibro, int idAutor) {
        try {
            return libroDAO.asociarAutor(idLibro, idAutor);
        } catch (SQLException e) {
            System.err.println("Error al asociar autor: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(Libro libro) {
        try {
            return libroDAO.actualizar(libro);
        } catch (SQLException e) {
            System.err.println("Error al actualizar libro: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int idLibro) {
        try {
            return libroDAO.eliminar(idLibro);
        } catch (SQLException e) {
            System.err.println("Error al eliminar libro: " + e.getMessage());
            return false;
        }
    }

    public int contarLibros() {
        try {
            return libroDAO.contarLibros();
        } catch (Exception e) {
            System.err.println("Error al contar libros: " + e.getMessage());
            return 0;
        }
    }
    public List<Libro> listarDisponibles() {
    try {
        return libroDAO.listarDisponibles();
    } catch (SQLException e) {
        System.err.println("Error al listar libros disponibles: " + e.getMessage());
        return new ArrayList<>();
    }
}
}