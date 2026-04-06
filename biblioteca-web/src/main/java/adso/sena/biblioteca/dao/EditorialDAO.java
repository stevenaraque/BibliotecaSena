package adso.sena.biblioteca.dao;

import adso.sena.biblioteca.model.Editorial;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EditorialDAO {
    public List<Editorial> listarTodos() throws SQLException {
        List<Editorial> editoriales = new ArrayList<>();
        String sql = "SELECT * FROM editorial ORDER BY nombre ASC";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Editorial e = new Editorial();
                e.setIdEditorial(rs.getInt("id_editorial"));
                e.setNombre(rs.getString("nombre"));
                e.setPais(rs.getString("pais"));
                e.setSitioWeb(rs.getString("sitio_web"));
                editoriales.add(e);
            }
        }
        return editoriales;
    }
}