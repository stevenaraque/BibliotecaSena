package adso.sena.biblioteca.controller;

import adso.sena.biblioteca.model.Multa;
import adso.sena.biblioteca.model.Prestamo;
import adso.sena.biblioteca.model.Usuario;
import adso.sena.biblioteca.service.LibroService;
import adso.sena.biblioteca.service.MultaService;
import adso.sena.biblioteca.service.PrestamoService;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "MiPortalServlet", urlPatterns = {"/miPortal"})
public class MiPortalServlet extends HttpServlet {

    private final PrestamoService prestamoService = new PrestamoService();
    private final MultaService    multaService    = new MultaService();
    private final LibroService    libroService    = new LibroService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        List<Prestamo> prestamos = prestamoService.listarPorUsuario(usuario.getIdUsuario());
        List<Multa>    multas    = multaService.listarPorUsuario(usuario.getIdUsuario());

        request.setAttribute("misPrestamos",      prestamos);
        request.setAttribute("misMultas",         multas);
        request.setAttribute("totalPrestamos",    prestamos.size());
        request.setAttribute("totalMultas",       multas.size());
        request.setAttribute("librosDisponibles", libroService.listarDisponibles());
        request.setAttribute("usuario",           usuario);

        request.getRequestDispatcher("/views/miPortal.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String action  = request.getParameter("action");
        String mensaje = "";

        try {
            if ("solicitar".equals(action)) {
                int idLibro             = Integer.parseInt(request.getParameter("idLibro"));
                LocalDate fechaEsperada = LocalDate.parse(request.getParameter("fechaDevolucionEsperada"));

                if (!fechaEsperada.isAfter(LocalDate.now())) {
                    mensaje = "❌ La fecha de devolución debe ser posterior a hoy.";
                } else {
                    boolean guardado = prestamoService.registrar(idLibro, usuario.getIdUsuario(), fechaEsperada);
                    mensaje = guardado
                            ? "✅ Préstamo solicitado correctamente."
                            : "❌ Error al registrar el préstamo.";
                }

            } else if ("devolver".equals(action)) {
                int idPrestamo   = Integer.parseInt(request.getParameter("idPrestamo"));
                boolean devuelto = prestamoService.devolver(idPrestamo);
                mensaje = devuelto
                        ? "✅ Libro devuelto correctamente. Si hubo retraso se generó una multa automáticamente."
                        : "❌ Error al registrar la devolución.";
            }

        } catch (Exception e) {
            mensaje = "❌ Error: " + e.getMessage();
        }

        request.setAttribute("mensaje", mensaje);
        doGet(request, response);
    }
}