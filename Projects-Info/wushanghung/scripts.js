// Mobile menu toggle
const menuToggle = document.getElementById('menuToggle');
const navMenu = document.getElementById('navMenu');
const navOverlay = document.getElementById('navOverlay');

function toggleMenu() {
    navMenu.classList.toggle('active');
    navOverlay.classList.toggle('active');
}

function closeMenu() {
    navMenu.classList.remove('active');
    navOverlay.classList.remove('active');
}

menuToggle.addEventListener('click', toggleMenu);

// Close menu when clicking overlay
navOverlay.addEventListener('click', closeMenu);

// Close menu when clicking nav links
document.querySelectorAll('.nav-link').forEach(link => {
    link.addEventListener('click', closeMenu);
});

// Card click handlers
document.querySelectorAll('.card[data-href]').forEach(card => {
    card.addEventListener('click', () => {
        const href = card.getAttribute('data-href');
        if (href.startsWith('http')) {
            window.open(href, '_self');
        } else {
            window.location.href = href;
        }
    });
});

// Smooth scrolling for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Add scroll effect to header
let lastScrollTop = 0;
const header = document.querySelector('.header');

window.addEventListener('scroll', () => {
    const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
    
    if (scrollTop > lastScrollTop && scrollTop > 100) {
        header.style.transform = 'translateY(-100%)';
    } else {
        header.style.transform = 'translateY(0)';
    }
    
    lastScrollTop = scrollTop;
});

// Intersection Observer for animations
// const observerOptions = {
//     threshold: 0.1,
//     rootMargin: '0px 0px -50px 0px'
// };

// const observer = new IntersectionObserver((entries) => {
//     entries.forEach(entry => {
//         if (entry.isIntersecting) {
//             entry.target.style.opacity = '1';
//             entry.target.style.transform = 'translateY(0)';
//         }
//     });
// }, observerOptions);

// // Observe cards for animation
// document.querySelectorAll('.card').forEach(card => {
//     card.style.opacity = '0';
//     card.style.transform = 'translateY(30px)';
//     observer.observe(card);
// });