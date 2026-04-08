<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mi Portal — Biblioteca SENA</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/views/includes/nav_universal.jsp"/>
    
    <div class="container">
        <%-- Header del usuario épico --%>
        <div class="row mb-5">
            <div class="col-12">
                <div style="background: linear-gradient(135deg, rgba(168, 85, 247, 0.15), rgba(6, 182, 212, 0.1));
                            border: 1px solid var(--border-subtle);
                            border-radius: var(--radius-xl);
                            padding: 32px;
                            position: relative;
                            overflow: hidden;">
                    <%-- Decoración de fondo --%>
                    <div style="position: absolute;
                                top: -50%;
                                right: -10%;
                                width: 300px;
                                height: 300px;
                                background: radial-gradient(circle, rgba(168, 85, 247, 0.2), transparent 70%);
                                pointer-events: none;">
                    </div>
                    
                    <div class="row align-items-center position-relative">
                        <div class="col-md-auto text-center text-md-start mb-3 mb-md-0">
                            <%-- Avatar grande --%>
                            <div style="width: 100px; height: 100px;
                                        background: linear-gradient(135deg, var(--accent-primary), var(--cyan-primary));
                                        border-radius: 50%;
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                        color: #fff;
                                        font-size: 2.5rem;
                                        font-weight: 700;
                                        box-shadow: var(--glow-md);
                                        margin: 0 auto;">
                                ${usuario.nombres.charAt(0)}${usuario.apellidos.charAt(0)}
                            </div>
                        </div>
                        <div class="col-md">
                            <h2 style="font-family: 'Orbitron', sans-serif; 
                                       color: var(--text-primary);
                                       margin-bottom: 8px;
                                       font-size: 1.8rem;">
                                ${usuario.nombreCompleto}
                            </h2>
                            <div class="d-flex flex-wrap gap-2 align-items-center">
                                <span class="badge" 
                                      style="background: ${usuario.esAdmin() ? 'linear-gradient(135deg, rgba(234, 179, 8, 0.2), rgba(161, 98, 7, 0.15))' : 'rgba(6, 182, 212, 0.15)'};
                                             border: 1px solid ${usuario.esAdmin() ? 'rgba(234, 179, 8, 0.4)' : 'rgba(6, 182, 212, 0.3)'};
                                             color: ${usuario.esAdmin() ? '#fde047' : 'var(--cyan-bright)'};
                                             padding: 8px 16px;
                                             font-size: 0.85rem;">
                                    <i class="bi ${usuario.esAdmin() ? 'bi-shield-fill' : 'bi-person-fill'} me-1"></i>
                                    ${usuario.tipoUsuario.nombre}
                                </span>
                                <span style="color: var(--text-muted);">
                                    <i class="bi bi-envelope-fill me-1" style="color: var(--accent-primary);"></i>
                                    ${usuario.email}
                                </span>
                                <c:if test="${not empty usuario.telefono}">
                                    <span style="color: var(--text-muted);">
                                        <i class="bi bi-telephone-fill me-1" style="color: var(--accent-primary);"></i>
                                        ${usuario.telefono}
                                    </span>
                                </c:if>
                            </div>
                        </div>
                        <div class="col-md-auto mt-3 mt-md-0 text-center">
                            <button class="btn btn-success btn-lg" onclick="abrirModalPrestamo()">
                                <i class="bi bi-plus-circle-fill me-2"></i>
                                Solicitar Préstamo
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- Alertas --%>
        <c:if test="${not empty mensaje}">
            <div class="alert alert-success alert-dismissible fade show mb-4">
                <i class="bi bi-check-circle-fill me-2"></i>
                ${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <%-- Stats personales --%>
        <div class="row g-4 mb-5">
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="bi bi-book-fill"></i>
                    </div>
                    <div class="stat-number">${totalPrestamos}</div>
                    <div class="stat-label">Mis Préstamos</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card" style="border-color: rgba(6, 182, 212, 0.3);">
                    <div class="stat-icon" style="color: var(--cyan-primary);">
                        <i class="bi bi-check-circle-fill"></i>
                    </div>
                    <div class="stat-number" style="background: linear-gradient(135deg, #67e8f9, #06b6d4); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                        <c:set var="devueltos" value="0" />
                        <c:forEach var="p" items="${misPrestamos}">
                            <c:if test="${p.estadoPrestamo.nombre eq 'devuelto'}">
                                <c:set var="devueltos" value="${devueltos + 1}" />
                            </c:if>
                        </c:forEach>
                        ${devueltos}
                    </div>
                    <div class="stat-label">Devueltos</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card" style="border-color: rgba(6, 182, 212, 0.3);">
                    <div class="stat-icon" style="color: var(--cyan-bright);">
                        <i class="bi bi-arrow-clockwise"></i>
                    </div>
                    <div class="stat-number" style="background: linear-gradient(135deg, #22d3ee, #0891b2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                        <c:set var="activos" value="0" />
                        <c:forEach var="p" items="${misPrestamos}">
                            <c:if test="${p.estadoPrestamo.nombre eq 'activo'}">
                                <c:set var="activos" value="${activos + 1}" />
                            </c:if>
                        </c:forEach>
                        ${activos}
                    </div>
                    <div class="stat-label">Activos</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card" style="border-color: rgba(236, 72, 153, 0.3);">
                    <div class="stat-icon" style="color: var(--pink-primary);">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                    </div>
                    <div class="stat-number" style="background: linear-gradient(135deg, #f472b6, #ec4899); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                        ${totalMultas}
                    </div>
                    <div class="stat-label">Mis Multas</div>
                </div>
            </div>
        </div>

        <%-- Mis Préstamos --%>
        <h2 class="page-title">
            <i class="bi bi-arrow-left-right"></i>
            Mis Préstamos
        </h2>
        
        <div class="table-responsive mb-5">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Libro</th>
                        <th>F. Préstamo</th>
                        <th>Dev. Esperada</th>
                        <th>Dev. Real</th>
                        <th>Estado</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty misPrestamos}">
                            <tr>
                                <td colspan="7" class="text-center py-5" style="color: var(--text-muted);">
                                    <i class="bi bi-inbox fs-1 d-block mb-3" style="color: rgba(168, 85, 247, 0.3);"></i>
                                    <h5>No tienes préstamos registrados</h5>
                                    <p class="mb-0">¡Solicita tu primer libro!</p>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${misPrestamos}">
                                <tr style="${p.estadoPrestamo.nombre eq 'vencido' ? 'background: rgba(236, 72, 153, 0.05);' : ''}">
                                    <td>
                                        <span style="font-family: 'Orbitron', sans-serif; 
                                                     color: var(--accent-primary);">
                                            #${p.idPrestamo}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <i class="bi bi-book-fill" style="color: var(--accent-primary);"></i>
                                            <span style="font-weight: 500;">${p.libro.titulo}</span>
                                        </div>
                                    </td>
                                    <td style="color: var(--text-muted);">
                                        ${p.fechaPrestamo}
                                    </td>
                                    <td>
                                        <span style="font-family: 'Orbitron', sans-serif; 
                                                     color: var(--cyan-bright);">
                                            ${p.fechaDevolucionEsperada}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty p.fechaDevolucionReal}">
                                                <span style="color: #86efac;">
                                                    <i class="bi bi-check-circle-fill me-1"></i>
                                                    ${p.fechaDevolucionReal}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: var(--text-muted);">
                                                    <i class="bi bi-hourglass-split me-1"></i>
                                                    —
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.estadoPrestamo.nombre eq 'activo'}">
                                                <span class="badge" style="background: rgba(6, 182, 212, 0.15); border: 1px solid rgba(6, 182, 212, 0.4); color: var(--cyan-bright);">
                                                    <i class="bi bi-play-circle-fill me-1"></i>
                                                    Activo
                                                </span>
                                            </c:when>
                                            <c:when test="${p.estadoPrestamo.nombre eq 'devuelto'}">
                                                <span class="badge bg-success">
                                                    <i class="bi bi-check-circle-fill me-1"></i>
                                                    Devuelto
                                                </span>
                                            </c:when>
                                            <c:when test="${p.estadoPrestamo.nombre eq 'vencido'}">
                                                <span class="badge bg-danger">
                                                    <i class="bi bi-exclamation-circle-fill me-1"></i>
                                                    Vencido
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${p.estadoPrestamo.nombre}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${p.estadoPrestamo.nombre eq 'activo' or p.estadoPrestamo.nombre eq 'vencido'}">
                                            <button class="btn btn-warning btn-sm"
                                                    onclick="confirmarDevolucion(${p.idPrestamo}, '${p.libro.titulo}')">
                                                <i class="bi bi-box-arrow-up me-1"></i>
                                                Devolver
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <%-- Mis Multas --%>
        <h2 class="page-title">
            <i class="bi bi-exclamation-triangle-fill"></i>
            Mis Multas
        </h2>
        
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Libro</th>
                        <th>Monto</th>
                        <th>F. Generación</th>
                        <th>F. Pago</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty misMultas}">
                            <tr>
                                <td colspan="6" class="text-center py-5" style="color: var(--text-muted);">
                                    <i class="bi bi-check-circle fs-1 d-block mb-3" style="color: rgba(34, 211, 238, 0.5);"></i>
                                    <h5>¡No tienes multas!</h5>
                                    <p class="mb-0">Sigue devolviendo los libros a tiempo</p>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${misMultas}">
                                <tr>
                                    <td>
                                        <span style="font-family: 'Orbitron', sans-serif; 
                                                     color: var(--pink-primary);">
                                            #${m.idMulta}
                                        </span>
                                    </td>
                                    <td>
                                        <i class="bi bi-book-fill me-1" style="color: var(--accent-primary);"></i>
                                        ${m.prestamo.libro.titulo}
                                    </td>
                                    <td>
                                        <span style="font-family: 'Orbitron', sans-serif; 
                                                     font-size: 1.1rem;
                                                     font-weight: 700;
                                                     color: ${m.estadoMulta.nombre eq 'pagada' ? '#86efac' : '#f472b6'};">
                                            <fmt:formatNumber value="${m.monto}" type="currency" currencySymbol="$" maxFractionDigits="0"/>
                                        </span>
                                    </td>
                                    <td style="color: var(--text-muted);">
                                        ${m.fechaGeneracion}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty m.fechaPago}">
                                                <span style="color: #86efac;">
                                                    <i class="bi bi-check-circle-fill me-1"></i>
                                                    ${m.fechaPago}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: var(--text-muted);">
                                                    <i class="bi bi-hourglass-split me-1"></i>
                                                    —
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${m.estadoMulta.nombre eq 'pendiente'}">
                                                <span class="badge bg-danger">
                                                    <i class="bi bi-exclamation-circle-fill me-1"></i>
                                                    Pendiente
                                                </span>
                                            </c:when>
                                            <c:when test="${m.estadoMulta.nombre eq 'pagada'}">
                                                <span class="badge" style="background: rgba(34, 211, 238, 0.2); border: 1px solid rgba(34, 211, 238, 0.4); color: var(--cyan-bright);">
                                                    <i class="bi bi-check-circle-fill me-1"></i>
                                                    Pagada
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${m.estadoMulta.nombre}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <%-- Modal Solicitar Préstamo --%>
    <div class="modal fade" id="prestamoModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">
                        <i class="bi bi-plus-circle-fill me-2"></i>
                        Solicitar Préstamo
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="formPrestamo" method="post" action="miPortal">
                        <input type="hidden" name="action" value="solicitar">
                        
                        <div class="mb-3">
                            <label class="form-label">
                                <i class="bi bi-book-fill me-1" style="color: var(--accent-primary);"></i>
                                Libro disponible
                            </label>
                            <select name="idLibro" id="modalLibro" class="form-select" required>
                                <option value="">Seleccione un libro...</option>
                                <c:forEach var="libro" items="${librosDisponibles}">
                                    <option value="${libro.idLibro}">
                                        ${libro.titulo}
                                        <c:if test="${not empty libro.autor.nombreCompleto}">
                                            — ${libro.autor.nombreCompleto}
                                        </c:if>
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="form-text" style="color: var(--text-muted);">
                                <i class="bi bi-info-circle me-1"></i>
                                Solo se muestran libros disponibles
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">
                                <i class="bi bi-calendar-event-fill me-1" style="color: var(--cyan-primary);"></i>
                                Fecha de devolución
                            </label>
                            <input type="date" name="fechaDevolucionEsperada" 
                                   id="modalFecha" class="form-control" required>
                            <div class="form-text" style="color: var(--text-muted);">
                                <i class="bi bi-clock me-1"></i>
                                Máximo 15 días de préstamo
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        Cancelar
                    </button>
                    <button type="button" class="btn btn-success" onclick="confirmarPrestamo()">
                        <i class="bi bi-check-circle me-2"></i>
                        Confirmar Préstamo
                    </button>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal Devolución --%>
    <div class="modal fade" id="devolucionModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-warning text-dark">
                    <h5 class="modal-title">
                        <i class="bi bi-box-arrow-up me-2"></i>
                        Confirmar Devolución
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-center">
                    <i class="bi bi-book" 
                       style="font-size: 4rem; color: var(--accent-primary); opacity: 0.5;"></i>
                    <p class="mt-3" style="color: var(--text-muted);">
                        ¿Confirmas la devolución del libro:
                    </p>
                    <h5 id="libroADevolver" 
                        style="color: var(--text-primary); font-family: 'Orbitron', sans-serif;">
                    </h5>
                    <div class="alert alert-warning mt-3">
                        <i class="bi bi-exclamation-triangle-fill me-1"></i>
                        Si devuelves después de la fecha esperada se generará una multa de
                        <strong>$2.000 por día de retraso</strong>.
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                    <form id="formDevolucion" method="post" action="miPortal">
                        <input type="hidden" name="action" value="devolver">
                        <input type="hidden" name="idPrestamo" id="idPrestamoDevolver">
                        <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">
                            Cancelar
                        </button>
                        <button type="submit" class="btn btn-warning">
                            <i class="bi bi-box-arrow-up me-2"></i>
                            Sí, devolver
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function abrirModalPrestamo() {
            // Fecha mínima: mañana
            const manana = new Date();
            manana.setDate(manana.getDate() + 1);
            
            // Fecha máxima: 15 días
            const maxFecha = new Date();
            maxFecha.setDate(maxFecha.getDate() + 15);
            
            const inputFecha = document.getElementById("modalFecha");
            inputFecha.min = manana.toISOString().split('T')[0];
            inputFecha.max = maxFecha.toISOString().split('T')[0];
            inputFecha.value = manana.toISOString().split('T')[0];
            
            document.getElementById("modalLibro").value = "";
            
            new bootstrap.Modal(document.getElementById("prestamoModal")).show();
        }
        
        function confirmarPrestamo() {
            if (!document.getElementById("modalLibro").value) {
                alert("❌ Selecciona un libro.");
                return;
            }
            if (!document.getElementById("modalFecha").value) {
                alert("❌ Ingresa la fecha de devolución.");
                return;
            }
            document.getElementById("formPrestamo").submit();
        }
        
        function confirmarDevolucion(idPrestamo, titulo) {
            document.getElementById("idPrestamoDevolver").value = idPrestamo;
            document.getElementById("libroADevolver").textContent = titulo;
            new bootstrap.Modal(document.getElementById("devolucionModal")).show();
        }
    </script>
    
    <%-- Script para abrir modal automáticamente si viene del catálogo --%>
    <c:if test="${abrirModalPrestamo}">
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                var modalPrestamo = new bootstrap.Modal(document.getElementById('prestamoModal'));
                modalPrestamo.show();
            });
        </script>
    </c:if>
    
    <jsp:include page="includes/chatbot.jsp"/>
</body>
</html>