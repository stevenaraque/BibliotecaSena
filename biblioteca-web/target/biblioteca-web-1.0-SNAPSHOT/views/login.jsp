<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Acceso — Biblioteca SENA</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: var(--bg-void);
            background-image:
                radial-gradient(ellipse 70% 50% at 15% 20%, rgba(138,43,226,0.15) 0%, transparent 60%),
                radial-gradient(ellipse 50% 40% at 85% 80%, rgba(75,0,130,0.12) 0%, transparent 55%);
            padding: 24px;
        }
        .login-wrapper { width: 100%; max-width: 420px; }
        .login-brand { text-align: center; margin-bottom: 32px; }
        .login-brand .brand-icon {
            width: 64px; height: 64px;
            border-radius: 18px;
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-deep));
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 16px;
            box-shadow: var(--glow-purple);
            font-size: 1.8rem; color: #fff;
        }
        .login-brand h1 {
            font-size: 1.1rem; font-weight: 800;
            background: linear-gradient(90deg, #c084fc, #818cf8, #38bdf8);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text; letter-spacing: 0.06em; margin-bottom: 4px;
        }
        .login-brand p { font-size: 0.75rem; color: var(--text-muted); letter-spacing: 0.08em; text-transform: uppercase; }
        .login-card {
            background: var(--bg-card);
            border: 1px solid var(--border-subtle);
            border-radius: 20px; padding: 36px 32px;
            position: relative; overflow: hidden;
        }
        .login-card::before {
            content: ''; position: absolute; inset: 0; border-radius: 20px; padding: 1px;
            background: linear-gradient(135deg, rgba(138,43,226,0.5), transparent 50%, rgba(75,0,130,0.3));
            -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
            -webkit-mask-composite: xor; mask-composite: exclude; pointer-events: none;
        }
        .login-footer { text-align: center; margin-top: 24px; font-size: 0.72rem; color: var(--text-muted); letter-spacing: 0.06em; }
        hr { border-color: var(--border-subtle) !important; }
        .login-card .input-group-text {
            background: rgba(138,43,226,0.1) !important;
            border: 1px solid var(--border-subtle) !important;
            border-right: none !important;
            color: var(--text-muted) !important;
            border-radius: 10px 0 0 10px !important;
        }
        .login-card .input-group .form-control { border-left: none !important; border-radius: 0 10px 10px 0 !important; }
        .login-card .input-group .btn { border-radius: 0 10px 10px 0 !important; border-left: none !important; }
    </style>
</head>
<body>
    <div class="login-wrapper">
        <div class="login-brand">
            <div class="brand-icon"><i class="bi bi-hexagon-fill"></i></div>
            <h1>Sistema de Biblioteca</h1>
            <p></p>
        </div>
        <div class="login-card">
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                    <i class="bi bi-shield-exclamation me-2"></i>${requestScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty requestScope.mensaje}">
                <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                    <i class="bi bi-check-circle me-2"></i>${requestScope.mensaje}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <form method="post" action="${pageContext.request.contextPath}/login">
                <div class="mb-3">
                    <label class="form-label">Correo electrónico</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                        <input type="email" name="email" class="form-control"
                               placeholder="tucorreo@sena.edu.co" required autofocus>
                    </div>
                </div>
                <div class="mb-4">
                    <label class="form-label">Contraseña</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" name="password" id="passwordLogin"
                               class="form-control" placeholder="••••••••" required>
                        <button class="btn btn-outline-secondary" type="button"
                                onclick="togglePassword('passwordLogin', this)">
                            <i class="bi bi-eye-fill"></i>
                        </button>
                    </div>
                </div>
                <button type="submit" class="btn btn-success btn-lg w-100">
                    <i class="bi bi-shield-lock-fill me-2"></i>Iniciar Sesión
                </button>
            </form>
            <hr style="margin: 24px 0;">
            <div class="text-center">
                <p style="font-size:0.78rem;color:var(--text-muted);margin-bottom:12px;">
                    ¿No tienes cuenta? Regístrate como estudiante o docente.
                </p>
                <button class="btn btn-outline-success w-100" onclick="abrirModalRegistro()">
                    <i class="bi bi-person-plus-fill me-2"></i>Crear Cuenta
                </button>
            </div>
        </div>
        <div class="login-footer">Proyecto Java Web Steven Araque</div>
    </div>

    <!-- Modal Registro -->
    <div class="modal fade" id="modalRegistro" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title"><i class="bi bi-person-plus-fill me-2"></i>Crear Cuenta</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="formRegistro" method="post" action="${pageContext.request.contextPath}/registro">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Nombres</label>
                                <input type="text" name="nombres" class="form-control" required placeholder="Ej: Carlos Andrés">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Apellidos</label>
                                <input type="text" name="apellidos" class="form-control" required placeholder="Ej: Rodríguez López">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Documento</label>
                                <input type="text" name="documento" class="form-control" required placeholder="Número de documento">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Teléfono</label>
                                <input type="text" name="telefono" class="form-control" placeholder="Ej: 3101234567">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Correo electrónico</label>
                            <input type="email" name="email" class="form-control" required placeholder="tucorreo@sena.edu.co">
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Contraseña</label>
                                <div class="input-group">
                                    <input type="password" name="password" id="passwordReg" class="form-control" required placeholder="Mínimo 4 caracteres">
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('passwordReg', this)"><i class="bi bi-eye-fill"></i></button>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Confirmar Contraseña</label>
                                <div class="input-group">
                                    <input type="password" id="passwordConfirm" class="form-control" required placeholder="Repite la contraseña">
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('passwordConfirm', this)"><i class="bi bi-eye-fill"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tipo de Usuario</label>
                            <select name="idTipoUsuario" class="form-select" required>
                                <option value="1">Estudiante</option>
                                <option value="2">Docente</option>
                            </select>
                            <div class="form-text">El rol Administrativo solo puede ser asignado por un administrador.</div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-success" onclick="guardarRegistro()">
                        <i class="bi bi-check-circle me-2"></i>Crear Cuenta
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function abrirModalRegistro() { new bootstrap.Modal(document.getElementById("modalRegistro")).show(); }
        function guardarRegistro() {
            const pass = document.getElementById("passwordReg").value;
            const confirm = document.getElementById("passwordConfirm").value;
            if (pass !== confirm) { alert("Las contraseñas no coinciden."); return; }
            if (pass.length < 4) { alert("La contraseña debe tener al menos 4 caracteres."); return; }
            document.getElementById("formRegistro").submit();
        }
        function togglePassword(inputId, btn) {
            const input = document.getElementById(inputId);
            const icon = btn.querySelector('i');
            if (input.type === "password") { input.type = "text"; icon.className = "bi bi-eye-slash-fill"; }
            else { input.type = "password"; icon.className = "bi bi-eye-fill"; }
        }
    </script>
</body>
</html>