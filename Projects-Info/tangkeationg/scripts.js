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
        subtitle: "機器學習",
        details: {
            "專題所屬的領域": "機器學習",
            "教授": "鄭桂忠",
            "建議先修或相關課程 / 需要自學的內容": "機器學習",
            "需要熟練的軟體 / 網站 / 程式語言": "Python",
            "什麼時候開始找的（開始做專題的當學期往前算）": "前一學期末，專題說明會後",
            "有沒有面試": "有",
            "專題的成績門檻": "有告知教授成績，但應該沒參考",
            "Meeting 模式": "須自行與教授和研究生約時間",
            "Meeting 頻率": "每週一次",
            "專題loading": "比電機系主科還輕鬆",
            "教授會不會希望專題生研究所繼續待在實驗室": "否",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "否",
            "給這個專題幾分（滿分10分）": "10"
        },
        experience: "如果想走ic還是建議做電路專題，台交不少有名的老師會看。這個專題滿水的，要考研或是有其他規劃的可以做。但你積極主動的學也是可以學到滿多系統概念的，我在面其他系所時，教授對這個題目印象都很深刻。體感上有加分效果。"
    },
    project2: {
        title: "Spiking Neural Network",
        subtitle: "數位電路設計",
        details: {
            "專題所屬的領域": "數位電路設計",
            "教授": "鄭桂忠",
            "建議先修或相關課程 / 需要自學的內容": "機器學習、邏輯設計實驗",
            "需要熟練的軟體 / 網站 / 程式語言": "Python、Verilog",
            "什麼時候開始找的（開始做專題的當學期往前算）": "前一學期中，專題說明會前",
            "有沒有面試": "有",
            "專題的成績門檻": "由助教評審",
            "Meeting 模式": "主要與研究生討論",
            "Meeting 頻率": "兩週一次",
            "專題loading": "相當於2個電機系主科",
            "教授會不會希望專題生研究所繼續待在實驗室": "否",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "否",
            "給這個專題幾分（滿分10分）": "6"
        },
        experience: "鄭桂忠的數位專題基本上會是 2 個 topic，每一個 topic 2 組人，每一組是 2-3 人。<br/>\
                數位會分成 DNN & SNN，基本上都是要做 hardware implemenation，但是 25 級好像有一組只有做 software code。DNN 似乎近年來都會做 CNN，我猜之後可能會往 transformer 做，那 SNN 就那樣，弄懂SNN 就花了 3 個月吧。\
                過程：全部都是對助教報，不會遇到教授。<br/>\
                先修：建議機器學習(清大現在沒有好的 ML 了，大概除了吳尚鴻深度學習 & 孫民機器學習)<br/>\
                邏設實驗面試：基本上會問兩個：<br/>\
                1. ML 會問一些智障到靠北的題目，完全不難，阿我就不洩題了，但就真的很白痴，修過 ML就基本上完全不用準備。 (除非你是楊雅棠，他的 ML 我不評論)。<br/>\
                2. verilog，基本上就是就是問你一些邏設實驗的題目；我覺得對於 1 年半沒有碰過 verilog 的人是真的非常需要複習。"
    },
    project3: {
        title: "SAR ADC",
        subtitle: "類比電路設計",
        details: {
            "專題所屬的領域": "類比電路設計",
            "教授": "鄭桂忠",
            "建議先修或相關課程 / 需要自學的內容": "AIC、電子學、畫 layout 的技巧",
            "需要熟練的軟體 / 網站 / 程式語言": "Hspice",
            "什麼時候開始找的（開始做專題的當學期往前算）": "前一學期末，專題說明會後",
            "有沒有面試": "有",
            "專題的成績門檻": "僅有告知成績，但不用到最頂",
            "Meeting 模式": "須自行與教授和研究生約時間",
            "Meeting 頻率": "不固定",
            "專題loading": "相當於2個電機系主科",
            "教授會不會希望專題生研究所繼續待在實驗室": "否",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "否",
            "給這個專題幾分（滿分10分）": "8"
        },
        experience: "無。"
    },
    project4: {
        title: "Low Dropout Regulator",
        subtitle: "類比電路設計",
        details: {
            "專題所屬的領域": "類比電路設計",
            "教授": "鄭桂忠",
            "建議先修或相關課程 / 需要自學的內容": "電子學一、電子學二、訊號與系統",
            "需要熟練的軟體 / 網站 / 程式語言": "Hspice、Virtuoso",
            "什麼時候開始找的（開始做專題的當學期往前算）": "專題當學期的前一個寒/暑假",
            "有沒有面試": "有",
            "專題的成績門檻": "有告知教授成績，系排前10%",
            "Meeting 模式": "主要與研究生討論",
            "Meeting 頻率": "每週一次",
            "專題loading": "相當於2個電機系主科",
            "教授會不會希望專題生研究所繼續待在實驗室": "否",
            "實驗室會不會 push 大家去比賽、實習、發 paper": "否",
            "給這個專題幾分（滿分10分）": "6"
        },
        experience: "要知道自己要做甚麼，學長很樂意討論，但也不會刻意推進度。所以專題做得好壞，取決於自己有多努力。"
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