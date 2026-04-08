<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Libros — Biblioteca SENA</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <jsp:include page="/views/includes/nav_universal.jsp"/>

        <div class="container">
            <%-- Título épico --%>
            <h2 class="page-title">
                <i class="bi bi-book-fill"></i>
                Gestión de Libros
            </h2>

            <%-- Alertas --%>
            <c:if test="${not empty mensaje}">
                <div class="alert alert-success alert-dismissible fade show mb-4" 
                     style="background: rgba(168, 85, 247, 0.1);
                     border-color: rgba(168, 85, 247, 0.3);
                     color: var(--accent-bright);">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    ${mensaje}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <%-- Barra de acciones --%>
            <div class="row g-3 align-items-center mb-4">
                <div class="col-md-auto">
                    <button class="btn btn-success" onclick="abrirModalNuevo()">
                        <i class="bi bi-plus-circle-fill me-2"></i>
                        Nuevo Libro
                    </button>
                </div>
                <div class="col-md">
                    <form method="get" action="libros" class="d-flex gap-2">
                        <div class="input-group">
                            <span class="input-group-text" 
                                  style="background: rgba(168, 85, 247, 0.1);
                                  border: 1px solid var(--border-subtle);">
                                <i class="bi bi-search" style="color: var(--accent-primary);"></i>
                            </span>
                            <input type="text" name="buscar" 
                                   placeholder="Buscar por título o autor..."
                                   value="${param.buscar}" 
                                   class="form-control"
                                   style="border-left: none;">
                        </div>
                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-search"></i>
                        </button>
                        <a href="libros" class="btn btn-secondary">
                            <i class="bi bi-x-circle"></i>
                        </a>
                    </form>
                </div>
            </div>

            <%-- Tabla de libros épica --%>
            <div class="table-responsive" style="border-radius: var(--radius-lg);">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th style="width: 60px;">ID</th>
                            <th>Título</th>
                            <th>ISBN</th>
                            <th>Autor</th>
                            <th>Categoría</th>
                            <th>Editorial</th>
                            <th style="width: 80px;">Año</th>
                            <th style="width: 80px;">Págs</th>
                            <th style="width: 110px;">Estado</th>
                            <th style="width: 100px;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="libro" items="${libros}">
                            <tr>
                                <td>
                                    <span style="font-family: 'Orbitron', sans-serif;
                                          color: var(--accent-primary);
                                          font-size: 0.85rem;">
                                        #${libro.idLibro}
                                    </span>
                                </td>
                                <td>
                                    <div style="font-weight: 500; color: var(--text-primary);">
                                        ${libro.titulo}
                                    </div>
                                </td>
                                <td>
                                    <code style="background: rgba(168, 85, 247, 0.1);
                                          padding: 4px 8px;
                                          border-radius: 4px;
                                          font-size: 0.8rem;
                                          color: var(--accent-bright);">
                                        ${libro.isbn}
                                    </code>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty libro.autor.nombreCompleto}">
                                            <i class="bi bi-person-fill me-1" style="color: var(--accent-primary);"></i>
                                            ${libro.autor.nombreCompleto}
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: var(--text-muted);">
                                                <i class="bi bi-dash-circle me-1"></i>
                                                Sin autor
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty libro.categoria.nombre}">
                                            <span class="badge" 
                                                  style="background: rgba(6, 182, 212, 0.15);
                                                  border: 1px solid rgba(6, 182, 212, 0.3);
                                                  color: var(--cyan-bright);">
                                                <i class="bi bi-tag-fill me-1"></i>
                                                ${libro.categoria.nombre}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: var(--text-muted);">—</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty libro.editorial.nombre}">
                                            <i class="bi bi-building me-1" style="color: var(--pink-primary);"></i>
                                            ${libro.editorial.nombre}
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: var(--text-muted);">—</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align: center;">
                                    <span style="font-family: 'Orbitron', sans-serif;">
                                        ${libro.anioPublicacion}
                                    </span>
                                </td>
                                <td style="text-align: center;">
                                    <span style="color: var(--text-muted);">
                                        ${libro.numPaginas}
                                    </span>
                                </td>
                                <td style="text-align: center;">
                                    <c:choose>
                                        <c:when test="${libro.disponible}">
                                            <span class="badge bg-success">
                                                <i class="bi bi-check-circle-fill me-1"></i>
                                                Disponible
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">
                                                <i class="bi bi-x-circle-fill me-1"></i>
                                                No disp.
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="d-flex gap-1">
                                        <button class="btn btn-warning btn-sm" 
                                                onclick="abrirModalEditar(this)"
                                                data-id="${libro.idLibro}" 
                                                data-titulo="${libro.titulo}"
                                                data-isbn="${libro.isbn}" 
                                                data-anio="${libro.anioPublicacion}"
                                                data-paginas="${libro.numPaginas}"
                                                data-idcategoria="${libro.categoria.idCategoria}"
                                                data-ideditorial="${libro.editorial.idEditorial}"
                                                data-disponible="${libro.disponible}"
                                                data-idautor="${libro.autor.idAutor}"  <%-- AGREGAR ESTA LÍNEA --%>
                                                title="Editar">
                                            <i class="bi bi-pencil-fill"></i>
                                        </button>
                                        <button class="btn btn-danger btn-sm"
                                                onclick="confirmarEliminar(${libro.idLibro}, '${libro.titulo}')"
                                                title="Eliminar">
                                            <i class="bi bi-trash-fill"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <%-- Empty state --%>
            <c:if test="${empty libros}">
                <div class="text-center py-5">
                    <i class="bi bi-inbox" 
                       style="font-size: 4rem; color: rgba(168, 85, 247, 0.2);"></i>
                    <h4 style="color: var(--text-muted); margin-top: 16px;">
                        No se encontraron libros
                    </h4>
                    <c:if test="${not empty param.buscar}">
                        <a href="libros" class="btn btn-outline-success mt-3">
                            Ver todos
                        </a>
                    </c:if>
                </div>
            </c:if>
        </div>

        <%-- Modal Crear/Editar --%>
        <div class="modal fade" id="libroModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="modalTituloLabel">
                            <i class="bi bi-plus-circle-fill me-2"></i>
                            Nuevo Libro
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="formLibro" method="post" action="libros">
                            <input type="hidden" name="action" id="modalAction" value="create">
                            <input type="hidden" name="idLibro" id="modalId">

                            <div class="row">
                                <div class="col-md-8 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-type-h1 me-1" style="color: var(--accent-primary);"></i>
                                        Título
                                    </label>
                                    <input type="text" name="titulo" id="modalTituloInput" 
                                           class="form-control" required
                                           placeholder="Nombre del libro">
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-upc-scan me-1" style="color: var(--accent-primary);"></i>
                                        ISBN
                                    </label>
                                    <input type="text" name="isbn" id="modalIsbn" 
                                           class="form-control"
                                           placeholder="978-...">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-person-fill me-1" style="color: var(--accent-primary);"></i>
                                        Autor
                                    </label>
                                    <select name="idAutor" id="modalIdAutor" class="form-select">
                                        <option value="">— Sin autor —</option>
                                        <c:forEach var="autor" items="${autores}">
                                            <option value="${autor.idAutor}">
                                                ${autor.nombreCompleto}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-tag-fill me-1" style="color: var(--cyan-primary);"></i>
                                        Categoría
                                    </label>
                                    <select name="idCategoria" id="modalIdCategoria" class="form-select" required>
                                        <c:forEach var="categoria" items="${categorias}">
                                            <option value="${categoria.idCategoria}">
                                                ${categoria.nombre}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-building me-1" style="color: var(--pink-primary);"></i>
                                        Editorial
                                    </label>
                                    <select name="idEditorial" id="modalIdEditorial" class="form-select" required>
                                        <c:forEach var="editorial" items="${editoriales}">
                                            <option value="${editorial.idEditorial}">
                                                ${editorial.nombre}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-check-circle-fill me-1" style="color: var(--accent-primary);"></i>
                                        Disponible
                                    </label>
                                    <select name="disponible" id="modalDisponible" class="form-select">
                                        <option value="true">Sí</option>
                                        <option value="false">No</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-calendar-fill me-1" style="color: var(--accent-primary);"></i>
                                        Año de Publicación
                                    </label>
                                    <input type="number" name="anioPublicacion" id="modalAnio" 
                                           class="form-control" required
                                           placeholder="2024">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-file-text-fill me-1" style="color: var(--accent-primary);"></i>
                                        Número de Páginas
                                    </label>
                                    <input type="number" name="numPaginas" id="modalPaginas" 
                                           class="form-control" required min="1"
                                           placeholder="300">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            Cancelar
                        </button>
                        <button type="button" class="btn btn-success" onclick="guardarLibro()">
                            <i class="bi bi-floppy-fill me-2"></i>
                            Guardar
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <%-- Modal Eliminar --%>
        <div class="modal fade" id="modalEliminar" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            Confirmar Eliminación
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-center">
                        <i class="bi bi-trash" 
                           style="font-size: 4rem; color: var(--pink-primary); opacity: 0.5;"></i>
                        <p class="mt-3" style="color: var(--text-muted);">
                            ¿Estás seguro que deseas eliminar el libro:
                        </p>
                        <h5 id="tituloAEliminar" 
                            style="color: var(--text-primary); font-family: 'Orbitron', sans-serif;">
                        </h5>
                        <div class="alert alert-danger mt-3" 
                             style="background: rgba(236, 72, 153, 0.1);
                             border-color: rgba(236, 72, 153, 0.3);
                             color: var(--pink-bright);
                             font-size: 0.85rem;">
                            <i class="bi bi-exclamation-circle-fill me-1"></i>
                            Esta acción no se puede deshacer
                        </div>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <form id="formEliminar" method="post" action="libros">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="idLibro" id="idEliminar">
                            <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">
                                Cancelar
                            </button>
                            <button type="submit" class="btn btn-danger">
                                <i class="bi bi-trash-fill me-2"></i>
                                Sí, eliminar
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            // Funciones del modal
                            function abrirModalNuevo() {
                                document.getElementById("modalTituloLabel").innerHTML =
                                        '<i class="bi bi-plus-circle-fill me-2"></i>Nuevo Libro';
                                document.getElementById("modalAction").value = "create";
                                document.getElementById("modalId").value = "";
                                document.getElementById("modalTituloInput").value = "";
                                document.getElementById("modalIsbn").value = "";
                                document.getElementById("modalIdAutor").value = "";
                                document.getElementById("modalIdCategoria").selectedIndex = 0;
                                document.getElementById("modalIdEditorial").selectedIndex = 0;
                                document.getElementById("modalAnio").value = "";
                                document.getElementById("modalPaginas").value = "";
                                document.getElementById("modalDisponible").value = "true";

                                new bootstrap.Modal(document.getElementById("libroModal")).show();
                            }

                            function abrirModalEditar(btn) {
                                document.getElementById("modalTituloLabel").innerHTML =
                                        '<i class="bi bi-pencil-fill me-2"></i>Editar Libro';
                                document.getElementById("modalAction").value = "update";
                                document.getElementById("modalId").value = btn.dataset.id;
                                document.getElementById("modalTituloInput").value = btn.dataset.titulo;
                                document.getElementById("modalIsbn").value = btn.dataset.isbn;
                                document.getElementById("modalAnio").value = btn.dataset.anio;
                                document.getElementById("modalPaginas").value = btn.dataset.paginas;
                                document.getElementById("modalIdCategoria").value = btn.dataset.idcategoria;
                                document.getElementById("modalIdEditorial").value = btn.dataset.ideditorial;
                                document.getElementById("modalDisponible").value = btn.dataset.disponible;
                                document.getElementById("modalIdAutor").value = btn.dataset.idautor || "";  // <-- CORREGIR ESTA LÍNEA

                                new bootstrap.Modal(document.getElementById("libroModal")).show();
                            }

                            function confirmarEliminar(id, titulo) {
                                document.getElementById("idEliminar").value = id;
                                document.getElementById("tituloAEliminar").textContent = titulo;
                                new bootstrap.Modal(document.getElementById("modalEliminar")).show();
                            }

                            function guardarLibro() {
                                document.getElementById("formLibro").submit();
                            }
        </script>
        <jsp:include page="includes/chatbot.jsp"/>
    </body>
</html>