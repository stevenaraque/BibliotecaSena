<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String uri = request.getRequestURI();
    String ctx = request.getContextPath();
    
    // Verificar si hay usuario en sesión
    boolean estaLogueado = false;
    boolean esAdmin = false;
    String nombreUsuario = "";
    
    if (session != null && session.getAttribute("usuario") != null) {
        estaLogueado = true;
        adso.sena.biblioteca.model.Usuario usuario = 
            (adso.sena.biblioteca.model.Usuario) session.getAttribute("usuario");
        nombreUsuario = usuario.getNombreCompleto();
        
        if (usuario.getTipoUsuario() != null && usuario.getTipoUsuario().getIdTipoUsuario() == 3) {
            esAdmin = true;
        }
    }
%>

<!-- ═══════════════════════════════════════════════════════════════
     NAVBAR UNIVERSAL - Biblioteca SENA (Estilo Galáctico Unificado)
     ═══════════════════════════════════════════════════════════════ -->

<nav class="navbar-galaxy" id="mainNav">
    <div class="navbar-inner">
        
        <!-- Brand -->
        <a href="<%= ctx %>/catalogo" class="brand">
            <div class="brand-icon">
                <i class="bi bi-hexagon-fill"></i>
            </div>
            <span class="brand-text">Biblioteca SENA</span>
        </a>

        <!-- Navegación Principal -->
        <div class="nav-pills">
            
            <% if (estaLogueado) { %>
                <!-- Usuario Logueado: Mi Portal -->
                <a href="<%= ctx %>/miPortal" 
                   class="nav-pill <%= uri.contains("/miPortal") ? "active" : "" %>">
                    <i class="bi bi-person-workspace"></i>
                    <span>Mi Portal</span>
                </a>
            <% } %>

            <!-- Catálogo (siempre visible) -->
            <a href="<%= ctx %>/catalogo" 
               class="nav-pill <%= uri.contains("/catalogo") ? "active" : "" %>">
                <i class="bi bi-collection"></i>
                <span>Catálogo</span>
            </a>

            <% if (esAdmin) { %>
                <!-- Divider Admin -->
                <div class="nav-divider">
                    <i class="bi bi-stars"></i>
                </div>
                
                <a href="<%= ctx %>/dashboard" 
                   class="nav-pill <%= uri.contains("/dashboard") ? "active" : "" %>">
                    <i class="bi bi-speedometer2"></i>
                    <span>Dashboard</span>
                </a>
                
                <a href="<%= ctx %>/usuarios" 
                   class="nav-pill <%= uri.contains("/usuarios") ? "active" : "" %>">
                    <i class="bi bi-people-fill"></i>
                    <span>Usuarios</span>
                </a>
                
                <a href="<%= ctx %>/libros" 
                   class="nav-pill <%= uri.contains("/libros") ? "active" : "" %>">
                    <i class="bi bi-book-fill"></i>
                    <span>Libros</span>
                </a>
                
                <a href="<%= ctx %>/prestamos" 
                   class="nav-pill <%= uri.contains("/prestamos") ? "active" : "" %>">
                    <i class="bi bi-arrow-left-right"></i>
                    <span>Préstamos</span>
                </a>
                
                <a href="<%= ctx %>/multas" 
                   class="nav-pill <%= uri.contains("/multas") ? "active" : "" %>">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <span>Multas</span>
                </a>
            <% } %>
        </div>

        <!-- Sección Derecha: Usuario o Login -->
        <div class="user-section">
            <% if (estaLogueado) { %>
                <!-- Usuario Logueado -->
                <div class="user-badge">
                    <div class="user-avatar">
                        <i class="bi bi-person-fill"></i>
                    </div>
                    <div class="user-info">
                        <span class="user-name"><%= nombreUsuario %></span>
                        <% if (esAdmin) { %>
                            <span class="user-role">Admin</span>
                        <% } %>
                    </div>
                </div>
                <a href="<%= ctx %>/logout" class="btn-logout" title="Cerrar Sesión">
                    <i class="bi bi-box-arrow-right"></i>
                </a>
            <% } else { %>
                <!-- Usuario NO Logueado - Botón Login -->
                <a href="<%= ctx %>/login" class="btn-login-nav">
                    <i class="bi bi-shield-lock-fill"></i>
                    <span>Iniciar Sesión</span>
                </a>
            <% } %>
        </div>
    </div>
</nav>

<!-- Espaciador -->
<div class="nav-spacer"></div>

<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<!-- Efectos Galácticos de Fondo -->
<script src="<%= ctx %>/js/galaxy-effects.js"></script>

<!-- Estilos Navbar Galáctico Unificado -->
<style>
    /* ═══════════════════════════════════════════════════════════
       NAVBAR GALÁCTICO - Estilo Oscuro/Morado Unificado
       ═══════════════════════════════════════════════════════════ */
    
    .navbar-galaxy {
        background: rgba(5, 1, 10, 0.95);
        backdrop-filter: blur(20px);
        border-bottom: 1px solid rgba(138, 43, 226, 0.3);
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        padding: 16px 24px;
        box-shadow: 0 4px 30px rgba(138, 43, 226, 0.2);
        transform: translateZ(0);
    }

    .navbar-inner {
        max-width: 1400px;
        margin: 0 auto;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 24px;
    }

    .nav-spacer {
        height: 75px;
        flex-shrink: 0;
    }

    /* ── Brand ───────────────────────────────────────────────── */
    .brand {
        display: flex;
        align-items: center;
        gap: 12px;
        text-decoration: none;
        flex-shrink: 0;
        transition: all 0.3s ease;
    }

    .brand:hover {
        transform: scale(1.02);
    }

    .brand-icon {
        width: 42px;
        height: 42px;
        background: linear-gradient(135deg, #8a2be2, #ec4899);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.2rem;
        box-shadow: 0 8px 32px rgba(138, 43, 226, 0.4);
        animation: pulseGlow 2s ease-in-out infinite;
    }

    @keyframes pulseGlow {
        0%, 100% { box-shadow: 0 8px 32px rgba(138, 43, 226, 0.4); }
        50% { box-shadow: 0 8px 32px rgba(138, 43, 226, 0.7), 0 0 40px rgba(138, 43, 226, 0.4); }
    }

    .brand-text {
        font-family: 'Orbitron', sans-serif;
        font-weight: 700;
        font-size: 1.1rem;
        background: linear-gradient(90deg, #c084fc, #a855f7, #c084fc);
        background-size: 200% auto;
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        animation: gradientShift 3s ease infinite;
    }

    @keyframes gradientShift {
        0%, 100% { background-position: 0% center; }
        50% { background-position: 100% center; }
    }

    /* ── Nav Pills ─────────────────────────────────────────── */
    .nav-pills {
        display: flex;
        align-items: center;
        gap: 8px;
        background: rgba(138, 43, 226, 0.1);
        padding: 6px;
        border-radius: 16px;
        border: 1px solid rgba(138, 43, 226, 0.2);
        flex: 1;
        justify-content: center;
        overflow-x: auto;
        scrollbar-width: none;
    }

    .nav-pills::-webkit-scrollbar {
        display: none;
    }

    .nav-pill {
        padding: 10px 18px;
        border-radius: 12px;
        color: #94a3b8;
        text-decoration: none;
        font-family: 'Rajdhani', sans-serif;
        font-weight: 600;
        font-size: 0.875rem;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
        white-space: nowrap;
        border: 1px solid transparent;
    }

    .nav-pill:hover {
        background: rgba(138, 43, 226, 0.2);
        color: #c084fc;
        border-color: rgba(138, 43, 226, 0.3);
        transform: translateY(-2px);
    }

    .nav-pill.active {
        background: rgba(138, 43, 226, 0.25);
        color: #c084fc;
        border-color: rgba(138, 43, 226, 0.5);
        box-shadow: 0 4px 20px rgba(138, 43, 226, 0.3);
    }

    .nav-pill i {
        font-size: 1rem;
    }

    /* Divider Admin */
    .nav-divider {
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #ec4899;
        font-size: 0.9rem;
        animation: pulseStar 2s infinite;
    }

    @keyframes pulseStar {
        0%, 100% { opacity: 1; transform: scale(1); }
        50% { opacity: 0.6; transform: scale(0.9); }
    }

    /* ── User Section ───────────────────────────────────────── */
    .user-section {
        display: flex;
        align-items: center;
        gap: 12px;
        flex-shrink: 0;
    }

    /* Usuario Logueado */
    .user-badge {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 6px 14px;
        background: rgba(138, 43, 226, 0.1);
        border: 1px solid rgba(138, 43, 226, 0.2);
        border-radius: 12px;
        transition: all 0.3s ease;
    }

    .user-badge:hover {
        border-color: rgba(138, 43, 226, 0.4);
        box-shadow: 0 4px 20px rgba(138, 43, 226, 0.2);
    }

    .user-avatar {
        width: 32px;
        height: 32px;
        background: linear-gradient(135deg, #8a2be2, #6366f1);
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 0.9rem;
    }

    .user-info {
        display: flex;
        flex-direction: column;
        line-height: 1.2;
    }

    .user-name {
        font-family: 'Rajdhani', sans-serif;
        font-weight: 600;
        font-size: 0.85rem;
        color: #f8fafc;
        max-width: 120px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .user-role {
        font-family: 'Orbitron', sans-serif;
        font-size: 0.7rem;
        color: #a855f7;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }

    .btn-logout {
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: rgba(239, 68, 68, 0.1);
        border: 1px solid rgba(239, 68, 68, 0.2);
        border-radius: 10px;
        color: #f87171;
        text-decoration: none;
        transition: all 0.3s ease;
        font-size: 1.1rem;
    }

    .btn-logout:hover {
        background: rgba(239, 68, 68, 0.2);
        color: #fca5a5;
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
    }

    /* Usuario NO Logueado - Botón Login */
    .btn-login-nav {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 12px 24px;
        background: linear-gradient(135deg, #8a2be2, #4b0082);
        border: none;
        border-radius: 12px;
        color: #fff;
        text-decoration: none;
        font-family: 'Orbitron', sans-serif;
        font-weight: 700;
        font-size: 0.8rem;
        letter-spacing: 1px;
        text-transform: uppercase;
        transition: all 0.3s ease;
        box-shadow: 0 4px 20px rgba(138, 43, 226, 0.5);
        position: relative;
        overflow: hidden;
    }

    .btn-login-nav::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition: left 0.5s;
    }

    .btn-login-nav:hover::before {
        left: 100%;
    }

    .btn-login-nav:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 30px rgba(138, 43, 226, 0.7);
    }

    /* ── Responsive ─────────────────────────────────────────── */
    @media (max-width: 1200px) {
        .nav-pill span {
            display: none;
        }
        .nav-pill {
            padding: 10px;
        }
        .user-name {
            display: none;
        }
        .user-role {
            display: none;
        }
        .btn-login-nav span {
            display: none;
        }
        .btn-login-nav {
            padding: 12px;
        }
    }

    @media (max-width: 768px) {
        .navbar-galaxy {
            padding: 12px 16px;
        }
        .brand-text {
            display: none;
        }
        .nav-spacer {
            height: 65px;
        }
        .nav-divider {
            display: none;
        }
    }

    @media (max-width: 576px) {
        .nav-pills {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            top: auto;
            border-radius: 20px 20px 0 0;
            border-bottom: none;
            border-top: 1px solid rgba(138, 43, 226, 0.2);
            padding: 8px;
            justify-content: space-around;
            z-index: 9999;
            background: rgba(5, 1, 10, 0.98);
            backdrop-filter: blur(20px);
        }
        .nav-spacer {
            height: 0;
        }
        body {
            padding-bottom: 70px;
        }
        .navbar-galaxy {
            position: relative;
        }
        .user-section {
            position: fixed;
            top: 12px;
            right: 16px;
            z-index: 1001;
        }
    }
</style>