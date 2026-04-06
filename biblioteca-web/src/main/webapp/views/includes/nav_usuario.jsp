<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String uri = request.getRequestURI();
%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<div class="header">
    <h1><i class="bi bi-hexagon-fill me-2"></i>Sistema de Biblioteca &mdash; SENA</h1>
    <span class="bienvenido">
        <i class="bi bi-person-circle me-1"></i>${sessionScope.usuario.nombreCompleto}
    </span>
</div>
<nav class="menu" id="mainNav">
    <a href="${pageContext.request.contextPath}/miPortal"
       class="<%= uri.contains("/miPortal") ? "active" : "" %>">
        <i class="bi bi-person-workspace"></i>Mi Portal
    </a>
    <a href="${pageContext.request.contextPath}/logout" class="ms-auto">
        <i class="bi bi-box-arrow-right"></i>Cerrar Sesi&oacute;n
    </a>
</nav>
