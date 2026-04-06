package adso.sena.biblioteca.dao;

import adso.sena.biblioteca.model.Autor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AutorDAO {

    public List<Autor> listarTodos() throws SQLException {
        List<Autor> autores = new ArrayList<>();
        String sql = "SELECT * FROM autor ORDER BY id_autor ASC";

        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Autor a = new Autor();
                a.setIdAutor(rs.getInt("id_autor"));
                a.setNombres(rs.getString("nombres"));
                a.setApellidos(rs.getString("apellidos"));
                autores.add(a);
            }
        }
        return autores;
    }
}