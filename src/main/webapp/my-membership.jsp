<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("currentUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer userMembershipId = (Integer) request.getAttribute("userMembershipId");
    String planName = (String) request.getAttribute("planName");

    // ✅ IMPORTANT: You must send these from servlet
    String status = (String) request.getAttribute("status");              // ACTIVE / EXPIRED / PENDING
    String paymentStatus = (String) request.getAttribute("paymentStatus"); // PAID / UNPAID
    Double price = (Double) request.getAttribute("price");               // membership_plans price
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Membership | FitnessWorld</title>

    <!-- ✅ BOOTSTRAP -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- ✅ Razorpay Checkout -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>

<body>

<%@ include file="navbar.jsp" %>

<style>
    body {
        background: #0b0b0b;
        color: #e5e7eb;
        font-family: "Poppins", Arial, sans-serif;
        padding-top: 90px;
    }

    .membership-box {
        max-width: 520px;
        margin: auto;
        background: rgba(20,20,20,0.95);
        padding: 32px;
        border-radius: 18px;
        box-shadow: 0 25px 50px rgba(0,0,0,0.6);
        text-align: center;
    }

    .membership-box h2 {
        margin-bottom: 20px;
    }

    .membership-box p {
        color: #ccc;
        margin-bottom: 8px;
    }

    .status-badge {
        display: inline-block;
        padding: 6px 16px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        margin-top: 10px;
    }

    .status-active {
        background: #22c55e;
        color: #000;
    }

    .status-expired {
        background: #ef4444;
        color: #fff;
    }

    .status-pending {
        background: #f59e0b;
        color: #000;
    }

    .btn-renew {
        margin-top: 18px;
        display: inline-block;
        background: #f59e0b;
        border: none;
        border-radius: 30px;
        padding: 10px 24px;
        font-weight: 600;
        color: #000;
    }

    .btn-buy {
        background: #ff2e2e;
        border: none;
        border-radius: 30px;
        padding: 10px 24px;
        font-weight: 600;
        color: #fff;
    }

    .btn-pay {
        background: #22c55e;
        border: none;
        border-radius: 30px;
        padding: 10px 24px;
        font-weight: 700;
        color: #000;
        margin-top: 15px;
    }
</style>

<div class="membership-box">

    <h2>My Membership</h2>

    <%-- ✅ Optional message --%>
    <%
        Object msgObj = session.getAttribute("msg");
        if (msgObj != null) {
    %>
    <div class="alert alert-info text-center" style="border-radius:12px;">
        <%= msgObj.toString() %>
    </div>
    <%
            session.removeAttribute("msg");
        }
    %>

    <% if (planName == null) { %>

        <p>You do not have any membership yet.</p>

        <a href="<%= request.getContextPath() %>/memberships"
           class="btn btn-buy mt-3">
            Buy Membership
        </a>

    <% } else { %>

        <p><strong>Plan:</strong> <%= planName %></p>

        <p><strong>Start Date:</strong>
            <%= request.getAttribute("startDate") != null ? request.getAttribute("startDate") : "-" %>
        </p>

        <p><strong>Valid Till:</strong>
            <%= request.getAttribute("endDate") != null ? request.getAttribute("endDate") : "-" %>
        </p>

        <%-- ✅ Status badge --%>
        <%
            String badgeClass = "status-expired";
            if ("ACTIVE".equals(status)) badgeClass = "status-active";
            else if ("PENDING".equals(status)) badgeClass = "status-pending";
        %>

        <div class="status-badge <%= badgeClass %>">
            <%= status %>
            <% if (paymentStatus != null) { %>
                | <%= paymentStatus %>
            <% } %>
        </div>

        <%-- ✅ Pay Now button for pending unpaid membership --%>
        <% if ("PENDING".equals(status) && "UNPAID".equals(paymentStatus)) { %>

            <p class="mt-3" style="color:#bbb;">
                Payment required to activate membership.
            </p>

            <button type="button" class="btn btn-pay" onclick="payMembership()">
                Pay Now ₹<%= (price != null ? price : 0) %>
            </button>

        <% } %>

        <%-- ✅ Renew button when expired --%>
        <% if ("EXPIRED".equals(status)) { %>
            <div>
                <a href="<%= request.getContextPath() %>/memberships"
                   class="btn btn-renew">
                    Renew Membership
                </a>
            </div>
        <% } %>

    <% } %>

</div>

<script>
    async function payMembership() {

        const userMembershipId = "<%= userMembershipId != null ? userMembershipId : "" %>";
        const amount = "<%= price != null ? price.intValue() : 0 %>"; // rupees

        if (!userMembershipId || amount <= 0) {
            alert("Membership payment setup error (missing membershipId/amount).");
            return;
        }

        try {
            // ✅ create order
            const res = await fetch("<%= request.getContextPath() %>/create-membership-order", {
                method: "POST",
                headers: {"Content-Type": "application/x-www-form-urlencoded"},
                body: "userMembershipId=" + encodeURIComponent(userMembershipId)
                    + "&amount=" + encodeURIComponent(amount)
            });

            const data = await res.json();

            if (!data.success) {
                alert(data.message || "Order creation failed");
                return;
            }

            const options = {
                key: "<%= com.gym_website.config.RazorpayConfig.KEY_ID %>",
                amount: data.amount,
                currency: data.currency,
                name: "FitnessWorld",
                description: "Membership Payment",
                order_id: data.orderId,

                handler: function (response) {

                    // ✅ send verification data to backend
                    const form = document.createElement("form");
                    form.method = "POST";
                    form.action = "<%= request.getContextPath() %>/verify-membership-payment";

                    form.innerHTML =
                        '<input type="hidden" name="userMembershipId" value="' + userMembershipId + '"/>' +
                        '<input type="hidden" name="razorpay_payment_id" value="' + response.razorpay_payment_id + '"/>' +
                        '<input type="hidden" name="razorpay_order_id" value="' + response.razorpay_order_id + '"/>' +
                        '<input type="hidden" name="razorpay_signature" value="' + response.razorpay_signature + '"/>';

                    document.body.appendChild(form);
                    form.submit();
                },

                theme: { color: "#ff2e2e" }
            };

            const rzp = new Razorpay(options);
            rzp.open();

        } catch (err) {
            console.error(err);
            alert("Something went wrong while opening Razorpay.");
        }
    }
</script>

</body>
</html>
