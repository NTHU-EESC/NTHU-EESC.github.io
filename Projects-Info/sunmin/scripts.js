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
navOverlay.addEventListener('click', closeMenu);

// Project data
const projectData = {
    project1: {
        title: "3D Instance Segmentation",
        subtitle: "資訊工程",
        details: {
            "專題所屬的領域": "資訊工程",
            "教授": "孫民",
            "建議先修或相關課程 / 需要自學的內容": "機器學習（概論 / 導論）、機器視覺",
            "需要熟練的軟體 / 網站 / 程式語言": "Python",
            "什麼時候開始找的（開始做專題的當學期往前算）": "前一學期中，專題說明會前",
            "有沒有面試": "沒有",
            "專題的成績門檻": "當初沒有提供教授成績",
            "Meeting 模式": "主要與研究生討論",
            "Meeting 頻率": "每週一次以上",
            "專題loading": "相當於1～2個電機系主科",
            "教授會不會希望專題生研究所繼續待在實驗室": "否",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "是",
            "給這個專題幾分（滿分10分）": "8"
        },
        experience: "自由度很高，基本上要和研究生一起討論題目，我自評專業知識不足，很吃力。"
    },
};

// Navigation functions
function showProjectList() {
    document.getElementById('projectListView').classList.remove('hidden');
    document.getElementById('projectDetailView').classList.add('hidden');
    window.scrollTo(0, 0);
}

function showProjectDetail(projectId) {
    const project = projectData[projectId];
    if (!project) return;

    // Update detail view content
    document.getElementById('detailTitle').textContent = project.title;
    document.getElementById('detailSubtitle').textContent = project.subtitle;

    // Build detail content
    let detailHTML = `
        <!--<h2>${project.title}</h2>-->
        <div class="project-info-grid">
    `;

    Object.entries(project.details).forEach(([key, value]) => {
        detailHTML += `
            <div class="info-item">
                <span class="info-label">${key}</span>
                <span class="info-value">${value}</span>
            </div>
        `;
    });

    detailHTML += `
        </div>
        <h3>心得</h3>
        <div class="experience-section">
            <p>${project.experience}</p>
        </div>
    `;

    document.getElementById('projectDetailContent').innerHTML = detailHTML;

    // Switch views
    document.getElementById('projectListView').classList.add('hidden');
    document.getElementById('projectDetailView').classList.remove('hidden');
    window.scrollTo(0, 0);
}

// Header scroll effect
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

// Close menu when clicking nav links
document.querySelectorAll('.nav-link').forEach(link => {
    link.addEventListener('click', closeMenu);
});