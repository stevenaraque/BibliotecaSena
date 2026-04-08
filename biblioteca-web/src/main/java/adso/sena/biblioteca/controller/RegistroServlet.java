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
import javax.servlet.http.HttpSession;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/registro"})
public class RegistroServlet extends HttpServlet {

    private final UsuarioService usuarioService = new UsuarioService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String mensajeFlash = null;
        String errorFlash   = null;

        try {
            String nombres   = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String documento = request.getParameter("documento");
            String telefono  = request.getParameter("telefono");
            String email     = request.getParameter("email");
            String password  = request.getParameter("password");
            String idTipoStr = request.getParameter("idTipoUsuario");

            // Validación
            if (nombres == null || nombres.trim().isEmpty()
                    || apellidos == null || apellidos.trim().isEmpty()
                    || documento == null || documento.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || password == null || password.trim().isEmpty()
                    || idTipoStr == null || idTipoStr.trim().isEmpty()) {
                errorFlash = "Por favor completa todos los campos obligatorios.";
            } else {
                int idTipo = Integer.parseInt(idTipoStr);
                if (idTipo == 3) idTipo = 1; // no se permite registrar admins

                TipoUsuario tipo = new TipoUsuario();
                tipo.setIdTipoUsuario(idTipo);

                EstadoUsuario estado = new EstadoUsuario();
                estado.setIdEstadoUsuario(1); // activo por defecto

                Usuario usuario = new Usuario();
                usuario.setNombres(nombres.trim());
                usuario.setApellidos(apellidos.trim());
                usuario.setDocumento(documento.trim());
                usuario.setTelefono(telefono != null ? telefono.trim() : "");
                usuario.setEmail(email.trim());
                usuario.setPassword(password.trim());
                usuario.setTipoUsuario(tipo);
                usuario.setEstadoUsuario(estado);

                boolean resultado = usuarioService.registrarUsuario(usuario);

                if (resultado) {
                    mensajeFlash = "Cuenta creada correctamente. Ya puedes iniciar sesion.";
                } else {
                    errorFlash = "No se pudo crear la cuenta. El correo o documento ya estan registrados.";
                }
            }

        } catch (RuntimeException e) {
            errorFlash = e.getMessage() != null
                    ? e.getMessage()
                    : "Error al procesar el registro.";
            e.printStackTrace();
        } catch (Exception e) {
            errorFlash = "Error inesperado: " + e.getMessage();
            e.printStackTrace();
        }

        // Guardar en sesión para que LoginServlet los lea al redirigir
        HttpSession session = request.getSession();
        if (mensajeFlash != null) session.setAttribute("mensaje", mensajeFlash);
        if (errorFlash   != null) session.setAttribute("error",   errorFlash);

        response.sendRedirect(request.getContextPath() + "/login");
    }
}