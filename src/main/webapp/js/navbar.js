// FitnessWorld - Navbar Scroll Animation

document.addEventListener("DOMContentLoaded", function () {
    const navbar = document.getElementById("fwNavbar");
    if (!navbar) return;

    window.addEventListener("scroll", function () {
        if (window.scrollY > 50) {
            navbar.classList.add("scrolled");
        } else {
            navbar.classList.remove("scrolled");
        }
    });
});
