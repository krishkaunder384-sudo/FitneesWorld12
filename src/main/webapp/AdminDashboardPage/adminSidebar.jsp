<style>
    .sidebar {
        position: fixed;
        width: 270px;
        height: 100vh;
        background: linear-gradient(180deg, #000, #1c1c1c);
        color: #fff;
        padding: 40px 20px;
        top: 0;
        left: 0;
        z-index: 999;
    }

    .sidebar h3 {
        text-align: center;
        margin-bottom: 50px;
        color: #ff2e2e;
        letter-spacing: 1px;
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
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .sidebar a:hover,
    .sidebar a.active {
        background: #ff2e2e;
        color: #fff;
    }
</style>

<div class="sidebar">
    <h3>FitnessWorld</h3>

    <a href="adminDashboard.jsp"><i class="fa fa-home"></i> Dashboard</a>
    <a href="membersList.jsp"><i class="fa fa-users"></i> Members</a>
    <a href="admin-bookings.jsp"><i class="fa fa-calendar-check"></i> Bookings</a>
    <a href="admin-user-memberships.jsp"><i class="fa fa-id-card"></i> Memberships</a>
    <a href="admin-workout-diet-overview.jsp"><i class="fa fa-dumbbell"></i> Workout & Diet Library</a>
    <a href="earningsOverview.jsp"><i class="fa fa-rupee-sign"></i> Earnings</a>
    <a href="gymSettings.jsp"><i class="fa fa-cog"></i> Settings</a>
    <a href="adminLogout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>
s