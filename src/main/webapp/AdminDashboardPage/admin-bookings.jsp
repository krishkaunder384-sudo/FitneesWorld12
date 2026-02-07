<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gym_website.dao.BookingDao" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<%
    // 🔐 Admin login check
    Boolean admin = (Boolean) session.getAttribute("admin");
    if (admin == null || !admin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?type=admin");
        return;
    }

    BookingDao dao = new BookingDao(ConnectionProvider.getConnection());
    List<Map<String, String>> bookings = dao.getAllBookings();
    if (bookings == null) {
        bookings = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Bookings | FitnessWorld Admin</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            background: #f4f6f9;
            font-family: "Poppins", Arial, sans-serif;
        }

        .page-container {
            margin-left: 270px;
            padding: 45px;
        }

        .page-header {
            background: #ffffff;
            padding: 32px;
            border-radius: 22px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.12);
            margin-bottom: 35px;
        }

        .page-header span {
            color: #ff2e2e;
        }

        .table-card {
            background: #ffffff;
            padding: 30px;
            border-radius: 22px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.12);
        }

        table { margin-top: 20px; }

        thead {
            background: #000;
            color: #fff;
        }

        th {
            font-weight: 600;
            text-align: center;
            border: none !important;
            padding: 14px;
        }

        td {
            text-align: center;
            vertical-align: middle;
            padding: 14px;
        }

        tbody tr:hover {
            background: #f1f3f5;
        }

        .badge-status {
            padding: 6px 16px;
            border-radius: 999px;
            font-size: 0.75rem;
            font-weight: 700;
        }

        .badge-pending { background: #facc15; color: #000; }
        .badge-approved { background: #22c55e; color: #fff; }
        .badge-rejected { background: #ef4444; color: #fff; }

        .btn-action {
            border-radius: 999px;
            font-size: 0.75rem;
            padding: 6px 16px;
            border: none;
            font-weight: 600;
        }

        .btn-approve { background: #22c55e; color: #fff; }
        .btn-reject { background: #ef4444; color: #fff; }

        .empty {
            text-align: center;
            padding: 50px;
            color: #6b7280;
            font-weight: 500;
        }

        @media (max-width: 992px) {
            .page-container {
                margin-left: 0;
                padding: 25px;
            }
        }
    </style>
</head>

<body>

<%@ include file="adminSidebar.jsp" %>

<div class="page-container">

    <div class="page-header">
        <h2>Booking <span>Management</span></h2>
        <p class="text-muted mb-0">
            Review, approve, or reject trainer booking requests.
        </p>
    </div>

    <div class="table-card">

        <% if (bookings.isEmpty()) { %>
            <div class="empty">
                <i class="fa fa-calendar-xmark fa-2x mb-3"></i><br>
                No booking requests found.
            </div>
        <% } else { %>

            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Trainer</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>

                    <% for (Map<String, String> b : bookings) { %>
                        <tr>
                            <td><%= b.get("userName") %></td>
                            <td><%= b.get("trainerName") %></td>
                            <td><%= b.get("date") %></td>
                            <td><%= b.get("time") %></td>

                            <td>
                                <% String status = b.get("status"); %>

                                <% if ("PENDING".equals(status)) { %>
                                    <span class="badge-status badge-pending">PENDING</span>
                                <% } else if ("APPROVED".equals(status)) { %>
                                    <span class="badge-status badge-approved">APPROVED</span>
                                <% } else { %>
                                    <span class="badge-status badge-rejected">REJECTED</span>
                                <% } %>
                            </td>

                            <td>
                                <% if ("PENDING".equals(status)) { %>

                                    <form action="<%= request.getContextPath() %>/UpdateBookingStatusServlet"
                                          method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="<%= b.get("id") %>">
                                        <input type="hidden" name="status" value="APPROVED">
                                        <button class="btn-action btn-approve">
                                            <i class="fa fa-check"></i> Approve
                                        </button>
                                    </form>

                                    <form action="<%= request.getContextPath() %>/UpdateBookingStatusServlet"
                                          method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="<%= b.get("id") %>">
                                        <input type="hidden" name="status" value="REJECTED">
                                        <button class="btn-action btn-reject">
                                            <i class="fa fa-times"></i> Reject
                                        </button>
                                    </form>

                                <% } else { %>
                                    —
                                <% } %>
                            </td>
                        </tr>
                    <% } %>

                    </tbody>
                </table>
            </div>

        <% } %>
    </div>

</div>

</body>
</html>
