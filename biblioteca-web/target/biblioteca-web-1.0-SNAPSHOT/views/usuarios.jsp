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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <jsp:include page="/views/includes/nav_admin.jsp"/>
    <div class="container">
        <h2 class="page-title"><i class="bi bi-people-fill"></i>Gestión de Usuarios</h2>

        <c:if test="${not empty mensaje}">
            <div class="alert alert-info alert-dismissible fade show mb-4">
                <i class="bi bi-info-circle me-2"></i>${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="d-flex flex-wrap gap-2 align-items-center mb-4">
            <button class="btn btn-success" onclick="abrirModalNuevo()">
                <i class="bi bi-person-plus-fill me-2"></i>Nuevo Usuario
            </button>
            <form method="get" action="usuarios" class="d-flex gap-2 ms-auto flex-wrap">
                <input type="text" name="buscar" placeholder="Buscar por nombre o documento..."
                       value="${param.buscar}" class="form-control" style="min-width:240px;">
                <button type="submit" class="btn btn-success"><i class="bi bi-search me-1"></i>Buscar</button>
                <a href="usuarios" class="btn btn-secondary"><i class="bi bi-x-circle me-1"></i>Limpiar</a>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>ID</th><th>Documento</th><th>Nombre Completo</th>
                        <th>Email</th><th>Teléfono</th><th>Tipo</th>
                        <th>Rol</th><th>Estado</th><th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${usuarios}">
                        <tr>
                            <td>${u.idUsuario}</td>
                            <td>${u.documento}</td>
                            <td>${u.nombreCompleto}</td>
                            <td>${u.email}</td>
                            <td>${u.telefono}</td>
                            <td>${u.tipoUsuario.nombre}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.esAdmin()}">
                                        <span class="badge" style="background:linear-gradient(135deg,rgba(234,179,8,0.3),rgba(161,98,7,0.2));border:1px solid rgba(234,179,8,0.4);color:#fde047;">Admin</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge" style="background:linear-gradient(135deg,rgba(56,189,248,0.2),rgba(14,165,233,0.15));border:1px solid rgba(56,189,248,0.3);color:#7dd3fc;">Usuario</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.estadoUsuario.nombre eq 'activo'}"><span class="badge bg-success">Activo</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">Inactivo</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-warning btn-sm" onclick="abrirModalEditar(this)"
                                        data-id="${u.idUsuario}" data-documento="${u.documento}"
                                        data-nombres="${u.nombres}" data-apellidos="${u.apellidos}"
                                        data-email="${u.email}" data-telefono="${u.telefono}"
                                        data-idtipo="${u.tipoUsuario.idTipoUsuario}"
                                        data-idestado="${u.estadoUsuario.idEstadoUsuario}">
                                    <i class="bi bi-pencil-fill"></i>
                                </button>
                                <button class="btn btn-danger btn-sm"
                                        onclick="confirmarEliminar(${u.idUsuario}, '${u.nombreCompleto}')">
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
    <div class="modal fade" id="usuarioModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title" id="modalTituloLabel">Nuevo Usuario</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="formUsuario" method="post" action="usuarios">
                        <input type="hidden" name="action" id="modalAction" value="create">
                        <input type="hidden" name="idUsuario" id="modalId">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Documento</label>
                                <input type="text" name="documento" id="modalDocumento" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Teléfono</label>
                                <input type="text" name="telefono" id="modalTelefono" class="form-control">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Nombres</label>
                                <input type="text" name="nombres" id="modalNombres" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Apellidos</label>
                                <input type="text" name="apellidos" id="modalApellidos" class="form-control" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" id="modalEmail" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contraseña <small style="color:var(--text-muted)">(dejar vacío para mantener la actual al editar)</small></label>
                            <input type="password" name="password" id="modalPassword" class="form-control" placeholder="Por defecto: 1234">
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tipo de Usuario</label>
                                <select name="idTipoUsuario" id="modalIdTipo" class="form-select" required>
                                    <c:forEach var="tipo" items="${tiposUsuario}">
                                        <option value="${tipo.idTipoUsuario}">${tipo.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Estado</label>
                                <select name="idEstadoUsuario" id="modalIdEstado" class="form-select" required>
                                    <c:forEach var="estado" items="${estadosUsuario}">
                                        <option value="${estado.idEstadoUsuario}">${estado.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-success" onclick="guardarUsuario()">
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
                    <p style="color:var(--text-muted)">¿Estás seguro que deseas eliminar al usuario:</p>
                    <p><strong id="nombreAEliminar" style="color:var(--text-heading)"></strong></p>
                    <p style="color:#fb7185;font-size:0.82rem;">Esta acción no se puede deshacer.</p>
                </div>
                <div class="modal-footer">
                    <form id="formEliminar" method="post" action="usuarios">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="idUsuario" id="idEliminar">
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
            document.getElementById("modalTituloLabel").textContent = "Nuevo Usuario";
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
            document.getElementById("modalTituloLabel").textContent = "Editar Usuario";
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
        function guardarUsuario() { document.getElementById("formUsuario").submit(); }
    </script>
    <jsp:include page="includes/chatbot.jsp"/>
</body>
</html>