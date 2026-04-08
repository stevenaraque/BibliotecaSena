/* ═══════════════════════════════════════════════════════════════
   GALAXY EFFECTS - Studiova Edition
   Animaciones épicas para tema galaxia
   ═══════════════════════════════════════════════════════════════ */

(function() {
    'use strict';

    // ═══════════════════════════════════════════════════════════
    // PARTÍCULAS ESTELARES (Canvas)
    // ═══════════════════════════════════════════════════════════
    const Starfield = {
        canvas: null,
        ctx: null,
        stars: [],
        mouse: { x: 0, y: 0 },
        
        init() {
            // Crear canvas
            this.canvas = document.createElement('canvas');
            this.canvas.id = 'starfield';
            this.canvas.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 0;
                opacity: 0.8;
            `;
            document.body.insertBefore(this.canvas, document.body.firstChild);
            
            this.ctx = this.canvas.getContext('2d');
            this.resize();
            this.createStars();
            this.animate();
            
            // Event listeners
            window.addEventListener('resize', () => this.resize());
            document.addEventListener('mousemove', (e) => {
                this.mouse.x = e.clientX;
                this.mouse.y = e.clientY;
            });
        },
        
        resize() {
            this.canvas.width = window.innerWidth;
            this.canvas.height = window.innerHeight;
        },
        
        createStars() {
            const count = Math.floor((this.canvas.width * this.canvas.height) / 8000);
            this.stars = [];
            
            for (let i = 0; i < count; i++) {
                this.stars.push({
                    x: Math.random() * this.canvas.width,
                    y: Math.random() * this.canvas.height,
                    size: Math.random() * 2 + 0.5,
                    speedX: (Math.random() - 0.5) * 0.3,
                    speedY: (Math.random() - 0.5) * 0.3,
                    opacity: Math.random() * 0.8 + 0.2,
                    twinkle: Math.random() * Math.PI * 2
                });
            }
        },
        
        animate() {
            this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
            
            this.stars.forEach(star => {
                // Movimiento
                star.x += star.speedX;
                star.y += star.speedY;
                star.twinkle += 0.02;
                
                // Wrap around
                if (star.x < 0) star.x = this.canvas.width;
                if (star.x > this.canvas.width) star.x = 0;
                if (star.y < 0) star.y = this.canvas.height;
                if (star.y > this.canvas.height) star.y = 0;
                
                // Efecto parallax con mouse
                const dx = (this.mouse.x - this.canvas.width / 2) * 0.0005;
                const dy = (this.mouse.y - this.canvas.height / 2) * 0.0005;
                star.x -= dx * star.size;
                star.y -= dy * star.size;
                
                // Dibujar estrella
                const twinkleOpacity = star.opacity * (0.7 + 0.3 * Math.sin(star.twinkle));
                this.ctx.beginPath();
                this.ctx.arc(star.x, star.y, star.size, 0, Math.PI * 2);
                this.ctx.fillStyle = `rgba(200, 180, 255, ${twinkleOpacity})`;
                this.ctx.fill();
                
                // Glow para estrellas grandes
                if (star.size > 1.5) {
                    this.ctx.beginPath();
                    this.ctx.arc(star.x, star.y, star.size * 3, 0, Math.PI * 2);
                    this.ctx.fillStyle = `rgba(168, 85, 247, ${twinkleOpacity * 0.2})`;
                    this.ctx.fill();
                }
            });
            
            requestAnimationFrame(() => this.animate());
        }
    };

    // ═══════════════════════════════════════════════════════════
    // SCROLL REVEAL ANIMATIONS
    // ═══════════════════════════════════════════════════════════
    const ScrollReveal = {
        init() {
            const observerOptions = {
                root: null,
                rootMargin: '0px',
                threshold: 0.1
            };
            
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('revealed');
                        observer.unobserve(entry.target);
                    }
                });
            }, observerOptions);
            
            // Elementos a animar
            const elements = document.querySelectorAll(
                '.stat-card, .galaxy-card, .table-responsive, .card, .page-title'
            );
            
            elements.forEach((el, index) => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(30px)';
                el.style.transition = `opacity 0.6s ease ${index * 0.1}s, transform 0.6s ease ${index * 0.1}s`;
                observer.observe(el);
            });
            
            // CSS para revealed
            const style = document.createElement('style');
            style.textContent = `
                .revealed {
                    opacity: 1 !important;
                    transform: translateY(0) !important;
                }
            `;
            document.head.appendChild(style);
        }
    };

    // ═══════════════════════════════════════════════════════════
    // NAVBAR SCROLL EFFECT
    // ═══════════════════════════════════════════════════════════
    const NavbarEffect = {
        init() {
            const menu = document.getElementById('mainNav');
            if (!menu) return;
            
            let lastScroll = 0;
            
            window.addEventListener('scroll', () => {
                const currentScroll = window.pageYOffset;
                
                // Añadir/quitar clase scrolled
                if (currentScroll > 50) {
                    menu.classList.add('scrolled');
                } else {
                    menu.classList.remove('scrolled');
                }
                
                // Hide/show on scroll direction
                if (currentScroll > lastScroll && currentScroll > 200) {
                    menu.style.transform = 'translateY(-100%)';
                } else {
                    menu.style.transform = 'translateY(0)';
                }
                
                lastScroll = currentScroll;
            });
        }
    };

    // ═══════════════════════════════════════════════════════════
    // 3D TILT EFFECT PARA CARDS
    // ═══════════════════════════════════════════════════════════
    const TiltEffect = {
        init() {
            const cards = document.querySelectorAll('.stat-card, .galaxy-card');
            
            cards.forEach(card => {
                card.addEventListener('mousemove', (e) => this.handleMouseMove(e, card));
                card.addEventListener('mouseleave', (e) => this.handleMouseLeave(e, card));
            });
        },
        
        handleMouseMove(e, card) {
            const rect = card.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            
            const centerX = rect.width / 2;
            const centerY = rect.height / 2;
            
            const rotateX = (y - centerY) / 10;
            const rotateY = (centerX - x) / 10;
            
            card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateY(-8px)`;
        },
        
        handleMouseLeave(e, card) {
            card.style.transform = 'perspective(1000px) rotateX(0) rotateY(0) translateY(0)';
        }
    };

    // ═══════════════════════════════════════════════════════════
    // BOTÓN RIPPLE EFFECT
    // ═══════════════════════════════════════════════════════════
    const RippleEffect = {
        init() {
            const buttons = document.querySelectorAll('.btn');
            
            buttons.forEach(btn => {
                btn.addEventListener('click', (e) => this.createRipple(e, btn));
            });
        },
        
        createRipple(e, btn) {
            const ripple = document.createElement('span');
            const rect = btn.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;
            
            ripple.style.cssText = `
                position: absolute;
                width: ${size}px;
                height: ${size}px;
                left: ${x}px;
                top: ${y}px;
                background: rgba(255, 255, 255, 0.3);
                border-radius: 50%;
                transform: scale(0);
                animation: ripple 0.6s ease-out;
                pointer-events: none;
            `;
            
            btn.style.position = 'relative';
            btn.style.overflow = 'hidden';
            btn.appendChild(ripple);
            
            setTimeout(() => ripple.remove(), 600);
        }
    };

    // ═══════════════════════════════════════════════════════════
    // TYPING EFFECT PARA TÍTULOS
    // ═══════════════════════════════════════════════════════════
    const TypeWriter = {
        init() {
            const titles = document.querySelectorAll('.page-title');
            
            titles.forEach(title => {
                const text = title.textContent;
                const icon = title.querySelector('i');
                title.textContent = '';
                if (icon) title.appendChild(icon);
                
                let i = icon ? 1 : 0;
                const type = () => {
                    if (i < text.length) {
                        title.appendChild(document.createTextNode(text.charAt(i)));
                        i++;
                        setTimeout(type, 30);
                    }
                };
                
                // Iniciar cuando sea visible
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            setTimeout(type, 300);
                            observer.unobserve(title);
                        }
                    });
                });
                
                observer.observe(title);
            });
        }
    };

    // ═══════════════════════════════════════════════════════════
    // CONTADORES ANIMADOS
    // ═══════════════════════════════════════════════════════════
    const AnimatedCounter = {
        init() {
            const counters = document.querySelectorAll('.stat-number');
            
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        this.animate(entry.target);
                        observer.unobserve(entry.target);
                    }
                });
            }, { threshold: 0.5 });
            
            counters.forEach(counter => observer.observe(counter));
        },
        
        animate(element) {
            const target = parseInt(element.textContent) || 0;
            if (target === 0) return;
            
            const duration = 2000;
            const start = 0;
            const startTime = performance.now();
            
            const update = (currentTime) => {
                const elapsed = currentTime - startTime;
                const progress = Math.min(elapsed / duration, 1);
                
                // Easing ease-out
                const easeOut = 1 - Math.pow(1 - progress, 3);
                const current = Math.floor(start + (target - start) * easeOut);
                
                element.textContent = current;
                
                if (progress < 1) {
                    requestAnimationFrame(update);
                } else {
                    element.textContent = target;
                }
            };
            
            element.textContent = '0';
            requestAnimationFrame(update);
        }
    };

    // ═══════════════════════════════════════════════════════════
    // CSS KEYFRAMES DINÁMICOS
    // ═══════════════════════════════════════════════════════════
    const injectKeyframes = () => {
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
            
            @keyframes float {
                0%, 100% { transform: translateY(0); }
                50% { transform: translateY(-10px); }
            }
            
            @keyframes glow {
                0%, 100% { box-shadow: 0 0 20px rgba(168, 85, 247, 0.4); }
                50% { box-shadow: 0 0 40px rgba(168, 85, 247, 0.7); }
            }
            
            @keyframes shimmer {
                0% { background-position: -200% 0; }
                100% { background-position: 200% 0; }
            }
        `;
        document.head.appendChild(style);
    };

    // ═══════════════════════════════════════════════════════════
    // INICIALIZACIÓN
    // ═══════════════════════════════════════════════════════════
    document.addEventListener('DOMContentLoaded', () => {
        injectKeyframes();
        Starfield.init();
        ScrollReveal.init();
        NavbarEffect.init();
        TiltEffect.init();
        RippleEffect.init();
        TypeWriter.init();
        AnimatedCounter.init();
        
        console.log('🌌 Galaxy Effects initialized');
    });

})();