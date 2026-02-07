<%@ page import="com.gym_website.entities.User" %>

<%
    User user = (User) session.getAttribute("currentUser");
%>

<nav class="navbar navbar-expand-lg navbar-dark fw-navbar fixed-top">

    <!-- BRAND -->
    <a class="navbar-brand fw-brand"
       href="<%= request.getContextPath() %>/index.jsp">
        <img src="<%= request.getContextPath() %>/assets/fitness-world.png"
             style="width:40px;">
        <span>Fitness</span>World
    </a>

    <!-- TOGGLER -->
    <button class="navbar-toggler" type="button"
            data-toggle="collapse"
            data-target="#fwNavbar">
        ☰
    </button>

    <!-- CONTENT -->
    <div class="collapse navbar-collapse" id="fwNavbar">

        <!-- LEFT -->
        <ul class="navbar-nav mx-auto">

            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/index.jsp">
                    Home
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link"
                   href="<%= request.getContextPath() %>/nearbygym/nearbygym.jsp">
                    Nearby Gyms
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link"
                   href="<%= request.getContextPath() %>/public-trainers.jsp">
                    Trainers
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link"
                   href="<%= request.getContextPath() %>/memberships">
                    Memberships
                </a>
            </li>

        </ul>

        <!-- RIGHT -->
        <ul class="navbar-nav align-items-center">

            <% if (user != null) { %>

                <li class="nav-item text-white mr-3">
                    Hi, <strong><%= user.getName() %></strong>
                </li>

                <li class="nav-item">
                    <a class="btn btn-outline-light btn-sm mr-2"
                       href="<%= request.getContextPath() %>/user-dashboard">
                        Dashboard
                    </a>
                </li>

                <li class="nav-item">
                    <a class="btn btn-danger btn-sm"
                       href="<%= request.getContextPath() %>/logoutservlet">
                        Logout
                    </a>
                </li>

            <% } else { %>

                <li class="nav-item">
                    <a class="btn btn-outline-light btn-sm mr-2"
                       href="<%= request.getContextPath() %>/login.jsp">
                        Login
                    </a>
                </li>

                <li class="nav-item">
                    <a class="btn btn-danger btn-sm"
                       href="<%= request.getContextPath() %>/signup.jsp">
                        Sign Up
                    </a>
                </li>

            <% } %>

        </ul>
    </div>
</nav>
