package adso.sena.biblioteca.service;

import adso.sena.biblioteca.dao.CategoriaDAO;
import adso.sena.biblioteca.model.Categoria;
import java.sql.SQLException;
import java.util.List;

public class CategoriaService {

    private final CategoriaDAO categoriaDAO;

    public CategoriaService() {
        this.categoriaDAO = new CategoriaDAO();
    }

    public List<Categoria> listarTodos() {
        try {
            return categoriaDAO.listarTodos();
        } catch (SQLException e) {
            System.err.println("Error al listar categorías: " + e.getMessage());
            return null;
        }
    }
}