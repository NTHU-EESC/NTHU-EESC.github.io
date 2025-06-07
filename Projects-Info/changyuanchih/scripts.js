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
        title: "太陽能及風力發電之電能轉換器研製對於綠能屋儲能系統之應用",
        subtitle: "電力工程",
        details: {
            "專題所屬的領域": "電力工程",
            "教授": "張淵智",
            "建議先修或相關課程 / 需要自學的內容": "電力電子、控制系統，沒有也沒差",
            "需要熟練的軟體 / 網站 / 程式語言": "C",
            "什麼時候開始找的（開始做專題的當學期往前算）": "前一學期末，專題說明會後",
            "有沒有面試": "沒有",
            "專題的成績門檻": "當初沒有提供教授成績",
            "Meeting 模式": "寫進度報告寄給教授",
            "Meeting 頻率": "每月一次",
            "專題loading": "相當於1個電機系主科",
            "教授會不會希望專題生研究所繼續待在實驗室": "否",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "否",
            "給這個專題幾分（滿分10分）": "10"
        },
        experience: "無。"
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