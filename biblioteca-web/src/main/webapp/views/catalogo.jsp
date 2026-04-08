<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Catálogo — Biblioteca SENA</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background-color: var(--bg-void);
            background-image:
                radial-gradient(ellipse 80% 50% at 20% 10%, rgba(138,43,226,0.1) 0%, transparent 60%),
                radial-gradient(ellipse 60% 40% at 80% 90%, rgba(75,0,130,0.08) 0%, transparent 55%);
            min-height: 100vh;
        }

        .cat-nav {
            background: rgba(5,1,10,0.92);
            backdrop-filter: blur(14px);
            border-bottom: 1px solid rgba(138,43,226,0.2);
            padding: 14px 0;
            position: sticky;
            top: 0;
            z-index: 200;
        }
        .cat-nav .brand {
            font-family: 'Orbitron', sans-serif;
            font-size: 1rem;
            font-weight: 800;
            background: linear-gradient(90deg, #c084fc, #818cf8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-decoration: none;
        }

        .cat-hero { text-align: center; padding: 60px 0 40px; }
        .cat-hero h1 {
            font-family: 'Orbitron', sans-serif;
            font-size: clamp(1.6rem, 4vw, 2.4rem);
            font-weight: 800;
            background: linear-gradient(90deg, #c084fc, #818cf8, #38bdf8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 12px;
        }
        .cat-hero p { color: var(--text-muted); font-size: 1rem; letter-spacing: 0.05em; }

        .search-wrap .form-control {
            background: rgba(15,5,26,0.9) !important;
            border: 1px solid rgba(138,43,226,0.3) !important;
            border-right: none !important;
            color: var(--text-primary) !important;
            border-radius: 12px 0 0 12px !important;
            font-family: 'Rajdhani', sans-serif;
            font-size: 0.95rem;
            padding: 12px 16px;
        }
        .search-wrap .form-control:focus {
            border-color: var(--accent-primary) !important;
            box-shadow: 0 0 0 3px rgba(138,43,226,0.15) !important;
        }
        .search-wrap .form-control::placeholder { color: var(--text-muted) !important; }
        .search-wrap .input-group-text {
            background: rgba(15,5,26,0.9) !important;
            border: 1px solid rgba(138,43,226,0.3) !important;
            border-right: none !important;
            color: var(--text-muted);
            border-radius: 12px 0 0 12px !important;
            padding: 12px 14px;
        }
        .search-wrap .btn-search {
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-deep)) !important;
            border: none !important;
            color: #fff;
            font-family: 'Rajdhani', sans-serif;
            font-weight: 600;
            letter-spacing: 0.06em;
            border-radius: 0 12px 12px 0 !important;
            padding: 12px 24px;
            cursor: pointer;
        }

        .results-info {
            font-size: 0.8rem;
            color: var(--text-muted);
            letter-spacing: 0.06em;
            text-transform: uppercase;
        }

        .libro-card {
            background: var(--bg-card);
            border: 1px solid rgba(138,43,226,0.15);
            border-radius: 16px;
            height: 100%;
            transition: all 0.3s cubic-bezier(0.4,0,0.2,1);
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        .libro-card:hover {
            border-color: rgba(138,43,226,0.45);
            box-shadow: 0 0 24px rgba(138,43,226,0.2);
            transform: translateY(-4px);
        }
        .libro-card-top {
            padding: 18px 18px 0;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }
        .libro-card-body { padding: 12px 18px 16px; flex: 1; }
        .libro-titulo {
            font-family: 'Orbitron', sans-serif;
            font-size: 0.82rem;
            font-weight: 700;
            color: var(--text-heading);
            margin-bottom: 12px;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .libro-meta {
            font-family: 'Rajdhani', sans-serif;
            font-size: 0.82rem;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 6px;
        }
        .libro-meta i { color: var(--accent-primary); font-size: 0.78rem; }
        .libro-card-footer {
            padding: 12px 18px 18px;
            border-top: 1px solid rgba(138,43,226,0.1);
        }

        .btn-solicitar {
            width: 100%;
            background: transparent;
            border: 1px solid rgba(138,43,226,0.4);
            color: var(--text-primary);
            font-family: 'Rajdhani', sans-serif;
            font-weight: 600;
            font-size: 0.8rem;
            letter-spacing: 0.07em;
            text-transform: uppercase;
            border-radius: 10px;
            padding: 9px;
            transition: all 0.3s;
            text-decoration: none;
            display: block;
            text-align: center;
            cursor: pointer;
        }
        .btn-solicitar:hover {
            background: rgba(138,43,226,0.15);
            border-color: var(--accent-primary);
            color: #c084fc;
            box-shadow: 0 0 12px rgba(138,43,226,0.25);
        }
        .btn-solicitar.disabled { opacity: 0.4; pointer-events: none; }

        .badge-disponible {
            background: linear-gradient(135deg,rgba(138,43,226,0.3),rgba(75,0,130,0.2));
            border: 1px solid rgba(138,43,226,0.4);
            color: #c084fc;
            font-family: 'Rajdhani', sans-serif;
            font-size: 0.7rem;
            letter-spacing: 0.08em;
            padding: 4px 10px;
            border-radius: 6px;
        }
        .badge-nodisponible {
            background: rgba(190,24,93,0.2);
            border: 1px solid rgba(190,24,93,0.35);
            color: #fb7185;
            font-family: 'Rajdhani', sans-serif;
            font-size: 0.7rem;
            letter-spacing: 0.08em;
            padding: 4px 10px;
            border-radius: 6px;
        }

        .cat-pagination .page-link {
            background: var(--bg-card) !important;
            border: 1px solid rgba(138,43,226,0.2) !important;
            color: var(--text-muted) !important;
            font-family: 'Rajdhani', sans-serif;
            font-weight: 600;
            transition: all 0.25s;
            margin: 0 2px;
            border-radius: 8px !important;
        }
        .cat-pagination .page-link:hover {
            background: rgba(138,43,226,0.15) !important;
            border-color: var(--accent-primary) !important;
            color: #c084fc !important;
        }
        .cat-pagination .page-item.active .page-link {
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-deep)) !important;
            border-color: var(--accent-primary) !important;
            color: #fff !important;
            box-shadow: 0 0 12px rgba(138,43,226,0.4);
        }
        .cat-pagination .page-item.disabled .page-link { opacity: 0.3; }

        .cat-footer {
            border-top: 1px solid rgba(138,43,226,0.15);
            padding: 24px 0;
            margin-top: 60px;
            text-align: center;
            font-size: 0.78rem;
            color: var(--text-muted);
            letter-spacing: 0.06em;
        }

        .empty-state { text-align: center; padding: 80px 0; color: var(--text-muted); }
        .empty-state i { font-size: 3.5rem; color: rgba(138,43,226,0.3); margin-bottom: 16px; }
        .empty-state p { font-family: 'Rajdhani', sans-serif; font-size: 1rem; }

        /* ── Modal préstamo ── */
        .modal-prestamo .modal-content {
            background: rgba(15,5,26,0.98);
            border: 1px solid rgba(138,43,226,0.4);
            border-radius: 16px;
            box-shadow: 0 0 40px rgba(138,43,226,0.3);
        }
        .modal-prestamo .modal-header { border-bottom: 1px solid rgba(138,43,226,0.2); padding: 20px 24px; }
        .modal-prestamo .modal-title { font-family: 'Orbitron', sans-serif; color: #c084fc; font-size: 1.1rem; }
        .modal-prestamo .modal-body  { padding: 24px; color: var(--text-primary); }
        .modal-prestamo .modal-footer{ border-top: 1px solid rgba(138,43,226,0.2); padding: 16px 24px; }

        .info-libro-modal {
            background: rgba(138,43,226,0.1);
            border: 1px solid rgba(138,43,226,0.2);
            border-radius: 10px;
            padding: 16px;
            margin-bottom: 20px;
        }
        .info-libro-modal .titulo {
            font-family: 'Orbitron', sans-serif;
            color: #f8fafc;
            font-size: 0.95rem;
            margin-bottom: 8px;
        }
        .info-libro-modal .autor { color: var(--text-muted); font-size: 0.85rem; }

        /* ── SweetAlert2 tema biblioteca ── */
        .swal-biblioteca.swal2-popup {
            background: rgba(15,5,26,0.98) !important;
            border: 1px solid rgba(138,43,226,0.4) !important;
            border-radius: 16px !important;
            font-family: 'Rajdhani', sans-serif !important;
            color: #e2e8f0 !important;
        }
        .swal-biblioteca .swal2-title {
            color: #f8fafc !important;
            font-family: 'Orbitron', sans-serif !important;
            font-size: 1.3rem !important;
        }
        .swal-biblioteca .swal2-html-container { color: #94a3b8 !important; }
        .swal-biblioteca .swal2-confirm {
            background: linear-gradient(135deg, #8a2be2, #4b0082) !important;
            border: none !important;
            font-family: 'Rajdhani', sans-serif !important;
            font-weight: 700 !important;
            letter-spacing: 0.06em !important;
            border-radius: 10px !important;
            padding: 10px 28px !important;
        }
        .swal-biblioteca .swal2-timer-progress-bar {
            background: linear-gradient(90deg, #c084fc, #818cf8) !important;
        }
        .swal-biblioteca .swal2-icon.swal2-success .swal2-success-ring { border-color: rgba(138,43,226,0.3) !important; }
        .swal-biblioteca .swal2-icon.swal2-success [class^='swal2-success-line'] { background: #c084fc !important; }
    </style>
</head>
<body>

    <%-- ══ NAVBAR CONDICIONAL ══ --%>
    <c:choose>
        <c:when test="${not empty sessionScope.usuario}">
            <jsp:include page="/views/includes/nav_universal.jsp"/>
        </c:when>
        <c:otherwise>
            <nav class="cat-nav">
                <div class="container d-flex justify-content-between align-items-center">
                    <a href="catalogo" class="brand">
                        <i class="bi bi-hexagon-fill me-2"
                           style="-webkit-text-fill-color:var(--accent-primary);"></i>
                        Biblioteca SENA
                    </a>
                    <a href="${pageContext.request.contextPath}/login"
                       class="btn btn-success btn-sm">
                        <i class="bi bi-shield-lock-fill me-1"></i>Iniciar Sesión
                    </a>
                </div>
            </nav>
        </c:otherwise>
    </c:choose>

    <div class="container">

        <%-- Hero --%>
        <div class="cat-hero">
            <h1>
                <i class="bi bi-collection-fill me-2"
                   style="-webkit-text-fill-color:var(--accent-primary);font-size:0.9em;"></i>
                Catálogo de Libros
            </h1>
            <p>Explora nuestra colección — inicia sesión para solicitar préstamos</p>
        </div>

        <%-- Buscador --%>
        <div class="row justify-content-center mb-4">
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

        <%-- Info resultados --%>
        <div class="d-flex justify-content-between align-items-center mb-4 px-1">
            <span class="results-info">
                <c:choose>
                    <c:when test="${not empty buscar}">
                        ${totalLibros} resultado(s) para
                        "<strong style="color:var(--text-primary)">${buscar}</strong>"
                        &nbsp;—&nbsp;
                        <a href="catalogo" style="color:var(--accent-primary);font-size:0.78rem;">Limpiar</a>
                    </c:when>
                    <c:otherwise>${totalLibros} libro(s) en el catálogo</c:otherwise>
                </c:choose>
            </span>
            <span class="results-info">Página ${paginaActual} de ${totalPaginas}</span>
        </div>

        <%-- Grid de libros --%>
        <div class="row g-4 mb-5">
            <c:choose>
                <c:when test="${empty libros}">
                    <div class="col-12 empty-state">
                        <i class="bi bi-search d-block"></i>
                        <p>No se encontraron libros
                            <c:if test="${not empty buscar}">para "<strong>${buscar}</strong>"</c:if>
                        </p>
                        <c:if test="${not empty buscar}">
                            <a href="catalogo" class="btn-solicitar d-inline-block mt-2"
                               style="width:auto;padding:9px 24px;">Ver todos los libros</a>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="libro" items="${libros}">
                        <div class="col-sm-6 col-lg-4 col-xl-3">
                            <div class="libro-card">
                                <div class="libro-card-top">
                                    <c:choose>
                                        <c:when test="${libro.disponible}">
                                            <span class="badge-disponible">Disponible</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-nodisponible">No disponible</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <small style="color:var(--text-muted);font-size:0.72rem;">
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
                                                    <%-- CORREGIDO: Usar data attributes en lugar de onclick con fn:replace --%>
                                                    <button type="button" class="btn-solicitar btn-prestamo"
                                                            data-id="${libro.idLibro}"
                                                            data-titulo="${fn:escapeXml(libro.titulo)}"
                                                            data-autor="${fn:escapeXml(libro.autor.nombreCompleto)}">
                                                        <i class="bi bi-check-circle me-1"></i>Solicitar préstamo
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/login?redirect=catalogo"
                                                       class="btn-solicitar">
                                                        <i class="bi bi-box-arrow-in-right me-1"></i>
                                                        Iniciar sesión para solicitar
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="btn-solicitar disabled">
                                                <i class="bi bi-x-circle me-1"></i>No disponible
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

        <%-- Paginación --%>
        <c:if test="${totalPaginas > 1}">
            <nav class="d-flex justify-content-center mb-5">
                <ul class="pagination cat-pagination">
                    <li class="page-item ${paginaActual == 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="catalogo?pagina=${paginaActual - 1}${not empty buscar ? '&buscar='.concat(buscar) : ''}">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>
                    <c:forEach begin="1" end="${totalPaginas}" var="i">
                        <li class="page-item ${i == paginaActual ? 'active' : ''}">
                            <a class="page-link"
                               href="catalogo?pagina=${i}${not empty buscar ? '&buscar='.concat(buscar) : ''}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${paginaActual == totalPaginas ? 'disabled' : ''}">
                        <a class="page-link"
                           href="catalogo?pagina=${paginaActual + 1}${not empty buscar ? '&buscar='.concat(buscar) : ''}">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>

    <div class="cat-footer">2026 Biblioteca SENA — Sistema de Gestión</div>

    <%-- ══ MODAL DE PRÉSTAMO (solo para usuarios logueados) ══ --%>
    <c:if test="${not empty sessionScope.usuario}">
        <div class="modal fade modal-prestamo" id="modalPrestamoCatalogo"
             tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="bi bi-bookmark-plus me-2"></i>Solicitar Préstamo
                        </h5>
                        <button type="button" class="btn-close btn-close-white"
                                data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>

                    <form id="formPrestamoCatalogo"
                          action="${pageContext.request.contextPath}/catalogo"
                          method="POST">
                        <div class="modal-body">
                            <input type="hidden" name="idLibro" id="modalIdLibro" value="">
                            <input type="hidden" name="buscar" value="${buscar}">
                            <input type="hidden" name="pagina" value="${paginaActual}">

                            <div class="info-libro-modal">
                                <div class="titulo" id="modalTituloLibro">Título del libro</div>
                                <div class="autor" id="modalAutorLibro">Autor</div>
                            </div>

                            <div class="mb-3">
                                <label for="fechaDevolucion" class="form-label"
                                       style="font-family:'Rajdhani',sans-serif;
                                              color:var(--text-muted);font-size:0.85rem;">
                                    <i class="bi bi-calendar-event me-1"></i>
                                    Fecha de devolución esperada:
                                </label>
                                <input type="date" class="form-control"
                                       id="fechaDevolucion"
                                       name="fechaDevolucionEsperada"
                                       style="background:rgba(15,5,26,0.9);
                                              border:1px solid rgba(138,43,226,0.3);
                                              color:var(--text-primary);"
                                       required>
                                <div class="form-text"
                                     style="color:var(--text-muted);font-size:0.75rem;margin-top:6px;">
                                    Debe ser posterior a hoy. Máximo 15 días de préstamo.
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                    data-bs-dismiss="modal"
                                    style="background:transparent;
                                           border:1px solid rgba(138,43,226,0.3);
                                           color:var(--text-muted);">
                                Cancelar
                            </button>
                            <button type="submit" class="btn btn-primary"
                                    style="background:linear-gradient(135deg,
                                           var(--accent-primary),var(--accent-deep));
                                           border:none;">
                                <i class="bi bi-check-circle me-1"></i>Confirmar Préstamo
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

    <%-- ══ SCRIPTS ══ --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <c:if test="${not empty sessionScope.usuario}">
        <script>
            /* Rellena y abre el modal con los datos del libro */
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

            /* CORREGIDO: Event listeners para botones de préstamo usando data attributes */
            document.addEventListener('DOMContentLoaded', function() {
                document.querySelectorAll('.btn-prestamo').forEach(function(btn) {
                    btn.addEventListener('click', function() {
                        var id = this.getAttribute('data-id');
                        var titulo = this.getAttribute('data-titulo');
                        var autor = this.getAttribute('data-autor');
                        abrirModalPrestamo(id, titulo, autor);
                    });
                });
            });

            /* Validación del lado cliente antes de enviar */
            document.getElementById('formPrestamoCatalogo')
                    .addEventListener('submit', function (e) {
                const fecha = new Date(document.getElementById('fechaDevolucion').value);
                const hoy = new Date();
                hoy.setHours(0, 0, 0, 0);
                if (fecha <= hoy) {
                    e.preventDefault();
                    Swal.fire({
                        customClass: { popup: 'swal-biblioteca' },
                        icon: 'warning',
                        title: 'Fecha inválida',
                        text: 'La fecha de devolución debe ser posterior a hoy.',
                        confirmButtonText: 'Entendido'
                    });
                }
            });
        </script>
    </c:if>

    <%-- ══ SweetAlert2: mostrar resultado después del redirect ══ --%>
    <c:if test="${not empty sessionScope.prestamoResultado}">
        <c:set var="swalResultado" value="${sessionScope.prestamoResultado}" scope="page"/>
        <c:remove var="prestamoResultado" scope="session"/>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                <c:choose>
                    <c:when test="${fn:startsWith(swalResultado, 'success')}">
                        Swal.fire({
                            customClass: { popup: 'swal-biblioteca' },
                            icon: 'success',
                            title: '¡Préstamo Exitoso!',
                            html: '<p style="color:#c084fc;font-size:1.05rem;margin-bottom:8px">'
                                 + '${fn:escapeXml(fn:substringAfter(swalResultado, "success|"))}'
                                 + '</p>'
                                 + '<span style="font-size:0.88rem;color:#94a3b8">'
                                 + 'Recuerda devolver el libro en la fecha acordada.</span>',
                            confirmButtonText: '¡Perfecto!',
                            timer: 6000,
                            timerProgressBar: true
                        });
                    </c:when>
                    <c:otherwise>
                        Swal.fire({
                            customClass: { popup: 'swal-biblioteca' },
                            icon: 'error',
                            title: 'Error al registrar',
                            text: '${fn:escapeXml(fn:substringAfter(swalResultado, "error|"))}',
                            confirmButtonText: 'Cerrar'
                        });
                    </c:otherwise>
                </c:choose>
            });
        </script>
    </c:if>

    <jsp:include page="includes/chatbot.jsp"/>
</body>
</html>