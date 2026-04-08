<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Préstamos — Biblioteca SENA</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/views/includes/nav_universal.jsp"/>
    
    <div class="container">
        <%-- Título épico --%>
        <h2 class="page-title">
            <i class="bi bi-arrow-left-right"></i>
            Gestión de Préstamos
        </h2>

        <%-- Alertas --%>
        <c:if test="${not empty mensaje}">
            <div class="alert alert-success alert-dismissible fade show mb-4">
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
                    Nuevo Préstamo
                </button>
            </div>
            <div class="col-md">
                <form method="get" action="prestamos" class="d-flex gap-2">
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-search" style="color: var(--accent-primary);"></i>
                        </span>
                        <input type="text" name="buscar" 
                               placeholder="Buscar por libro o usuario..."
                               value="${param.buscar}" 
                               class="form-control">
                    </div>
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-search"></i>
                    </button>
                    <a href="prestamos" class="btn btn-secondary">
                        <i class="bi bi-x-circle"></i>
                    </a>
                </form>
            </div>
        </div>

        <%-- Tabla de préstamos épica --%>
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th style="width: 60px;">ID</th>
                        <th>Libro</th>
                        <th>Usuario</th>
                        <th>F. Préstamo</th>
                        <th>Dev. Esperada</th>
                        <th>Dev. Real</th>
                        <th>Estado</th>
                        <th style="width: 100px;">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="prestamo" items="${prestamos}">
                        <tr>
                            <td>
                                <span style="font-family: 'Orbitron', sans-serif; 
                                             color: var(--accent-primary);
                                             font-size: 0.85rem;">
                                    #${prestamo.idPrestamo}
                                </span>
                            </td>
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <i class="bi bi-book-fill" style="color: var(--accent-primary);"></i>
                                    <span style="font-weight: 500;">${prestamo.libro.titulo}</span>
                                </div>
                            </td>
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <div style="width: 32px; height: 32px;
                                                background: linear-gradient(135deg, var(--cyan-primary), var(--accent-deep));
                                                border-radius: 50%;
                                                display: flex;
                                                align-items: center;
                                                justify-content: center;
                                                color: #fff;
                                                font-size: 0.8rem;">
                                        <i class="bi bi-person-fill"></i>
                                    </div>
                                    <span>${prestamo.usuario.nombreCompleto}</span>
                                </div>
                            </td>
                            <td>
                                <span style="color: var(--text-muted);">
                                    <i class="bi bi-calendar-check-fill me-1" style="color: var(--accent-primary);"></i>
                                    ${prestamo.fechaPrestamo}
                                </span>
                            </td>
                            <td>
                                <span style="font-family: 'Orbitron', sans-serif; 
                                             color: var(--cyan-bright);">
                                    ${prestamo.fechaDevolucionEsperada}
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty prestamo.fechaDevolucionReal}">
                                        <span style="color: var(--accent-bright);">
                                            <i class="bi bi-calendar-check-fill me-1"></i>
                                            ${prestamo.fechaDevolucionReal}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: var(--text-muted);">
                                            <i class="bi bi-hourglass-split me-1"></i>
                                            Pendiente
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${prestamo.estadoPrestamo.nombre eq 'activo'}">
                                        <span class="badge" 
                                              style="background: rgba(6, 182, 212, 0.15);
                                                     border: 1px solid rgba(6, 182, 212, 0.4);
                                                     color: var(--cyan-bright);">
                                            <i class="bi bi-play-circle-fill me-1"></i>
                                            Activo
                                        </span>
                                    </c:when>
                                    <c:when test="${prestamo.estadoPrestamo.nombre eq 'devuelto'}">
                                        <span class="badge bg-success">
                                            <i class="bi bi-check-circle-fill me-1"></i>
                                            Devuelto
                                        </span>
                                    </c:when>
                                    <c:when test="${prestamo.estadoPrestamo.nombre eq 'vencido'}">
                                        <span class="badge bg-danger">
                                            <i class="bi bi-exclamation-circle-fill me-1"></i>
                                            Vencido
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">
                                            ${prestamo.estadoPrestamo.nombre}
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="d-flex gap-1">
                                    <button class="btn btn-warning btn-sm" 
                                            onclick="abrirModalEditar(this)"
                                            data-id="${prestamo.idPrestamo}"
                                            data-libro="${prestamo.libro.idLibro}"
                                            data-usuario="${prestamo.usuario.idUsuario}"
                                            data-fechaesperada="${prestamo.fechaDevolucionEsperada}"
                                            data-fechareal="${prestamo.fechaDevolucionReal}"
                                            data-estado="${prestamo.estadoPrestamo.nombre}"
                                            title="Editar">
                                        <i class="bi bi-pencil-fill"></i>
                                    </button>
                                    <button class="btn btn-danger btn-sm"
                                            onclick="confirmarEliminar(${prestamo.idPrestamo}, '${prestamo.libro.titulo}', '${prestamo.usuario.nombreCompleto}')"
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
        <c:if test="${empty prestamos}">
            <div class="text-center py-5">
                <i class="bi bi-inbox" style="font-size: 4rem; color: rgba(168, 85, 247, 0.2);"></i>
                <h4 style="color: var(--text-muted); margin-top: 16px;">
                    No hay préstamos registrados
                </h4>
            </div>
        </c:if>
    </div>

    <%-- Modal Crear/Editar --%>
    <div class="modal fade" id="prestamoModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title" id="modalTitulo">
                        <i class="bi bi-plus-circle-fill me-2"></i>
                        Nuevo Préstamo
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="formPrestamo" method="post" action="prestamos">
                        <input type="hidden" name="action" id="modalAction" value="create">
                        <input type="hidden" name="idPrestamo" id="modalId">
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">
                                    <i class="bi bi-book-fill me-1" style="color: var(--accent-primary);"></i>
                                    Libro
                                </label>
                                <select name="idLibro" id="modalLibro" class="form-select" required>
                                    <option value="">Seleccione un libro...</option>
                                    <c:forEach var="libro" items="${libros}">
                                        <option value="${libro.idLibro}">
                                            ${libro.titulo}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">
                                    <i class="bi bi-person-fill me-1" style="color: var(--accent-primary);"></i>
                                    Usuario
                                </label>
                                <select name="idUsuario" id="modalUsuario" class="form-select" required>
                                    <option value="">Seleccione un usuario...</option>
                                    <c:forEach var="u" items="${usuarios}">
                                        <option value="${u.idUsuario}">
                                            ${u.nombreCompleto}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">
                                    <i class="bi bi-calendar-event-fill me-1" style="color: var(--cyan-primary);"></i>
                                    Devolución Esperada
                                </label>
                                <input type="date" name="fechaDevolucionEsperada" 
                                       id="modalFechaEsperada" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">
                                    <i class="bi bi-calendar-check-fill me-1" style="color: var(--accent-primary);"></i>
                                    Devolución Real
                                    <small style="color: var(--text-muted);">(opcional)</small>
                                </label>
                                <input type="date" name="fechaDevolucionReal" 
                                       id="modalFechaReal" class="form-control">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">
                                <i class="bi bi-toggle-on me-1" style="color: var(--pink-primary);"></i>
                                Estado
                            </label>
                            <select name="estado" id="modalEstado" class="form-select" required>
                                <option value="activo">🟦 Activo</option>
                                <option value="devuelto">🟩 Devuelto</option>
                                <option value="vencido">🟥 Vencido</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        Cancelar
                    </button>
                    <button type="button" class="btn btn-success" onclick="guardarPrestamo()">
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
                    <i class="bi bi-arrow-left-right" 
                       style="font-size: 4rem; color: var(--pink-primary); opacity: 0.5;"></i>
                    <p class="mt-3" style="color: var(--text-muted);">
                        ¿Eliminar el préstamo de:
                    </p>
                    <h5 id="libroEliminar" 
                        style="color: var(--text-primary); font-family: 'Orbitron', sans-serif;">
                    </h5>
                    <p id="usuarioEliminar" style="color: var(--text-muted);"></p>
                    <div class="alert alert-warning mt-3">
                        <i class="bi bi-info-circle-fill me-1"></i>
                        Se eliminará también la multa asociada si existe
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                    <form id="formEliminar" method="post" action="prestamos">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="idPrestamo" id="idEliminar">
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
        function abrirModalNuevo() {
            document.getElementById("modalTitulo").innerHTML = 
                '<i class="bi bi-plus-circle-fill me-2"></i>Nuevo Préstamo';
            document.getElementById("modalAction").value = "create";
            document.getElementById("modalId").value = "";
            document.getElementById("modalLibro").value = "";
            document.getElementById("modalUsuario").value = "";
            document.getElementById("modalFechaEsperada").value = "";
            document.getElementById("modalFechaReal").value = "";
            document.getElementById("modalEstado").value = "activo";
            
            // Fecha mínima: hoy
            const hoy = new Date().toISOString().split('T')[0];
            document.getElementById("modalFechaEsperada").min = hoy;
            
            new bootstrap.Modal(document.getElementById("prestamoModal")).show();
        }
        
        function abrirModalEditar(btn) {
            const fechaReal = btn.getAttribute("data-fechareal");
            
            document.getElementById("modalTitulo").innerHTML = 
                '<i class="bi bi-pencil-fill me-2"></i>Editar Préstamo';
            document.getElementById("modalAction").value = "update";
            document.getElementById("modalId").value = btn.dataset.id;
            document.getElementById("modalLibro").value = btn.dataset.libro;
            document.getElementById("modalUsuario").value = btn.dataset.usuario;
            document.getElementById("modalFechaEsperada").value = btn.dataset.fechaesperada || "";
            document.getElementById("modalFechaReal").value = (fechaReal && fechaReal !== "null") ? fechaReal : "";
            document.getElementById("modalEstado").value = btn.dataset.estado || "activo";
            
            new bootstrap.Modal(document.getElementById("prestamoModal")).show();
        }
        
        function confirmarEliminar(id, libro, usuario) {
            document.getElementById("idEliminar").value = id;
            document.getElementById("libroEliminar").textContent = libro;
            document.getElementById("usuarioEliminar").textContent = "Usuario: " + usuario;
            new bootstrap.Modal(document.getElementById("modalEliminar")).show();
        }
        
        function guardarPrestamo() {
            document.getElementById("formPrestamo").submit();
        }
    </script>
    <jsp:include page="includes/chatbot.jsp"/>
</body>
</html>