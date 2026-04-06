<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Libros &mdash; Biblioteca SENA</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <jsp:include page="/views/includes/nav_admin.jsp"/>
    <div class="container">
        <h2 class="page-title"><i class="bi bi-book-fill"></i>Gestión de Libros</h2>

        <c:if test="${not empty mensaje}">
            <div class="alert alert-info alert-dismissible fade show mb-4">
                <i class="bi bi-info-circle me-2"></i>${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="d-flex flex-wrap gap-2 align-items-center mb-4">
            <button class="btn btn-success" onclick="abrirModalNuevo()">
                <i class="bi bi-plus-circle-fill me-2"></i>Nuevo Libro
            </button>
            <form method="get" action="libros" class="d-flex gap-2 ms-auto flex-wrap">
                <input type="text" name="buscar" placeholder="Buscar por título o autor..."
                       value="${param.buscar}" class="form-control" style="min-width:240px;">
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-search me-1"></i>Buscar
                </button>
                <a href="libros" class="btn btn-secondary">
                    <i class="bi bi-x-circle me-1"></i>Limpiar
                </a>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>ID</th><th>Título</th><th>ISBN</th><th>Autor</th>
                        <th>Categoría</th><th>Editorial</th><th>Año</th>
                        <th>Páginas</th><th>Disponible</th><th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="libro" items="${libros}">
                        <tr>
                            <td>${libro.idLibro}</td>
                            <td>${libro.titulo}</td>
                            <td>${libro.isbn}</td>
                            <td><c:choose><c:when test="${not empty libro.autor.nombreCompleto}">${libro.autor.nombreCompleto}</c:when><c:otherwise><span style="color:var(--text-muted)">Sin autor</span></c:otherwise></c:choose></td>
                            <td><c:choose><c:when test="${not empty libro.categoria.nombre}">${libro.categoria.nombre}</c:when><c:otherwise><span style="color:var(--text-muted)">—</span></c:otherwise></c:choose></td>
                            <td><c:choose><c:when test="${not empty libro.editorial.nombre}">${libro.editorial.nombre}</c:when><c:otherwise><span style="color:var(--text-muted)">—</span></c:otherwise></c:choose></td>
                            <td>${libro.anioPublicacion}</td>
                            <td>${libro.numPaginas}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${libro.disponible}"><span class="badge bg-success">Disponible</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">No disponible</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-warning btn-sm" onclick="abrirModalEditar(this)"
                                        data-id="${libro.idLibro}" data-titulo="${libro.titulo}"
                                        data-isbn="${libro.isbn}" data-anio="${libro.anioPublicacion}"
                                        data-paginas="${libro.numPaginas}"
                                        data-idcategoria="${libro.categoria.idCategoria}"
                                        data-ideditorial="${libro.editorial.idEditorial}"
                                        data-disponible="${libro.disponible}">
                                    <i class="bi bi-pencil-fill"></i>
                                </button>
                                <button class="btn btn-danger btn-sm"
                                        onclick="confirmarEliminar(${libro.idLibro}, '${libro.titulo}')">
                                    <i class="bi bi-trash-fill"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal Crear/Editar -->
    <div class="modal fade" id="libroModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title" id="modalTituloLabel">Nuevo Libro</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="formLibro" method="post" action="libros">
                        <input type="hidden" name="action" id="modalAction" value="create">
                        <input type="hidden" name="idLibro" id="modalId">
                        <div class="row">
                            <div class="col-md-8 mb-3">
                                <label class="form-label">Título</label>
                                <input type="text" name="titulo" id="modalTituloInput" class="form-control" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">ISBN</label>
                                <input type="text" name="isbn" id="modalIsbn" class="form-control">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Autor</label>
                                <select name="idAutor" id="modalIdAutor" class="form-select">
                                    <option value="">— Sin autor —</option>
                                    <c:forEach var="autor" items="${autores}">
                                        <option value="${autor.idAutor}">${autor.nombreCompleto}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Categoría</label>
                                <select name="idCategoria" id="modalIdCategoria" class="form-select" required>
                                    <c:forEach var="categoria" items="${categorias}">
                                        <option value="${categoria.idCategoria}">${categoria.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Editorial</label>
                                <select name="idEditorial" id="modalIdEditorial" class="form-select" required>
                                    <c:forEach var="editorial" items="${editoriales}">
                                        <option value="${editorial.idEditorial}">${editorial.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Disponible</label>
                                <select name="disponible" id="modalDisponible" class="form-select">
                                    <option value="true">Sí</option>
                                    <option value="false">No</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Año de Publicación</label>
                                <input type="number" name="anioPublicacion" id="modalAnio" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Número de Páginas</label>
                                <input type="number" name="numPaginas" id="modalPaginas" class="form-control" required min="1">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-success" onclick="guardarLibro()">
                        <i class="bi bi-floppy-fill me-2"></i>Guardar
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Eliminar -->
    <div class="modal fade" id="modalEliminar" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title"><i class="bi bi-exclamation-triangle-fill me-2"></i>Confirmar Eliminación</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p style="color:var(--text-muted)">¿Estás seguro que deseas eliminar el libro:</p>
                    <p><strong id="tituloAEliminar" style="color:var(--text-heading)"></strong></p>
                    <p style="color:#fb7185;font-size:0.82rem;">Esta acción no se puede deshacer.</p>
                </div>
                <div class="modal-footer">
                    <form id="formEliminar" method="post" action="libros">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="idLibro" id="idEliminar">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-danger">
                            <i class="bi bi-trash-fill me-2"></i>Sí, eliminar
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        window.addEventListener('scroll', () => {
            document.getElementById('mainNav')?.classList.toggle('scrolled', window.scrollY > 40);
        });
        function abrirModalNuevo() {
            document.getElementById("modalTituloLabel").textContent = "Nuevo Libro";
            document.getElementById("modalAction").value = "create";
            document.getElementById("modalId").value = "";
            document.getElementById("modalTituloInput").value = "";
            document.getElementById("modalIsbn").value = "";
            document.getElementById("modalIdAutor").value = "";
            document.getElementById("modalAnio").value = "";
            document.getElementById("modalPaginas").value = "";
            document.getElementById("modalDisponible").value = "true";
            new bootstrap.Modal(document.getElementById("libroModal")).show();
        }
        function abrirModalEditar(btn) {
            document.getElementById("modalTituloLabel").textContent = "Editar Libro";
            document.getElementById("modalAction").value = "update";
            document.getElementById("modalId").value = btn.dataset.id;
            document.getElementById("modalTituloInput").value = btn.dataset.titulo;
            document.getElementById("modalIsbn").value = btn.dataset.isbn;
            document.getElementById("modalAnio").value = btn.dataset.anio;
            document.getElementById("modalPaginas").value = btn.dataset.paginas;
            document.getElementById("modalIdCategoria").value = btn.dataset.idcategoria;
            document.getElementById("modalIdEditorial").value = btn.dataset.ideditorial;
            document.getElementById("modalDisponible").value = btn.dataset.disponible;
            document.getElementById("modalIdAutor").value = "";
            new bootstrap.Modal(document.getElementById("libroModal")).show();
        }
        function confirmarEliminar(id, titulo) {
            document.getElementById("idEliminar").value = id;
            document.getElementById("tituloAEliminar").textContent = titulo;
            new bootstrap.Modal(document.getElementById("modalEliminar")).show();
        }
        function guardarLibro() { document.getElementById("formLibro").submit(); }
    </script>
    <jsp:include page="includes/chatbot.jsp"/>
</body>
</html>