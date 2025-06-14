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
        title: "Open World Model",
        subtitle: "深度學習",
        details: {
            "專題所屬的領域": "深度學習",
            "教授": "吳尚鴻",
            "建議先修或相關課程 / 需要自學的內容": "機器學習（概論 / 導論）、深度學習",
            "需要熟練的軟體 / 網站 / 程式語言": "Python",
            "什麼時候開始找的（開始做專題的當學期往前算）": "超過一學期之前",
            "有沒有面試": "沒有",
            "專題的成績門檻": "有告知教授成績，但不用到最頂",
            "Meeting 模式": "分兩種： 大的是跟教授還有所有研究生，小的是自己跟助教約",
            "Meeting 頻率": "大的一週一次，小的兩週一次",
            "專題loading": "相當於2個電機系主科",
            "教授會不會希望專題生研究所繼續待在實驗室": "否",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "是",
            "給這個專題幾分（滿分10分）": "8"
        },
        experience: "時間: 3 下 4 上。<br/>\
                題目：Deep Learning (2025.2 月更新），和過去的都不一樣。<br/>\
                人數：1-2 人一組。<br/>\
                preequisite：他會叫你大三上修深度學習(CS)，課號是資工所的(還不保證你能簽到)。<br/>\
                找教授的方法：堵他，對，堵他軟實 (大概 3,4 月就要找)，我堵過他，堵了 2 個多小時，然後他會叫你丟給他 CV。<br/>\
                專題題目：可以分成 2 大類，3 大種領域：<br/>\
                第一類：偏向產學。<br/>\
                AI for education：<br/>\
                Topic 1：turning boring study materials into engaging stories.<br/>\
                Topic 2：Situational coach for language learners.<br/>\
                CV(Computer Vision):<br/>\
                Topic 3：Low cost, character-consistent image generation.(尋找fine tuning lowcost的方法)<br/>\
                Topic 4：AI-powered facilitars for online study/working groups.<br/>\
                第二類：RL<br/>\
                Reinforcement Learning<br/>\
                Topic 5：Automated GUI tester<br/>\
                Topic 6：Open-world RL agents<br/>\
                meeting 相關：<br/>\
                基本上都是對助教報，但都比較是探索性的，所以不一定有答案或者助教們知道結果。\
                一個月/還是一個學期 好像是會跟教授直接報一次。<br/>\
                Schedule:<br/>\
                4月：看paper<br/>\
                6月：(這個學期之前proposed兩個東西)：<br/>\
                1. 想要做的東西(unique value proposition / UVP 創見)<br/>\
                2. submit一個experiment plan (去嘗試解決research questions)<br/>\
                9月：(到暑假之前做玩的東西)：<br/>\
                Conduct experiment，確認結果，Collect data<br/>\
                10月：<br/>\
                正式的submit結果。(report presentation)"
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