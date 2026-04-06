package adso.sena.biblioteca.controller;

import adso.sena.biblioteca.service.*;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private final UsuarioService usuarioService = new UsuarioService();
    private final LibroService libroService = new LibroService();
    private final PrestamoService prestamoService = new PrestamoService();
    private final MultaService multaService = new MultaService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login");
            return;
        }

        request.setAttribute("totalUsuarios", usuarioService.contarUsuarios());
        request.setAttribute("totalLibros", libroService.contarLibros());
        request.setAttribute("totalPrestamos", prestamoService.contarTodos());

        request.setAttribute("totalMultas", multaService.contarTodas());
        request.setAttribute("multasPendientes", multaService.contarMultasPendientes());
        request.setAttribute("totalDeuda", multaService.totalDeudaPendiente());

        request.setAttribute("usuario", session.getAttribute("usuario"));

        request.getRequestDispatcher("/views/adminDashboard.jsp").forward(request, response);
    }
}