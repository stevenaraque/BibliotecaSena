<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Catálogo — Biblioteca SENA</title>
        <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700;800;900&family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        
        <%-- Estilos SweetAlert Galáctico --%>
        <style>
            .swal-biblioteca {
                background: rgba(15, 5, 26, 0.98) !important;
                border: 1px solid rgba(138, 43, 226, 0.4) !important;
                border-radius: 20px !important;
                box-shadow: 0 0 80px rgba(138, 43, 226, 0.4) !important;
            }
            .swal-biblioteca .swal2-title {
                font-family: 'Orbitron', sans-serif !important;
                color: #c084fc !important;
                font-size: 1.5rem !important;
            }
            .swal-biblioteca .swal2-html-container {
                font-family: 'Rajdhani', sans-serif !important;
                color: #f8fafc !important;
                font-size: 1.1rem !important;
            }
            .swal-biblioteca .swal2-confirm {
                background: linear-gradient(135deg, #8a2be2, #4b0082) !important;
                border: none !important;
                border-radius: 12px !important;
                font-family: 'Rajdhani', sans-serif !important;
                font-weight: 700 !important;
                padding: 12px 32px !important;
                box-shadow: 0 4px 20px rgba(138, 43, 226, 0.5) !important;
                transition: all 0.3s ease !important;
            }
            .swal-biblioteca .swal2-confirm:hover {
                box-shadow: 0 8px 30px rgba(138, 43, 226, 0.7) !important;
                transform: translateY(-2px) !important;
            }
            .swal-biblioteca .swal2-timer-progress-bar {
                background: linear-gradient(90deg, #8a2be2, #ec4899) !important;
            }
            .swal-biblioteca .swal2-icon.swal2-success {
                border-color: #8a2be2 !important;
                color: #8a2be2 !important;
            }
            .swal-biblioteca .swal2-icon.swal2-success [class^=swal2-success-line] {
                background-color: #8a2be2 !important;
            }
            .swal-biblioteca .swal2-icon.swal2-success .swal2-success-ring {
                border-color: rgba(138, 43, 226, 0.3) !important;
            }
            .swal-biblioteca .swal2-icon.swal2-error {
                border-color: #ec4899 !important;
                color: #ec4899 !important;
            }
            .swal-biblioteca .swal2-icon.swal2-error [class^=swal2-x-mark-line] {
                background-color: #ec4899 !important;
            }
        </style>

        <style>
            /* ═══════════════════════════════════════════════════════════
               FUTURISTA OPTIMIZADO - PALETA MORADA ORIGINAL
               ═══════════════════════════════════════════════════════════ */
            
            /* Scanlines sutiles (bajo consumo) */
            body::before {
                content: "";
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(
                    rgba(18, 16, 16, 0) 50%, 
                    rgba(0, 0, 0, 0.05) 50%
                );
                background-size: 100% 4px;
                pointer-events: none;
                z-index: 9997;
                opacity: 0.2;
            }
            
            .galaxy-content {
                position: relative;
                z-index: 1;
            }
            
            /* Animaciones optimizadas (GPU accelerated) */
            @keyframes fadeInUp {
                from { opacity: 0; transform: translateY(30px); }
                to { opacity: 1; transform: translateY(0); }
            }
            @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
            
            @keyframes glitch {
                0% { transform: translate(0); }
                20% { transform: translate(-2px, 2px); }
                40% { transform: translate(-2px, -2px); }
                60% { transform: translate(2px, 2px); }
                80% { transform: translate(2px, -2px); }
                100% { transform: translate(0); }
            }
            
            @keyframes pulseGlow {
                0%, 100% { box-shadow: 0 0 20px rgba(138, 43, 226, 0.4); }
                50% { box-shadow: 0 0 40px rgba(138, 43, 226, 0.7); }
            }
            
            @keyframes gradientShift {
                0%, 100% { background-position: 0% center; }
                50% { background-position: 100% center; }
            }
            
            @keyframes float {
                0%, 100% { transform: translateY(0px); }
                50% { transform: translateY(-10px); }
            }
            
            @keyframes shimmer {
                0% { left: -100%; }
                100% { left: 100%; }
            }

            /* Hero con typewriter */
            .cat-hero {
                text-align: center;
                padding: 80px 0 50px;
                animation: fadeInUp 0.8s ease-out;
                position: relative;
            }
            
            .cat-hero h1 {
                font-family: 'Orbitron', sans-serif;
                font-size: clamp(1.8rem, 5vw, 2.8rem);
                font-weight: 800;
                background: linear-gradient(90deg, #c084fc, #a855f7, #c084fc);
                background-size: 300% auto;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                animation: gradientShift 4s ease infinite;
                margin-bottom: 16px;
                min-height: 1.2em;
            }
            
            .cat-hero h1::after {
                content: '|';
                color: #a855f7;
                animation: blink 1s infinite;
                margin-left: 5px;
            }
            
            @keyframes blink {
                0%, 100% { opacity: 1; }
                50% { opacity: 0; }
            }
            
            .cat-hero p {
                font-family: 'Rajdhani', sans-serif;
                font-size: 1.1rem;
                color: #94a3b8;
                letter-spacing: 0.08em;
                animation: fadeIn 1s ease-out 0.5s both;
            }

            /* Buscador futurista */
            .search-wrap {
                animation: fadeInUp 0.8s ease-out 0.2s both;
                position: relative;
            }
            
            .search-wrap::before {
                content: '';
                position: absolute;
                inset: -2px;
                background: linear-gradient(45deg, #8a2be2, #a855f7, #8a2be2);
                border-radius: 16px;
                opacity: 0;
                transition: opacity 0.3s;
                z-index: -1;
                filter: blur(8px);
            }
            
            .search-wrap:focus-within::before {
                opacity: 0.6;
                animation: pulseGlow 2s infinite;
            }
            
            .search-wrap .input-group {
                background: rgba(15, 5, 30, 0.9);
                border-radius: 14px;
                overflow: hidden;
                border: 1px solid rgba(138, 43, 226, 0.3);
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
                transition: all 0.3s ease;
            }
            
            .search-wrap .input-group:focus-within {
                transform: translateY(-2px);
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4), 0 0 40px rgba(138, 43, 226, 0.2);
            }
            
            .search-wrap .form-control {
                background: transparent;
                border: none;
                color: #f8fafc;
                font-family: 'Rajdhani', sans-serif;
                font-size: 1rem;
                padding: 16px 24px;
            }
            
            .search-wrap .form-control:focus {
                background: rgba(138, 43, 226, 0.05);
                box-shadow: none;
            }
            
            .search-wrap .input-group-text {
                background: transparent;
                border: none;
                color: #8a2be2;
                padding: 0 20px;
                font-size: 1.2rem;
            }
            
            .search-wrap .btn-search {
                background: linear-gradient(135deg, #8a2be2, #4b0082);
                border: none;
                color: #fff;
                font-family: 'Orbitron', sans-serif;
                font-weight: 700;
                font-size: 0.9rem;
                letter-spacing: 1px;
                text-transform: uppercase;
                padding: 16px 40px;
                position: relative;
                overflow: hidden;
                transition: all 0.3s;
            }
            
            .search-wrap .btn-search:hover {
                box-shadow: 0 0 30px rgba(138, 43, 226, 0.6);
                letter-spacing: 2px;
            }

            /* Info resultados */
            .results-info {
                font-family: 'Rajdhani', sans-serif;
                font-size: 0.85rem;
                color: #64748b;
                letter-spacing: 0.08em;
                text-transform: uppercase;
                animation: fadeIn 0.6s ease-out 0.4s both;
            }
            .results-info strong { color: #f8fafc; font-weight: 600; }
            .results-info a { color: #8a2be2; text-decoration: none; transition: all 0.3s; }
            .results-info a:hover { color: #c084fc; }

            /* Tarjetas 3D holográficas */
            .libro-card {
                background: rgba(15, 5, 30, 0.6);
                border: 1px solid rgba(138, 43, 226, 0.15);
                border-radius: 20px;
                height: 100%;
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                overflow: hidden;
                display: flex;
                flex-direction: column;
                backdrop-filter: blur(10px);
                transform-style: preserve-3d;
                perspective: 1000px;
                position: relative;
                animation: fadeInUp 0.6s ease-out both;
                will-change: transform;
            }
            
            .row.g-4 > div:nth-child(1) .libro-card { animation-delay: 0.1s; }
            .row.g-4 > div:nth-child(2) .libro-card { animation-delay: 0.2s; }
            .row.g-4 > div:nth-child(3) .libro-card { animation-delay: 0.3s; }
            .row.g-4 > div:nth-child(4) .libro-card { animation-delay: 0.4s; }
            .row.g-4 > div:nth-child(5) .libro-card { animation-delay: 0.5s; }
            .row.g-4 > div:nth-child(6) .libro-card { animation-delay: 0.6s; }
            .row.g-4 > div:nth-child(7) .libro-card { animation-delay: 0.7s; }
            .row.g-4 > div:nth-child(8) .libro-card { animation-delay: 0.8s; }
            
            .libro-card::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(135deg, rgba(138, 43, 226, 0.1), transparent);
                opacity: 0;
                transition: opacity 0.3s;
                pointer-events: none;
            }
            
            .libro-card:hover::before {
                opacity: 1;
            }
            
            .libro-card::after {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: linear-gradient(
                    45deg,
                    transparent 30%,
                    rgba(255, 255, 255, 0.05) 50%,
                    transparent 70%
                );
                transform: rotate(45deg) translateY(-100%);
                transition: transform 0.6s;
                pointer-events: none;
            }
            
            .libro-card:hover::after {
                transform: rotate(45deg) translateY(100%);
            }
            
            .libro-card:hover {
                transform: translateY(-12px) rotateX(5deg) scale(1.02);
                border-color: rgba(138, 43, 226, 0.4);
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4), 0 0 60px rgba(138, 43, 226, 0.2);
            }
            
            .libro-card-top {
                padding: 20px 20px 0;
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
            }
            
            .libro-card-body { padding: 16px 20px; flex: 1; }
            
            .libro-titulo {
                font-family: 'Orbitron', sans-serif;
                font-size: 0.9rem;
                font-weight: 700;
                color: #f1f5f9;
                margin-bottom: 14px;
                line-height: 1.4;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                transition: color 0.3s;
            }
            
            .libro-card:hover .libro-titulo {
                color: #c084fc;
            }
            
            .libro-meta {
                font-family: 'Rajdhani', sans-serif;
                font-size: 0.85rem;
                color: #94a3b8;
                display: flex;
                align-items: center;
                gap: 8px;
                margin-bottom: 8px;
                transition: all 0.3s;
            }
            
            .libro-card:hover .libro-meta {
                transform: translateX(5px);
                color: #cbd5e1;
            }
            
            .libro-meta i { color: #8a2be2; font-size: 0.85rem; }
            
            .libro-card-footer {
                padding: 16px 20px 20px;
                border-top: 1px solid rgba(138, 43, 226, 0.1);
            }

            /* Botón holográfico */
            .btn-solicitar {
                width: 100%;
                background: transparent;
                border: 1px solid rgba(138, 43, 226, 0.4);
                color: #f8fafc;
                font-family: 'Rajdhani', sans-serif;
                font-weight: 600;
                font-size: 0.85rem;
                letter-spacing: 0.08em;
                text-transform: uppercase;
                border-radius: 12px;
                padding: 12px;
                transition: all 0.3s ease;
                text-decoration: none;
                display: block;
                text-align: center;
                position: relative;
                overflow: hidden;
            }
            
            .btn-solicitar::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
                transition: left 0.5s;
            }
            
            .btn-solicitar:hover::before {
                left: 100%;
            }
            
            .btn-solicitar:hover {
                background: rgba(138, 43, 226, 0.15);
                border-color: #8a2be2;
                color: #c084fc;
                box-shadow: 0 0 30px rgba(138, 43, 226, 0.3);
                transform: translateY(-2px);
            }
            
            .btn-solicitar.disabled {
                opacity: 0.4;
                pointer-events: none;
            }

            /* Badges */
            .badge-disponible {
                background: linear-gradient(135deg, rgba(138, 43, 226, 0.3), rgba(75, 0, 130, 0.2));
                border: 1px solid rgba(138, 43, 226, 0.4);
                color: #c084fc;
                font-family: 'Orbitron', sans-serif;
                font-size: 0.7rem;
                font-weight: 700;
                letter-spacing: 1px;
                text-transform: uppercase;
                padding: 6px 12px;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(138, 43, 226, 0.2);
                animation: pulseGlow 2s ease-in-out infinite;
                position: relative;
                overflow: hidden;
            }
            
            .badge-disponible::after {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
                animation: shimmer 2s infinite;
            }
            
            .badge-nodisponible {
                background: rgba(190, 24, 93, 0.2);
                border: 1px solid rgba(190, 24, 93, 0.35);
                color: #fb7185;
                font-family: 'Orbitron', sans-serif;
                font-size: 0.7rem;
                font-weight: 700;
                letter-spacing: 1px;
                text-transform: uppercase;
                padding: 6px 12px;
                border-radius: 8px;
            }

            /* Paginación */
            .cat-pagination { animation: fadeInUp 0.6s ease-out 0.6s both; }
            
            .cat-pagination .page-link {
                background: rgba(15, 5, 30, 0.6);
                border: 1px solid rgba(138, 43, 226, 0.2);
                color: #94a3b8;
                font-family: 'Rajdhani', sans-serif;
                font-weight: 600;
                font-size: 0.9rem;
                border-radius: 10px !important;
                margin: 0 4px;
                width: 42px;
                height: 42px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            }
            
            .cat-pagination .page-link:hover {
                border-color: #8a2be2;
                color: #c084fc;
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(138, 43, 226, 0.3);
            }
            
            .cat-pagination .page-item.active .page-link {
                background: linear-gradient(135deg, #8a2be2, #4b0082);
                border-color: #8a2be2;
                color: #fff;
                box-shadow: 0 0 30px rgba(138, 43, 226, 0.5);
                transform: translateY(-3px);
            }

            /* Footer */
            .cat-footer {
                border-top: 1px solid rgba(138, 43, 226, 0.15);
                padding: 30px 0;
                margin-top: 80px;
                text-align: center;
                font-family: 'Rajdhani', sans-serif;
                font-size: 0.8rem;
                color: #64748b;
                letter-spacing: 0.1em;
                text-transform: uppercase;
            }
            
            .cat-footer i { color: #8a2be2; animation: pulseGlow 2s infinite; }

            /* Empty state */
            .empty-state {
                text-align: center;
                padding: 100px 0;
                color: #94a3b8;
                animation: fadeInUp 0.6s ease-out;
            }
            
            .empty-state i {
                font-size: 4rem;
                color: rgba(138, 43, 226, 0.3);
                margin-bottom: 20px;
                animation: float 3s ease-in-out infinite;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .cat-hero { padding: 60px 0 40px; }
            }
        </style>
    </head>
    <body>

        <div class="galaxy-content">
            <!-- Navegación -->
            <jsp:include page="/views/includes/nav_universal.jsp"/>

            <div class="container">
                <!-- Hero -->
                <div class="cat-hero">
                    <h1 id="typewriter-text">
                        <i class="bi bi-collection-fill me-2" style="color: #8a2be2;"></i>
                        Catálogo de Libros
                    </h1>
                    <p>Explora nuestra colección galáctica — inicia sesión para solicitar préstamos</p>
                </div>

                <!-- Buscador -->
                <div class="row justify-content-center mb-5">
                    <div class="col-md-8 col-lg-6 search-wrap">
                        <form method="get" action="catalogo">
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-search"></i></span>
                                <input type="text" name="buscar" class="form-control"
                                       placeholder="Buscar por título, autor o categoría..."
                                       value="${not empty buscar ? buscar : ''}">
                                <button class="btn-search" type="submit">Buscar</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Resultados -->
                <div class="d-flex justify-content-between align-items-center mb-4 px-1">
                    <span class="results-info">
                        <c:choose>
                            <c:when test="${not empty buscar}">
                                ${totalLibros} resultado(s) para "<strong>${buscar}</strong>"
                                — <a href="catalogo">Limpiar</a>
                            </c:when>
                            <c:otherwise>${totalLibros} libro(s) disponibles</c:otherwise>
                        </c:choose>
                    </span>
                    <span class="results-info">Página ${paginaActual} de ${totalPaginas}</span>
                </div>

                <!-- Grid de Libros -->
                <div class="row g-4 mb-5">
                    <c:choose>
                        <c:when test="${empty libros}">
                            <div class="col-12 empty-state">
                                <i class="bi bi-search d-block"></i>
                                <p>No se encontraron libros
                                    <c:if test="${not empty buscar}">para "<strong>${buscar}</strong>"</c:if>
                                </p>
                                <c:if test="${not empty buscar}">
                                    <a href="catalogo" class="btn-solicitar d-inline-block mt-3" style="width: auto; padding: 12px 32px;">
                                        <i class="bi bi-arrow-left me-2"></i>Ver todos
                                    </a>
                                </c:if>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="libro" items="${libros}">
                                <div class="col-sm-6 col-lg-4 col-xl-3">
                                    <div class="libro-card" data-tilt>
                                        <div class="libro-card-top">
                                            <c:choose>
                                                <c:when test="${libro.disponible}">
                                                    <span class="badge-disponible">Disponible</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge-nodisponible">No disponible</span>
                                                </c:otherwise>
                                            </c:choose>
                                            <small style="color: #64748b; font-size: 0.75rem; font-family: 'Rajdhani', sans-serif;">
                                                <i class="bi bi-calendar3 me-1"></i>
                                                ${libro.anioPublicacion > 0 ? libro.anioPublicacion : '—'}
                                            </small>
                                        </div>

                                        <div class="libro-card-body">
                                            <div class="libro-titulo">${libro.titulo}</div>
                                            <div class="libro-meta">
                                                <i class="bi bi-person-fill"></i>
                                                <c:choose>
                                                    <c:when test="${not empty libro.autor and not empty libro.autor.nombreCompleto}">
                                                        ${libro.autor.nombreCompleto}
                                                    </c:when>
                                                    <c:otherwise>Sin autor</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="libro-meta">
                                                <i class="bi bi-tag-fill"></i>
                                                <c:choose>
                                                    <c:when test="${not empty libro.categoria and not empty libro.categoria.nombre}">
                                                        ${libro.categoria.nombre}
                                                    </c:when>
                                                    <c:otherwise>Sin categoría</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="libro-meta">
                                                <i class="bi bi-building"></i>
                                                <c:choose>
                                                    <c:when test="${not empty libro.editorial and not empty libro.editorial.nombre}">
                                                        ${libro.editorial.nombre}
                                                    </c:when>
                                                    <c:otherwise>Sin editorial</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <div class="libro-card-footer">
                                            <c:choose>
                                                <c:when test="${libro.disponible}">
                                                    <c:choose>
                                                        <c:when test="${not empty sessionScope.usuario}">
                                                            <button type="button" class="btn-solicitar btn-prestamo"
                                                                    data-id="${libro.idLibro}"
                                                                    data-titulo="${fn:escapeXml(libro.titulo)}"
                                                                    data-autor="${fn:escapeXml(libro.autor.nombreCompleto)}">
                                                                <i class="bi bi-check-circle me-2"></i>Solicitar préstamo
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/login?redirect=catalogo" class="btn-solicitar">
                                                                <i class="bi bi-box-arrow-in-right me-2"></i>Iniciar sesión
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="btn-solicitar disabled">
                                                        <i class="bi bi-x-circle me-2"></i>No disponible
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Paginación -->
                <c:if test="${totalPaginas > 1}">
                    <nav class="d-flex justify-content-center mb-5">
                        <ul class="pagination cat-pagination">
                            <li class="page-item ${paginaActual == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="catalogo?pagina=${paginaActual - 1}${not empty buscar ? '&buscar='.concat(buscar) : ''}">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </li>
                            <c:forEach begin="1" end="${totalPaginas}" var="i">
                                <li class="page-item ${i == paginaActual ? 'active' : ''}">
                                    <a class="page-link" href="catalogo?pagina=${i}${not empty buscar ? '&buscar='.concat(buscar) : ''}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${paginaActual == totalPaginas ? 'disabled' : ''}">
                                <a class="page-link" href="catalogo?pagina=${paginaActual + 1}${not empty buscar ? '&buscar='.concat(buscar) : ''}">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>

            <!-- Footer -->
            <div class="cat-footer">
                <i class="bi bi-stars me-2"></i>
                2026 Biblioteca SENA — Sistema de Gestión Galáctico
            </div>
        </div>

        <!-- Modal -->
        <c:if test="${not empty sessionScope.usuario}">
            <div class="modal fade" id="modalPrestamoCatalogo" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content" style="background: rgba(15, 5, 26, 0.98); border: 1px solid rgba(138, 43, 226, 0.4); border-radius: 20px; box-shadow: 0 0 80px rgba(138, 43, 226, 0.4);">
                        <div class="modal-header" style="border-bottom: 1px solid rgba(138, 43, 226, 0.2); padding: 24px;">
                            <h5 class="modal-title" style="font-family: 'Orbitron', sans-serif; color: #c084fc; font-size: 1.2rem;">
                                <i class="bi bi-bookmark-plus me-2"></i>Solicitar Préstamo
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form id="formPrestamoCatalogo" action="${pageContext.request.contextPath}/catalogo" method="POST">
                            <div class="modal-body">
                                <input type="hidden" name="idLibro" id="modalIdLibro">
                                <input type="hidden" name="buscar" value="${buscar}">
                                <input type="hidden" name="pagina" value="${paginaActual}">

                                <div style="background: rgba(138, 43, 226, 0.1); border: 1px solid rgba(138, 43, 226, 0.2); border-radius: 12px; padding: 20px; margin-bottom: 24px;">
                                    <div style="font-family: 'Orbitron', sans-serif; color: #f8fafc; font-size: 1rem; margin-bottom: 8px;" id="modalTituloLibro">Título del libro</div>
                                    <div style="color: #94a3b8; font-size: 0.9rem;" id="modalAutorLibro">Autor</div>
                                </div>

                                <div class="mb-3">
                                    <label for="fechaDevolucion" style="font-family: 'Rajdhani', sans-serif; color: #94a3b8; font-size: 0.9rem; display: block; margin-bottom: 8px;">
                                        <i class="bi bi-calendar-event me-2"></i>Fecha de devolución esperada:
                                    </label>
                                    <input type="date" class="form-control" id="fechaDevolucion" 
                                           name="fechaDevolucionEsperada"
                                           style="background: rgba(15,5,26,0.9); border: 1px solid rgba(138,43,226,0.3);
                                           color: #f8fafc; padding: 12px; border-radius: 10px;" required>
                                    <div style="color: #64748b; font-size: 0.8rem; margin-top: 8px;">
                                        <i class="bi bi-info-circle me-1"></i>
                                        Debe ser posterior a hoy. Máximo 15 días de préstamo.
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer" style="border-top: 1px solid rgba(138, 43, 226, 0.2); padding: 20px 24px;">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" 
                                        style="background: transparent; border: 1px solid rgba(138,43,226,0.3);
                                        color: #94a3b8; font-family: 'Rajdhani', sans-serif; padding: 10px 20px; border-radius: 10px;">
                                    Cancelar
                                </button>
                                <button type="submit" class="btn btn-primary" 
                                        style="background: linear-gradient(135deg, #8a2be2, #4b0082); border: none;
                                        font-family: 'Rajdhani', sans-serif; font-weight: 700; padding: 10px 24px; border-radius: 10px; color: #fff;">
                                    <i class="bi bi-check-circle me-2"></i>Confirmar Préstamo
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:if>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="${pageContext.request.contextPath}/js/galaxy-effects.js"></script>

        <!-- Scripts optimizados -->
        <script>
            // Efecto 3D Tilt en tarjetas (ligero)
            document.querySelectorAll('[data-tilt]').forEach(card => {
                card.addEventListener('mousemove', (e) => {
                    const rect = card.getBoundingClientRect();
                    const x = e.clientX - rect.left;
                    const y = e.clientY - rect.top;
                    const centerX = rect.width / 2;
                    const centerY = rect.height / 2;
                    const rotateX = (y - centerY) / 20;
                    const rotateY = (centerX - x) / 20;
                    card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateY(-12px) scale(1.02)`;
                });
                
                card.addEventListener('mouseleave', () => {
                    card.style.transform = 'perspective(1000px) rotateX(0) rotateY(0) translateY(0) scale(1)';
                });
            });

            // Efecto de escritura optimizado
            const titleElement = document.getElementById('typewriter-text');
            const originalText = titleElement.innerHTML;
            titleElement.innerHTML = '';
            let charIndex = 0;
            
            function typeWriter() {
                if (charIndex < originalText.length) {
                    titleElement.innerHTML = originalText.substring(0, charIndex + 1) + '<span style="color:#a855f7;">|</span>';
                    charIndex++;
                    setTimeout(typeWriter, 40);
                } else {
                    titleElement.innerHTML = originalText + '<span style="color:#a855f7;animation:blink 1s infinite;">|</span>';
                }
            }
            
            setTimeout(typeWriter, 300);

            // Ripple effect en botones
            document.querySelectorAll('.btn-solicitar, .btn-search, .page-link').forEach(btn => {
                btn.addEventListener('click', function(e) {
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;
                    
                    ripple.style.cssText = `
                        position: absolute;
                        width: ${size}px;
                        height: ${size}px;
                        left: ${x}px;
                        top: ${y}px;
                        background: radial-gradient(circle, rgba(138,43,226,0.4) 0%, transparent 70%);
                        border-radius: 50%;
                        transform: scale(0);
                        animation: rippleEffect 0.6s ease-out;
                        pointer-events: none;
                    `;
                    
                    this.style.position = 'relative';
                    this.style.overflow = 'hidden';
                    this.appendChild(ripple);
                    setTimeout(() => ripple.remove(), 600);
                });
            });

            // Keyframe para ripple
            const style = document.createElement('style');
            style.textContent = `
                @keyframes rippleEffect {
                    to { transform: scale(2); opacity: 0; }
                }
                @keyframes blink {
                    0%, 100% { opacity: 1; }
                    50% { opacity: 0; }
                }
            `;
            document.head.appendChild(style);
        </script>

        <!-- Scripts condicionales -->
        <c:if test="${not empty sessionScope.usuario}">
            <script>
                function abrirModalPrestamo(idLibro, titulo, autor) {
                    document.getElementById('modalIdLibro').value = idLibro;
                    document.getElementById('modalTituloLibro').textContent = titulo || 'Título no disponible';
                    document.getElementById('modalAutorLibro').textContent = autor || 'Sin autor';

                    const manana = new Date();
                    manana.setDate(manana.getDate() + 1);
                    const minFecha = manana.toISOString().split('T')[0];
                    const maxDate = new Date();
                    maxDate.setDate(maxDate.getDate() + 15);

                    const inputFecha = document.getElementById('fechaDevolucion');
                    inputFecha.min = minFecha;
                    inputFecha.max = maxDate.toISOString().split('T')[0];
                    inputFecha.value = minFecha;

                    new bootstrap.Modal(document.getElementById('modalPrestamoCatalogo')).show();
                }

                document.addEventListener('DOMContentLoaded', function () {
                    document.querySelectorAll('.btn-prestamo').forEach(function (btn) {
                        btn.addEventListener('click', function () {
                            abrirModalPrestamo(
                                this.getAttribute('data-id'),
                                this.getAttribute('data-titulo'),
                                this.getAttribute('data-autor')
                            );
                        });
                    });

                    document.getElementById('formPrestamoCatalogo').addEventListener('submit', function (e) {
                        const fecha = new Date(document.getElementById('fechaDevolucion').value);
                        const hoy = new Date();
                        hoy.setHours(0, 0, 0, 0);
                        if (fecha <= hoy) {
                            e.preventDefault();
                            Swal.fire({
                                customClass: {popup: 'swal-biblioteca'},
                                icon: 'warning',
                                title: 'Fecha inválida',
                                text: 'La fecha de devolución debe ser posterior a hoy.',
                                confirmButtonText: 'Entendido',
                                background: 'rgba(15, 5, 26, 0.98)',
                                backdrop: 'rgba(0, 0, 0, 0.8)'
                            });
                        }
                    });
                });
            </script>
        </c:if>

        <c:if test="${not empty sessionScope.prestamoResultado}">
            <c:set var="swalResultado" value="${sessionScope.prestamoResultado}" scope="page"/>
            <c:remove var="prestamoResultado" scope="session"/>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                <c:choose>
                    <c:when test="${fn:startsWith(swalResultado, 'success')}">
                    Swal.fire({
                        customClass: {
                            popup: 'swal-biblioteca',
                            title: 'swal2-title',
                            htmlContainer: 'swal2-html-container',
                            confirmButton: 'swal2-confirm'
                        },
                        icon: 'success',
                        title: '¡Préstamo Exitoso!',
                        html: '<div style="text-align: center;">' +
                                '<i class="bi bi-check-circle-fill" style="font-size: 3rem; color: #c084fc; margin-bottom: 16px; display: block;"></i>' +
                                '<p style="color: #c084fc; font-size: 1.1rem; margin-bottom: 8px;">${fn:escapeXml(fn:substringAfter(swalResultado, "success|"))}</p>' +
                                '<span style="color: #94a3b8; font-size: 0.9rem;">Recuerda devolver el libro en la fecha acordada.</span></div>',
                        showConfirmButton: true,
                        confirmButtonText: '¡Perfecto!',
                        background: 'rgba(15, 5, 26, 0.98)',
                        backdrop: 'rgba(0, 0, 0, 0.8)',
                        timer: 5000,
                        timerProgressBar: true
                    });
                    </c:when>
                    <c:otherwise>
                    Swal.fire({
                        customClass: {
                            popup: 'swal-biblioteca',
                            title: 'swal2-title',
                            htmlContainer: 'swal2-html-container',
                            confirmButton: 'swal2-confirm'
                        },
                        icon: 'error',
                        title: 'Error al registrar',
                        text: '${fn:escapeXml(fn:substringAfter(swalResultado, "error|"))}',
                        background: 'rgba(15, 5, 26, 0.98)',
                        backdrop: 'rgba(0, 0, 0, 0.8)'
                    });
                    </c:otherwise>
                </c:choose>
                });
            </script>
        </c:if>

        <jsp:include page="includes/chatbot.jsp"/>
    </body>
</html>