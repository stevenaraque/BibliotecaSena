package adso.sena.biblioteca.service;

import adso.sena.biblioteca.dao.EditorialDAO;
import adso.sena.biblioteca.model.Editorial;
import java.sql.SQLException;
import java.util.List;

public class EditorialService {
    private final EditorialDAO editorialDAO;

    public EditorialService() {
        this.editorialDAO = new EditorialDAO();
    }

    public List<Editorial> listarTodos() {
        try {
            return editorialDAO.listarTodos();
        } catch (SQLException e) {
            System.err.println("Error al listar editoriales: " + e.getMessage());
            return null;
        }
    }
}