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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <jsp:include page="/views/includes/nav_usuario.jsp"/>
    <div class="container">
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
            <div>
                <h2 class="page-title mb-1">
                    <i class="bi bi-person-workspace"></i>${usuario.nombreCompleto}
                </h2>
                <p style="color:var(--text-muted);font-size:0.82rem;margin:0;">
                    <span class="badge bg-secondary me-2">${usuario.tipoUsuario.nombre}</span>
                    ${usuario.email}
                </p>
            </div>
            <button class="btn btn-success" onclick="abrirModalPrestamo()">
                <i class="bi bi-plus-circle-fill me-2"></i>Solicitar Préstamo
            </button>
        </div>

        <c:if test="${not empty mensaje}">
            <div class="alert alert-info alert-dismissible fade show mb-4">
                <i class="bi bi-info-circle me-2"></i>${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row g-4 mb-5">
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="bi bi-arrow-left-right"></i></div>
                    <div class="stat-number">${totalPrestamos}</div>
                    <div class="stat-label">Mis Préstamos</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon" style="color:var(--accent-pink)">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                    </div>
                    <div class="stat-number" style="background:linear-gradient(135deg,#fb7185,#be185d);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">
                        ${totalMultas}
                    </div>
                    <div class="stat-label">Mis Multas</div>
                </div>
            </div>
        </div>

        <h2 class="page-title"><i class="bi bi-arrow-left-right"></i>Mis Préstamos</h2>
        <div class="table-responsive mb-5">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>ID</th><th>Libro</th><th>F. Préstamo</th>
                        <th>Dev. Esperada</th><th>Dev. Real</th><th>Estado</th><th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty misPrestamos}">
                            <tr><td colspan="7" class="text-center py-4" style="color:var(--text-muted);">
                                <i class="bi bi-inbox fs-3 d-block mb-2"></i>No tienes préstamos registrados.
                            </td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${misPrestamos}">
                                <tr>
                                    <td>${p.idPrestamo}</td>
                                    <td>${p.libro.titulo}</td>
                                    <td>${p.fechaPrestamo}</td>
                                    <td>${p.fechaDevolucionEsperada}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty p.fechaDevolucionReal}">${p.fechaDevolucionReal}</c:when>
                                            <c:otherwise><span style="color:var(--text-muted)">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.estadoPrestamo.nombre eq 'activo'}">
                                                <span class="badge" style="background:linear-gradient(135deg,rgba(56,189,248,0.25),rgba(14,165,233,0.15));border:1px solid rgba(56,189,248,0.35);color:#7dd3fc;">Activo</span>
                                            </c:when>
                                            <c:when test="${p.estadoPrestamo.nombre eq 'devuelto'}">
                                                <span class="badge bg-success">Devuelto</span>
                                            </c:when>
                                            <c:when test="${p.estadoPrestamo.nombre eq 'vencido'}">
                                                <span class="badge bg-danger">Vencido</span>
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
                                                <i class="bi bi-box-arrow-up me-1"></i>Devolver
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

        <h2 class="page-title"><i class="bi bi-exclamation-triangle-fill"></i>Mis Multas</h2>
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>ID</th><th>Libro</th><th>Monto</th>
                        <th>F. Generación</th><th>F. Pago</th><th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty misMultas}">
                            <tr><td colspan="6" class="text-center py-4" style="color:var(--text-muted);">
                                <i class="bi bi-check-circle fs-3 d-block mb-2" style="color:#86efac;"></i>
                                No tienes multas registradas.
                            </td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${misMultas}">
                                <tr>
                                    <td>${m.idMulta}</td>
                                    <td>${m.prestamo.libro.titulo}</td>
                                    <td style="color:#86efac;font-family:'Orbitron',sans-serif;font-size:0.82rem;">
                                        <fmt:formatNumber value="${m.monto}" type="currency" currencySymbol="$" maxFractionDigits="0"/>
                                    </td>
                                    <td>${m.fechaGeneracion}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty m.fechaPago}">${m.fechaPago}</c:when>
                                            <c:otherwise><span style="color:var(--text-muted)">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${m.estadoMulta.nombre eq 'pendiente'}"><span class="badge bg-danger">Pendiente</span></c:when>
                                            <c:when test="${m.estadoMulta.nombre eq 'pagada'}"><span class="badge bg-success">Pagada</span></c:when>
                                            <c:otherwise><span class="badge bg-secondary">${m.estadoMulta.nombre}</span></c:otherwise>
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

    <!-- Modal Solicitar Préstamo -->
    <div class="modal fade" id="prestamoModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title"><i class="bi bi-plus-circle-fill me-2"></i>Solicitar Préstamo</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="formPrestamo" method="post" action="miPortal">
                        <input type="hidden" name="action" value="solicitar">
                        <div class="mb-3">
                            <label class="form-label">Libro disponible</label>
                            <select name="idLibro" id="modalLibro" class="form-select" required>
                                <option value="">Seleccione un libro...</option>
                                <c:forEach var="libro" items="${librosDisponibles}">
                                    <option value="${libro.idLibro}">
                                        ${libro.titulo}<c:if test="${not empty libro.autor.nombreCompleto}"> — ${libro.autor.nombreCompleto}</c:if>
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="form-text">Solo se muestran libros disponibles.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Fecha de devolución</label>
                            <input type="date" name="fechaDevolucionEsperada" id="modalFecha" class="form-control" required>
                            <div class="form-text">Debe ser posterior a hoy.</div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-success" onclick="confirmarPrestamo()">
                        <i class="bi bi-check-circle me-2"></i>Confirmar Préstamo
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Confirmar Devolución -->
    <div class="modal fade" id="devolucionModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title"><i class="bi bi-box-arrow-up me-2"></i>Confirmar Devolución</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p style="color:var(--text-muted)">¿Confirmas la devolución del libro:</p>
                    <p><strong id="libroADevolver" style="color:var(--text-heading)"></strong></p>
                    <div class="alert alert-danger mb-0" style="font-size:0.82rem;">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        Si devuelves después de la fecha esperada se generará una multa de
                        <strong>$2.000 por día de retraso</strong>.
                    </div>
                </div>
                <div class="modal-footer">
                    <form id="formDevolucion" method="post" action="miPortal">
                        <input type="hidden" name="action" value="devolver">
                        <input type="hidden" name="idPrestamo" id="idPrestamoDevolver">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-danger">
                            <i class="bi bi-box-arrow-up me-2"></i>Sí, devolver
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
        function abrirModalPrestamo() {
            const manana = new Date();
            manana.setDate(manana.getDate() + 1);
            document.getElementById("modalFecha").min = manana.toISOString().split('T')[0];
            document.getElementById("modalFecha").value = "";
            document.getElementById("modalLibro").value = "";
            new bootstrap.Modal(document.getElementById("prestamoModal")).show();
        }
        function confirmarPrestamo() {
            if (!document.getElementById("modalLibro").value) { alert("Selecciona un libro."); return; }
            if (!document.getElementById("modalFecha").value) { alert("Ingresa la fecha de devolución."); return; }
            document.getElementById("formPrestamo").submit();
        }
        function confirmarDevolucion(idPrestamo, titulo) {
            document.getElementById("idPrestamoDevolver").value = idPrestamo;
            document.getElementById("libroADevolver").textContent = titulo;
            new bootstrap.Modal(document.getElementById("devolucionModal")).show();
        }
    </script>
    <jsp:include page="includes/chatbot.jsp"/>
</body>
</html>