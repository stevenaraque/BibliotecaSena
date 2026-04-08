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
        
        <!-- Fuentes Galaxy -->
        <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700;800&family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        
        <style>
            /* ── Fondo Galaxy ─────────────────────────────────────────── */
            body {
                background-color: #030005;
                background-image: 
                    radial-gradient(ellipse 80% 50% at 0% 0%, rgba(168, 85, 247, 0.15) 0%, transparent 50%),
                    radial-gradient(ellipse 60% 40% at 100% 100%, rgba(6, 182, 212, 0.1) 0%, transparent 40%);
                min-height: 100vh;
                position: relative;
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

            /* Contenido por encima */
            .galaxy-content {
                position: relative;
                z-index: 1;
            }

            /* ── Animaciones ─────────────────────────────────────────── */
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

            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }

            @keyframes float {
                0%, 100% { transform: translateY(0); }
                50% { transform: translateY(-10px); }
            }

            @keyframes pulseGlow {
                0%, 100% { 
                    box-shadow: 0 0 20px rgba(138, 43, 226, 0.4);
                }
                50% { 
                    box-shadow: 0 0 40px rgba(138, 43, 226, 0.7);
                }
            }

            @keyframes shimmer {
                0% { background-position: -200% 0; }
                100% { background-position: 200% 0; }
            }

            @keyframes gradientShift {
                0%, 100% { background-position: 0% center; }
                50% { background-position: 100% center; }
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateX(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            /* ── Navbar Público Premium ──────────────────────────────── */
            .nav-public {
                background: rgba(5, 1, 10, 0.95);
                backdrop-filter: blur(20px);
                border-bottom: 1px solid rgba(138, 43, 226, 0.25);
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                box-shadow: 0 4px 30px rgba(138, 43, 226, 0.2);
                animation: fadeInDown 0.6s ease-out;
            }

            @keyframes fadeInDown {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .nav-public-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 0 24px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                height: 70px;
            }

            .nav-spacer {
                height: 70px;
            }

            .nav-brand {
                display: flex;
                align-items: center;
                gap: 12px;
                text-decoration: none;
                padding: 8px 16px;
                border-radius: 12px;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .nav-brand::before {
                content: '';
                position: absolute;
                inset: 0;
                background: radial-gradient(circle at center, rgba(138, 43, 226, 0.2), transparent 70%);
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .nav-brand:hover::before {
                opacity: 1;
            }

            .nav-brand i {
                font-size: 1.8rem;
                color: #8a2be2;
                filter: drop-shadow(0 0 15px rgba(138, 43, 226, 0.8));
                animation: pulseIcon 2s ease-in-out infinite;
                position: relative;
                z-index: 1;
            }

            @keyframes pulseIcon {
                0%, 100% { filter: drop-shadow(0 0 15px rgba(138, 43, 226, 0.8)); }
                50% { filter: drop-shadow(0 0 25px rgba(138, 43, 226, 1)); }
            }

            .nav-brand span {
                font-family: 'Orbitron', sans-serif;
                font-size: 1.1rem;
                font-weight: 700;
                background: linear-gradient(90deg, #c084fc, #818cf8, #38bdf8);
                background-size: 200% auto;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                animation: gradientShift 3s ease infinite;
                position: relative;
                z-index: 1;
            }

            .nav-indicator {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 10px 24px;
                background: rgba(138, 43, 226, 0.15);
                border: 1px solid rgba(138, 43, 226, 0.3);
                border-radius: 12px;
                color: #c084fc;
                font-family: 'Rajdhani', sans-serif;
                font-weight: 600;
                font-size: 0.9rem;
                box-shadow: 0 0 20px rgba(138, 43, 226, 0.15);
                animation: pulseGlow 3s ease-in-out infinite;
            }

            .nav-indicator i {
                font-size: 1.2rem;
            }

            .btn-login {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 12px 28px;
                background: linear-gradient(135deg, #8a2be2, #4b0082);
                border: none;
                border-radius: 12px;
                color: #fff;
                text-decoration: none;
                font-family: 'Rajdhani', sans-serif;
                font-weight: 700;
                font-size: 0.9rem;
                letter-spacing: 0.05em;
                position: relative;
                overflow: hidden;
                transition: all 0.3s ease;
                box-shadow: 0 4px 20px rgba(138, 43, 226, 0.5);
            }

            .btn-login::before {
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

            .btn-login:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 30px rgba(138, 43, 226, 0.7);
            }

            .btn-login:hover::before {
                left: 100%;
            }

            /* ── Hero Épico ──────────────────────────────────────────── */
            .cat-hero {
                text-align: center;
                padding: 80px 0 50px;
                animation: fadeInUp 0.8s ease-out;
            }

            .cat-hero h1 {
                font-family: 'Orbitron', sans-serif;
                font-size: clamp(1.8rem, 5vw, 2.8rem);
                font-weight: 800;
                background: linear-gradient(90deg, #c084fc, #818cf8, #38bdf8, #c084fc);
                background-size: 300% auto;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 16px;
                animation: gradientShift 4s ease infinite;
                text-shadow: 0 0 60px rgba(138, 43, 226, 0.3);
                position: relative;
            }

            .cat-hero h1::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 3px;
                background: linear-gradient(90deg, transparent, #8a2be2, transparent);
                border-radius: 2px;
            }

            .cat-hero p {
                font-family: 'Rajdhani', sans-serif;
                font-size: 1.1rem;
                color: #94a3b8;
                letter-spacing: 0.08em;
                animation: fadeIn 1s ease-out 0.3s both;
            }

            /* ── Buscador Premium ───────────────────────────────────── */
            .search-wrap {
                animation: fadeInUp 0.8s ease-out 0.2s both;
            }

            .search-wrap .input-group {
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
                border-radius: 14px;
                overflow: hidden;
                transition: all 0.3s ease;
            }

            .search-wrap .input-group:focus-within {
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4),
                            0 0 40px rgba(138, 43, 226, 0.2);
                transform: translateY(-2px);
            }

            .search-wrap .form-control {
                background: rgba(15, 5, 26, 0.9);
                border: 1px solid rgba(138, 43, 226, 0.3);
                border-right: none;
                color: #f8fafc;
                border-radius: 0;
                font-family: 'Rajdhani', sans-serif;
                font-size: 1rem;
                padding: 14px 20px;
                transition: all 0.3s ease;
            }

            .search-wrap .form-control:focus {
                background: rgba(20, 10, 40, 0.95);
                border-color: #8a2be2;
                box-shadow: none;
            }

            .search-wrap .input-group-text {
                background: rgba(15, 5, 26, 0.9);
                border: 1px solid rgba(138, 43, 226, 0.3);
                border-right: none;
                color: #8a2be2;
                padding: 14px 18px;
                font-size: 1.1rem;
            }

            .search-wrap .btn-search {
                background: linear-gradient(135deg, #8a2be2, #4b0082);
                border: none;
                color: #fff;
                font-family: 'Rajdhani', sans-serif;
                font-weight: 700;
                font-size: 0.95rem;
                letter-spacing: 0.08em;
                text-transform: uppercase;
                padding: 14px 32px;
                position: relative;
                overflow: hidden;
                transition: all 0.3s ease;
            }

            .search-wrap .btn-search::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, 
                    transparent, 
                    rgba(255, 255, 255, 0.2), 
                    transparent);
                transition: left 0.5s ease;
            }

            .search-wrap .btn-search:hover {
                box-shadow: 0 0 30px rgba(138, 43, 226, 0.5);
            }

            .search-wrap .btn-search:hover::before {
                left: 100%;
            }

            /* ── Info Resultados ────────────────────────────────────── */
            .results-info {
                font-family: 'Rajdhani', sans-serif;
                font-size: 0.85rem;
                color: #64748b;
                letter-spacing: 0.08em;
                text-transform: uppercase;
                animation: fadeIn 0.6s ease-out 0.4s both;
            }

            .results-info strong {
                color: #f8fafc;
                font-weight: 600;
            }

            .results-info a {
                color: #8a2be2;
                text-decoration: none;
                transition: all 0.3s ease;
                position: relative;
            }

            .results-info a::after {
                content: '';
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 0;
                height: 1px;
                background: #c084fc;
                transition: width 0.3s ease;
            }

            .results-info a:hover {
                color: #c084fc;
            }

            .results-info a:hover::after {
                width: 100%;
            }

            /* ── Cards de Libros Épicas ─────────────────────────────── */
            .libro-card {
                background: rgba(15, 5, 30, 0.6);
                border: 1px solid rgba(138, 43, 226, 0.15);
                border-radius: 20px;
                height: 100%;
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                overflow: hidden;
                display: flex;
                flex-direction: column;
                backdrop-filter: blur(10px);
                animation: fadeInUp 0.6s ease-out both;
                position: relative;
            }

            /* Animación escalonada para las cards */
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
                border-radius: 20px;
                padding: 1px;
                background: linear-gradient(135deg, 
                    rgba(138, 43, 226, 0.4) 0%, 
                    transparent 50%, 
                    rgba(6, 182, 212, 0.2) 100%);
                -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
                -webkit-mask-composite: xor;
                mask-composite: exclude;
                pointer-events: none;
                opacity: 0;
                transition: opacity 0.4s ease;
            }

            .libro-card:hover {
                border-color: rgba(138, 43, 226, 0.4);
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4),
                            0 0 60px rgba(138, 43, 226, 0.25);
                transform: translateY(-12px) scale(1.02);
            }

            .libro-card:hover::before {
                opacity: 1;
            }

            .libro-card-top {
                padding: 20px 20px 0;
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
            }

            .libro-card-body {
                padding: 16px 20px;
                flex: 1;
            }

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
                transition: color 0.3s ease;
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
                transition: all 0.3s ease;
            }

            .libro-card:hover .libro-meta {
                color: #818cf8;
            }

            .libro-meta i {
                color: #8a2be2;
                font-size: 0.85rem;
                transition: all 0.3s ease;
            }

            .libro-card:hover .libro-meta i {
                transform: scale(1.2);
                filter: drop-shadow(0 0 8px rgba(138, 43, 226, 0.6));
            }

            .libro-card-footer {
                padding: 16px 20px 20px;
                border-top: 1px solid rgba(138, 43, 226, 0.1);
            }

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
                top: 50%;
                left: 50%;
                width: 0;
                height: 0;
                background: rgba(138, 43, 226, 0.2);
                border-radius: 50%;
                transform: translate(-50%, -50%);
                transition: width 0.6s ease, height 0.6s ease;
            }

            .btn-solicitar:hover::before {
                width: 300px;
                height: 300px;
            }

            .btn-solicitar:hover {
                border-color: #8a2be2;
                color: #c084fc;
                box-shadow: 0 0 30px rgba(138, 43, 226, 0.3);
                transform: translateY(-2px);
            }

            .btn-solicitar.disabled {
                opacity: 0.4;
                pointer-events: none;
            }

            /* Badges mejorados */
            .badge-disponible {
                background: linear-gradient(135deg, rgba(138, 43, 226, 0.3), rgba(75, 0, 130, 0.2));
                border: 1px solid rgba(138, 43, 226, 0.4);
                color: #c084fc;
                font-family: 'Rajdhani', sans-serif;
                font-size: 0.75rem;
                font-weight: 600;
                letter-spacing: 0.1em;
                text-transform: uppercase;
                padding: 6px 12px;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(138, 43, 226, 0.2);
                animation: pulseGlow 2s ease-in-out infinite;
            }

            .badge-nodisponible {
                background: rgba(190, 24, 93, 0.2);
                border: 1px solid rgba(190, 24, 93, 0.35);
                color: #fb7185;
                font-family: 'Rajdhani', sans-serif;
                font-size: 0.75rem;
                font-weight: 600;
                letter-spacing: 0.1em;
                text-transform: uppercase;
                padding: 6px 12px;
                border-radius: 8px;
            }

            /* ── Paginación Épica ──────────────────────────────────── */
            .cat-pagination {
                animation: fadeInUp 0.6s ease-out 0.6s both;
            }

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
                position: relative;
                overflow: hidden;
            }

            .cat-pagination .page-link::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(135deg, 
                    rgba(138, 43, 226, 0.3), 
                    rgba(75, 0, 130, 0.2));
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .cat-pagination .page-link:hover {
                border-color: #8a2be2;
                color: #c084fc;
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(138, 43, 226, 0.3);
            }

            .cat-pagination .page-link:hover::before {
                opacity: 1;
            }

            .cat-pagination .page-item.active .page-link {
                background: linear-gradient(135deg, #8a2be2, #4b0082);
                border-color: #8a2be2;
                color: #fff;
                box-shadow: 0 0 30px rgba(138, 43, 226, 0.5);
                transform: translateY(-3px);
            }

            .cat-pagination .page-item.disabled .page-link {
                opacity: 0.3;
                transform: none;
            }

            /* ── Footer ─────────────────────────────────────────────── */
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
                animation: fadeIn 0.6s ease-out 0.8s both;
            }

            /* ── Empty State ───────────────────────────────────────── */
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

            .empty-state p {
                font-family: 'Rajdhani', sans-serif;
                font-size: 1.1rem;
                margin-bottom: 24px;
            }

            /* ── Modal Mejorado ───────────────────────────────────── */
            .modal-prestamo .modal-content {
                background: rgba(15, 5, 26, 0.98);
                border: 1px solid rgba(138, 43, 226, 0.4);
                border-radius: 20px;
                box-shadow: 0 0 80px rgba(138, 43, 226, 0.4);
                animation: fadeInUp 0.4s ease-out;
            }

            .modal-prestamo .modal-header {
                border-bottom: 1px solid rgba(138, 43, 226, 0.2);
                padding: 24px;
            }

            .modal-prestamo .modal-title {
                font-family: 'Orbitron', sans-serif;
                color: #c084fc;
                font-size: 1.2rem;
            }

            .info-libro-modal {
                background: rgba(138, 43, 226, 0.1);
                border: 1px solid rgba(138, 43, 226, 0.2);
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 24px;
                position: relative;
                overflow: hidden;
            }

            .info-libro-modal::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 2px;
                background: linear-gradient(90deg, transparent, #8a2be2, transparent);
                animation: shimmer 2s infinite;
            }

            .info-libro-modal .titulo {
                font-family: 'Orbitron', sans-serif;
                color: #f8fafc;
                font-size: 1rem;
                margin-bottom: 8px;
            }

            .info-libro-modal .autor {
                color: #94a3b8;
                font-size: 0.9rem;
            }

            /* SweetAlert2 Theme */
            .swal-biblioteca.swal2-popup {
                background: rgba(15, 5, 26, 0.98) !important;
                border: 1px solid rgba(138, 43, 226, 0.4) !important;
                border-radius: 20px !important;
                box-shadow: 0 0 60px rgba(138, 43, 226, 0.3) !important;
            }

            .swal-biblioteca .swal2-title {
                font-family: 'Orbitron', sans-serif !important;
                color: #f8fafc !important;
            }

            .swal-biblioteca .swal2-html-container {
                font-family: 'Rajdhani', sans-serif !important;
                color: #94a3b8 !important;
            }

            .swal-biblioteca .swal2-confirm {
                background: linear-gradient(135deg, #8a2be2, #4b0082) !important;
                border: none !important;
                font-family: 'Rajdhani', sans-serif !important;
                font-weight: 700 !important;
                border-radius: 12px !important;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .nav-public-container {
                    padding: 0 16px;
                    height: 60px;
                }
                .nav-spacer {
                    height: 60px;
                }
                .nav-brand span {
                    display: none;
                }
                .nav-indicator span {
                    display: none;
                }
                .btn-login span {
                    display: none;
                }
                .btn-login {
                    padding: 12px;
                }
                .cat-hero {
                    padding: 60px 0 40px;
                }
                .cat-hero h1::after {
                    width: 60px;
                }
            }
        </style>
    </head>
    <body>

        <%-- Canvas para estrellas --%>
        <canvas id="starfield"></canvas>

        <div class="galaxy-content">

            <%-- ══ NAVBAR CONDICIONAL ══ --%>
            <c:choose>
                <c:when test="${not empty sessionScope.usuario}">
                    <jsp:include page="/views/includes/nav_universal.jsp"/>
                </c:when>
                <c:otherwise>
                    <nav class="nav-public">
                        <div class="nav-public-container">
                            <a href="catalogo" class="nav-brand">
                                <i class="bi bi-hexagon-fill"></i>
                                <span>Biblioteca SENA</span>
                            </a>
                            <div class="nav-indicator">
                                <i class="bi bi-collection"></i>
                                <span>Catálogo</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/login" class="btn-login">
                                <i class="bi bi-shield-lock-fill"></i>
                                <span>Iniciar Sesión</span>
                            </a>
                        </div>
                    </nav>
                    <div class="nav-spacer"></div>
                </c:otherwise>
            </c:choose>

            <div class="container">

                <%-- Hero --%>
                <div class="cat-hero">
                    <h1>
                        <i class="bi bi-collection-fill me-2" style="color: #8a2be2; font-size: 0.8em;"></i>
                        Catálogo de Libros
                    </h1>
                    <p>Explora nuestra colección galáctica — inicia sesión para solicitar préstamos</p>
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
                                ${totalLibros} resultado(s) para "<strong>${buscar}</strong>"
                                — <a href="catalogo">Limpiar búsqueda</a>
                            </c:when>
                            <c:otherwise>${totalLibros} libro(s) disponibles</c:otherwise>
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
                                       style="width: auto; padding: 12px 32px;">
                                        <i class="bi bi-arrow-left me-2"></i>Ver todos los libros
                                    </a>
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
                                                            <a href="${pageContext.request.contextPath}/login?redirect=catalogo" 
                                                               class="btn-solicitar">
                                                                <i class="bi bi-box-arrow-in-right me-2"></i>Iniciar sesión para solicitar
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

                <%-- Paginación --%>
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

            <div class="cat-footer">
                <i class="bi bi-stars me-2" style="color: #8a2be2;"></i>
                2026 Biblioteca SENA — Sistema de Gestión
            </div>

        </div>

        <%-- Modal Préstamo --%>
        <c:if test="${not empty sessionScope.usuario}">
            <div class="modal fade modal-prestamo" id="modalPrestamoCatalogo" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="bi bi-bookmark-plus me-2"></i>Solicitar Préstamo
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form id="formPrestamoCatalogo" action="${pageContext.request.contextPath}/catalogo" method="POST">
                            <div class="modal-body">
                                <input type="hidden" name="idLibro" id="modalIdLibro">
                                <input type="hidden" name="buscar" value="${buscar}">
                                <input type="hidden" name="pagina" value="${paginaActual}">

                                <div class="info-libro-modal">
                                    <div class="titulo" id="modalTituloLibro">Título del libro</div>
                                    <div class="autor" id="modalAutorLibro">Autor</div>
                                </div>

                                <div class="mb-3">
                                    <label for="fechaDevolucion" class="form-label"
                                           style="font-family: 'Rajdhani', sans-serif; color: #94a3b8; font-size: 0.9rem;">
                                        <i class="bi bi-calendar-event me-2"></i>Fecha de devolución esperada:
                                    </label>
                                    <input type="date" class="form-control" id="fechaDevolucion" 
                                           name="fechaDevolucionEsperada"
                                           style="background: rgba(15,5,26,0.9); border: 1px solid rgba(138,43,226,0.3); 
                                           color: #f8fafc; padding: 12px; border-radius: 10px;" required>
                                    <div class="form-text" style="color: #64748b; font-size: 0.8rem; margin-top: 8px;">
                                        <i class="bi bi-info-circle me-1"></i>
                                        Debe ser posterior a hoy. Máximo 15 días de préstamo.
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" 
                                        style="background: transparent; border: 1px solid rgba(138,43,226,0.3); 
                                        color: #94a3b8; font-family: 'Rajdhani', sans-serif; padding: 10px 20px; border-radius: 10px;">
                                    Cancelar
                                </button>
                                <button type="submit" class="btn btn-primary" 
                                        style="background: linear-gradient(135deg, #8a2be2, #4b0082); border: none;
                                        font-family: 'Rajdhani', sans-serif; font-weight: 700; padding: 10px 24px; border-radius: 10px;">
                                    <i class="bi bi-check-circle me-2"></i>Confirmar Préstamo
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:if>

        <%-- Scripts --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="${pageContext.request.contextPath}/js/galaxy-effects.js"></script>

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
                                customClass: { popup: 'swal-biblioteca' },
                                icon: 'warning',
                                title: 'Fecha inválida',
                                text: 'La fecha de devolución debe ser posterior a hoy.',
                                confirmButtonText: 'Entendido',
                                confirmButtonColor: '#8a2be2'
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
                                customClass: { popup: 'swal-biblioteca' },
                                icon: 'success',
                                title: '¡Préstamo Exitoso!',
                                html: '<div style="text-align: center;">' +
                                      '<i class="bi bi-check-circle-fill" style="font-size: 3rem; color: #c084fc; margin-bottom: 16px; display: block;"></i>' +
                                      '<p style="color: #c084fc; font-size: 1.1rem; margin-bottom: 8px;">${fn:escapeXml(fn:substringAfter(swalResultado, "success|"))}</p>' +
                                      '<span style="color: #94a3b8; font-size: 0.9rem;">Recuerda devolver el libro en la fecha acordada.</span></div>',
                                confirmButtonText: '¡Perfecto!',
                                confirmButtonColor: '#8a2be2',
                                timer: 5000,
                                timerProgressBar: true,
                                showConfirmButton: true
                            });
                        </c:when>
                        <c:otherwise>
                            Swal.fire({
                                customClass: { popup: 'swal-biblioteca' },
                                icon: 'error',
                                title: 'Error al registrar',
                                text: '${fn:escapeXml(fn:substringAfter(swalResultado, "error|"))}',
                                confirmButtonText: 'Cerrar',
                                confirmButtonColor: '#8a2be2'
                            });
                        </c:otherwise>
                    </c:choose>
                });
            </script>
        </c:if>

        <jsp:include page="includes/chatbot.jsp"/>
    </body>
</html>