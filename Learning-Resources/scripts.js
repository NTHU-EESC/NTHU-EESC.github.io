document.addEventListener('DOMContentLoaded', (event) => {
    // Mobile menu toggle
    const menuToggle = document.getElementById('menuToggle');
    const navMenu = document.getElementById('navMenu');
    const navOverlay = document.getElementById('navOverlay');

    function toggleMenu() {
        navMenu.classList.toggle('active');
        navOverlay.classList.toggle('active');
        // Optional: Toggle body scroll
        // document.body.style.overflow = navMenu.classList.contains('active') ? 'hidden' : '';
    }

    function closeMenu() {
        navMenu.classList.remove('active');
        navOverlay.classList.remove('active');
        // document.body.style.overflow = '';
    }

    if (menuToggle && navMenu && navOverlay) {
        menuToggle.addEventListener('click', toggleMenu);
        navOverlay.addEventListener('click', closeMenu);

        // Close menu when clicking nav links (especially for single-page anchors)
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', (e) => {
                // If it's not an anchor link for the current page, or if it is, still close.
                // For multi-page navigation, this ensures menu closes after selection.
                 if (!link.getAttribute('href').startsWith('#')) {
                    closeMenu();
                 } else {
                    // If it is an anchor link, smooth scroll might be handled by another function
                    // but we still want to close the menu.
                    setTimeout(closeMenu, 100); // Delay to allow scroll to start
                 }
            });
        });
    }

    // Card click handlers
    document.querySelectorAll('.card[data-href]').forEach(card => {
        card.addEventListener('click', () => {
            const href = card.getAttribute('data-href');
            if (href) {
                // Open external links (like Google Drive) in a new tab
                if (href.startsWith('http')) {
                    window.open(href, '_blank');
                } else {
                    window.location.href = href;
                }
            }
        });
    });

    // Smooth scrolling for anchor links (if any are added later)
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Add scroll effect to header (hide on scroll down, show on scroll up)
    let lastScrollTop = 0;
    const header = document.querySelector('.header');
    if (header) {
        window.addEventListener('scroll', () => {
            const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
            
            if (scrollTop > lastScrollTop && scrollTop > header.offsetHeight) {
                // Scroll Down
                header.style.transform = 'translateY(-100%)';
            } else {
                // Scroll Up
                header.style.transform = 'translateY(0)';
            }
            lastScrollTop = scrollTop <= 0 ? 0 : scrollTop; // For Mobile or negative scrolling
        }, false);
    }

    // Intersection Observer for card animations
    const observerOptions = {
        threshold: 0.1, // Trigger when 10% of the element is visible
        rootMargin: '0px 0px -50px 0px' // Start animation a bit before it's fully in view
    };

    const observer = new IntersectionObserver((entries, observerInstance) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
                observerInstance.unobserve(entry.target); // Optional: stop observing after animation
            }
        });
    }, observerOptions);

    // Observe cards for animation
    document.querySelectorAll('.card').forEach(card => {
        card.style.opacity = '0'; // Initial state for animation
        card.style.transform = 'translateY(30px)'; // Initial state for animation
        observer.observe(card);
    });
});