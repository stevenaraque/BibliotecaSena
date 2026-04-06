package adso.sena.biblioteca.filter;

import adso.sena.biblioteca.model.Usuario;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Protege TODAS las rutas excepto login y recursos estáticos
@WebFilter(urlPatterns = {"/*"})
public class RolFilter implements Filter {

    // Rutas públicas — no requieren sesión
    private static final String[] RUTAS_PUBLICAS = {"/login", "/css/", "/images/"};

    // Rutas exclusivas de admin
    private static final String[] RUTAS_ADMIN = {
        "/dashboard", "/usuarios", "/libros", "/prestamos", "/multas"
    };

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;

        String ruta = request.getServletPath();

        // 1. Permitir rutas públicas sin verificación
        for (String publica : RUTAS_PUBLICAS) {
            if (ruta.startsWith(publica)) {
                chain.doFilter(req, res);
                return;
            }
        }

        // 2. Verificar que haya sesión activa
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null)
                ? (Usuario) session.getAttribute("usuario")
                : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 3. Verificar acceso a rutas de admin
        for (String rutaAdmin : RUTAS_ADMIN) {
            if (ruta.startsWith(rutaAdmin) && !usuario.esAdmin()) {
                // Usuario normal intentando entrar a zona admin
                response.sendRedirect(request.getContextPath() + "/miPortal");
                return;
            }
        }

        // 4. Verificar que usuario normal no acceda a portal de admin
        if (ruta.startsWith("/miPortal") && usuario.esAdmin()) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Todo bien — continuar
        chain.doFilter(req, res);
    }

    @Override public void init(FilterConfig fc) throws ServletException {}
    @Override public void destroy() {}
}