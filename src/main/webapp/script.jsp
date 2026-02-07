<!-- ================= GLOBAL JS ================= -->

<!-- jQuery (ONLY ONCE) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- SweetAlert -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

<!-- ================= TOAST SYSTEM ================= -->
<style>
.toast-container {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 9999;
}

.toast-msg {
    min-width: 280px;
    margin-bottom: 12px;
    padding: 14px 18px;
    border-radius: 12px;
    color: #fff;
    font-family: "Poppins", sans-serif;
    font-size: 0.9rem;
    box-shadow: 0 12px 30px rgba(0,0,0,0.25);
    animation: slideIn 0.5s ease;
}

.toast-success { background: #28a745; }
.toast-error   { background: #dc3545; }
.toast-info    { background: #007bff; }

@keyframes slideIn {
    from { transform: translateX(120%); opacity: 0; }
    to   { transform: translateX(0); opacity: 1; }
}
</style>

<div class="toast-container" id="toastContainer"></div>

<script>
function showToast(message, type = "info") {
    const toast = document.createElement("div");
    toast.className = `toast-msg toast-${type}`;
    toast.innerText = message;

    document.getElementById("toastContainer").appendChild(toast);

    setTimeout(() => {
        toast.style.opacity = "0";
        toast.style.transform = "translateX(120%)";
        setTimeout(() => toast.remove(), 400);
    }, 3000);
}
</script>

<!-- ================= SESSION MESSAGE HANDLER ================= -->
<%
    com.gym_website.entities.Message msg =
            (com.gym_website.entities.Message) session.getAttribute("msg");

    if (msg != null) {
%>
<script>
    showToast("<%= msg.getContent() %>",
        "<%= msg.getType().equals("error") ? "error" : "success" %>");
</script>
<%
        session.removeAttribute("msg");
    }
%>

<!-- ================= THEME SYSTEM ================= -->
<style>
:root {
    --bg: #0b0b0b;
    --card: #151515;
    --text: #ffffff;
    --muted: #aaaaaa;
    --accent: #ff2e2e;
}

body.light {
    --bg: #f4f6f9;
    --card: #ffffff;
    --text: #111111;
    --muted: #555555;
    --accent: #ff2e2e;
}

body {
    background: var(--bg);
    color: var(--text);
}

.card,
.auth-card,
.signup-card,
.dash-card,
.stat-card,
.chart-box {
    background: var(--card) !important;
    color: var(--text);
}

.text-muted {
    color: var(--muted) !important;
}
</style>

<script>
document.addEventListener("DOMContentLoaded", function () {

    const body = document.body;
    const themeToggle = document.getElementById("themeToggle");

    // Load saved theme
    const savedTheme = localStorage.getItem("fw-theme");
    if (savedTheme === "light") {
        body.classList.add("light");
        if (themeToggle) themeToggle.innerText = "☀️";
    }

    if (themeToggle) {
        themeToggle.addEventListener("click", function () {
            body.classList.toggle("light");

            const isLight = body.classList.contains("light");
            themeToggle.innerText = isLight ? "☀️" : "🌙";

            localStorage.setItem("fw-theme", isLight ? "light" : "dark");
        });
    }

});
</script>

<!-- ================= NAVBAR JS ================= -->
<script src="<%= request.getContextPath() %>/assets/js/navbar.js"></script>

<!-- ================= CUSTOM JS ================= -->
<script src="<%= request.getContextPath() %>/assets/js/index.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/signup.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/profile_edit.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/add_post.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/load_posts.js"></script>

</body>
</html>

<!-- ================= BUTTON LOADING ================= -->
<style>
.btn-loading {
    pointer-events: none;
    opacity: 0.8;
}

.btn-loading .spinner-border {
    width: 1rem;
    height: 1rem;
    margin-right: 8px;
}
</style>

<script>
document.addEventListener("DOMContentLoaded", function () {

    document.querySelectorAll("form").forEach(form => {
        form.addEventListener("submit", function () {

            const submitBtn = form.querySelector(
                'button[type="submit"], input[type="submit"]'
            );

            if (!submitBtn) return;

            const originalText = submitBtn.innerHTML;

            submitBtn.classList.add("btn-loading");
            submitBtn.disabled = true;

            submitBtn.innerHTML = `
                <span class="spinner-border spinner-border-sm"></span>
                Processing...
            `;

            setTimeout(() => {
                submitBtn.disabled = false;
                submitBtn.classList.remove("btn-loading");
                submitBtn.innerHTML = originalText;
            }, 8000);
        });
    });

});
</script>
