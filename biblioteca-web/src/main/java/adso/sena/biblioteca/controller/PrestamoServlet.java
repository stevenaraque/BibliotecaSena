package adso.sena.biblioteca.controller;

import adso.sena.biblioteca.service.LibroService;
import adso.sena.biblioteca.service.PrestamoService;
import adso.sena.biblioteca.service.UsuarioService;
import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PrestamoServlet", urlPatterns = {"/prestamos"})
public class PrestamoServlet extends HttpServlet {

    private final PrestamoService prestamoService = new PrestamoService();
    private final LibroService    libroService    = new LibroService();
    private final UsuarioService  usuarioService  = new UsuarioService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login");
            return;
        }

        String buscar = request.getParameter("buscar");
        request.setAttribute("prestamos", prestamoService.listarTodos(buscar));
        request.setAttribute("libros",    libroService.listarTodos());
        request.setAttribute("usuarios",  usuarioService.listarTodos());
        request.setAttribute("usuario",   session.getAttribute("usuario"));
        request.getRequestDispatcher("/views/prestamos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action  = request.getParameter("action");
        String mensaje = "";

        try {
            if ("create".equals(action)) {
                int idLibro             = Integer.parseInt(request.getParameter("idLibro"));
                int idUsuario           = Integer.parseInt(request.getParameter("idUsuario"));
                LocalDate fechaEsperada = LocalDate.parse(request.getParameter("fechaDevolucionEsperada"));
                boolean guardado        = prestamoService.registrar(idLibro, idUsuario, fechaEsperada);
                mensaje = guardado
                        ? "✅ Préstamo creado correctamente"
                        : "❌ Error al crear préstamo";

            } else if ("update".equals(action)) {
                int idPrestamo          = Integer.parseInt(request.getParameter("idPrestamo"));
                int idLibro             = Integer.parseInt(request.getParameter("idLibro"));
                int idUsuario           = Integer.parseInt(request.getParameter("idUsuario"));
                LocalDate fechaEsperada = LocalDate.parse(request.getParameter("fechaDevolucionEsperada"));
                String fechaRealStr     = request.getParameter("fechaDevolucionReal");
                LocalDate fechaReal     = (fechaRealStr == null || fechaRealStr.isEmpty())
                        ? null : LocalDate.parse(fechaRealStr);
                String estado           = request.getParameter("estado");
                boolean actualizado     = prestamoService.actualizar(idPrestamo, idLibro, idUsuario, fechaEsperada, fechaReal, estado);
                mensaje = actualizado
                        ? "✅ Préstamo actualizado correctamente"
                        : "❌ Error al actualizar préstamo";

            } else if ("delete".equals(action)) {
                int idPrestamo    = Integer.parseInt(request.getParameter("idPrestamo"));
                boolean eliminado = prestamoService.eliminar(idPrestamo);
                mensaje = eliminado
                        ? "✅ Préstamo eliminado correctamente"
                        : "❌ Error al eliminar préstamo";
            }

        } catch (Exception e) {
            mensaje = "❌ Error: " + e.getMessage();
        }

        request.setAttribute("mensaje", mensaje);
        doGet(request, response);
    }
}