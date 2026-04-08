package adso.sena.biblioteca.dao;

import adso.sena.biblioteca.model.Autor;
import adso.sena.biblioteca.model.Categoria;
import adso.sena.biblioteca.model.Editorial;
import adso.sena.biblioteca.model.Libro;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LibroDAO {

    public List<Libro> listarTodos() throws SQLException {
        List<Libro> libros = new ArrayList<>();
        String sql = "SELECT l.id_libro, l.titulo, l.isbn, l.anio_publicacion, l.num_paginas, l.disponible, "
                + "a.id_autor, a.nombres, a.apellidos, "
                + "c.id_categoria, c.nombre AS nombre_categoria, "
                + "e.id_editorial, e.nombre AS nombre_editorial "
                + "FROM libro l "
                + "LEFT JOIN libro_autor la ON l.id_libro = la.id_libro "
                + "LEFT JOIN autor a ON la.id_autor = a.id_autor "
                + "LEFT JOIN categoria c ON l.id_categoria = c.id_categoria "
                + "LEFT JOIN editorial e ON l.id_editorial = e.id_editorial "
                + "ORDER BY l.id_libro ASC";
        try (Connection conn = ConexionDB.obtenerConexion(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Libro libro = new Libro();
                libro.setIdLibro(rs.getInt("id_libro"));
                libro.setTitulo(rs.getString("titulo"));
                libro.setIsbn(rs.getString("isbn"));
                libro.setAnioPublicacion(rs.getInt("anio_publicacion"));
                libro.setNumPaginas(rs.getInt("num_paginas"));
                libro.setDisponible(rs.getBoolean("disponible"));

                Autor autor = new Autor();
                autor.setIdAutor(rs.getInt("id_autor"));
                autor.setNombres(rs.getString("nombres"));
                autor.setApellidos(rs.getString("apellidos"));
                libro.setAutor(autor);

                Categoria categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("id_categoria"));
                categoria.setNombre(rs.getString("nombre_categoria"));
                libro.setCategoria(categoria);

                Editorial editorial = new Editorial();
                editorial.setIdEditorial(rs.getInt("id_editorial"));
                editorial.setNombre(rs.getString("nombre_editorial"));
                libro.setEditorial(editorial);

                libros.add(libro);
            }
        }
        return libros;
    }

    public int insertar(Libro libro) throws SQLException {
        String sql = "INSERT INTO libro (titulo, isbn, anio_publicacion, num_paginas, id_categoria, id_editorial, disponible) "
                + "VALUES (?, ?, ?, ?, ?, ?, true)";
        try (Connection conn = ConexionDB.obtenerConexion(); PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, libro.getTitulo());
            ps.setString(2, libro.getIsbn());
            ps.setInt(3, libro.getAnioPublicacion());
            ps.setInt(4, libro.getNumPaginas());
            ps.setInt(5, libro.getCategoria().getIdCategoria());
            ps.setInt(6, libro.getEditorial().getIdEditorial());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    public boolean asociarAutor(int idLibro, int idAutor) throws SQLException {
        String sql = "INSERT INTO libro_autor (id_libro, id_autor) VALUES (?, ?)";
        try (Connection conn = ConexionDB.obtenerConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idLibro);
            ps.setInt(2, idAutor);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean actualizar(Libro libro) throws SQLException {
        String sql = "UPDATE libro SET titulo = ?, isbn = ?, anio_publicacion = ?, "
                + "num_paginas = ?, id_categoria = ?, id_editorial = ?, disponible = ? "
                + "WHERE id_libro = ?";
        try (Connection conn = ConexionDB.obtenerConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, libro.getTitulo());
            ps.setString(2, libro.getIsbn());
            ps.setInt(3, libro.getAnioPublicacion());
            ps.setInt(4, libro.getNumPaginas());
            ps.setInt(5, libro.getCategoria().getIdCategoria());
            ps.setInt(6, libro.getEditorial().getIdEditorial());
            ps.setBoolean(7, libro.isDisponible());
            ps.setInt(8, libro.getIdLibro());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean eliminar(int idLibro) throws SQLException {
        String sqlMultas = "DELETE FROM multa WHERE id_prestamo IN (SELECT id_prestamo FROM prestamo WHERE id_libro = ?)";
        String sqlAuditoria = "DELETE FROM auditoria_prestamo WHERE id_libro = ?";
        String sqlPrestamos = "DELETE FROM prestamo WHERE id_libro = ?";
        String sqlAutores = "DELETE FROM libro_autor WHERE id_libro = ?";
        String sqlLibro = "DELETE FROM libro WHERE id_libro = ?";

        try (Connection conn = ConexionDB.obtenerConexion()) {
            conn.setAutoCommit(false);
            try {
                try (PreparedStatement ps = conn.prepareStatement(sqlMultas)) {
                    ps.setInt(1, idLibro);
                    ps.executeUpdate();
                }
                try (PreparedStatement ps = conn.prepareStatement(sqlAuditoria)) {
                    ps.setInt(1, idLibro);
                    ps.executeUpdate();
                }
                try (PreparedStatement ps = conn.prepareStatement(sqlPrestamos)) {
                    ps.setInt(1, idLibro);
                    ps.executeUpdate();
                }
                try (PreparedStatement ps = conn.prepareStatement(sqlAutores)) {
                    ps.setInt(1, idLibro);
                    ps.executeUpdate();
                }
                try (PreparedStatement ps = conn.prepareStatement(sqlLibro)) {
                    ps.setInt(1, idLibro);
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

    public List<Libro> listarDisponibles() throws SQLException {
        List<Libro> libros = new ArrayList<>();
        String sql = "SELECT l.id_libro, l.titulo, l.isbn, l.anio_publicacion, l.num_paginas, l.disponible, "
                + "a.id_autor, a.nombres, a.apellidos, "
                + "c.id_categoria, c.nombre AS nombre_categoria, "
                + "e.id_editorial, e.nombre AS nombre_editorial "
                + "FROM libro l "
                + "LEFT JOIN libro_autor la ON l.id_libro = la.id_libro "
                + "LEFT JOIN autor a        ON la.id_autor = a.id_autor "
                + "LEFT JOIN categoria c    ON l.id_categoria = c.id_categoria "
                + "LEFT JOIN editorial e    ON l.id_editorial = e.id_editorial "
                + "WHERE l.disponible = true "
                + "ORDER BY l.titulo ASC";

        try (Connection conn = ConexionDB.obtenerConexion(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Libro libro = new Libro();
                libro.setIdLibro(rs.getInt("id_libro"));
                libro.setTitulo(rs.getString("titulo"));
                libro.setIsbn(rs.getString("isbn"));
                libro.setAnioPublicacion(rs.getInt("anio_publicacion"));
                libro.setNumPaginas(rs.getInt("num_paginas"));
                libro.setDisponible(rs.getBoolean("disponible"));

                Autor autor = new Autor();
                autor.setIdAutor(rs.getInt("id_autor"));
                autor.setNombres(rs.getString("nombres"));
                autor.setApellidos(rs.getString("apellidos"));
                libro.setAutor(autor);

                Categoria categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("id_categoria"));
                categoria.setNombre(rs.getString("nombre_categoria"));
                libro.setCategoria(categoria);

                Editorial editorial = new Editorial();
                editorial.setIdEditorial(rs.getInt("id_editorial"));
                editorial.setNombre(rs.getString("nombre_editorial"));
                libro.setEditorial(editorial);

                libros.add(libro);
            }
        }
        return libros;
    }

    public int contarLibros() throws SQLException {
        String sql = "SELECT COUNT(*) FROM libro";
        try (Connection conn = ConexionDB.obtenerConexion(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public List<Libro> buscarDisponibles(String buscar) throws SQLException {
        List<Libro> libros = new ArrayList<>();
        String patron = "%" + buscar + "%";
        String sql = "SELECT l.id_libro, l.titulo, l.isbn, l.anio_publicacion, "
                + "l.num_paginas, l.disponible, "
                + "a.id_autor, a.nombres, a.apellidos, "
                + "c.id_categoria, c.nombre AS nombre_categoria, "
                + "e.id_editorial, e.nombre AS nombre_editorial "
                + "FROM libro l "
                + "LEFT JOIN libro_autor la ON l.id_libro = la.id_libro "
                + "LEFT JOIN autor a        ON la.id_autor = a.id_autor "
                + "LEFT JOIN categoria c    ON l.id_categoria = c.id_categoria "
                + "LEFT JOIN editorial e    ON l.id_editorial = e.id_editorial "
                + "WHERE l.disponible = true "
                + "AND (l.titulo LIKE ? OR a.nombres LIKE ? OR a.apellidos LIKE ? "
                + "OR c.nombre LIKE ?) "
                + "ORDER BY l.titulo ASC";

        try (Connection conn = ConexionDB.obtenerConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, patron);
            ps.setString(2, patron);
            ps.setString(3, patron);
            ps.setString(4, patron);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    libros.add(mapearLibroSimple(rs));
                }
            }
        }
        return libros;
    }
    public List<Libro> buscarEnCatalogo(String texto) throws SQLException {
    List<Libro> libros = new ArrayList<>();
    String sql = "SELECT l.id_libro, l.titulo, l.isbn, l.anio_publicacion, l.num_paginas, l.disponible, " +
                 "a.id_autor, a.nombres, a.apellidos, " +
                 "c.id_categoria, c.nombre AS nombre_categoria, " +
                 "e.id_editorial, e.nombre AS nombre_editorial " +
                 "FROM libro l " +
                 "LEFT JOIN libro_autor la ON l.id_libro = la.id_libro " +
                 "LEFT JOIN autor a ON la.id_autor = a.id_autor " +
                 "LEFT JOIN categoria c ON l.id_categoria = c.id_categoria " +
                 "LEFT JOIN editorial e ON l.id_editorial = e.id_editorial " +
                 "WHERE l.titulo LIKE ? OR a.nombres LIKE ? OR a.apellidos LIKE ? OR c.nombre LIKE ? " +
                 "ORDER BY l.id_libro ASC";
    String like = "%" + texto + "%";
    try (Connection conn = ConexionDB.obtenerConexion();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, like);
        ps.setString(2, like);
        ps.setString(3, like);
        ps.setString(4, like);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Libro libro = new Libro();
                libro.setIdLibro(rs.getInt("id_libro"));
                libro.setTitulo(rs.getString("titulo"));
                libro.setIsbn(rs.getString("isbn"));
                libro.setAnioPublicacion(rs.getInt("anio_publicacion"));
                libro.setNumPaginas(rs.getInt("num_paginas"));
                libro.setDisponible(rs.getBoolean("disponible"));

                Autor autor = new Autor();
                autor.setIdAutor(rs.getInt("id_autor"));
                autor.setNombres(rs.getString("nombres"));
                autor.setApellidos(rs.getString("apellidos"));
                libro.setAutor(autor);

                Categoria categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("id_categoria"));
                categoria.setNombre(rs.getString("nombre_categoria"));
                libro.setCategoria(categoria);

                Editorial editorial = new Editorial();
                editorial.setIdEditorial(rs.getInt("id_editorial"));
                editorial.setNombre(rs.getString("nombre_editorial"));
                libro.setEditorial(editorial);

                libros.add(libro);
            }
        }
    }
    return libros;
}
    public Libro obtenerPorId(int idLibro) throws SQLException {
    String sql = "SELECT l.id_libro, l.titulo, l.isbn, l.anio_publicacion, l.num_paginas, l.disponible, "
            + "a.id_autor, a.nombres, a.apellidos, "
            + "c.id_categoria, c.nombre AS nombre_categoria, "
            + "e.id_editorial, e.nombre AS nombre_editorial "
            + "FROM libro l "
            + "LEFT JOIN libro_autor la ON l.id_libro = la.id_libro "
            + "LEFT JOIN autor a ON la.id_autor = a.id_autor "
            + "LEFT JOIN categoria c ON l.id_categoria = c.id_categoria "
            + "LEFT JOIN editorial e ON l.id_editorial = e.id_editorial "
            + "WHERE l.id_libro = ?";

    try (Connection conn = ConexionDB.obtenerConexion();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, idLibro);
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return mapearLibroSimple(rs);
            }
        }
    }
    return null;
}

    private Libro mapearLibroSimple(ResultSet rs) throws SQLException {
        Libro libro = new Libro();
        libro.setIdLibro(rs.getInt("id_libro"));
        libro.setTitulo(rs.getString("titulo"));
        libro.setIsbn(rs.getString("isbn"));
        libro.setAnioPublicacion(rs.getInt("anio_publicacion"));
        libro.setNumPaginas(rs.getInt("num_paginas"));
        libro.setDisponible(rs.getBoolean("disponible"));

        Autor autor = new Autor();
        autor.setIdAutor(rs.getInt("id_autor"));
        autor.setNombres(rs.getString("nombres"));
        autor.setApellidos(rs.getString("apellidos"));
        libro.setAutor(autor);

        Categoria categoria = new Categoria();
        categoria.setIdCategoria(rs.getInt("id_categoria"));
        categoria.setNombre(rs.getString("nombre_categoria"));
        libro.setCategoria(categoria);

        Editorial editorial = new Editorial();
        editorial.setIdEditorial(rs.getInt("id_editorial"));
        editorial.setNombre(rs.getString("nombre_editorial"));
        libro.setEditorial(editorial);

        return libro;
    }
}
