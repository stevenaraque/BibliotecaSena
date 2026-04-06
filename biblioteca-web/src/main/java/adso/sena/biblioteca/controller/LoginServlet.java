package adso.sena.biblioteca.controller;

import adso.sena.biblioteca.model.Usuario;
import adso.sena.biblioteca.service.UsuarioService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private final UsuarioService usuarioService = new UsuarioService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Si ya hay sesión activa, redirigir según rol
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuario") != null) {
            Usuario u = (Usuario) session.getAttribute("usuario");
            response.sendRedirect(u.esAdmin() ? "dashboard" : "miPortal");
            return;
        }
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        // Validación básica de campos vacíos
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Por favor completa todos los campos.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }

        Usuario usuario = usuarioService.autenticar(email.trim(), password.trim());

        if (usuario != null) {
            // Crear sesión y guardar usuario
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            session.setMaxInactiveInterval(30 * 60); 

            // Redirigir según rol
            if (usuario.esAdmin()) {
                response.sendRedirect("dashboard");
            } else {
                response.sendRedirect("miPortal");
            }

        } else {
            request.setAttribute("error", "Correo o contraseña incorrectos, o usuario inactivo.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}