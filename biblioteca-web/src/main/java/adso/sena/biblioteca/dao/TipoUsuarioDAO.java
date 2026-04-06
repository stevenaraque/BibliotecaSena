package adso.sena.biblioteca.dao;

import adso.sena.biblioteca.model.TipoUsuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TipoUsuarioDAO {
    public List<TipoUsuario> listarTodos() throws SQLException {
        List<TipoUsuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM tipo_usuario ORDER BY id_tipo_usuario ASC";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new TipoUsuario(
                    rs.getInt("id_tipo_usuario"),
                    rs.getString("nombre"),
                    rs.getString("descripcion")
                ));
            }
        }
        return lista;
    }
}