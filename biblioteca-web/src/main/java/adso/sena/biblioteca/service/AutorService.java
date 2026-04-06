package adso.sena.biblioteca.service;

import adso.sena.biblioteca.dao.AutorDAO;
import adso.sena.biblioteca.model.Autor;
import java.sql.SQLException;
import java.util.List;

public class AutorService {

    private final AutorDAO autorDAO;

    public AutorService() {
        this.autorDAO = new AutorDAO();
    }

    public List<Autor> listarTodos() {
        try {
            return autorDAO.listarTodos();
        } catch (SQLException e) {
            System.err.println("Error al listar autores: " + e.getMessage());
            return null;
        }
    }
}