package adso.sena.biblioteca.controller;

import adso.sena.biblioteca.model.Libro;
import adso.sena.biblioteca.model.Categoria;
import adso.sena.biblioteca.model.Editorial;
import adso.sena.biblioteca.service.LibroService;
import adso.sena.biblioteca.service.AutorService;
import adso.sena.biblioteca.service.CategoriaService;
import adso.sena.biblioteca.service.EditorialService;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LibroServlet", urlPatterns = {"/libros"})
public class LibroServlet extends HttpServlet {

    private final LibroService libroService       = new LibroService();
    private final CategoriaService categoriaService = new CategoriaService();
    private final EditorialService editorialService = new EditorialService();
    private final AutorService autorService         = new AutorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // CORREGIDO: Manejar SQLException con try-catch
        List<Libro> libros = new ArrayList<>();
        String buscar = request.getParameter("buscar");
        
        try {
            if (buscar != null && !buscar.trim().isEmpty()) {
                libros = libroService.buscarPorTituloOAutor(buscar.trim());
            } else {
                libros = libroService.listarTodos();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al buscar libros: " + e.getMessage());
        }
        
        request.setAttribute("libros",      libros);
        request.setAttribute("categorias",  categoriaService.listarTodos());
        request.setAttribute("editoriales", editorialService.listarTodos());
        request.setAttribute("autores",     autorService.listarTodos());
        request.setAttribute("buscar",      buscar);
        request.getRequestDispatcher("/views/libros.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String mensaje = "";

        try {
            if ("create".equals(action) || "update".equals(action)) {
                String titulo       = request.getParameter("titulo");
                String isbn         = request.getParameter("isbn");
                int anioPublicacion = Integer.parseInt(request.getParameter("anioPublicacion"));
                int numPaginas      = Integer.parseInt(request.getParameter("numPaginas"));
                int idCategoria     = Integer.parseInt(request.getParameter("idCategoria"));
                int idEditorial     = Integer.parseInt(request.getParameter("idEditorial"));
                boolean disponible  = Boolean.parseBoolean(request.getParameter("disponible"));
                
                // Leer el autor
                String idAutorParam = request.getParameter("idAutor");
                Integer idAutor = (idAutorParam != null && !idAutorParam.isEmpty()) 
                                  ? Integer.parseInt(idAutorParam) 
                                  : null;

                Categoria categoria = new Categoria();
                categoria.setIdCategoria(idCategoria);

                Editorial editorial = new Editorial();
                editorial.setIdEditorial(idEditorial);

                Libro libro = new Libro();
                libro.setTitulo(titulo);
                libro.setIsbn(isbn);
                libro.setAnioPublicacion(anioPublicacion);
                libro.setNumPaginas(numPaginas);
                libro.setCategoria(categoria);
                libro.setEditorial(editorial);
                libro.setDisponible(disponible);

                if ("create".equals(action)) {
                    int idGenerado = libroService.registrar(libro);
                    if (idGenerado > 0) {
                        if (idAutor != null) {
                            libroService.asociarAutor(idGenerado, idAutor);
                        }
                        mensaje = "✅ Libro creado correctamente";
                    } else {
                        mensaje = "❌ Error al crear libro";
                    }
                } else {
                    // UPDATE
                    libro.setIdLibro(Integer.parseInt(request.getParameter("idLibro")));
                    boolean resultado = libroService.actualizar(libro);
                    
                    // Actualizar relación con autor
                    if (resultado && idAutor != null) {
                        libroService.actualizarAutor(libro.getIdLibro(), idAutor);
                    }
                    
                    mensaje = resultado ? "✅ Libro actualizado correctamente" : "❌ Error al actualizar libro";
                }

            } else if ("delete".equals(action)) {
                int idLibro = Integer.parseInt(request.getParameter("idLibro"));
                boolean resultado = libroService.eliminar(idLibro);
                mensaje = resultado ? "✅ Libro eliminado correctamente" : "❌ Error al eliminar libro";
            }

        } catch (Exception e) {
            mensaje = "❌ Error: " + e.getMessage();
            e.printStackTrace();
        }

        request.setAttribute("mensaje", mensaje);
        doGet(request, response);
    }
}