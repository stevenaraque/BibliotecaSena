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
    </head>
    <body>
        <jsp:include page="/views/includes/nav_universal.jsp"/>

        <div class="container">
            <%-- Título épico --%>
            <h2 class="page-title">
                <i class="bi bi-exclamation-triangle-fill"></i>
                Gestión de Multas
            </h2>

            <%-- Alertas --%>
            <c:if test="${not empty mensaje}">
                <div class="alert alert-success alert-dismissible fade show mb-4">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    ${mensaje}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <%-- Stats de multas --%>
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="stat-card" style="border-color: rgba(236, 72, 153, 0.3);">
                        <div class="stat-icon" style="color: var(--pink-primary);">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                        </div>
                        <div class="stat-number" style="background: linear-gradient(135deg, #f472b6, #ec4899); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                            <c:set var="totalPendientes" value="0" />
                            <c:forEach var="m" items="${multas}">
                                <c:if test="${m.estadoMulta.nombre eq 'pendiente'}">
                                    <c:set var="totalPendientes" value="${totalPendientes + 1}" />
                                </c:if>
                            </c:forEach>
                            ${totalPendientes}
                        </div>
                        <div class="stat-label">Multas Pendientes</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card" style="border-color: rgba(34, 211, 238, 0.3);">
                        <div class="stat-icon" style="color: var(--cyan-primary);">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>
                        <div class="stat-number" style="background: linear-gradient(135deg, #67e8f9, #06b6d4); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                            <c:set var="totalPagadas" value="0" />
                            <c:forEach var="m" items="${multas}">
                                <c:if test="${m.estadoMulta.nombre eq 'pagada'}">
                                    <c:set var="totalPagadas" value="${totalPagadas + 1}" />
                                </c:if>
                            </c:forEach>
                            ${totalPagadas}
                        </div>
                        <div class="stat-label">Multas Pagadas</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="bi bi-cash-stack"></i>
                        </div>
                        <div class="stat-number" style="background: linear-gradient(135deg, #c084fc, #a855f7); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                            <c:set var="totalRecaudado" value="0" />
                            <c:forEach var="m" items="${multas}">
                                <c:if test="${m.estadoMulta.nombre eq 'pagada'}">
                                    <c:set var="totalRecaudado" value="${totalRecaudado + m.monto}" />
                                </c:if>
                            </c:forEach>
                            $<fmt:formatNumber value="${totalRecaudado}" type="number" maxFractionDigits="0" groupingUsed="true"/>
                        </div>
                        <div class="stat-label">Total Recaudado</div>
                    </div>
                </div>
            </div>

            <%-- Barra de acciones --%>
            <div class="row g-3 align-items-center mb-4">
                <div class="col-md-auto">
                    <button class="btn btn-success" onclick="abrirModalNuevo()">
                        <i class="bi bi-plus-circle-fill me-2"></i>
                        Nueva Multa
                    </button>
                </div>
                <div class="col-md">
                    <form method="get" action="multas" class="d-flex gap-2">
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-search" style="color: var(--accent-primary);"></i>
                            </span>
                            <input type="text" name="buscar" 
                                   placeholder="Buscar por usuario o libro..."
                                   value="${param.buscar}" 
                                   class="form-control">
                        </div>
                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-search"></i>
                        </button>
                        <a href="multas" class="btn btn-secondary">
                            <i class="bi bi-x-circle"></i>
                        </a>
                    </form>
                </div>
            </div>

            <%-- Tabla de multas épica --%>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th style="width: 60px;">ID</th>
                            <th>Préstamo</th>
                            <th>Usuario</th>
                            <th>Libro</th>
                            <th style="width: 120px;">Monto</th>
                            <th>F. Generación</th>
                            <th>F. Pago</th>
                            <th>Estado</th>
                            <th style="width: 100px;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="multa" items="${multas}">
                            <tr style="${multa.estadoMulta.nombre eq 'pendiente' ? 'background: rgba(236, 72, 153, 0.05);' : ''}">
                                <td>
                                    <span style="font-family: 'Orbitron', sans-serif;
                                          color: var(--pink-primary);
                                          font-size: 0.85rem;">
                                        #${multa.idMulta}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge" style="background: rgba(168, 85, 247, 0.15); border: 1px solid rgba(168, 85, 247, 0.3); color: var(--accent-bright);">
                                        <i class="bi bi-arrow-left-right me-1"></i>
                                        #${multa.prestamo.idPrestamo}
                                    </span>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <div style="width: 32px; height: 32px;
                                             background: linear-gradient(135deg, var(--pink-primary), #be185d);
                                             border-radius: 50%;
                                             display: flex;
                                             align-items: center;
                                             justify-content: center;
                                             color: #fff;
                                             font-size: 0.8rem;">
                                            <i class="bi bi-person-fill"></i>
                                        </div>
                                        <span>
                                            <c:choose>
                                                <c:when test="${not empty multa.prestamo.usuario.nombres}">
                                                    ${multa.prestamo.usuario.nombres} ${multa.prestamo.usuario.apellidos}
                                                </c:when>
                                                <c:otherwise>—</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <i class="bi bi-book-fill me-1" style="color: var(--accent-primary);"></i>
                                    <c:choose>
                                        <c:when test="${not empty multa.prestamo.libro.titulo}">
                                            ${multa.prestamo.libro.titulo}
                                        </c:when>
                                        <c:otherwise>—</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span style="font-family: 'Orbitron', sans-serif;
                                          font-size: 1.1rem;
                                          font-weight: 700;
                                          color: ${multa.estadoMulta.nombre eq 'pagada' ? '#86efac' : '#f472b6'};">
                                        <fmt:setLocale value="es_CO"/>
                                        <fmt:formatNumber value="${multa.monto}" type="currency" currencySymbol="$" maxFractionDigits="0"/>
                                    </span>
                                </td>
                                <td>
                                    <span style="color: var(--text-muted);">
                                        <i class="bi bi-calendar-x-fill me-1" style="color: var(--pink-primary);"></i>
                                        ${multa.fechaGeneracion}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty multa.fechaPago}">
                                            <span style="color: #86efac;">
                                                <i class="bi bi-calendar-check-fill me-1"></i>
                                                ${multa.fechaPago}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: var(--text-muted);">
                                                <i class="bi bi-hourglass-split me-1"></i>
                                                Sin pagar
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${multa.estadoMulta.nombre eq 'pendiente'}">
                                            <span class="badge bg-danger">
                                                <i class="bi bi-exclamation-circle-fill me-1"></i>
                                                Pendiente
                                            </span>
                                        </c:when>
                                        <c:when test="${multa.estadoMulta.nombre eq 'pagada'}">
                                            <span class="badge" style="background: rgba(34, 211, 238, 0.2); border: 1px solid rgba(34, 211, 238, 0.4); color: var(--cyan-bright);">
                                                <i class="bi bi-check-circle-fill me-1"></i>
                                                Pagada
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${multa.estadoMulta.nombre}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="d-flex gap-1">
                                        <button class="btn btn-warning btn-sm" 
                                                onclick="abrirModalEditar(this)"
                                                data-id="${multa.idMulta}"
                                                data-prestamo="${multa.prestamo.idPrestamo}"
                                                data-monto="${multa.monto}"
                                                data-fechapago="${multa.fechaPago}"
                                                data-estado="${multa.estadoMulta.idEstadoMulta}"
                                                title="Editar">
                                            <i class="bi bi-pencil-fill"></i>
                                        </button>
                                        <button class="btn btn-danger btn-sm"
                                                onclick="confirmarEliminar(${multa.idMulta}, ${multa.prestamo.idPrestamo})"
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
            <c:if test="${empty multas}">
                <div class="text-center py-5">
                    <i class="bi bi-check-circle" style="font-size: 4rem; color: rgba(34, 211, 238, 0.3);"></i>
                    <h4 style="color: var(--text-muted); margin-top: 16px;">
                        No hay multas registradas
                    </h4>
                    <p style="color: var(--text-dark);">¡Todos los usuarios están al día!</p>
                </div>
            </c:if>
        </div>

        <%-- Modal Crear/Editar --%>
        <div class="modal fade" id="multaModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="modalTituloLabel">
                            <i class="bi bi-plus-circle-fill me-2"></i>
                            Nueva Multa
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="formMulta" method="post" action="multas">
                            <input type="hidden" name="action" id="modalAction" value="create">
                            <input type="hidden" name="idMulta" id="modalId">

                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="bi bi-arrow-left-right me-1" style="color: var(--accent-primary);"></i>
                                    ID Préstamo
                                </label>
                                <input type="number" name="idPrestamo" id="modalPrestamo" 
                                       class="form-control" required min="1" readonly
                                       style="background: rgba(168, 85, 247, 0.05);">
                                <div class="form-text" style="color: var(--text-muted);">
                                    El préstamo no se puede cambiar una vez creada la multa.
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="bi bi-cash-coin me-1" style="color: var(--pink-primary);"></i>
                                    Monto ($)
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" step="0.01" name="monto" id="modalMonto" 
                                           class="form-control" required min="0.01">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="bi bi-calendar-check-fill me-1" style="color: var(--cyan-primary);"></i>
                                    Fecha de Pago
                                    <small style="color: var(--text-muted);">(dejar vacío si aún no paga)</small>
                                </label>
                                <input type="date" name="fechaPago" id="modalFechaPago" 
                                       class="form-control">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="bi bi-toggle-on me-1" style="color: var(--accent-primary);"></i>
                                    Estado
                                </label>
                                <select name="idEstadoMulta" id="modalEstado" class="form-select">
                                    <option value="1">🔴 Pendiente</option>
                                    <option value="2">🟢 Pagada</option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            Cancelar
                        </button>
                        <button type="button" class="btn btn-success" onclick="guardarMulta()">
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
                        <i class="bi bi-exclamation-triangle" 
                           style="font-size: 4rem; color: var(--pink-primary); opacity: 0.5;"></i>
                        <p class="mt-3" style="color: var(--text-muted);">
                            ¿Eliminar la multa del préstamo:
                        </p>
                        <h5 id="prestamoAEliminar" 
                            style="color: var(--text-primary); font-family: 'Orbitron', sans-serif;">
                        </h5>
                        <div class="alert alert-danger mt-3">
                            <i class="bi bi-exclamation-circle-fill me-1"></i>
                            Esta acción no se puede deshacer
                        </div>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <form id="formEliminar" method="post" action="multas">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="idMulta" id="idEliminar">
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
                                document.getElementById("modalTituloLabel").innerHTML =
                                        '<i class="bi bi-plus-circle-fill me-2"></i>Nueva Multa';
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

                                document.getElementById("modalTituloLabel").innerHTML =
                                        '<i class="bi bi-pencil-fill me-2"></i>Editar Multa';
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

                            function guardarMulta() {
                                document.getElementById("formMulta").submit();
                            }
        </script>
        <jsp:include page="includes/chatbot.jsp"/>
    </body>
</html>