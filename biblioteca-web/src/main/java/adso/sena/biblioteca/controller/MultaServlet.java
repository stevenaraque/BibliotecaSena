package adso.sena.biblioteca.controller;

import adso.sena.biblioteca.model.Multa;
import adso.sena.biblioteca.service.MultaService;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "MultaServlet", urlPatterns = {"/multas"})
public class MultaServlet extends HttpServlet {

    private final MultaService multaService = new MultaService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login");
            return;
        }

        List<Multa> multas = multaService.listarTodas();
        request.setAttribute("multas", multas);
        request.setAttribute("usuario", session.getAttribute("usuario"));
        request.getRequestDispatcher("/views/multas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String mensaje = "";

        try {
            if ("create".equals(action)) {
                int idPrestamo     = Integer.parseInt(request.getParameter("idPrestamo"));
                BigDecimal monto   = new BigDecimal(request.getParameter("monto"));
                boolean guardado   = multaService.registrar(idPrestamo, monto);
                mensaje = guardado
                        ? "✅ Multa registrada correctamente"
                        : "❌ Error al registrar la multa";

            } else if ("update".equals(action)) {
                int idMulta        = Integer.parseInt(request.getParameter("idMulta"));
                int idPrestamo     = Integer.parseInt(request.getParameter("idPrestamo"));
                BigDecimal monto   = new BigDecimal(request.getParameter("monto"));
                int idEstado       = Integer.parseInt(request.getParameter("idEstadoMulta"));

                String fechaPagoStr = request.getParameter("fechaPago");
                LocalDate fechaPago = (fechaPagoStr == null || fechaPagoStr.isEmpty())
                        ? null
                        : LocalDate.parse(fechaPagoStr);

                boolean actualizado = multaService.actualizar(idMulta, idPrestamo, monto, fechaPago, idEstado);
                mensaje = actualizado
                        ? "✅ Multa actualizada correctamente"
                        : "❌ Error al actualizar la multa";

            } else if ("delete".equals(action)) {
                int idMulta      = Integer.parseInt(request.getParameter("idMulta"));
                boolean eliminado = multaService.eliminar(idMulta);
                mensaje = eliminado
                        ? "✅ Multa eliminada correctamente"
                        : "❌ Error al eliminar la multa";
            }

        } catch (Exception e) {
            mensaje = "❌ Error: " + e.getMessage();
        }

        // Mismo patrón que LibroServlet y PrestamoServlet
        request.setAttribute("mensaje", mensaje);
        doGet(request, response);
    }
}