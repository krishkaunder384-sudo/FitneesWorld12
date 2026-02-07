<%@ page import="com.gym_website.entities.User" %>

<nav id="fwNavbar" class="navbar navbar-expand-lg fw-navbar fixed-top">

    <a class="navbar-brand fw-brand"
       href="<%= request.getContextPath() %>/index.jsp">
        <span>Fitness</span>World
    </a>

    <button class="navbar-toggler fw-toggler" type="button"
            data-toggle="collapse"
            data-target="#navbarContent">
        ☰
    </button>

    <div class="collapse navbar-collapse" id="navbarContent">

        <ul class="navbar-nav mx-auto fw-menu">
            <li class="nav-item">
                <a class="nav-link fw-link" href="<%= request.getContextPath() %>/index.jsp">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link fw-link" href="<%= request.getContextPath() %>/public-trainers.jsp">Trainers</a>
            </li>
            <li class="nav-item">
                <a class="nav-link fw-link" href="<%= request.getContextPath() %>/memberships">Memberships</a>
            </li>
            <li class="nav-item">
                <a class="nav-link fw-link" href="<%= request.getContextPath() %>/nearbygym/nearbygym.jsp">Nearby Gyms</a>
            </li>
            <li class="nav-item">
                <a class="nav-link fw-link" href="<%= request.getContextPath() %>/about-us.jsp">About</a>
            </li>
            <li class="nav-item">
                <a class="nav-link fw-link" href="<%= request.getContextPath() %>/contact-us.jsp">Contact</a>
            </li>
        </ul>

        <ul class="navbar-nav align-items-center fw-actions">

            <li class="nav-item">
                <button id="themeToggle" class="fw-theme-toggle">
                    <i class="fa fa-moon"></i>
                </button>
            </li>

            <%
                User navUser = (User) session.getAttribute("currentUser");
            %>

            <% if (navUser != null) { %>
                <li class="nav-item fw-user">
                    Hi, <strong><%= navUser.getName() %></strong>
                </li>
                <li class="nav-item">
                    <a class="btn fw-btn-outline"
                       href="<%= request.getContextPath() %>/user-dashboard">
                        Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="btn fw-btn-danger"
                       href="<%= request.getContextPath() %>/logoutservlet">
                        Logout
                    </a>


                </li>
            <% } else { %>
                <li class="nav-item">
                    <a class="btn fw-btn-outline"
                       href="<%= request.getContextPath() %>/login.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="btn fw-btn-danger"
                       href="<%= request.getContextPath() %>/signup.jsp">Sign Up</a>
                </li>
            <% } %>
        </ul>
    </div>
</nav>

<style>
.fw-navbar {
    height: 78px;
    background: rgba(10,10,10,0.9);
    backdrop-filter: blur(14px);
    padding: 0 36px;
    display: flex;
    align-items: center;
    z-index: 1000;
}

.fw-navbar.scrolled {
    box-shadow: 0 12px 28px rgba(0,0,0,0.6);
}

.fw-brand {
    font-size: 1.7rem;
    font-weight: 800;
    color: #fff !important;
}

.fw-brand span {
    color: #ff2e2e;
}

.fw-menu .fw-link {
    color: #ddd !important;
    margin: 0 14px;
    position: relative;
}

.fw-menu .fw-link::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: -6px;
    width: 0;
    height: 2px;
    background: #ff2e2e;
    transition: width 0.3s ease;
}

.fw-menu .fw-link:hover::after {
    width: 100%;
}

.fw-actions .nav-item {
    margin-left: 12px;
}

.fw-btn-outline {
    border: 1px solid #fff;
    color: #fff;
    padding: 6px 16px;
    border-radius: 25px;
}

.fw-btn-danger {
    background: #ff2e2e;
    color: #fff;
    padding: 6px 18px;
    border-radius: 25px;
}

.fw-theme-toggle {
    background: transparent;
    border: 1px solid #444;
    color: #fff;
    width: 38px;
    height: 38px;
    border-radius: 50%;
}
</style>

<script>
window.addEventListener("scroll", () => {
    document.getElementById("fwNavbar")
        .classList.toggle("scrolled", window.scrollY > 20);
});
</script>
