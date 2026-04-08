<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Usuarios — Biblioteca SENA</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <jsp:include page="/views/includes/nav_universal.jsp"/>

        <div class="container">
            <%-- Título épico --%>
            <h2 class="page-title">
                <i class="bi bi-people-fill"></i>
                Gestión de Usuarios
            </h2>
            <c:if test="${not empty buscar}">
                <div class="alert alert-info mb-4" style="background: rgba(168, 85, 247, 0.1); border-color: rgba(168, 85, 247, 0.3); color: var(--accent-bright);">
                    <i class="bi bi-search me-2"></i>
                    Mostrando resultados para: <strong>"${buscar}"</strong>
                    <a href="usuarios" class="float-end" style="color: var(--accent-primary);">
                        <i class="bi bi-x-circle"></i> Limpiar búsqueda
                    </a>
                </div>
            </c:if>

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
                        <i class="bi bi-person-plus-fill me-2"></i>
                        Nuevo Usuario
                    </button>
                </div>
                <div class="col-md">
                    <form method="get" action="usuarios" class="d-flex gap-2">
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-search" style="color: var(--accent-primary);"></i>
                            </span>
                            <input type="text" name="buscar" 
                                   placeholder="Buscar por nombre o documento..."
                                   value="${param.buscar}" 
                                   class="form-control">
                        </div>
                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-search"></i>
                        </button>
                        <a href="usuarios" class="btn btn-secondary">
                            <i class="bi bi-x-circle"></i>
                        </a>
                    </form>
                </div>
            </div>

            <%-- Tabla de usuarios épica --%>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th style="width: 60px;">ID</th>
                            <th>Documento</th>
                            <th>Nombre Completo</th>
                            <th>Email</th>
                            <th>Teléfono</th>
                            <th>Tipo</th>
                            <th>Rol</th>
                            <th>Estado</th>
                            <th style="width: 100px;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${usuarios}">
                            <tr>
                                <td>
                                    <span style="font-family: 'Orbitron', sans-serif;
                                          color: var(--accent-primary);
                                          font-size: 0.85rem;">
                                        #${u.idUsuario}
                                    </span>
                                </td>
                                <td>
                                    <code style="background: rgba(168, 85, 247, 0.1);
                                          padding: 4px 8px;
                                          border-radius: 4px;
                                          font-size: 0.85rem;">
                                        ${u.documento}
                                    </code>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <div style="width: 36px; height: 36px;
                                             background: linear-gradient(135deg, var(--accent-primary), var(--accent-dark));
                                             border-radius: 50%;
                                             display: flex;
                                             align-items: center;
                                             justify-content: center;
                                             color: #fff;
                                             font-weight: 600;
                                             font-size: 0.9rem;">
                                            ${u.nombres.charAt(0)}${u.apellidos.charAt(0)}
                                        </div>
                                        <span style="font-weight: 500;">${u.nombreCompleto}</span>
                                    </div>
                                </td>
                                <td>
                                    <a href="mailto:${u.email}" 
                                       style="color: var(--cyan-bright); text-decoration: none;">
                                        <i class="bi bi-envelope-fill me-1"></i>
                                        ${u.email}
                                    </a>
                                </td>
                                <td>
                                    <c:if test="${not empty u.telefono}">
                                        <span style="color: var(--text-muted);">
                                            <i class="bi bi-telephone-fill me-1" style="color: var(--accent-primary);"></i>
                                            ${u.telefono}
                                        </span>
                                    </c:if>
                                </td>
                                <td>
                                    <span class="badge" 
                                          style="background: rgba(6, 182, 212, 0.15);
                                          border: 1px solid rgba(6, 182, 212, 0.3);
                                          color: var(--cyan-bright);">
                                        ${u.tipoUsuario.nombre}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.esAdmin()}">
                                            <span class="badge" 
                                                  style="background: linear-gradient(135deg, rgba(234, 179, 8, 0.2), rgba(161, 98, 7, 0.15));
                                                  border: 1px solid rgba(234, 179, 8, 0.4);
                                                  color: #fde047;">
                                                <i class="bi bi-shield-fill me-1"></i>
                                                Admin
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge" 
                                                  style="background: rgba(148, 163, 184, 0.15);
                                                  border: 1px solid rgba(148, 163, 184, 0.3);
                                                  color: var(--text-muted);">
                                                <i class="bi bi-person me-1"></i>
                                                Usuario
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.estadoUsuario.nombre eq 'activo'}">
                                            <span class="badge bg-success">
                                                <i class="bi bi-check-circle-fill me-1"></i>
                                                Activo
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">
                                                <i class="bi bi-pause-circle-fill me-1"></i>
                                                Inactivo
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="d-flex gap-1">
                                        <button class="btn btn-warning btn-sm" 
                                                onclick="abrirModalEditar(this)"
                                                data-id="${u.idUsuario}" 
                                                data-documento="${u.documento}"
                                                data-nombres="${u.nombres}" 
                                                data-apellidos="${u.apellidos}"
                                                data-email="${u.email}" 
                                                data-telefono="${u.telefono}"
                                                data-idtipo="${u.tipoUsuario.idTipoUsuario}"
                                                data-idestado="${u.estadoUsuario.idEstadoUsuario}"
                                                title="Editar">
                                            <i class="bi bi-pencil-fill"></i>
                                        </button>
                                        <button class="btn btn-danger btn-sm"
                                                onclick="confirmarEliminar(${u.idUsuario}, '${u.nombreCompleto}')"
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
            <c:if test="${empty usuarios}">
                <div class="text-center py-5">
                    <i class="bi bi-inbox" style="font-size: 4rem; color: rgba(168, 85, 247, 0.2);"></i>
                    <h4 style="color: var(--text-muted); margin-top: 16px;">
                        No se encontraron usuarios
                    </h4>
                </div>
            </c:if>
        </div>

        <%-- Modal Crear/Editar --%>
        <div class="modal fade" id="usuarioModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="modalTituloLabel">
                            <i class="bi bi-person-plus-fill me-2"></i>
                            Nuevo Usuario
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="formUsuario" method="post" action="usuarios">
                            <input type="hidden" name="action" id="modalAction" value="create">
                            <input type="hidden" name="idUsuario" id="modalId">

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-card-text me-1" style="color: var(--accent-primary);"></i>
                                        Documento
                                    </label>
                                    <input type="text" name="documento" id="modalDocumento" 
                                           class="form-control" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-telephone-fill me-1" style="color: var(--accent-primary);"></i>
                                        Teléfono
                                    </label>
                                    <input type="text" name="telefono" id="modalTelefono" 
                                           class="form-control">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-person-fill me-1" style="color: var(--accent-primary);"></i>
                                        Nombres
                                    </label>
                                    <input type="text" name="nombres" id="modalNombres" 
                                           class="form-control" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-person-fill me-1" style="color: var(--accent-primary);"></i>
                                        Apellidos
                                    </label>
                                    <input type="text" name="apellidos" id="modalApellidos" 
                                           class="form-control" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="bi bi-envelope-fill me-1" style="color: var(--accent-primary);"></i>
                                    Email
                                </label>
                                <input type="email" name="email" id="modalEmail" 
                                       class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="bi bi-lock-fill me-1" style="color: var(--accent-primary);"></i>
                                    Contraseña
                                    <small style="color: var(--text-muted);">
                                        (dejar vacío para mantener al editar)
                                    </small>
                                </label>
                                <input type="password" name="password" id="modalPassword" 
                                       class="form-control" placeholder="Por defecto: 1234">
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-person-badge-fill me-1" style="color: var(--cyan-primary);"></i>
                                        Tipo de Usuario
                                    </label>
                                    <select name="idTipoUsuario" id="modalIdTipo" class="form-select" required>
                                        <c:forEach var="tipo" items="${tiposUsuario}">
                                            <option value="${tipo.idTipoUsuario}">
                                                ${tipo.nombre}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-toggle-on me-1" style="color: var(--pink-primary);"></i>
                                        Estado
                                    </label>
                                    <select name="idEstadoUsuario" id="modalIdEstado" class="form-select" required>
                                        <c:forEach var="estado" items="${estadosUsuario}">
                                            <option value="${estado.idEstadoUsuario}">
                                                ${estado.nombre}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            Cancelar
                        </button>
                        <button type="button" class="btn btn-success" onclick="guardarUsuario()">
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
                        <div id="avatarEliminar" 
                             style="width: 80px; height: 80px;
                             background: linear-gradient(135deg, var(--pink-primary), #be185d);
                             border-radius: 50%;
                             display: flex;
                             align-items: center;
                             justify-content: center;
                             color: #fff;
                             font-size: 2rem;
                             margin: 0 auto 16px;">
                            <i class="bi bi-person-x"></i>
                        </div>
                        <p style="color: var(--text-muted);">
                            ¿Eliminar permanentemente al usuario:
                        </p>
                        <h5 id="nombreAEliminar" 
                            style="color: var(--text-primary); font-family: 'Orbitron', sans-serif;">
                        </h5>
                        <div class="alert alert-danger mt-3">
                            <i class="bi bi-exclamation-circle-fill me-1"></i>
                            Esta acción no se puede deshacer
                        </div>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <form id="formEliminar" method="post" action="usuarios">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="idUsuario" id="idEliminar">
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
                                        '<i class="bi bi-person-plus-fill me-2"></i>Nuevo Usuario';
                                document.getElementById("modalAction").value = "create";
                                document.getElementById("modalId").value = "";
                                document.getElementById("modalDocumento").value = "";
                                document.getElementById("modalNombres").value = "";
                                document.getElementById("modalApellidos").value = "";
                                document.getElementById("modalEmail").value = "";
                                document.getElementById("modalTelefono").value = "";
                                document.getElementById("modalPassword").value = "";
                                document.getElementById("modalIdTipo").selectedIndex = 0;
                                document.getElementById("modalIdEstado").selectedIndex = 0;

                                new bootstrap.Modal(document.getElementById("usuarioModal")).show();
                            }

                            function abrirModalEditar(btn) {
                                document.getElementById("modalTituloLabel").innerHTML =
                                        '<i class="bi bi-pencil-fill me-2"></i>Editar Usuario';
                                document.getElementById("modalAction").value = "update";
                                document.getElementById("modalId").value = btn.dataset.id;
                                document.getElementById("modalDocumento").value = btn.dataset.documento;
                                document.getElementById("modalNombres").value = btn.dataset.nombres;
                                document.getElementById("modalApellidos").value = btn.dataset.apellidos;
                                document.getElementById("modalEmail").value = btn.dataset.email;
                                document.getElementById("modalTelefono").value = btn.dataset.telefono;
                                document.getElementById("modalPassword").value = "";
                                document.getElementById("modalIdTipo").value = btn.dataset.idtipo;
                                document.getElementById("modalIdEstado").value = btn.dataset.idestado;

                                new bootstrap.Modal(document.getElementById("usuarioModal")).show();
                            }

                            function confirmarEliminar(id, nombre) {
                                document.getElementById("idEliminar").value = id;
                                document.getElementById("nombreAEliminar").textContent = nombre;
                                new bootstrap.Modal(document.getElementById("modalEliminar")).show();
                            }

                            function guardarUsuario() {
                                document.getElementById("formUsuario").submit();
                            }
        </script>
        <jsp:include page="includes/chatbot.jsp"/>
    </body>
</html>