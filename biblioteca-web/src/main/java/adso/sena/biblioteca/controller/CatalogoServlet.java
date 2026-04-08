package adso.sena.biblioteca.controller;

import adso.sena.biblioteca.model.Libro;
import adso.sena.biblioteca.model.Usuario;
import adso.sena.biblioteca.service.LibroService;
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

@WebServlet(name = "CatalogoServlet", urlPatterns = {"/catalogo", ""})
public class CatalogoServlet extends HttpServlet {

    private final LibroService libroService = new LibroService();
    private final PrestamoService prestamoService = new PrestamoService();
    private static final int LIBROS_POR_PAGINA = 8;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String buscar = request.getParameter("buscar");
        if (buscar != null) buscar = buscar.trim();

        // Página actual
        int pagina = 1;
        try {
            String pParam = request.getParameter("pagina");
            if (pParam != null) pagina = Integer.parseInt(pParam);
            if (pagina < 1) pagina = 1;
        } catch (NumberFormatException e) {
            pagina = 1;
        }

        // Obtener todos los libros (con o sin búsqueda)
        List<Libro> todos;
        if (buscar != null && !buscar.isEmpty()) {
            todos = libroService.buscarEnCatalogo(buscar);
        } else {
            todos = libroService.listarTodos();
        }

        // Calcular paginación
        int total = todos == null ? 0 : todos.size();
        int totalPaginas = (int) Math.ceil((double) total / LIBROS_POR_PAGINA);
        if (totalPaginas < 1) totalPaginas = 1;
        if (pagina > totalPaginas) pagina = totalPaginas;

        int desde = (pagina - 1) * LIBROS_POR_PAGINA;
        int hasta = Math.min(desde + LIBROS_POR_PAGINA, total);

        List<Libro> librosPagina = (todos != null && !todos.isEmpty())
                ? todos.subList(desde, hasta)
                : todos;

        request.setAttribute("libros",       librosPagina);
        request.setAttribute("buscar",       buscar);
        request.setAttribute("paginaActual", pagina);
        request.setAttribute("totalPaginas", totalPaginas);
        request.setAttribute("totalLibros",  total);

        request.getRequestDispatcher("/views/catalogo.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        // Si no hay sesión, redirigir al login
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String resultadoJS;

        try {
            int idLibro = Integer.parseInt(request.getParameter("idLibro"));
            LocalDate fechaEsperada = LocalDate.parse(request.getParameter("fechaDevolucionEsperada"));

            if (!fechaEsperada.isAfter(LocalDate.now())) {
                resultadoJS = "error|La fecha de devolución debe ser posterior a hoy.";
            } else {
                boolean guardado = prestamoService.registrar(idLibro, usuario.getIdUsuario(), fechaEsperada);
                if (guardado) {
                    resultadoJS = "success|¡Préstamo realizado exitosamente!";
                } else {
                    resultadoJS = "error|No se pudo registrar el préstamo. Intenta de nuevo.";
                }
            }

        } catch (Exception e) {
            resultadoJS = "error|Error inesperado: " + e.getMessage();
        }

        // Guardar resultado en sesión para mostrarlo luego del redirect (POST-Redirect-GET)
        session.setAttribute("prestamoResultado", resultadoJS);

        // Redirigir de vuelta al catálogo (patrón PRG: evita reenvío del form al refrescar)
        String buscar = request.getParameter("buscar");
        String pagina = request.getParameter("pagina");
        StringBuilder redirect = new StringBuilder(request.getContextPath() + "/catalogo");
        String sep = "?";
        if (pagina != null && !pagina.isEmpty()) {
            redirect.append(sep).append("pagina=").append(pagina);
            sep = "&";
        }
        if (buscar != null && !buscar.isEmpty()) {
            redirect.append(sep).append("buscar=").append(java.net.URLEncoder.encode(buscar, "UTF-8"));
        }
        response.sendRedirect(redirect.toString());
    }
}