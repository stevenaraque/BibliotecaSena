<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Acceso — Biblioteca SENA</title>
    
    <!-- Fuentes Galaxy -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700;800&family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #030005;
            background-image:
                radial-gradient(ellipse 70% 50% at 15% 20%, rgba(138,43,226,0.15) 0%, transparent 60%),
                radial-gradient(ellipse 50% 40% at 85% 80%, rgba(75,0,130,0.12) 0%, transparent 55%);
            padding: 24px;
            position: relative;
            overflow-x: hidden;
        }

        /* Canvas de estrellas */
        #starfield {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 0;
            opacity: 0.8;
        }

        /* Contenedor principal por encima del canvas */
        .login-wrapper {
            width: 100%;
            max-width: 420px;
            position: relative;
            z-index: 1;
            animation: fadeInUp 0.8s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-brand {
            text-align: center;
            margin-bottom: 32px;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .login-brand .brand-icon {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            background: linear-gradient(135deg, #8a2be2, #4b0082);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 0 40px rgba(138, 43, 226, 0.5),
                        0 0 80px rgba(138, 43, 226, 0.3),
                        inset 0 0 20px rgba(255, 255, 255, 0.1);
            font-size: 2.2rem;
            color: #fff;
            position: relative;
            overflow: hidden;
            animation: pulseGlow 2s ease-in-out infinite;
        }

        @keyframes pulseGlow {
            0%, 100% { 
                box-shadow: 0 0 40px rgba(138, 43, 226, 0.5),
                            0 0 80px rgba(138, 43, 226, 0.3);
            }
            50% { 
                box-shadow: 0 0 60px rgba(138, 43, 226, 0.8),
                            0 0 100px rgba(138, 43, 226, 0.5);
            }
        }

        /* Efecto de brillo en el icono */
        .login-brand .brand-icon::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                45deg,
                transparent 30%,
                rgba(255, 255, 255, 0.1) 50%,
                transparent 70%
            );
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%) rotate(45deg); }
            100% { transform: translateX(100%) rotate(45deg); }
        }

        .login-brand h1 {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.3rem;
            font-weight: 800;
            background: linear-gradient(90deg, #c084fc, #818cf8, #38bdf8);
            background-size: 200% auto;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: 0.06em;
            margin-bottom: 8px;
            animation: gradientShift 3s ease infinite;
        }

        @keyframes gradientShift {
            0%, 100% { background-position: 0% center; }
            50% { background-position: 100% center; }
        }

        .login-brand p {
            font-family: 'Rajdhani', sans-serif;
            font-size: 0.8rem;
            color: #94a3b8;
            letter-spacing: 0.15em;
            text-transform: uppercase;
        }

        .login-card {
            background: rgba(15, 5, 30, 0.6);
            border: 1px solid rgba(138, 43, 226, 0.2);
            border-radius: 20px;
            padding: 36px 32px;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(20px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4),
                        0 0 60px rgba(138, 43, 226, 0.1);
            transition: all 0.3s ease;
        }

        .login-card:hover {
            border-color: rgba(138, 43, 226, 0.4);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4),
                        0 0 80px rgba(138, 43, 226, 0.2);
        }

        .login-card::before {
            content: '';
            position: absolute;
            inset: 0;
            border-radius: 20px;
            padding: 1px;
            background: linear-gradient(135deg, 
                rgba(138, 43, 226, 0.6) 0%, 
                transparent 40%, 
                transparent 60%, 
                rgba(75, 0, 130, 0.4) 100%);
            -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
            -webkit-mask-composite: xor;
            mask-composite: exclude;
            pointer-events: none;
        }

        /* Inputs mejorados */
        .login-card .form-label {
            font-family: 'Rajdhani', sans-serif;
            font-size: 0.8rem;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .login-card .input-group-text {
            background: rgba(138, 43, 226, 0.15) !important;
            border: 1px solid rgba(138, 43, 226, 0.3) !important;
            border-right: none !important;
            color: #8a2be2 !important;
            border-radius: 12px 0 0 12px !important;
            padding: 12px 16px;
            transition: all 0.3s ease;
        }

        .login-card .input-group:focus-within .input-group-text {
            background: rgba(138, 43, 226, 0.25) !important;
            color: #c084fc !important;
        }

        .login-card .input-group .form-control {
            background: rgba(15, 5, 26, 0.8) !important;
            border: 1px solid rgba(138, 43, 226, 0.3) !important;
            border-left: none !important;
            border-radius: 0 12px 12px 0 !important;
            color: #f8fafc !important;
            font-family: 'Rajdhani', sans-serif;
            padding: 12px 16px;
            transition: all 0.3s ease;
        }

        .login-card .input-group .form-control:focus {
            box-shadow: none !important;
            border-color: #8a2be2 !important;
        }

        .login-card .input-group:focus-within {
            box-shadow: 0 0 20px rgba(138, 43, 226, 0.2);
            border-radius: 12px;
        }

        .login-card .input-group .btn {
            border-radius: 0 12px 12px 0 !important;
            border-left: none !important;
            background: rgba(15, 5, 26, 0.8);
            border-color: rgba(138, 43, 226, 0.3);
            color: #94a3b8;
            transition: all 0.3s ease;
        }

        .login-card .input-group .btn:hover {
            background: rgba(138, 43, 226, 0.2);
            color: #c084fc;
        }

        /* Botón de login épico */
        .btn-login-galaxy {
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, #8a2be2, #4b0082) !important;
            border: none !important;
            font-family: 'Rajdhani', sans-serif;
            font-weight: 700;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            padding: 14px !important;
            border-radius: 12px !important;
            box-shadow: 0 4px 20px rgba(138, 43, 226, 0.4);
            transition: all 0.3s ease;
        }

        .btn-login-galaxy::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, 
                transparent, 
                rgba(255, 255, 255, 0.3), 
                transparent);
            transition: left 0.6s ease;
        }

        .btn-login-galaxy:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(138, 43, 226, 0.6);
        }

        .btn-login-galaxy:hover::before {
            left: 100%;
        }

        /* Botón de registro */
        .btn-register-galaxy {
            background: transparent !important;
            border: 1px solid rgba(138, 43, 226, 0.4) !important;
            color: #c084fc !important;
            font-family: 'Rajdhani', sans-serif;
            font-weight: 600;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            padding: 12px !important;
            border-radius: 12px !important;
            transition: all 0.3s ease;
        }

        .btn-register-galaxy:hover {
            background: rgba(138, 43, 226, 0.15) !important;
            border-color: #8a2be2 !important;
            color: #f8fafc !important;
            box-shadow: 0 0 20px rgba(138, 43, 226, 0.3);
        }

        hr {
            border-color: rgba(138, 43, 226, 0.2) !important;
            margin: 28px 0 !important;
        }

        .login-footer {
            text-align: center;
            margin-top: 24px;
            font-family: 'Rajdhani', sans-serif;
            font-size: 0.75rem;
            color: #64748b;
            letter-spacing: 0.1em;
            text-transform: uppercase;
        }

        /* Alertas mejoradas */
        .alert-galaxy {
            background: rgba(190, 24, 93, 0.15);
            border: 1px solid rgba(190, 24, 93, 0.3);
            color: #fb7185;
            border-radius: 12px;
            font-family: 'Rajdhani', sans-serif;
        }

        .alert-galaxy-success {
            background: rgba(138, 43, 226, 0.15);
            border: 1px solid rgba(138, 43, 226, 0.3);
            color: #c084fc;
        }

        /* Modal de registro mejorado */
        .modal-content {
            background: rgba(15, 5, 26, 0.98);
            border: 1px solid rgba(138, 43, 226, 0.3);
            border-radius: 20px;
            box-shadow: 0 0 60px rgba(138, 43, 226, 0.3);
        }

        .modal-header {
            background: linear-gradient(135deg, rgba(138, 43, 226, 0.3), rgba(75, 0, 130, 0.2));
            border-bottom: 1px solid rgba(138, 43, 226, 0.2);
            border-radius: 20px 20px 0 0;
        }

        .modal-title {
            font-family: 'Orbitron', sans-serif;
            color: #f8fafc;
        }

        .modal-body .form-label {
            font-family: 'Rajdhani', sans-serif;
            font-size: 0.8rem;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.08em;
        }

        .modal-body .form-control,
        .modal-body .form-select {
            background: rgba(15, 5, 26, 0.8);
            border: 1px solid rgba(138, 43, 226, 0.3);
            color: #f8fafc;
            border-radius: 10px;
            font-family: 'Rajdhani', sans-serif;
        }

        .modal-body .form-control:focus,
        .modal-body .form-select:focus {
            border-color: #8a2be2;
            box-shadow: 0 0 15px rgba(138, 43, 226, 0.2);
        }

        .modal-footer {
            border-top: 1px solid rgba(138, 43, 226, 0.2);
        }

        /* SweetAlert2 Custom Theme */
        .swal-galaxy {
            font-family: 'Rajdhani', sans-serif !important;
        }
        .swal-galaxy .swal2-popup {
            background: rgba(15, 5, 26, 0.98) !important;
            border: 1px solid rgba(138, 43, 226, 0.4) !important;
            border-radius: 16px !important;
            box-shadow: 0 0 40px rgba(138, 43, 226, 0.3) !important;
        }
        .swal-galaxy .swal2-title {
            font-family: 'Orbitron', sans-serif !important;
            color: #f8fafc !important;
        }
        .swal-galaxy .swal2-html-container {
            color: #94a3b8 !important;
        }
        .swal-galaxy .swal2-confirm {
            background: linear-gradient(135deg, #8a2be2, #4b0082) !important;
            border: none !important;
            font-family: 'Rajdhani', sans-serif !important;
            font-weight: 700 !important;
            letter-spacing: 0.06em !important;
            border-radius: 10px !important;
        }
        .swal-galaxy .swal2-cancel {
            background: transparent !important;
            border: 1px solid rgba(138, 43, 226, 0.4) !important;
            color: #94a3b8 !important;
        }
        .swal-galaxy .swal2-icon.swal2-error {
            border-color: #fb7185 !important;
            color: #fb7185 !important;
        }
        .swal-galaxy .swal2-icon.swal2-success {
            border-color: #c084fc !important;
            color: #c084fc !important;
        }
        .swal-galaxy .swal2-success-ring {
            border-color: rgba(192, 132, 252, 0.3) !important;
        }

        /* Responsive */
        @media (max-width: 576px) {
            .login-brand .brand-icon {
                width: 60px;
                height: 60px;
                font-size: 1.6rem;
            }
            .login-brand h1 {
                font-size: 1.1rem;
            }
            .login-card {
                padding: 24px 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Canvas para estrellas -->
    <canvas id="starfield"></canvas>

    <div class="login-wrapper">
        <div class="login-brand">
            <div class="brand-icon"><i class="bi bi-hexagon-fill"></i></div>
            <h1>Sistema de Biblioteca</h1>
            <p>Acceso Seguro — SENA</p>
        </div>
        
        <div class="login-card">
            <!-- Alertas con animación -->
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-galaxy alert-dismissible fade show mb-4" role="alert">
                    <i class="bi bi-shield-exclamation me-2"></i>${requestScope.error}
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty requestScope.mensaje}">
                <div class="alert alert-galaxy-success alert-dismissible fade show mb-4" role="alert">
                    <i class="bi bi-check-circle me-2"></i>${requestScope.mensaje}
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/login" id="loginForm">
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
                        <button class="btn" type="button" onclick="togglePassword('passwordLogin', this)">
                            <i class="bi bi-eye-fill"></i>
                        </button>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-success btn-lg w-100 btn-login-galaxy">
                    <i class="bi bi-shield-lock-fill me-2"></i>Iniciar Sesión
                </button>
            </form>

            <hr>

            <div class="text-center">
                <p style="font-size:0.85rem;color:#94a3b8;margin-bottom:16px;">
                    ¿No tienes cuenta? Regístrate como estudiante o docente.
                </p>
                <button class="btn btn-outline-success w-100 btn-register-galaxy" onclick="abrirModalRegistro()">
                    <i class="bi bi-person-plus-fill me-2"></i>Crear Cuenta
                </button>
            </div>
        </div>
        
        <div class="login-footer">Proyecto Java Web — Steven Araque</div>
    </div>

    <!-- Modal Registro Mejorado -->
    <div class="modal fade" id="modalRegistro" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-person-plus-fill me-2"></i>Crear Cuenta</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="formRegistro" method="post" action="${pageContext.request.contextPath}/registro">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Nombres</label>
                                <input type="text" name="nombres" class="form-control" required 
                                       placeholder="Ej: Carlos Andrés">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Apellidos</label>
                                <input type="text" name="apellidos" class="form-control" required 
                                       placeholder="Ej: Rodríguez López">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Documento</label>
                                <input type="text" name="documento" class="form-control" required 
                                       placeholder="Número de documento">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Teléfono</label>
                                <input type="text" name="telefono" class="form-control" 
                                       placeholder="Ej: 3101234567">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Correo electrónico</label>
                            <input type="email" name="email" class="form-control" required 
                                   placeholder="tucorreo@sena.edu.co">
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Contraseña</label>
                                <div class="input-group">
                                    <input type="password" name="password" id="passwordReg" 
                                           class="form-control" required 
                                           placeholder="Mínimo 4 caracteres">
                                    <button class="btn btn-outline-secondary" type="button" 
                                            onclick="togglePassword('passwordReg', this)">
                                        <i class="bi bi-eye-fill"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Confirmar Contraseña</label>
                                <div class="input-group">
                                    <input type="password" id="passwordConfirm" 
                                           class="form-control" required 
                                           placeholder="Repite la contraseña">
                                    <button class="btn btn-outline-secondary" type="button" 
                                            onclick="togglePassword('passwordConfirm', this)">
                                        <i class="bi bi-eye-fill"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tipo de Usuario</label>
                            <select name="idTipoUsuario" class="form-select" required>
                                <option value="1">Estudiante</option>
                                <option value="2">Docente</option>
                            </select>
                            <div class="form-text" style="color: #64748b; font-size: 0.75rem;">
                                El rol Administrativo solo puede ser asignado por un administrador.
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                            style="background: transparent; border: 1px solid rgba(138,43,226,0.3); color: #94a3b8;">
                        Cancelar
                    </button>
                    <button type="button" class="btn btn-success btn-login-galaxy" onclick="guardarRegistro()">
                        <i class="bi bi-check-circle me-2"></i>Crear Cuenta
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="${pageContext.request.contextPath}/js/galaxy-effects.js"></script>

    <script>
        // Animación de entrada
        document.addEventListener('DOMContentLoaded', function() {
            // Efecto de typing en el subtítulo
            const subtitle = document.querySelector('.login-brand p');
            const text = subtitle.textContent;
            subtitle.textContent = '';
            let i = 0;
            const typeWriter = () => {
                if (i < text.length) {
                    subtitle.textContent += text.charAt(i);
                    i++;
                    setTimeout(typeWriter, 50);
                }
            };
            setTimeout(typeWriter, 500);
        });

        function abrirModalRegistro() {
            new bootstrap.Modal(document.getElementById("modalRegistro")).show();
        }

        function guardarRegistro() {
            const pass = document.getElementById("passwordReg").value;
            const confirm = document.getElementById("passwordConfirm").value;
            
            if (pass !== confirm) {
                Swal.fire({
                    customClass: { container: 'swal-galaxy' },
                    icon: 'error',
                    title: '¡Error!',
                    text: 'Las contraseñas no coinciden.',
                    confirmButtonText: 'Entendido',
                    timer: 3000,
                    timerProgressBar: true
                });
                return;
            }
            
            if (pass.length < 4) {
                Swal.fire({
                    customClass: { container: 'swal-galaxy' },
                    icon: 'warning',
                    title: 'Contraseña muy corta',
                    text: 'La contraseña debe tener al menos 4 caracteres.',
                    confirmButtonText: 'Entendido'
                });
                return;
            }

            // Confirmación épica
            Swal.fire({
                customClass: { container: 'swal-galaxy' },
                icon: 'question',
                title: '¿Confirmar registro?',
                text: 'Verifica que tus datos sean correctos.',
                showCancelButton: true,
                confirmButtonText: '<i class="bi bi-check-circle me-1"></i>Sí, crear cuenta',
                cancelButtonText: 'Cancelar',
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById("formRegistro").submit();
                }
            });
        }

        function togglePassword(inputId, btn) {
            const input = document.getElementById(inputId);
            const icon = btn.querySelector('i');
            if (input.type === "password") {
                input.type = "text";
                icon.className = "bi bi-eye-slash-fill";
            } else {
                input.type = "password";
                icon.className = "bi bi-eye-fill";
            }
        }

        // Efecto de carga en el login
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const btn = this.querySelector('.btn-login-galaxy');
            btn.innerHTML = '<i class="bi bi-arrow-repeat spin me-2"></i>Accediendo...';
            btn.disabled = true;
        });
    </script>
</body>
</html>