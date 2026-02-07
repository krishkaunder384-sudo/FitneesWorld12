<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<%
    // 🔐 Admin login check
    Boolean admin = (Boolean) session.getAttribute("admin");
    if (admin == null || !admin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?type=admin");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Memberships | FitnessWorld Admin</title>

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

        thead {
            background: #000;
            color: #fff;
        }

        th, td {
            text-align: center;
            vertical-align: middle !important;
        }

        .search-box input {
            border-radius: 30px;
            padding: 10px 20px;
        }

        .empty {
            text-align: center;
            padding: 50px;
            color: #6b7280;
            font-weight: 600;
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
        <h2>Membership <span>Management</span></h2>
        <p class="text-muted mb-0">
            View all user memberships, plans, status and payment info.
        </p>
    </div>

    <div class="table-card">

        <div class="row mb-3">
            <div class="col-md-4 search-box">
                <input type="text"
                       id="searchInput"
                       class="form-control"
                       placeholder="Search by user, email, plan...">
            </div>
        </div>

        <%
            boolean hasRows = false;
        %>

        <div class="table-responsive">
            <table class="table table-bordered table-hover" id="membershipTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>User</th>
                    <th>Email</th>
                    <th>Plan</th>
                    <th>Start</th>
                    <th>End</th>
                    <th>Status</th>
                    <th>Payment</th>
                    <th>Order ID</th>
                    <th>Payment ID</th>
                </tr>
                </thead>
                <tbody>

                <%
                    try (Connection con = ConnectionProvider.getConnection()) {

                        if (con == null) {
                %>
                            <tr>
                                <td colspan="10" class="text-danger text-center">
                                    Database connection failed.
                                </td>
                            </tr>
                <%
                        } else {

                            String sql =
                                    "SELECT um.id, um.start_date, um.end_date, um.status, um.payment_status, " +
                                    "um.razorpay_order_id, um.razorpay_payment_id, " +
                                    "u.name AS user_name, u.email AS user_email, " +
                                    "mp.name AS plan_name " +
                                    "FROM user_memberships um " +
                                    "JOIN users u ON um.user_id = u.id " +
                                    "JOIN membership_plans mp ON um.plan_id = mp.id " +
                                    "ORDER BY um.id DESC";

                            try (PreparedStatement ps = con.prepareStatement(sql);
                                 ResultSet rs = ps.executeQuery()) {

                                while (rs.next()) {
                                    hasRows = true;

                                    String status = rs.getString("status");
                                    String payStatus = rs.getString("payment_status");

                                    String statusBadge =
                                            "ACTIVE".equalsIgnoreCase(status) ? "badge-success" :
                                            "PENDING".equalsIgnoreCase(status) ? "badge-warning" :
                                            "badge-danger";

                                    String payBadge =
                                            "PAID".equalsIgnoreCase(payStatus) ? "badge-success" :
                                            "badge-warning";
                %>
                                <tr>
                                    <td><%= rs.getInt("id") %></td>
                                    <td><%= rs.getString("user_name") %></td>
                                    <td><%= rs.getString("user_email") %></td>
                                    <td><%= rs.getString("plan_name") %></td>
                                    <td><%= rs.getString("start_date") %></td>
                                    <td><%= rs.getString("end_date") %></td>

                                    <td>
                                        <span class="badge <%= statusBadge %>">
                                            <%= status %>
                                        </span>
                                    </td>

                                    <td>
                                        <span class="badge <%= payBadge %>">
                                            <%= payStatus %>
                                        </span>
                                    </td>

                                    <td style="font-size:12px;">
                                        <%= rs.getString("razorpay_order_id") %>
                                    </td>

                                    <td style="font-size:12px;">
                                        <%= rs.getString("razorpay_payment_id") %>
                                    </td>
                                </tr>
                <%
                                }
                            }
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                        <tr>
                            <td colspan="10" class="text-danger text-center">
                                Error loading memberships.
                            </td>
                        </tr>
                <%
                    }
                %>

                </tbody>
            </table>
        </div>

        <% if (!hasRows) { %>
        <div class="empty">
            <i class="fa fa-id-card fa-2x mb-3"></i><br>
            No memberships found.
        </div>
        <% } %>

    </div>

</div>

<script>
    document.getElementById("searchInput").addEventListener("keyup", function () {
        const value = this.value.toLowerCase();
        const rows = document.querySelectorAll("#membershipTable tbody tr");

        rows.forEach(row => {
            row.style.display =
                row.innerText.toLowerCase().includes(value)
                    ? ""
                    : "none";
        });
    });
</script>

</body>
</html>
