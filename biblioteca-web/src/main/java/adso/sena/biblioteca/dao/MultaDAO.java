package adso.sena.biblioteca.dao;

import adso.sena.biblioteca.model.EstadoMulta;
import adso.sena.biblioteca.model.Multa;
import adso.sena.biblioteca.model.Prestamo;
import adso.sena.biblioteca.model.Usuario;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class MultaDAO {

    public List<Multa> listarTodas() throws SQLException {
        List<Multa> multas = new ArrayList<>();
        String sql = "SELECT m.id_multa, m.monto, m.fecha_generacion, m.fecha_pago, "
                + "p.id_prestamo, "
                + "u.nombres, u.apellidos, "
                + "l.titulo AS libro_titulo, "
                + "em.id_estado_multa, em.nombre AS estado_nombre "
                + "FROM multa m "
                + "JOIN prestamo p  ON m.id_prestamo  = p.id_prestamo "
                + "JOIN usuario u   ON p.id_usuario   = u.id_usuario "
                + "JOIN libro l     ON p.id_libro     = l.id_libro "
                + "JOIN estado_multa em ON m.id_estado_multa = em.id_estado_multa "
                + "ORDER BY m.id_multa ASC";

        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                multas.add(mapearMulta(rs));
            }
        }
        return multas;
    }

    public boolean registrar(int idPrestamo, BigDecimal monto) throws SQLException {
        String sql = "INSERT INTO multa (id_prestamo, monto, fecha_generacion, id_estado_multa) "
                + "VALUES (?, ?, CURDATE(), 1)";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idPrestamo);
            ps.setBigDecimal(2, monto);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean actualizar(int idMulta, int idPrestamo, BigDecimal monto,
                               LocalDate fechaPago, int idEstado) throws SQLException {
        String sql = "UPDATE multa SET id_prestamo = ?, monto = ?, fecha_pago = ?, "
                + "id_estado_multa = ? WHERE id_multa = ?";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idPrestamo);
            ps.setBigDecimal(2, monto);
            ps.setObject(3, fechaPago);   
            ps.setInt(4, idEstado);
            ps.setInt(5, idMulta);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean eliminar(int idMulta) throws SQLException {
        String sql = "DELETE FROM multa WHERE id_multa = ?";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idMulta);
            return ps.executeUpdate() > 0;
        }
    }

    public int contarPendientes() throws SQLException {
        String sql = "SELECT COUNT(*) FROM multa WHERE id_estado_multa = 1";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public int contarTodas() throws SQLException {
        String sql = "SELECT COUNT(*) FROM multa";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public double totalMultasPendientes() throws SQLException {
        String sql = "SELECT COALESCE(SUM(monto), 0) FROM multa WHERE id_estado_multa = 1";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        }
        return 0;
    }
    public List<Multa> listarPorUsuario(int idUsuario) throws SQLException {
    List<Multa> multas = new ArrayList<>();
    String sql = "SELECT m.id_multa, m.monto, m.fecha_generacion, m.fecha_pago, "
               + "p.id_prestamo, "
               + "u.nombres, u.apellidos, "
               + "l.titulo AS libro_titulo, "
               + "em.id_estado_multa, em.nombre AS estado_nombre "
               + "FROM multa m "
               + "JOIN prestamo p      ON m.id_prestamo      = p.id_prestamo "
               + "JOIN usuario u       ON p.id_usuario        = u.id_usuario "
               + "JOIN libro l         ON p.id_libro          = l.id_libro "
               + "JOIN estado_multa em ON m.id_estado_multa   = em.id_estado_multa "
               + "WHERE p.id_usuario = ? "
               + "ORDER BY m.id_multa DESC";

    try (Connection conn = ConexionDB.obtenerConexion();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, idUsuario);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                multas.add(mapearMulta(rs));
            }
        }
    }
    return multas;
}
    public List<Multa> buscarPorUsuarioOLibro(String criterio) throws SQLException {
    List<Multa> multas = new ArrayList<>();
    
    
    String sql = "SELECT m.id_multa, m.monto, m.fecha_generacion, m.fecha_pago, "
               + "p.id_prestamo, "
               + "u.nombres, u.apellidos, "
               + "l.titulo AS libro_titulo, "
               + "em.id_estado_multa, em.nombre AS estado_nombre "
               + "FROM multa m "
               + "JOIN prestamo p ON m.id_prestamo = p.id_prestamo "
               + "JOIN usuario u ON p.id_usuario = u.id_usuario "
               + "JOIN libro l ON p.id_libro = l.id_libro "
               + "JOIN estado_multa em ON m.id_estado_multa = em.id_estado_multa "  // <-- FALTABA ESTO
               + "WHERE u.nombres LIKE ? OR u.apellidos LIKE ? OR l.titulo LIKE ?";
    
    String like = "%" + criterio + "%";
    try (Connection conn = ConexionDB.obtenerConexion();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, like);
        ps.setString(2, like);
        ps.setString(3, like);
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                multas.add(mapearMulta(rs)); // Ahora sí funciona
            }
        }
    }
    return multas;
}

    private Multa mapearMulta(ResultSet rs) throws SQLException {
        Multa multa = new Multa();
        multa.setIdMulta(rs.getInt("id_multa"));
        multa.setMonto(rs.getBigDecimal("monto"));
        multa.setFechaGeneracion(rs.getObject("fecha_generacion", LocalDate.class));
        multa.setFechaPago(rs.getObject("fecha_pago", LocalDate.class));

        Prestamo prestamo = new Prestamo();
        prestamo.setIdPrestamo(rs.getInt("id_prestamo"));

        Usuario usuario = new Usuario();
        usuario.setNombres(rs.getString("nombres"));
        usuario.setApellidos(rs.getString("apellidos"));
        prestamo.setUsuario(usuario);

        // Título del libro para mostrarlo en la tabla
        adso.sena.biblioteca.model.Libro libro = new adso.sena.biblioteca.model.Libro();
        libro.setTitulo(rs.getString("libro_titulo"));
        prestamo.setLibro(libro);

        multa.setPrestamo(prestamo);

        EstadoMulta estado = new EstadoMulta();
        estado.setIdEstadoMulta(rs.getInt("id_estado_multa"));
        estado.setNombre(rs.getString("estado_nombre"));
        multa.setEstadoMulta(estado);

        return multa;
    }
}