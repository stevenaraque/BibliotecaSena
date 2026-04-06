package adso.sena.biblioteca.controller;

import adso.sena.biblioteca.model.EstadoUsuario;
import adso.sena.biblioteca.model.TipoUsuario;
import adso.sena.biblioteca.model.Usuario;
import adso.sena.biblioteca.service.UsuarioService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/registro"})
public class RegistroServlet extends HttpServlet {

    private final UsuarioService usuarioService = new UsuarioService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String mensaje = "";
        String error   = "";

        try {
            String nombres   = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String documento = request.getParameter("documento");
            String telefono  = request.getParameter("telefono");
            String email     = request.getParameter("email");
            String password  = request.getParameter("password");
            int idTipo       = Integer.parseInt(request.getParameter("idTipoUsuario"));

            // ✅ Solo permite estudiante (1) o docente (2) — nunca admin (3)
            if (idTipo == 3) idTipo = 1;

            TipoUsuario tipo = new TipoUsuario();
            tipo.setIdTipoUsuario(idTipo);

            EstadoUsuario estado = new EstadoUsuario();
            estado.setIdEstadoUsuario(1); // activo por defecto

            Usuario usuario = new Usuario();
            usuario.setNombres(nombres);
            usuario.setApellidos(apellidos);
            usuario.setDocumento(documento);
            usuario.setTelefono(telefono);
            usuario.setEmail(email);
            usuario.setPassword(password);
            usuario.setTipoUsuario(tipo);
            usuario.setEstadoUsuario(estado);

            boolean resultado = usuarioService.registrarUsuario(usuario);
            if (resultado) {
                mensaje = "Cuenta creada correctamente. Ya puedes iniciar sesión.";
            } else {
                error = "No se pudo crear la cuenta. Intenta de nuevo.";
            }

        } catch (RuntimeException e) {
            error = e.getMessage();
        } catch (Exception e) {
            error = "Error inesperado: " + e.getMessage();
        }

        if (!mensaje.isEmpty()) {
            request.setAttribute("mensaje", mensaje);
        } else {
            request.setAttribute("error", error);
        }

        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
}