<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
    if (session.getAttribute("currentTrainer") == null) {
        response.sendRedirect("trainer-login.jsp");
        return;
    }

    List<Map<String, String>> bookings =
            (List<Map<String, String>>) request.getAttribute("bookings");

    String msg = (String) session.getAttribute("msg");
    if (msg != null) session.removeAttribute("msg");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Trainer Bookings | FitnessWorld</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>
        body{
            background:#0b0b0b;
            color:#e5e7eb;
            font-family:Poppins, Arial, sans-serif;
            padding: 70px 0;
        }
        .box{
            max-width:1100px;
            margin:auto;
            background:rgba(20,20,20,0.95);
            padding:30px;
            border-radius:18px;
            box-shadow:0 25px 50px rgba(0,0,0,0.6);
        }
        h2{
            text-align:center;
            margin-bottom:25px;
            font-weight:700;
        }
        table{
            color:#fff;
        }
        .badge{
            padding:8px 12px;
            border-radius:20px;
        }
    </style>
</head>

<body>

<div class="box">

    <h2>📅 My Session Bookings</h2>

    <% if (msg != null) { %>
        <div class="alert alert-info text-center"><%= msg %></div>
    <% } %>

    <% if (bookings == null || bookings.isEmpty()) { %>
        <div class="text-center text-muted">
            No bookings received yet.
        </div>
    <% } else { %>

        <div class="table-responsive">
            <table class="table table-bordered table-dark text-center">
                <thead>
                <tr>
                    <th>User</th>
                    <th>Email</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Payment</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>
                <% for(Map<String,String> b: bookings){ %>
                    <tr>
                        <td><%= b.get("userName") %></td>
                        <td><%= b.get("userEmail") %></td>
                        <td><%= b.get("date") %></td>
                        <td><%= b.get("time") %></td>

                        <td>
                            <span class="badge
                                <%= "PENDING".equals(b.get("status")) ? "badge-warning" :
                                    "APPROVED".equals(b.get("status")) ? "badge-success" :
                                    "REJECTED".equals(b.get("status")) ? "badge-danger" :
                                    "badge-secondary" %>">
                                <%= b.get("status") %>
                            </span>
                        </td>

                        <td>
                            <%= b.get("payment_status") %>
                        </td>

                        <td>
                            <% if ("PENDING".equals(b.get("status"))) { %>
                                <form action="<%=request.getContextPath()%>/trainer-update-booking" method="post" style="display:inline;">
                                    <input type="hidden" name="bookingId" value="<%= b.get("id") %>">
                                    <input type="hidden" name="status" value="APPROVED">
                                    <button class="btn btn-sm btn-success">Approve</button>
                                </form>

                                <form action="<%=request.getContextPath()%>/trainer-update-booking" method="post" style="display:inline;">
                                    <input type="hidden" name="bookingId" value="<%= b.get("id") %>">
                                    <input type="hidden" name="status" value="REJECTED">
                                    <button class="btn btn-sm btn-danger">Reject</button>
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

    <div class="text-center mt-4">
        <a href="<%= request.getContextPath() %>/trainer-dashboard"
           class="btn btn-outline-light btn-sm">
            ← Back to Dashboard
        </a>
    </div>

</div>

</body>
</html>
