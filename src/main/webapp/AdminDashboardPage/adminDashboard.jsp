<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.sql.*" %>

<%@ page import="com.gym_website.admin.dao.*" %>
<%@ page import="com.gym_website.dao.BookingDao" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<%
    // 🔐 ADMIN SESSION CHECK
    Boolean admin = (Boolean) session.getAttribute("admin");
    if (admin == null || !admin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?type=admin");
        return;
    }

    String adminName = "Admin";

    // ================= DASHBOARD DATA =================
    List<Double> earnings = new ArrayList<>();
    int monthlyBookings = 0;
    int pendingPayments = 0;
    int customersEngaged = 0;

    try {
        DashboardDAO dao = new DashboardDAOImpl();

        earnings = dao.getEarnings();
        if (earnings == null) earnings = new ArrayList<>();

        monthlyBookings = dao.getMonthlyBookings();
        pendingPayments = dao.getPendingPayments();
        customersEngaged = dao.getCustomersEngaged();

    } catch (Exception e) {
        e.printStackTrace();
    }

    Locale india = new Locale("en", "IN");
    NumberFormat formatter = NumberFormat.getCurrencyInstance(india);

    double totalEarnings = earnings.stream()
            .mapToDouble(Double::doubleValue)
            .sum();

    String formattedTotalEarnings = formatter.format(totalEarnings);

    // ================= BOOKING STATS =================
    int totalBookings = 0;
    int pendingBookings = 0;
    int approvedBookings = 0;
    int rejectedBookings = 0;

    try {
        BookingDao bdao = new BookingDao(ConnectionProvider.getConnection());

        totalBookings = bdao.getTotalBookings();
        pendingBookings = bdao.getBookingCountByStatus("PENDING");
        approvedBookings = bdao.getBookingCountByStatus("APPROVED");
        rejectedBookings = bdao.getBookingCountByStatus("REJECTED");

    } catch (Exception e) {
        e.printStackTrace();
    }

    // ================= OTHER COUNTS =================
    int totalMembers = 0;
    int totalMembershipPlans = 0;
    int activeMemberships = 0;
    int workoutPlans = 0;
    int dietPlans = 0;

    try (Connection con = ConnectionProvider.getConnection()) {

        if (con != null) {

            try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM users");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) totalMembers = rs.getInt(1);
            }

            try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM membership_plans");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) totalMembershipPlans = rs.getInt(1);
            }

            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM user_memberships WHERE status='ACTIVE' AND payment_status='PAID'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) activeMemberships = rs.getInt(1);
            }

            try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM workout_plans");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) workoutPlans = rs.getInt(1);
            }

            try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM diet_plans");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) dietPlans = rs.getInt(1);
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    // 🚫 Prevent back button cache
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard | FitnessWorld</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body { margin: 0; font-family: Poppins, Arial, sans-serif; background: #f4f6f9; }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 25px;
        }

        .dashboard-card {
            background: #fff;
            padding: 30px;
            border-radius: 18px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.08);
            display: flex;
            align-items: center;
            gap: 20px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 45px rgba(0,0,0,0.12);
        }

        .dashboard-card h4 {
            margin: 0;
            font-size: 14px;
            color: #777;
        }

        .dashboard-card p {
            margin: 5px 0 0 0;
            font-size: 22px;
            font-weight: 700;
            color: #111;
        }

        .icon {
            font-size: 28px;
            color: #ff2e2e;
        }


        .sidebar {
            position: fixed;
            width: 270px;
            height: 100vh;
            background: linear-gradient(180deg, #000, #1c1c1c);
            color: #fff;
            padding: 40px 20px;
        }

        .sidebar h3 {
            text-align: center;
            margin-bottom: 50px;
            color: #ff2e2e;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #ddd;
            padding: 14px 18px;
            margin-bottom: 12px;
            border-radius: 14px;
            text-decoration: none;
        }

        .sidebar a:hover {
            background: #ff2e2e;
            color: #fff;
        }

        .main {
            margin-left: 270px;
            padding: 50px;
        }

        .card-box {
            background: #fff;
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.12);
            margin-bottom: 20px;
        }

        .stat {
            font-size: 20px;
            font-weight: 600;
        }
    </style>
</head>

<body>

<div class="sidebar">
    <h3>FitnessWorld</h3>

    <a href="<%= request.getContextPath() %>/AdminDashboardPage/adminDashboard.jsp">
        <i class="fa fa-home"></i> Dashboard
    </a>

    <a href="<%= request.getContextPath() %>/AdminDashboardPage/membersList.jsp">
        <i class="fa fa-users"></i> Members
    </a>

    <a href="<%= request.getContextPath() %>/AdminDashboardPage/admin-bookings.jsp">
        <i class="fa fa-calendar-check"></i> Bookings
    </a>

    <a href="<%= request.getContextPath() %>/AdminDashboardPage/admin-user-memberships.jsp">
        <i class="fa fa-id-card"></i> Memberships
    </a>

    <a href="<%= request.getContextPath() %>/AdminDashboardPage/admin-workout-diet-overview.jsp">
        <i class="fa fa-dumbbell"></i> Workout & Diet
    </a>

    <a href="<%= request.getContextPath() %>/AdminDashboardPage/earningsOverview.jsp">
        <i class="fa fa-rupee-sign"></i> Earnings
    </a>

    <a href="<%= request.getContextPath() %>/AdminDashboardPage/settingsPage.jsp">
        <i class="fa fa-cog"></i> Settings
    </a>

    <a href="<%= request.getContextPath() %>/adminlogout">
        <i class="fa fa-sign-out-alt"></i> Logout
    </a>
</div>

<div class="main">

    <h2 style="margin-bottom:30px;">
        Welcome back,
        <span style="color:#ff2e2e;"><%= adminName %></span> 👑
    </h2>

    <div class="dashboard-grid">

        <div class="dashboard-card">
            <i class="fa fa-rupee-sign icon"></i>
            <div>
                <h4>Total Earnings</h4>
                <p><%= formattedTotalEarnings %></p>
            </div>
        </div>

        <div class="dashboard-card">
            <i class="fa fa-users icon"></i>
            <div>
                <h4>Total Members</h4>
                <p><%= totalMembers %></p>
            </div>
        </div>

        <div class="dashboard-card">
            <i class="fa fa-id-card icon"></i>
            <div>
                <h4>Active Memberships</h4>
                <p><%= activeMemberships %></p>
            </div>
        </div>

        <div class="dashboard-card">
            <i class="fa fa-calendar-check icon"></i>
            <div>
                <h4>Total Bookings</h4>
                <p><%= totalBookings %></p>
            </div>
        </div>

        <div class="dashboard-card">
            <i class="fa fa-dumbbell icon"></i>
            <div>
                <h4>Workout Plans</h4>
                <p><%= workoutPlans %></p>
            </div>
        </div>

        <div class="dashboard-card">
            <i class="fa fa-apple-alt icon"></i>
            <div>
                <h4>Diet Plans</h4>
                <p><%= dietPlans %></p>
            </div>
        </div>

    </div>

</div>

</div>

</body>
</html>
