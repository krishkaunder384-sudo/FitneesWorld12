<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<%
   Boolean admin = (Boolean) session.getAttribute("admin");
              if (admin == null || !admin) {
                  response.sendRedirect(request.getContextPath() + "/login.jsp?type=admin");
                  return;
   }   %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Members | FitnessWorld Admin</title>

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
            margin-left: 270px; /* match admin sidebar */
            padding: 40px;
        }

        .page-header {
            background: #ffffff;
            padding: 30px;
            border-radius: 18px;
            box-shadow: 0 18px 40px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .page-header h2 span {
            color: #ff2e2e;
        }

        /* TABLE CARD */
        .table-card {
            background: #ffffff;
            padding: 25px;
            border-radius: 18px;
            box-shadow: 0 18px 40px rgba(0,0,0,0.1);
        }

        /* SEARCH */
        .search-box input {
            border-radius: 30px;
            padding: 10px 20px;
        }

        /* TABLE */
        table {
            margin-top: 20px;
        }

        thead {
            background: #111;
            color: #fff;
        }

        th {
            border: none !important;
            font-weight: 600;
            text-align: center;
        }

        td {
            vertical-align: middle;
            text-align: center;
        }

        tbody tr {
            transition: background 0.3s ease;
        }

        tbody tr:hover {
            background: #f1f1f1;
        }

        /* EMPTY */
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

<!-- ✅ COMMON ADMIN SIDEBAR -->
<%@ include file="adminSidebar.jsp" %>

<div class="page-container">

    <!-- HEADER -->
    <div class="page-header">
        <h2>Members <span>Management</span></h2>
        <p class="text-muted mb-0">
            View and manage registered members on FitnessWorld.
        </p>
    </div>

    <!-- TABLE CARD -->
    <div class="table-card">

        <!-- SEARCH -->
        <div class="row mb-3">
            <div class="col-md-4 search-box">
                <input type="text"
                       id="searchInput"
                       class="form-control"
                       placeholder="Search by name / email / mobile...">
            </div>
        </div>

        <%
            boolean hasRows = false;
        %>

        <!-- TABLE -->
        <div class="table-responsive">
            <table class="table table-hover" id="membersTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Gender</th>
                    <th>DOB</th>
                    <th>Address</th>
                </tr>
                </thead>

                <tbody>
                <%
                    try (Connection con = ConnectionProvider.getConnection()) {

                        String sql = "SELECT id, name, email, mobile, gender, dob, address FROM users ORDER BY id DESC";
                        try (PreparedStatement ps = con.prepareStatement(sql);
                             ResultSet rs = ps.executeQuery()) {

                            while (rs.next()) {
                                hasRows = true;
                %>
                                <tr>
                                    <td><%= rs.getInt("id") %></td>
                                    <td><%= rs.getString("name") %></td>
                                    <td><%= rs.getString("email") %></td>
                                    <td><%= rs.getString("mobile") %></td>
                                    <td><%= rs.getString("gender") %></td>
                                    <td><%= rs.getString("dob") %></td>
                                    <td><%= rs.getString("address") %></td>
                                </tr>
                <%
                            }
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                        <tr>
                            <td colspan="7" class="text-danger text-center">
                                Error loading members.
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
                <i class="fa fa-users-slash fa-2x mb-3"></i><br>
                No members found.
            </div>
        <% } %>

    </div>

</div>

<!-- SEARCH SCRIPT -->
<script>
    document.getElementById("searchInput").addEventListener("keyup", function () {
        const value = this.value.toLowerCase();
        const rows = document.querySelectorAll("#membersTable tbody tr");

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
