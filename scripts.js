document.addEventListener('DOMContentLoaded', (event) => {
    const menuToggle = document.getElementById('menu-toggle');
    const sidebar = document.getElementById('sidebar');
    const bodyContent = document.getElementsByClassName('bodyContent');
    const overlay = document.getElementById('overlay');

    // 切換側邊欄的顯示與隱藏
    menuToggle.addEventListener('click', () => {
        sidebar.classList.toggle('show');
        for (let i = 0; i < bodyContent.length; i++) {
            bodyContent.item(i).classList.toggle('showNavigationBar');
        }
        overlay.classList.toggle('showNavigationBar');
    });

    // 點擊側邊欄外的地方時隱藏側邊欄
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

document.getElementById("projectsInfoCard").onclick = function() {
    window.open("./Projects-Info/", "_self");
}

document.getElementById("learningResourcesCard").onclick = function() {
    window.open("./Learning-Resources/", "_self");
}

document.getElementById("eecampCard").onclick = function() {
    window.open("./EECamp/", "_self");
}

document.getElementById("eeccCard").onclick = function() {
    window.open("https://eecc.nthuee.org", "_self");
}

document.getElementById("eenightCard").onclick = function() {
    window.open("./EENight/", "_self");
}