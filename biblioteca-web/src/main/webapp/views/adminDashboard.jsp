<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard &mdash; Biblioteca SENA</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/views/includes/nav_universal.jsp"/>
    
    <div class="container">
        <!-- Título épico -->
        <h2 class="page-title">
            <i class="bi bi-grid-1x2-fill"></i>
            Panel de Control
        </h2>
        
        <!-- Stats Cards con animación -->
        <div class="row g-4 mb-5">
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="bi bi-book-fill"></i>
                    </div>
                    <div class="stat-number">${totalLibros}</div>
                    <div class="stat-label">Libros Totales</div>
                    <a href="${pageContext.request.contextPath}/libros" 
                       class="btn btn-success btn-sm mt-3 w-100">
                        <i class="bi bi-arrow-right me-1"></i>
                        Gestionar
                    </a>
                </div>
            </div>
            
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div class="stat-number">${totalUsuarios}</div>
                    <div class="stat-label">Usuarios</div>
                    <a href="${pageContext.request.contextPath}/usuarios" 
                       class="btn btn-success btn-sm mt-3 w-100">
                        <i class="bi bi-arrow-right me-1"></i>
                        Gestionar
                    </a>
                </div>
            </div>
            
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="bi bi-arrow-left-right"></i>
                    </div>
                    <div class="stat-number">${totalPrestamos}</div>
                    <div class="stat-label">Préstamos</div>
                    <a href="${pageContext.request.contextPath}/prestamos" 
                       class="btn btn-success btn-sm mt-3 w-100">
                        <i class="bi bi-arrow-right me-1"></i>
                        Gestionar
                    </a>
                </div>
            </div>
            
            <div class="col-6 col-md-3">
                <div class="stat-card" style="border-color: rgba(236, 72, 153, 0.3);">
                    <div class="stat-icon" style="color: var(--pink-primary);">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                    </div>
                    <div class="stat-number" 
                         style="background: linear-gradient(135deg, #f472b6, #ec4899); 
                                -webkit-background-clip: text; 
                                -webkit-text-fill-color: transparent;">
                        ${multasPendientes}
                    </div>
                    <div class="stat-label">Multas Pendientes</div>
                    <a href="${pageContext.request.contextPath}/multas" 
                       class="btn btn-danger btn-sm mt-3 w-100">
                        <i class="bi bi-arrow-right me-1"></i>
                        Gestionar
                    </a>
                </div>
            </div>
        </div>

        <!-- Acceso Rápido -->
        <h2 class="page-title">
            <i class="bi bi-lightning-fill"></i>
            Acceso Rápido
        </h2>
        
        <div class="row g-3">
            <div class="col-12 col-sm-6 col-md-3">
                <a href="${pageContext.request.contextPath}/usuarios" 
                   class="galaxy-card text-decoration-none">
                    <i class="bi bi-people-fill fs-2" style="color: var(--accent-primary);"></i>
                    <div>
                        <div style="font-family: 'Orbitron', sans-serif; 
                                    font-size: 0.85rem; 
                                    color: var(--text-primary);">
                            Gestionar Usuarios
                        </div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">
                            CRUD completo
                        </div>
                    </div>
                </a>
            </div>
            
            <div class="col-12 col-sm-6 col-md-3">
                <a href="${pageContext.request.contextPath}/libros" 
                   class="galaxy-card text-decoration-none">
                    <i class="bi bi-book-fill fs-2" style="color: #818cf8;"></i>
                    <div>
                        <div style="font-family: 'Orbitron', sans-serif; 
                                    font-size: 0.85rem; 
                                    color: var(--text-primary);">
                            Gestionar Libros
                        </div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">
                            Catálogo completo
                        </div>
                    </div>
                </a>
            </div>
            
            <div class="col-12 col-sm-6 col-md-3">
                <a href="${pageContext.request.contextPath}/prestamos" 
                   class="galaxy-card text-decoration-none">
                    <i class="bi bi-arrow-left-right fs-2" style="color: #22d3ee;"></i>
                    <div>
                        <div style="font-family: 'Orbitron', sans-serif; 
                                    font-size: 0.85rem; 
                                    color: var(--text-primary);">
                            Gestionar Préstamos
                        </div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">
                            Control de préstamos
                        </div>
                    </div>
                </a>
            </div>
            
            <div class="col-12 col-sm-6 col-md-3">
                <a href="${pageContext.request.contextPath}/multas" 
                   class="galaxy-card text-decoration-none">
                    <i class="bi bi-exclamation-triangle-fill fs-2" 
                       style="color: var(--pink-primary);"></i>
                    <div>
                        <div style="font-family: 'Orbitron', sans-serif; 
                                    font-size: 0.85rem; 
                                    color: var(--text-primary);">
                            Gestionar Multas
                        </div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">
                            Pagos pendientes
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <jsp:include page="includes/chatbot.jsp"/>
</body>
</html>