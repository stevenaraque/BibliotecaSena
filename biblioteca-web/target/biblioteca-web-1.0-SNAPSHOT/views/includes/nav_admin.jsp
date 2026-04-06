<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String uri = request.getRequestURI();
    String ctx = request.getContextPath();
%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<div class="header">
    <h1><i class="bi bi-hexagon-fill me-2"></i>Sistema de Biblioteca &mdash; SENA</h1>
    <span class="bienvenido">
        <i class="bi bi-person-circle me-1"></i>${sessionScope.usuario.nombreCompleto}
    </span>
</div>
<nav class="menu" id="mainNav">
    <a href="${pageContext.request.contextPath}/dashboard"
       class="<%= uri.contains("/dashboard") ? "active" : "" %>">
        <i class="bi bi-grid-1x2-fill"></i>Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/usuarios"
       class="<%= uri.contains("/usuarios") ? "active" : "" %>">
        <i class="bi bi-people-fill"></i>Usuarios
    </a>
    <a href="${pageContext.request.contextPath}/libros"
       class="<%= uri.contains("/libros") ? "active" : "" %>">
        <i class="bi bi-book-fill"></i>Libros
    </a>
    <a href="${pageContext.request.contextPath}/prestamos"
       class="<%= uri.contains("/prestamos") ? "active" : "" %>">
        <i class="bi bi-arrow-left-right"></i>Pr&eacute;stamos
    </a>
    <a href="${pageContext.request.contextPath}/multas"
       class="<%= uri.contains("/multas") ? "active" : "" %>">
        <i class="bi bi-exclamation-triangle-fill"></i>Multas
    </a>
    <a href="${pageContext.request.contextPath}/logout" class="ms-auto">
        <i class="bi bi-box-arrow-right"></i>Cerrar Sesi&oacute;n
    </a>
</nav>
