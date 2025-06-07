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
        title: "XLSR-53 聲學模型微調在泰雅語語音學習之應用",
        subtitle: "數位訊號處理",
        details: {
            "專題所屬的領域": "數位訊號處理",
            "教授": "劉奕汶",
            "建議先修或相關課程 / 需要自學的內容": "機器學習、語音學（通識課：人類語言的奧秘）",
            "需要熟練的軟體 / 網站 / 程式語言": "Python",
            "什麼時候開始找的（開始做專題的當學期往前算）": "前一學期中，專題說明會前",
            "有沒有面試": "沒有",
            "專題的成績門檻": "有告知教授成績，但應該沒參考",
            "Meeting 模式": "面對教授+一堆研究生",
            "Meeting 頻率": "每週一次",
            "專題loading": "相當於1～2個電機系主科",
            "教授會不會希望專題生研究所繼續待在實驗室": "是",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "是",
            "給這個專題幾分（滿分10分）": "10"
        },
        experience: "第一學期主要是在學東西，但還是要參加每週的meeting聽學長姐報告，\
                原則上會有一個實驗室的學長姐帶專題。暑假開始實作並在第二學期間完成。\
                第一學期loading大概一個主科（大部分都是讀不同paper），\
                第二學期loading至少兩個主科。\
                教授人很好會提供專題一個大方向，並根據你們的專題進度看要不要新增其他的東西進去，\
                實驗室學長姐人也都蠻不錯的，可以從他們身上學到一些東西。"
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