<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
    if (session.getAttribute("currentUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Map<String, String>> bookings =
            (List<Map<String, String>>) request.getAttribute("bookings");
%>

<!-- ✅ HEADER -->
<%@ include file="header.jsp" %>

<!-- ✅ NAVBAR -->
<%@ include file="navbar.jsp" %>

<div class="container mt-5"
     style="
        max-width:1000px;
        background:#fff;
        padding:30px;
        border-radius:16px;
        box-shadow:0 15px 30px rgba(0,0,0,0.12);
     ">

    <h2 class="text-center mb-4">My Bookings</h2>

    <% if (bookings == null || bookings.isEmpty()) { %>

        <div class="text-center text-muted py-4">
            You have not booked any sessions yet.
        </div>

    <% } else { %>

        <table class="table table-bordered text-center">
            <thead class="bg-primary text-white">
            <tr>
                <th>Trainer</th>
                <th>Date</th>
                <th>Time</th>
                <th>Status</th>
                <th>Payment</th>
            </tr>
            </thead>

            <tbody>
            <% for (Map<String, String> b : bookings) { %>
                <tr>
                    <td><%= b.get("trainerName") %></td>
                    <td><%= b.get("date") %></td>
                    <td><%= b.get("time") %></td>

                    <td>
                        <span class="badge
                            <%= "PENDING".equals(b.get("status")) ? "badge-warning" :
                                "APPROVED".equals(b.get("status")) ? "badge-success" :
                                "badge-danger" %>">
                            <%= b.get("status") %>
                        </span>

                        <% if ("PENDING".equals(b.get("status"))) { %>
                            <form action="<%= request.getContextPath() %>/cancel-booking"
                                  method="post" class="mt-2">
                                <input type="hidden" name="bookingId"
                                       value="<%= b.get("id") %>">
                                <button class="btn btn-sm btn-danger"
                                        onclick="return confirm('Cancel this booking?');">
                                    Cancel
                                </button>
                            </form>
                        <% } %>
                    </td>

                    <td>
                        <% if ("APPROVED".equals(b.get("status"))
                               && "UNPAID".equals(b.get("payment_status"))) { %>

                            <form action="<%= request.getContextPath() %>/payment.jsp" method="get">

                                <input type="hidden" name="bookingId"
                                       value="<%= b.get("id") %>">
                                <button class="btn btn-sm btn-success">
                                    Pay Now
                                </button>
                            </form>

                        <% } else if ("PAID".equals(b.get("payment_status"))) { %>
                            <span class="badge badge-info">PAID</span>
                        <% } else { %>
                            —
                        <% } %>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>

    <% } %>

    <div class="text-center mt-4">
        <a href="public-trainers.jsp" class="btn btn-light">
            ← Back to Trainers
        </a>
    </div>
</div>

<%@ include file="script.jsp" %>

</body>
</html>
