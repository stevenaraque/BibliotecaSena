<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Multas — Biblioteca SENA</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <jsp:include page="/views/includes/nav_admin.jsp"/>
    <div class="container">
        <h2 class="page-title"><i class="bi bi-exclamation-triangle-fill"></i>Gestión de Multas</h2>

        <c:if test="${not empty mensaje}">
            <div class="alert alert-info alert-dismissible fade show mb-4">
                <i class="bi bi-info-circle me-2"></i>${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="d-flex flex-wrap gap-2 align-items-center mb-4">
            <button class="btn btn-success" onclick="abrirModalNuevo()">
                <i class="bi bi-plus-circle-fill me-2"></i>Nueva Multa
            </button>
            <form method="get" action="multas" class="d-flex gap-2 ms-auto flex-wrap">
                <input type="text" name="buscar" placeholder="Buscar por usuario o libro..."
                       value="${param.buscar}" class="form-control" style="min-width:240px;">
                <button type="submit" class="btn btn-success"><i class="bi bi-search me-1"></i>Buscar</button>
                <a href="multas" class="btn btn-secondary"><i class="bi bi-x-circle me-1"></i>Limpiar</a>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>ID</th><th>Préstamo</th><th>Usuario</th><th>Libro</th>
                        <th>Monto</th><th>F. Generación</th><th>F. Pago</th>
                        <th>Estado</th><th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="multa" items="${multas}">
                        <tr>
                            <td>${multa.idMulta}</td>
                            <td>#${multa.prestamo.idPrestamo}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty multa.prestamo.usuario.nombres}">
                                        ${multa.prestamo.usuario.nombres} ${multa.prestamo.usuario.apellidos}
                                    </c:when>
                                    <c:otherwise><span style="color:var(--text-muted)">—</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty multa.prestamo.libro.titulo}">${multa.prestamo.libro.titulo}</c:when>
                                    <c:otherwise><span style="color:var(--text-muted)">—</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td style="color:#86efac;font-family:'Orbitron',sans-serif;font-size:0.82rem;">
                                <fmt:formatNumber value="${multa.monto}" type="currency" currencySymbol="$" maxFractionDigits="0"/>
                            </td>
                            <td>${multa.fechaGeneracion}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty multa.fechaPago}">${multa.fechaPago}</c:when>
                                    <c:otherwise><span style="color:var(--text-muted)">—</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${multa.estadoMulta.nombre eq 'pendiente'}"><span class="badge bg-danger">Pendiente</span></c:when>
                                    <c:when test="${multa.estadoMulta.nombre eq 'pagada'}"><span class="badge bg-success">Pagada</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">${multa.estadoMulta.nombre}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-warning btn-sm" onclick="abrirModalEditar(this)"
                                        data-id="${multa.idMulta}"
                                        data-prestamo="${multa.prestamo.idPrestamo}"
                                        data-monto="${multa.monto}"
                                        data-fechapago="${multa.fechaPago}"
                                        data-estado="${multa.estadoMulta.idEstadoMulta}">
                                    <i class="bi bi-pencil-fill"></i>
                                </button>
                                <button class="btn btn-danger btn-sm"
                                        onclick="confirmarEliminar(${multa.idMulta}, ${multa.prestamo.idPrestamo})">
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
    <div class="modal fade" id="multaModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title" id="modalTituloLabel">Nueva Multa</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="formMulta" method="post" action="multas">
                        <input type="hidden" name="action" id="modalAction" value="create">
                        <input type="hidden" name="idMulta" id="modalId">
                        <div class="mb-3">
                            <label class="form-label">ID Préstamo</label>
                            <input type="number" name="idPrestamo" id="modalPrestamo" class="form-control" required min="1" readonly style="background:rgba(138,43,226,0.05);">
                            <div class="form-text">El préstamo no se puede cambiar una vez creada la multa.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Monto ($)</label>
                            <input type="number" step="0.01" name="monto" id="modalMonto" class="form-control" required min="0.01">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Fecha de Pago <small style="color:var(--text-muted)">(dejar vacío si aún no paga)</small></label>
                            <input type="date" name="fechaPago" id="modalFechaPago" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Estado</label>
                            <select name="idEstadoMulta" id="modalEstado" class="form-select">
                                <option value="1">Pendiente</option>
                                <option value="2">Pagada</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-success" onclick="guardarMulta()">
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
                    <p style="color:var(--text-muted)">¿Estás seguro que deseas eliminar la multa del préstamo:</p>
                    <p><strong id="prestamoAEliminar" style="color:var(--text-heading)"></strong></p>
                    <p style="color:#fb7185;font-size:0.82rem;">Esta acción no se puede deshacer.</p>
                </div>
                <div class="modal-footer">
                    <form id="formEliminar" method="post" action="multas">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="idMulta" id="idEliminar">
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
            document.getElementById("modalTituloLabel").textContent = "Nueva Multa";
            document.getElementById("modalAction").value = "create";
            document.getElementById("modalId").value = "";
            document.getElementById("modalPrestamo").value = "";
            document.getElementById("modalMonto").value = "";
            document.getElementById("modalFechaPago").value = "";
            document.getElementById("modalEstado").value = "1";
            document.getElementById("modalPrestamo").removeAttribute("readonly");
            new bootstrap.Modal(document.getElementById("multaModal")).show();
        }
        function abrirModalEditar(btn) {
            const fechaPago = btn.getAttribute("data-fechapago");
            document.getElementById("modalTituloLabel").textContent = "Editar Multa";
            document.getElementById("modalAction").value = "update";
            document.getElementById("modalId").value = btn.dataset.id;
            document.getElementById("modalPrestamo").value = btn.dataset.prestamo;
            document.getElementById("modalPrestamo").setAttribute("readonly", true);
            document.getElementById("modalMonto").value = btn.dataset.monto;
            document.getElementById("modalFechaPago").value = (fechaPago && fechaPago !== "null") ? fechaPago : "";
            document.getElementById("modalEstado").value = btn.dataset.estado;
            new bootstrap.Modal(document.getElementById("multaModal")).show();
        }
        function confirmarEliminar(idMulta, idPrestamo) {
            document.getElementById("idEliminar").value = idMulta;
            document.getElementById("prestamoAEliminar").textContent = "Préstamo #" + idPrestamo;
            new bootstrap.Modal(document.getElementById("modalEliminar")).show();
        }
        function guardarMulta() { document.getElementById("formMulta").submit(); }
    </script>
    <jsp:include page="includes/chatbot.jsp"/>
</body>
</html>