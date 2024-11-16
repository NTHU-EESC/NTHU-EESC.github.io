document.addEventListener('DOMContentLoaded', (event) => {
    const menuToggle = document.getElementById('menu-toggle');
    const sidebar = document.getElementById('sidebar');
    const bodyContent = document.getElementsByClassName('bodyContent');
    const overlay = document.getElementById('overlay');
    const themeToggle = document.getElementById('theme-toggle');

    // Existing menu toggle functionality
    menuToggle.addEventListener('click', () => {
        sidebar.classList.toggle('show');
        for (let i = 0; i < bodyContent.length; i++) {
            bodyContent.item(i).classList.toggle('showNavigationBar');
        }
        overlay.classList.toggle('showNavigationBar');
    });

    // Existing overlay click functionality
    document.addEventListener('click', (e) => {
        if (!sidebar.contains(e.target) && e.target !== menuToggle) {
            sidebar.classList.remove('show');
            for (let i = 0; i < bodyContent.length; i++) {
                bodyContent.item(i).classList.remove('showNavigationBar');
            }
            overlay.classList.remove('showNavigationBar');
        }
    });
});

document.addEventListener('DOMContentLoaded', () => {
    const header = document.querySelector('header');
    const menuToggle = document.getElementById('menu-toggle');

    window.addEventListener('scroll', () => {
        if (window.scrollY > 185) {  // 當滾動超過 150px 時，縮小 header
            header.classList.add('sticky');
            menuToggle.classList.add('sticky');
        } else {
            header.classList.remove('sticky');
            menuToggle.classList.remove('sticky');
        }
        lastScrollY = window.scrollY;
    });
});