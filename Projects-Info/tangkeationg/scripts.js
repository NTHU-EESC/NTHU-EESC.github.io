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
        title: "電子鼻於系統應用的相關演算法",
        subtitle: "詳細了解「電子鼻於系統應用的相關演算法」專題",
        details: {
            "專題所屬的領域": "機器學習",
            "教授": "鄭桂忠",
            "建議先修或相關課程 / 需要自學的內容": "機器學習",
            "需要熟練的軟體 / 網站 / 程式語言": "MATLAB, CST Studio Suite, ADS",
            "什麼時候開始找的（開始做專題的當學期往前算）": "前一學期開學後一個月",
            "有沒有面試": "有",
            "專題的成績門檻": "電磁學成績B+以上",
            "Meeting 模式": "固定時間meeting",
            "Meeting 頻率": "雙週一次",
            "專題loading": "中等，和電機系主科差不多",
            "教授會不會希望專題生研究所繼續待在實驗室": "不會強求",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "會鼓勵但不強制",
            "給這個專題幾分（滿分10分）": "9"
        },
        experience: "這個專題很適合對通訊系統有興趣的同學。王教授人很好，不會給太大壓力，但又能學到實用的技能。5G是很熱門的領域，做這個專題對找工作很有幫助。實驗室氣氛很好，同學們都很友善互助。唯一缺點可能是需要花比較多時間學習電磁模擬軟體。"
    }
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