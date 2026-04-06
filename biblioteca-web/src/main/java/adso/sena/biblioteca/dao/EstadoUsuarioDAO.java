package adso.sena.biblioteca.dao;

import adso.sena.biblioteca.model.EstadoUsuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EstadoUsuarioDAO {
    public List<EstadoUsuario> listarTodos() throws SQLException {
        List<EstadoUsuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM estado_usuario ORDER BY id_estado_usuario ASC";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new EstadoUsuario(
                    rs.getInt("id_estado_usuario"),
                    rs.getString("nombre"),
                    rs.getString("descripcion")
                ));
            }
        }
        return lista;
    }
}