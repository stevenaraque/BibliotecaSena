package adso.sena.biblioteca.controller;

import adso.sena.biblioteca.model.EstadoUsuario;
import adso.sena.biblioteca.model.TipoUsuario;
import adso.sena.biblioteca.model.Usuario;
import adso.sena.biblioteca.service.UsuarioService;
import adso.sena.biblioteca.dao.TipoUsuarioDAO;
import adso.sena.biblioteca.dao.EstadoUsuarioDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/usuarios"})
public class UsuarioServlet extends HttpServlet {

    private final UsuarioService usuarioService   = new UsuarioService();
    private final TipoUsuarioDAO tipoUsuarioDAO   = new TipoUsuarioDAO();
    private final EstadoUsuarioDAO estadoUsuarioDAO = new EstadoUsuarioDAO();

   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        
        String buscar = request.getParameter("buscar");
        List<Usuario> usuarios;
        
        if (buscar != null && !buscar.trim().isEmpty()) {
            usuarios = usuarioService.buscarPorNombreODocumento(buscar.trim());
        } else {
            usuarios = usuarioService.listarTodos();
        }
        
        request.setAttribute("usuarios", usuarios);
        request.setAttribute("buscar", buscar);  // Para mantener valor en el input
        request.setAttribute("tiposUsuario", tipoUsuarioDAO.listarTodos());
        request.setAttribute("estadosUsuario", estadoUsuarioDAO.listarTodos());
    } catch (Exception e) {
        request.setAttribute("mensaje", "❌ Error al cargar datos: " + e.getMessage());
    }
    request.getRequestDispatcher("/views/usuarios.jsp").forward(request, response);
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String mensaje = "";

        try {
            if ("create".equals(action) || "update".equals(action)) {
                String documento    = request.getParameter("documento");
                String nombres      = request.getParameter("nombres");
                String apellidos    = request.getParameter("apellidos");
                String email        = request.getParameter("email");
                String telefono     = request.getParameter("telefono");
                int idTipo          = Integer.parseInt(request.getParameter("idTipoUsuario"));
                int idEstado        = Integer.parseInt(request.getParameter("idEstadoUsuario"));

                TipoUsuario tipo = new TipoUsuario();
                tipo.setIdTipoUsuario(idTipo);

                EstadoUsuario estado = new EstadoUsuario();
                estado.setIdEstadoUsuario(idEstado);

                Usuario usuario = new Usuario();
                usuario.setDocumento(documento);
                usuario.setNombres(nombres);
                usuario.setApellidos(apellidos);
                usuario.setEmail(email);
                usuario.setTelefono(telefono);
                usuario.setTipoUsuario(tipo);
                usuario.setEstadoUsuario(estado);

                if ("create".equals(action)) {
                    boolean resultado = usuarioService.registrarUsuario(usuario);
                    mensaje = resultado ? "✅ Usuario creado correctamente" : "❌ Error al crear usuario";
                } else {
                    usuario.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
                    boolean resultado = usuarioService.actualizarUsuario(usuario);
                    mensaje = resultado ? "✅ Usuario actualizado correctamente" : "❌ Error al actualizar usuario";
                }

            } else if ("delete".equals(action)) {
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                boolean resultado = usuarioService.eliminar(idUsuario);
                mensaje = resultado ? "✅ Usuario eliminado correctamente" : "❌ Error al eliminar usuario";
            }

        } catch (Exception e) {
            mensaje = "❌ Error: " + e.getMessage();
        }

        request.setAttribute("mensaje", mensaje);
        doGet(request, response);
    }
}