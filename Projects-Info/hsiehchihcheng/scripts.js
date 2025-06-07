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
        title: "一具放電電流的電壓時間轉換器輔以時間數位轉換器的共模電壓基底每秒兩千萬次採樣之十位元的連續漸進式類比數位轉換器",
        subtitle: "類比電路設計",
        details: {
            "專題所屬的領域": "類比電路設計",
            "教授": "謝志成",
            "建議先修或相關課程 / 需要自學的內容": "VLSI、電子學二",
            "需要熟練的軟體 / 網站 / 程式語言": "Hspice、Matlab",
            "什麼時候開始找的（開始做專題的當學期往前算）": "前一學期中，專題說明會前",
            "有沒有面試": "有",
            "專題的成績門檻": "有告知教授成績，系排前30%",
            "Meeting 模式": "面對教授+一堆研究生",
            "Meeting 頻率": "每週一次",
            "專題loading": "相當於1個電機系主科",
            "教授會不會希望專題生研究所繼續待在實驗室": "是",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "否",
            "給這個專題幾分（滿分10分）": "7"
        },
        experience: "大家都說謝老師的專題很硬要下線，但我覺得主要是時間控管能力要好，而且要細心，不然很多事情其實很快就能解決，再加上實驗室學長姊都很樂意幫忙，不用擔心不知道該怎麼辦，只要勇敢問就好。"
    },
    project2: {
        title: "Sensor",
        subtitle: "類比電路設計",
        details: {
            "專題所屬的領域": "類比電路設計",
            "教授": "謝志成",
            "建議先修或相關課程 / 需要自學的內容": "VLSI、電子學二",
            "需要熟練的軟體 / 網站 / 程式語言": "Hspice",
            "什麼時候開始找的（開始做專題的當學期往前算）": "前一學期末，專題說明會後",
            "有沒有面試": "有",
            "專題的成績門檻": "有告知教授成績，系排前30%",
            "Meeting 模式": "面對教授+一堆研究生",
            "Meeting 頻率": "每週一次以上",
            "專題loading": "相當於2個電機系主科",
            "教授會不會希望專題生研究所繼續待在實驗室": "是",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "否",
            "給這個專題幾分（滿分10分）": "9"
        },
        experience: "無。"
    },
    project3: {
        title: "Noise Shaping SAR",
        subtitle: "類比電路設計",
        details: {
            "專題所屬的領域": "類比電路設計",
            "教授": "謝志成",
            "建議先修或相關課程 / 需要自學的內容": "VLSI、電子學二、AIC、DSP、控制系統",
            "需要熟練的軟體 / 網站 / 程式語言": "Hspice、Virtuoso",
            "什麼時候開始找的（開始做專題的當學期往前算）": "前一學期中，專題說明會前",
            "有沒有面試": "有",
            "專題的成績門檻": "僅有告知成績，但不用到最頂",
            "Meeting 模式": "大咪跟教授咪 小咪跟研究生咪",
            "Meeting 頻率": "一週一次大咪一次小咪",
            "專題loading": "相當於1～2個電機系主科",
            "教授會不會希望專題生研究所繼續待在實驗室": "是",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "否",
            "給這個專題幾分（滿分10分）": "7"
        },
        experience: "我覺得做專題要有一定的心理準備留出時間，以大三下16學分而言loading真的不算輕。實驗室學長姐都很好，不過很多東西還是要自己看懂比較好。"
    },
    project4: {
        title: "ADC",
        subtitle: "類比電路設計",
        details: {
            "專題所屬的領域": "類比電路設計",
            "教授": "謝志成",
            "建議先修或相關課程 / 需要自學的內容": "VLSI、電子學二",
            "需要熟練的軟體 / 網站 / 程式語言": "Hspice、Matlab",
            "什麼時候開始找的（開始做專題的當學期往前算）": "超過一年之前",
            "有沒有面試": "有",
            "專題的成績門檻": "有告知教授成績，但不用到最頂",
            "Meeting 模式": "單獨與教授討論",
            "Meeting 頻率": "兩週一次",
            "專題loading": "相當於2個以上電機系主科",
            "教授會不會希望專題生研究所繼續待在實驗室": "是",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "是",
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