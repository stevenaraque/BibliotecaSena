<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String uri = request.getRequestURI();
    String ctx = request.getContextPath();
    
    boolean esAdmin = false;
    if (session != null && session.getAttribute("usuario") != null) {
        adso.sena.biblioteca.model.Usuario usuario = 
            (adso.sena.biblioteca.model.Usuario) session.getAttribute("usuario");
        if (usuario.getTipoUsuario() != null && usuario.getTipoUsuario().getIdTipoUsuario() == 3) {
            esAdmin = true;
        }
    }
%>

<!-- ═══════════════════════════════════════════════════════════════
     NAVBAR GALAXY - Sistema Biblioteca SENA
     ═══════════════════════════════════════════════════════════════ -->

<nav class="galaxy-nav" id="mainNav">
    <div class="nav-container">
        
        <!-- Brand -->
        <a href="<%= ctx %>/catalogo" class="nav-brand">
            <i class="bi bi-hexagon-fill brand-icon"></i>
            <span class="brand-text">Biblioteca SENA</span>
        </a>

        <!-- Navegación Principal -->
        <div class="nav-links">
            <a href="<%= ctx %>/miPortal" 
               class="nav-link <%= uri.contains("/miPortal") ? "active" : "" %>">
                <i class="bi bi-person-workspace"></i>
                <span>Mi Portal</span>
            </a>

            <a href="<%= ctx %>/catalogo" 
               class="nav-link <%= uri.contains("/catalogo") ? "active" : "" %>">
                <i class="bi bi-collection"></i>
                <span>Catálogo</span>
            </a>

            <% if (esAdmin) { %>
                <!-- Admin Links Visibles Directamente -->
                <div class="admin-section">
                    <span class="admin-divider"></span>
                    
                    <a href="<%= ctx %>/dashboard" 
                       class="nav-link <%= uri.contains("/dashboard") ? "active" : "" %>">
                        <i class="bi bi-speedometer2"></i>
                        <span>Dashboard</span>
                    </a>
                    
                    <a href="<%= ctx %>/usuarios" 
                       class="nav-link <%= uri.contains("/usuarios") ? "active" : "" %>">
                        <i class="bi bi-people-fill"></i>
                        <span>Usuarios</span>
                    </a>
                    
                    <a href="<%= ctx %>/libros" 
                       class="nav-link <%= uri.contains("/libros") ? "active" : "" %>">
                        <i class="bi bi-book-fill"></i>
                        <span>Libros</span>
                    </a>
                    
                    <a href="<%= ctx %>/prestamos" 
                       class="nav-link <%= uri.contains("/prestamos") ? "active" : "" %>">
                        <i class="bi bi-arrow-left-right"></i>
                        <span>Préstamos</span>
                    </a>
                    
                    <a href="<%= ctx %>/multas" 
                       class="nav-link <%= uri.contains("/multas") ? "active" : "" %>">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                        <span>Multas</span>
                    </a>
                </div>
            <% } %>
        </div>

        <!-- Usuario y Logout -->
        <div class="nav-user">
            <div class="user-info">
                <i class="bi bi-person-circle user-icon"></i>
                <div class="user-details">
                    <span class="user-name">${sessionScope.usuario.nombreCompleto}</span>
                    <% if (esAdmin) { %>
                        <span class="user-role">ADMIN</span>
                    <% } %>
                </div>
            </div>
            <a href="<%= ctx %>/logout" class="btn-logout" title="Cerrar Sesión">
                <i class="bi bi-box-arrow-right"></i>
            </a>
        </div>
    </div>
</nav>

<!-- Espaciador para compensar el navbar fijo -->
<div class="nav-spacer"></div>

<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<!-- Estilos Navbar -->
<style>
    /* ── Navbar Galaxy ───────────────────────────────────────── */
    .galaxy-nav {
        background: rgba(5, 1, 10, 0.95);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border-bottom: 1px solid rgba(138, 43, 226, 0.25);
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        box-shadow: 0 4px 30px rgba(138, 43, 226, 0.2);
    }

    .nav-container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 0 24px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 70px;
    }

    /* Espaciador para el contenido no quede detrás del navbar */
    .nav-spacer {
        height: 70px;
        flex-shrink: 0;
    }

    /* ── Brand ───────────────────────────────────────────────── */
    .nav-brand {
        display: flex;
        align-items: center;
        gap: 12px;
        text-decoration: none;
        padding: 8px 12px;
        border-radius: 10px;
        transition: all 0.3s ease;
        flex-shrink: 0;
    }

    .nav-brand:hover {
        background: rgba(138, 43, 226, 0.1);
    }

    .brand-icon {
        font-size: 1.6rem;
        color: #8a2be2;
        filter: drop-shadow(0 0 10px rgba(138, 43, 226, 0.6));
        animation: pulseIcon 2s ease-in-out infinite;
    }

    @keyframes pulseIcon {
        0%, 100% { filter: drop-shadow(0 0 10px rgba(138, 43, 226, 0.6)); }
        50% { filter: drop-shadow(0 0 20px rgba(138, 43, 226, 0.9)); }
    }

    .brand-text {
        font-family: 'Orbitron', sans-serif;
        font-size: 1rem;
        font-weight: 700;
        background: linear-gradient(90deg, #c084fc, #818cf8);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        white-space: nowrap;
    }

    /* ── Links ───────────────────────────────────────────────── */
    .nav-links {
        display: flex;
        align-items: center;
        gap: 4px;
        flex: 1;
        margin-left: 30px;
        overflow-x: auto;
        scrollbar-width: none;
        -ms-overflow-style: none;
    }

    .nav-links::-webkit-scrollbar {
        display: none;
    }

    .nav-link {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 10px 16px;
        color: #94a3b8;
        text-decoration: none;
        font-family: 'Rajdhani', sans-serif;
        font-weight: 600;
        font-size: 0.85rem;
        border-radius: 8px;
        transition: all 0.3s ease;
        border: 1px solid transparent;
        white-space: nowrap;
        flex-shrink: 0;
    }

    .nav-link:hover,
    .nav-link.active {
        color: #f8fafc;
        background: rgba(138, 43, 226, 0.15);
        border-color: rgba(138, 43, 226, 0.3);
        box-shadow: 0 0 20px rgba(138, 43, 226, 0.2);
    }

    .nav-link i {
        font-size: 1rem;
    }

    /* ── Admin Section ──────────────────────────────────────── */
    .admin-section {
        display: flex;
        align-items: center;
        gap: 4px;
        margin-left: 10px;
        padding-left: 15px;
        border-left: 1px solid rgba(138, 43, 226, 0.2);
    }

    .admin-divider {
        display: none;
    }

    /* ── User Section ───────────────────────────────────────── */
    .nav-user {
        display: flex;
        align-items: center;
        gap: 16px;
        margin-left: 20px;
        flex-shrink: 0;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 6px 14px;
        background: rgba(138, 43, 226, 0.08);
        border: 1px solid rgba(138, 43, 226, 0.2);
        border-radius: 50px;
    }

    .user-icon {
        font-size: 1.4rem;
        color: #8a2be2;
    }

    .user-details {
        display: flex;
        flex-direction: column;
        line-height: 1.2;
    }

    .user-name {
        font-family: 'Rajdhani', sans-serif;
        font-weight: 600;
        font-size: 0.85rem;
        color: #f8fafc;
        white-space: nowrap;
        max-width: 150px;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .user-role {
        font-size: 0.65rem;
        color: #c084fc;
        text-transform: uppercase;
        letter-spacing: 0.1em;
        font-weight: 700;
    }

    .btn-logout {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
        background: transparent;
        border: 1px solid rgba(236, 72, 153, 0.3);
        border-radius: 10px;
        color: #fb7185;
        text-decoration: none;
        transition: all 0.3s ease;
        flex-shrink: 0;
    }

    .btn-logout:hover {
        background: rgba(236, 72, 153, 0.15);
        border-color: rgba(236, 72, 153, 0.5);
        color: #f472b6;
        box-shadow: 0 0 15px rgba(236, 72, 153, 0.3);
    }

    /* ── Responsive ─────────────────────────────────────────── */
    @media (max-width: 1200px) {
        .nav-link span {
            display: none;
        }
        .nav-link {
            padding: 10px;
        }
        .user-name {
            max-width: 100px;
        }
    }

    @media (max-width: 768px) {
        .nav-container {
            padding: 0 16px;
            height: 60px;
        }
        .nav-spacer {
            height: 60px;
        }
        .brand-text {
            display: none;
        }
        .admin-section {
            margin-left: 5px;
            padding-left: 10px;
        }
        .user-details {
            display: none;
        }
        .nav-links {
            margin-left: 10px;
        }
    }

    @media (max-width: 576px) {
        .nav-links {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(5, 1, 10, 0.98);
            border-top: 1px solid rgba(138, 43, 226, 0.3);
            margin: 0;
            padding: 8px;
            justify-content: space-around;
            z-index: 9999;
            overflow-x: auto;
        }
        .admin-section {
            border-left: none;
            margin-left: 0;
            padding-left: 0;
        }
        .nav-spacer {
            height: 0;
        }
        body {
            padding-bottom: 70px;
        }
        .galaxy-nav {
            position: relative;
        }
    }
</style>

<!-- GALAXY EFFECTS JS -->
<script src="<%= ctx %>/js/galaxy-effects.js"></script>