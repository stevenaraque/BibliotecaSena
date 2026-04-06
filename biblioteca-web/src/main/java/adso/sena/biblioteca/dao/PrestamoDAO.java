package adso.sena.biblioteca.dao;

import adso.sena.biblioteca.model.EstadoPrestamo;
import adso.sena.biblioteca.model.Libro;
import adso.sena.biblioteca.model.Prestamo;
import adso.sena.biblioteca.model.Usuario;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

public class PrestamoDAO {

    private static final String SQL_BASE =
            "SELECT p.id_prestamo, p.id_libro, p.id_usuario, "
            + "p.fecha_prestamo, p.fecha_devolucion_esperada, p.fecha_devolucion_real, "
            + "l.titulo AS libro_titulo, "
            + "u.nombres, u.apellidos, "
            + "ep.id_estado_prestamo, ep.nombre AS estado_nombre "
            + "FROM prestamo p "
            + "JOIN libro l            ON p.id_libro           = l.id_libro "
            + "JOIN usuario u          ON p.id_usuario         = u.id_usuario "
            + "JOIN estado_prestamo ep ON p.id_estado_prestamo = ep.id_estado_prestamo ";

    public List<Prestamo> listarTodos(String buscar) throws SQLException {
        List<Prestamo> prestamos = new ArrayList<>();
        String sql = SQL_BASE;
        if (buscar != null && !buscar.trim().isEmpty()) {
            sql += "WHERE l.titulo LIKE ? OR u.nombres LIKE ? OR u.apellidos LIKE ? ";
        }
        sql += "ORDER BY p.id_prestamo ASC";

        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (buscar != null && !buscar.trim().isEmpty()) {
                String patron = "%" + buscar.trim() + "%";
                ps.setString(1, patron);
                ps.setString(2, patron);
                ps.setString(3, patron);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) prestamos.add(mapearPrestamo(rs));
            }
        }
        return prestamos;
    }

    public List<Prestamo> listarPorUsuario(int idUsuario) throws SQLException {
        List<Prestamo> prestamos = new ArrayList<>();
        String sql = SQL_BASE
                + "WHERE p.id_usuario = ? "
                + "ORDER BY p.id_prestamo DESC";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) prestamos.add(mapearPrestamo(rs));
            }
        }
        return prestamos;
    }

    public boolean insertar(int idLibro, int idUsuario, LocalDate fechaDevolucion) throws SQLException {
        String sql = "INSERT INTO prestamo (id_libro, id_usuario, fecha_prestamo, "
                + "fecha_devolucion_esperada, id_estado_prestamo) "
                + "VALUES (?, ?, CURDATE(), ?, 1)";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idLibro);
            ps.setInt(2, idUsuario);
            ps.setObject(3, fechaDevolucion);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean actualizar(int idPrestamo, int idLibro, int idUsuario,
                               LocalDate fechaEsperada, LocalDate fechaReal,
                               String estado) throws SQLException {
        String sql = "UPDATE prestamo SET id_libro = ?, id_usuario = ?, "
                + "fecha_devolucion_esperada = ?, fecha_devolucion_real = ?, "
                + "id_estado_prestamo = ? WHERE id_prestamo = ?";
        int idEstado = 1;
        if ("devuelto".equalsIgnoreCase(estado)) idEstado = 2;
        if ("vencido".equalsIgnoreCase(estado))  idEstado = 3;

        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idLibro);
            ps.setInt(2, idUsuario);
            ps.setObject(3, fechaEsperada);
            ps.setObject(4, fechaReal);
            ps.setInt(5, idEstado);
            ps.setInt(6, idPrestamo);
            return ps.executeUpdate() > 0;
        }
    }

    // Devuelve el préstamo — registra multa si hay retraso
    public boolean devolver(int idPrestamo) throws SQLException {
        // Primero obtener fechas del préstamo
        String sqlSelect = "SELECT fecha_devolucion_esperada FROM prestamo WHERE id_prestamo = ?";
        LocalDate fechaEsperada;

        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sqlSelect)) {
            ps.setInt(1, idPrestamo);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return false;
                fechaEsperada = rs.getObject("fecha_devolucion_esperada", LocalDate.class);
            }
        }

        LocalDate hoy        = LocalDate.now();
        long diasRetraso     = ChronoUnit.DAYS.between(fechaEsperada, hoy);
        boolean hayRetraso   = diasRetraso > 0;

       
        int idEstado = hayRetraso ? 3 : 2;

        String sqlUpdate = "UPDATE prestamo SET fecha_devolucion_real = ?, "
                + "id_estado_prestamo = ? WHERE id_prestamo = ?";

        try (Connection conn = ConexionDB.obtenerConexion()) {
            conn.setAutoCommit(false);
            try {
                // 1. Actualizar préstamo
                try (PreparedStatement ps = conn.prepareStatement(sqlUpdate)) {
                    ps.setObject(1, hoy);
                    ps.setInt(2, idEstado);
                    ps.setInt(3, idPrestamo);
                    ps.executeUpdate();
                }

                // 2. Si hay retraso, registrar multa ($2.000 por día)
                if (hayRetraso) {
                    BigDecimal monto = new BigDecimal(diasRetraso * 2000);
                    String sqlMulta = "INSERT INTO multa (id_prestamo, monto, fecha_generacion, id_estado_multa) "
                            + "VALUES (?, ?, CURDATE(), 1)";
                    try (PreparedStatement ps = conn.prepareStatement(sqlMulta)) {
                        ps.setInt(1, idPrestamo);
                        ps.setBigDecimal(2, monto);
                        ps.executeUpdate();
                    }
                }

                // 3. Marcar libro como disponible nuevamente
                String sqlLibro = "UPDATE libro SET disponible = true "
                        + "WHERE id_libro = (SELECT id_libro FROM prestamo WHERE id_prestamo = ?)";
                try (PreparedStatement ps = conn.prepareStatement(sqlLibro)) {
                    ps.setInt(1, idPrestamo);
                    ps.executeUpdate();
                }

                conn.commit();
                return true;

            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public boolean eliminar(int idPrestamo) throws SQLException {
        String sqlMulta     = "DELETE FROM multa WHERE id_prestamo = ?";
        String sqlAuditoria = "DELETE FROM auditoria_prestamo WHERE id_prestamo = ?";
        String sqlPrestamo  = "DELETE FROM prestamo WHERE id_prestamo = ?";

        try (Connection conn = ConexionDB.obtenerConexion()) {
            conn.setAutoCommit(false);
            try {
                try (PreparedStatement ps = conn.prepareStatement(sqlMulta)) {
                    ps.setInt(1, idPrestamo); ps.executeUpdate();
                }
                try (PreparedStatement ps = conn.prepareStatement(sqlAuditoria)) {
                    ps.setInt(1, idPrestamo); ps.executeUpdate();
                }
                try (PreparedStatement ps = conn.prepareStatement(sqlPrestamo)) {
                    ps.setInt(1, idPrestamo);
                    int filas = ps.executeUpdate();
                    conn.commit();
                    return filas > 0;
                }
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public int contarTodos() throws SQLException {
        String sql = "SELECT COUNT(*) FROM prestamo";
        try (Connection conn = ConexionDB.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    private Prestamo mapearPrestamo(ResultSet rs) throws SQLException {
        Prestamo prestamo = new Prestamo();
        prestamo.setIdPrestamo(rs.getInt("id_prestamo"));
        prestamo.setFechaPrestamo(rs.getObject("fecha_prestamo", LocalDate.class));
        prestamo.setFechaDevolucionEsperada(rs.getObject("fecha_devolucion_esperada", LocalDate.class));
        prestamo.setFechaDevolucionReal(rs.getObject("fecha_devolucion_real", LocalDate.class));

        Libro libro = new Libro();
        libro.setIdLibro(rs.getInt("id_libro"));
        libro.setTitulo(rs.getString("libro_titulo"));
        prestamo.setLibro(libro);

        Usuario usuario = new Usuario();
        usuario.setIdUsuario(rs.getInt("id_usuario"));
        usuario.setNombres(rs.getString("nombres"));
        usuario.setApellidos(rs.getString("apellidos"));
        prestamo.setUsuario(usuario);

        EstadoPrestamo estado = new EstadoPrestamo();
        estado.setIdEstadoPrestamo(rs.getInt("id_estado_prestamo"));
        estado.setNombre(rs.getString("estado_nombre"));
        prestamo.setEstadoPrestamo(estado);

        return prestamo;
    }
}