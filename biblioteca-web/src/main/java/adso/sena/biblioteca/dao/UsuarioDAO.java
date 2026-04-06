package adso.sena.biblioteca.dao;

import adso.sena.biblioteca.model.EstadoUsuario;
import adso.sena.biblioteca.model.TipoUsuario;
import adso.sena.biblioteca.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    // SQL base reutilizable — incluye password y alias consistentes
    private static final String SQL_BASE =
            "SELECT u.id_usuario, u.documento, u.nombres, u.apellidos, "
            + "u.email, u.password, u.telefono, "
            + "t.id_tipo_usuario, t.nombre AS tipo_nombre, "
            + "e.id_estado_usuario, e.nombre AS estado_nombre "
            + "FROM usuario u "
            + "JOIN tipo_usuario t     ON u.id_tipo_usuario    = t.id_tipo_usuario "
            + "JOIN estado_usuario e   ON u.id_estado_usuario  = e.id_estado_usuario ";

    public List<Usuario> listarTodos() throws SQLException {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = SQL_BASE + "ORDER BY u.id_usuario ASC";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                usuarios.add(mapearUsuario(rs));
            }
        }
        return usuarios;
    }

    public Usuario buscarPorId(int idUsuario) throws SQLException {
        String sql = SQL_BASE + "WHERE u.id_usuario = ?";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapearUsuario(rs);
            }
        }
        return null;
    }

    public Usuario buscarPorEmail(String email) throws SQLException {
        String sql = SQL_BASE + "WHERE u.email = ?";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapearUsuario(rs);
            }
        }
        return null;
    }

    public Usuario buscarPorEmailYPassword(String email, String password) throws SQLException {
        String sql = SQL_BASE + "WHERE u.email = ? AND u.password = ? AND e.nombre = 'activo'";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapearUsuario(rs);
            }
        }
        return null;
    }

    public boolean insertar(Usuario usuario) throws SQLException {
        String sql = "INSERT INTO usuario (documento, nombres, apellidos, email, password, "
                + "telefono, id_tipo_usuario, id_estado_usuario) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, usuario.getDocumento());
            ps.setString(2, usuario.getNombres());
            ps.setString(3, usuario.getApellidos());
            ps.setString(4, usuario.getEmail());
            ps.setString(5, usuario.getPassword() != null ? usuario.getPassword() : "1234");
            ps.setString(6, usuario.getTelefono());
            ps.setInt(7, usuario.getTipoUsuario().getIdTipoUsuario());
            ps.setInt(8, usuario.getEstadoUsuario().getIdEstadoUsuario());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean actualizar(Usuario usuario) throws SQLException {
        String sql = "UPDATE usuario SET documento = ?, nombres = ?, apellidos = ?, "
                + "email = ?, telefono = ?, id_tipo_usuario = ?, id_estado_usuario = ? "
                + "WHERE id_usuario = ?";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, usuario.getDocumento());
            ps.setString(2, usuario.getNombres());
            ps.setString(3, usuario.getApellidos());
            ps.setString(4, usuario.getEmail());
            ps.setString(5, usuario.getTelefono());
            ps.setInt(6, usuario.getTipoUsuario().getIdTipoUsuario());
            ps.setInt(7, usuario.getEstadoUsuario().getIdEstadoUsuario());
            ps.setInt(8, usuario.getIdUsuario());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean eliminar(int idUsuario) throws SQLException {
        String sql = "DELETE FROM usuario WHERE id_usuario = ?";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            return ps.executeUpdate() > 0;
        }
    }

    public int contarTodos() throws SQLException {
        String sql = "SELECT COUNT(*) FROM usuario";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    private Usuario mapearUsuario(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();
        u.setIdUsuario(rs.getInt("id_usuario"));
        u.setDocumento(rs.getString("documento"));
        u.setNombres(rs.getString("nombres"));
        u.setApellidos(rs.getString("apellidos"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        u.setTelefono(rs.getString("telefono"));

        TipoUsuario tipo = new TipoUsuario();
        tipo.setIdTipoUsuario(rs.getInt("id_tipo_usuario"));
        tipo.setNombre(rs.getString("tipo_nombre"));
        u.setTipoUsuario(tipo);

        EstadoUsuario estado = new EstadoUsuario();
        estado.setIdEstadoUsuario(rs.getInt("id_estado_usuario"));
        estado.setNombre(rs.getString("estado_nombre"));
        u.setEstadoUsuario(estado);

        return u;
    }
}