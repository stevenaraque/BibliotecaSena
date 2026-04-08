package adso.sena.biblioteca.service;

import adso.sena.biblioteca.dao.UsuarioDAO;
import adso.sena.biblioteca.model.Usuario;
import java.sql.SQLException;
import java.util.List;

public class UsuarioService {
    private final UsuarioDAO usuarioDAO;

    public UsuarioService() {
        this.usuarioDAO = new UsuarioDAO();
    }

    public List<Usuario> listarTodos() {
        try {
            return usuarioDAO.listarTodos();
        } catch (SQLException e) {
            System.err.println("Error al listar usuarios: " + e.getMessage());
            return null;
        }
    }
    public Usuario autenticar(String email, String password) {
    try {
        return usuarioDAO.buscarPorEmailYPassword(email, password);
    } catch (SQLException e) {
        System.err.println("Error al autenticar usuario: " + e.getMessage());
        return null;
    }
}

    public Usuario buscarPorId(int idUsuario) {
        try {
            return usuarioDAO.buscarPorId(idUsuario);
        } catch (SQLException e) {
            System.err.println("Error al buscar usuario por ID: " + e.getMessage());
            return null;
        }
    }

    public Usuario buscarPorEmail(String email) {
        try {
            return usuarioDAO.buscarPorEmail(email);
        } catch (SQLException e) {
            System.err.println("Error al buscar usuario por email: " + e.getMessage());
            return null;
        }
    }

    public boolean registrarUsuario(Usuario usuario) {
        if (usuario == null) return false;
        try {
            return usuarioDAO.insertar(usuario);
        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) {
                throw new RuntimeException("El documento o email ya está registrado.");
            }
            System.err.println("Error al registrar usuario: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizarUsuario(Usuario usuario) {
        if (usuario == null) return false;
        try {
            return usuarioDAO.actualizar(usuario);
        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) {
                throw new RuntimeException("El documento o email ya está registrado en otro usuario.");
            }
            System.err.println("Error al actualizar usuario: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int idUsuario) {
        try {
            return usuarioDAO.eliminar(idUsuario);
        } catch (SQLException e) {
            System.err.println("Error al eliminar usuario: " + e.getMessage());
            return false;
        }
    }

    public int contarUsuarios() {
        try {
            return usuarioDAO.contarTodos();
        } catch (Exception e) {
            return 0;
        }
    }
    public List<Usuario> buscarPorNombreODocumento(String criterio) {
    try {
        return usuarioDAO.buscarPorNombreODocumento(criterio);
    } catch (SQLException e) {
        System.err.println("Error al buscar usuarios: " + e.getMessage());
        return null;
    }
}
}