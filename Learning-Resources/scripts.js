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

    // 為側邊欄的鏈接添加點擊事件
    // const sidebarLinks = document.querySelectorAll('#sidebar ul li a');
    // sidebarLinks.forEach(link => {
    //     link.addEventListener('click', function(e) {
    //         e.preventDefault();
    //         alert(`您點擊了 "${this.textContent}" 鏈接`);
    //         sidebar.classList.remove('show');
    //     });
    // });

    // 移除之前為卡片添加的點擊事件，因為我們現在使用 CSS :active 偽類
});

document.getElementById("eeLearningResourcesCard").onclick = function() {
    window.open("https://drive.google.com/drive/folders/18lsPnehtjThgx5O8ux0PJnqlMW88mbsC?usp=drive_link");
}

document.getElementById("csLearningResourcesCard").onclick = function() {
    window.open("https://drive.google.com/drive/folders/1zoRayCwbnTJIZ_WJSXRyR0Z5-BThec8X?usp=drive_link");
}

document.getElementById("eeLearningResourcesUploadCard").onclick = function() {
    window.open("https://drive.google.com/drive/folders/1VvK-21Defq3rbkgAfrcL-eyn9rxczBla?usp=drive_link");
}