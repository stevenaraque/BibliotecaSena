<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Préstamos — Biblioteca SENA</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <jsp:include page="/views/includes/nav_admin.jsp"/>
    <div class="container">
        <h2 class="page-title"><i class="bi bi-arrow-left-right"></i>Gestión de Préstamos</h2>

        <c:if test="${not empty mensaje}">
            <div class="alert alert-info alert-dismissible fade show mb-4">
                <i class="bi bi-info-circle me-2"></i>${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="d-flex flex-wrap gap-2 align-items-center mb-4">
            <button class="btn btn-success" onclick="abrirModalNuevo()">
                <i class="bi bi-plus-circle-fill me-2"></i>Nuevo Préstamo
            </button>
            <form method="get" action="prestamos" class="d-flex gap-2 ms-auto flex-wrap">
                <input type="text" name="buscar" placeholder="Buscar por libro o usuario..."
                       value="${param.buscar}" class="form-control" style="min-width:240px;">
                <button type="submit" class="btn btn-success"><i class="bi bi-search me-1"></i>Buscar</button>
                <a href="prestamos" class="btn btn-secondary"><i class="bi bi-x-circle me-1"></i>Limpiar</a>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>ID</th><th>Libro</th><th>Usuario</th>
                        <th>F. Préstamo</th><th>Dev. Esperada</th>
                        <th>Dev. Real</th><th>Estado</th><th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="prestamo" items="${prestamos}">
                        <tr>
                            <td>${prestamo.idPrestamo}</td>
                            <td>${prestamo.libro.titulo}</td>
                            <td>${prestamo.usuario.nombreCompleto}</td>
                            <td>${prestamo.fechaPrestamo}</td>
                            <td>${prestamo.fechaDevolucionEsperada}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty prestamo.fechaDevolucionReal}">${prestamo.fechaDevolucionReal}</c:when>
                                    <c:otherwise><span style="color:var(--text-muted)">—</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${prestamo.estadoPrestamo.nombre eq 'activo'}">
                                        <span class="badge" style="background:linear-gradient(135deg,rgba(56,189,248,0.25),rgba(14,165,233,0.15));border:1px solid rgba(56,189,248,0.35);color:#7dd3fc;">Activo</span>
                                    </c:when>
                                    <c:when test="${prestamo.estadoPrestamo.nombre eq 'devuelto'}">
                                        <span class="badge bg-success">Devuelto</span>
                                    </c:when>
                                    <c:when test="${prestamo.estadoPrestamo.nombre eq 'vencido'}">
                                        <span class="badge bg-danger">Vencido</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${prestamo.estadoPrestamo.nombre}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-warning btn-sm" onclick="abrirModalEditar(this)"
                                        data-id="${prestamo.idPrestamo}"
                                        data-libro="${prestamo.libro.idLibro}"
                                        data-usuario="${prestamo.usuario.idUsuario}"
                                        data-fechaesperada="${prestamo.fechaDevolucionEsperada}"
                                        data-fechareal="${prestamo.fechaDevolucionReal}"
                                        data-estado="${prestamo.estadoPrestamo.nombre}">
                                    <i class="bi bi-pencil-fill"></i>
                                </button>
                                <button class="btn btn-danger btn-sm"
                                        onclick="confirmarEliminar(${prestamo.idPrestamo}, '${prestamo.libro.titulo}', '${prestamo.usuario.nombreCompleto}')">
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
    <div class="modal fade" id="prestamoModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title" id="modalTitulo">Nuevo Préstamo</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="formPrestamo" method="post" action="prestamos">
                        <input type="hidden" name="action" id="modalAction" value="create">
                        <input type="hidden" name="idPrestamo" id="modalId">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Libro</label>
                                <select name="idLibro" id="modalLibro" class="form-select" required>
                                    <option value="">Seleccione un libro...</option>
                                    <c:forEach var="libro" items="${libros}">
                                        <option value="${libro.idLibro}">${libro.titulo}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Usuario</label>
                                <select name="idUsuario" id="modalUsuario" class="form-select" required>
                                    <option value="">Seleccione un usuario...</option>
                                    <c:forEach var="u" items="${usuarios}">
                                        <option value="${u.idUsuario}">${u.nombreCompleto}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Devolución Esperada</label>
                                <input type="date" name="fechaDevolucionEsperada" id="modalFechaEsperada" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Devolución Real <small style="color:var(--text-muted)">(opcional)</small></label>
                                <input type="date" name="fechaDevolucionReal" id="modalFechaReal" class="form-control">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Estado</label>
                                <select name="estado" id="modalEstado" class="form-select" required>
                                    <option value="activo">Activo</option>
                                    <option value="devuelto">Devuelto</option>
                                    <option value="vencido">Vencido</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-success" onclick="guardarPrestamo()">
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
                    <p style="color:var(--text-muted)">¿Estás seguro que deseas eliminar el préstamo de:</p>
                    <p><strong id="infoEliminar" style="color:var(--text-heading)"></strong></p>
                    <p style="color:#fb7185;font-size:0.82rem;">Esta acción eliminará también la multa asociada si existe.</p>
                </div>
                <div class="modal-footer">
                    <form id="formEliminar" method="post" action="prestamos">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="idPrestamo" id="idEliminar">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-danger"><i class="bi bi-trash-fill me-2"></i>Sí, eliminar</button>
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
            document.getElementById("modalTitulo").textContent = "Nuevo Préstamo";
            document.getElementById("modalAction").value = "create";
            document.getElementById("modalId").value = "";
            document.getElementById("modalLibro").value = "";
            document.getElementById("modalUsuario").value = "";
            document.getElementById("modalFechaEsperada").value = "";
            document.getElementById("modalFechaReal").value = "";
            document.getElementById("modalEstado").value = "activo";
            new bootstrap.Modal(document.getElementById("prestamoModal")).show();
        }
        function abrirModalEditar(btn) {
            const fechaReal = btn.getAttribute("data-fechareal");
            document.getElementById("modalTitulo").textContent = "Editar Préstamo";
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
            document.getElementById("infoEliminar").textContent = libro + " — " + usuario;
            new bootstrap.Modal(document.getElementById("modalEliminar")).show();
        }
        function guardarPrestamo() { document.getElementById("formPrestamo").submit(); }
    </script>
    <jsp:include page="includes/chatbot.jsp"/>
</body>
</html>