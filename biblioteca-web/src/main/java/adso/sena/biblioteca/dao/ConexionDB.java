package adso.sena.biblioteca.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase de conexión a la base de datos de la Biblioteca
 */
public class ConexionDB {

    private static final String URL = "jdbc:mysql://localhost:3306/biblioteca_db"
            + "?useSSL=false"
            + "&serverTimezone=UTC"
            + "&useUnicode=true"
            + "&characterEncoding=UTF-8"
            + "&allowPublicKeyRetrieval=true";

    private static final String USUARIO = "root";
    private static final String CLAVE = "1057585950";   // ← Tu contraseña

    /**
     * Obtiene una conexión a la base de datos
     * @return Connection
     * @throws SQLException 
     */
    public static Connection obtenerConexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");   // Cargamos el driver explícitamente
            Connection conn = DriverManager.getConnection(URL, USUARIO, CLAVE);
            System.out.println("✅ Conexión exitosa a la base de datos biblioteca_db");
            return conn;
        } catch (ClassNotFoundException e) {
            System.err.println("❌ No se encontró el driver de MySQL. Verifica que tengas el JAR agregado.");
            throw new SQLException("Driver de MySQL no encontrado", e);
        } catch (SQLException e) {
            System.err.println("❌ Error al conectar con la base de datos.");
            System.err.println("   Verifica que MySQL esté corriendo y la contraseña sea correcta.");
            throw e;
        }
    }
}