function initializeModal() {
    const modal = document.querySelector(".custom-modal");
    const overlay = document.querySelector(".overlay");
    const openModalBtn = document.querySelector(".modal-btn-open");
    const closeModalBtn = document.querySelector(".modal-btn-close");

    if (modal && overlay && closeModalBtn) {
        const closeModal = function () {
            modal.classList.add("hidden-modal");
            overlay.classList.add("hidden-modal");
        };

        closeModalBtn.addEventListener("click", closeModal);
        overlay.addEventListener("click", closeModal);

        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape" && !modal.classList.contains("hidden-modal")) {
                closeModal();
            }
        });
    }

    if (openModalBtn) {
        const openModal = function () {
            window.scrollTo(0, 0);
            modal.classList.remove("hidden-modal");
            overlay.classList.remove("hidden-modal");
        };

        openModalBtn.addEventListener("click", openModal);
    }
}

document.addEventListener("DOMContentLoaded", initializeModal, { once: true });

document.addEventListener("turbo:load", initializeModal, { once: true });

