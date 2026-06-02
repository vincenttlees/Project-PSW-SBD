// ===============================
// VIEW MENU BUTTON (HOME → MENU)
// ===============================
document.addEventListener("DOMContentLoaded", function () {
    const btn = document.getElementById("viewMenuBtn");
    if (btn) {
        btn.addEventListener("click", function () {
            window.location.href = "menu.php";
        });
    }
});

document.addEventListener("DOMContentLoaded", function () {

    const menuCards =
        document.querySelectorAll(".menu-card");

    const modal =
        document.getElementById("menuModal");

    const closeBtn =
        document.getElementById("closePopup");

    menuCards.forEach(card => {

        card.addEventListener("click", function () {

            const categoryID =
                card.getAttribute("data-category");

            fetch("getMenu.php?categoryID=" + categoryID)

            .then(response => response.json())

            .then(data => {

                document.getElementById("MenuName").innerText =
                    data.category;

                const container =
                    document.getElementById("menuList");

                container.innerHTML = "";

                data.menu.forEach(item => {

                    container.innerHTML += `

                        <div class="popup-menu-item">

                            <div class="popup-menu-top">

                                <h4>${item.MenuName}</h4>

                                <span class="popup-price">
                                    Rp ${Number(item.Price).toLocaleString("id-ID")}
                                </span>

                            </div>

                            <p>${item.ShortDesc}</p>

                        </div>

                    `;

                });
                console.log(modal);
                console.log(data);

                modal.style.display = "flex";

            })

            .catch(error => {

                console.log(error);

            });

        });

    });

    // close button
    closeBtn.addEventListener("click", function () {

        modal.style.display = "none";

    });

    // klik background
    modal.addEventListener("click", function (e) {

        if (e.target === modal) {

            modal.style.display = "none";

        }

    });

});

// ===============================
// BACK BUTTON
// ===============================
function goHome() {
    window.location.href = "index.php";
}

function goMenu() {
    window.location.href = "menu.php";
}

// ===============================
// SMOOTH SCROLL (NAVBAR)
// ===============================
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener("click", function (e) {
        e.preventDefault();

        const target = document.querySelector(this.getAttribute("href"));

        if (target) {
            target.scrollIntoView({
                behavior: "smooth"
            });
        }
    });
});

(function () {
    const track = document.querySelector(".review-track");
    const grid  = document.querySelector(".review-grid");
    if (!track || !grid) return;

    const cards     = track.querySelectorAll(".card");
    const total     = cards.length / 2;  // karena ada duplikat
    let current     = 0;
    let autoTimer   = null;
    let pauseTimer  = null;
    let isDragging  = false;
    let startX      = 0;
    let dragOffset  = 0;

    function getCardWidth() {
        return cards[0].offsetWidth + 20;  // 20 = gap
    }

    function goTo(index) {
        // loop balik ke awal tanpa animasi saat sampai duplikat
        if (index >= total) {
            track.style.transition = "none";
            current = 0;
            track.style.transform = `translateX(0px)`;
            // force reflow lalu aktifkan animasi lagi
            track.offsetHeight;
            track.style.transition = "transform 0.5s ease";
            index = 1;
        }
        current = index;
        track.style.transform = `translateX(-${current * getCardWidth()}px)`;
    }

    function next() {
        goTo(current + 1);
    }

    function startAuto() {
        stopAuto();
        autoTimer = setInterval(next, 4000);  // jeda per card (ms)
    }

    function stopAuto() {
        clearInterval(autoTimer);
    }

    function pauseThenResume() {
        stopAuto();
        clearTimeout(pauseTimer);
        pauseTimer = setTimeout(startAuto, 2500);  // resume setelah 1.5 detik
    }

    // ── DRAG / SCROLL MANUAL ──
    grid.addEventListener("mousedown", (e) => {
        isDragging = true;
        startX     = e.clientX;
        dragOffset = current * getCardWidth();
        grid.classList.add("dragging");
        stopAuto();
        track.style.transition = "none";
    });

    window.addEventListener("mousemove", (e) => {
        if (!isDragging) return;
        const diff = startX - e.clientX;
        track.style.transform = `translateX(-${dragOffset + diff}px)`;
    });

    window.addEventListener("mouseup", (e) => {
        if (!isDragging) return;
        isDragging = false;
        grid.classList.remove("dragging");
        track.style.transition = "transform 0.5s ease";

        const diff = startX - e.clientX;
        if (diff > 50)       goTo(current + 1);   // geser kiri
        else if (diff < -50) goTo(current - 1 < 0 ? 0 : current - 1);
        else                 goTo(current);        // kembalikan posisi

        pauseThenResume();
    });

    // touch support
    grid.addEventListener("touchstart", (e) => {
        startX     = e.touches[0].clientX;
        dragOffset = current * getCardWidth();
        stopAuto();
        track.style.transition = "none";
    });

    grid.addEventListener("touchend", (e) => {
        const diff = startX - e.changedTouches[0].clientX;
        track.style.transition = "transform 0.5s ease";
        if (diff > 50)       goTo(current + 1);
        else if (diff < -50) goTo(current - 1 < 0 ? 0 : current - 1);
        else                 goTo(current);
        pauseThenResume();
    });

    // hover pause
    grid.addEventListener("mouseenter", stopAuto);
    grid.addEventListener("mouseleave", startAuto);

    startAuto();
})();