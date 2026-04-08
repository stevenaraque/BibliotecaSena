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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<!-- GALAXY EFFECTS JS -->
<script src="<%= ctx %>/js/galaxy-effects.js"></script>
<div class="header">
    <h1><i class="bi bi-hexagon-fill me-2"></i>Sistema de Biblioteca &mdash; SENA</h1>
    <span class="bienvenido">
        <i class="bi bi-person-circle me-1"></i>${sessionScope.usuario.nombreCompleto}
        <% if (esAdmin) { %>
            <span class="badge-admin">ADMIN</span>
        <% } %>
    </span>
</div>

<nav class="menu" id="mainNav">
    
    <!-- OPCIONES COMUNES (todos los usuarios) -->
    <a href="<%= ctx %>/miPortal"
       class="<%= uri.contains("/miPortal") ? "active" : "" %>">
        <i class="bi bi-person-workspace"></i>Mi Portal
    </a>
    
    <a href="<%= ctx %>/catalogo"
       class="<%= uri.contains("/catalogo") ? "active" : "" %>">
        <i class="bi bi-collection"></i>Catálogo
    </a>
    
    <!-- OPCIONES SOLO ADMIN -->
    <% if (esAdmin) { %>
        <a href="<%= ctx %>/dashboard"
           class="<%= uri.contains("/dashboard") ? "active" : "" %>">
            <i class="bi bi-grid-1x2-fill"></i>Dashboard
        </a>
        
        <a href="<%= ctx %>/usuarios"
           class="<%= uri.contains("/usuarios") ? "active" : "" %>">
            <i class="bi bi-people-fill"></i>Usuarios
        </a>
        
        <a href="<%= ctx %>/libros"
           class="<%= uri.contains("/libros") ? "active" : "" %>">
            <i class="bi bi-book-fill"></i>Libros
        </a>
        
        <a href="<%= ctx %>/prestamos"
           class="<%= uri.contains("/prestamos") ? "active" : "" %>">
            <i class="bi bi-arrow-left-right"></i>Préstamos
        </a>
        
        <a href="<%= ctx %>/multas"
           class="<%= uri.contains("/multas") ? "active" : "" %>">
            <i class="bi bi-exclamation-triangle-fill"></i>Multas
        </a>
    <% } %>
    
    <!-- CERRAR SESIÓN (todos) -->
    <a href="<%= ctx %>/logout" class="ms-auto">
        <i class="bi bi-box-arrow-right"></i>Cerrar Sesi&oacute;n
    </a>
</nav>

<!-- Estilo opcional para badge ADMIN -->
<style>
    .badge-admin {
        background: linear-gradient(135deg, #8a2be2, #4b0082);
        color: #fff;
        font-size: 0.65rem;
        padding: 2px 8px;
        border-radius: 4px;
        margin-left: 8px;
        font-family: 'Rajdhani', sans-serif;
        font-weight: 600;
        letter-spacing: 0.1em;
    }
</style>