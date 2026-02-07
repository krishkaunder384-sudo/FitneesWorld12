<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gym_website.entities.*" %>

<%
    List<Membership> plans =
            (List<Membership>) request.getAttribute("plans");

    User currentUser =
            (User) session.getAttribute("currentUser");
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Membership Plans | FitnessWorld</title>

    <!-- ✅ BOOTSTRAP (REQUIRED) -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>

<body>

<%@ include file="navbar.jsp" %>

<style>
    body {
        background: #0b0b0b;
        color: #e5e7eb;
        font-family: "Poppins", Arial, sans-serif;
        padding-top: 90px; /* ✅ FIX navbar overlap */
    }

    .page-hero {
        text-align: center;
        padding: 40px 15px 40px;
    }

    .page-hero h1 span {
        color: #ff2e2e;
    }

    .membership-grid {
        max-width: 1200px;
        margin: auto;
        padding: 0 20px 80px;
    }

    .membership-card {
        background: rgba(20,20,20,0.95);
        border-radius: 18px;
        padding: 30px;
        display: flex;
            flex-direction: column;
            justify-content: space-between;
        text-align: center;
        box-shadow: 0 25px 50px rgba(0,0,0,0.6);
        transition: transform 0.35s ease;
        height: 100%;
    }

    .membership-card:hover {
        transform: translateY(-10px);
    }

    .membership-price {
        font-size: 2rem;
        font-weight: 800;
        color: #ff2e2e;
        margin: 20px 0 10px;
    }

    .membership-duration {
        font-size: 0.9rem;
        color: #aaa;
        margin-bottom: 20px;
    }

    .btn-buy {
        background: #ff2e2e;
        border: none;
        border-radius: 30px;
        padding: 10px;
        font-weight: 600;
        color: #fff;
    }

    .btn-buy:hover {
        background: #e60023;
    }

    .btn-login {
        background: #f59e0b;
        border-radius: 30px;
        padding: 10px;
        font-weight: 600;
        color: #000;
    }
</style>

<div class="page-hero">
    <h1>Membership <span>Plans</span></h1>
    <p class="text-muted">
        Choose a plan that fits your fitness journey
    </p>
</div>

<div class="membership-grid">
    <div class="row">

        <% if (plans == null || plans.isEmpty()) { %>

            <div class="col-12 text-center text-muted">
                No membership plans available right now.
            </div>

        <% } else {
            for (Membership m : plans) { %>

        <div class="col-md-4 mb-4">
            <div class="membership-card">

                <h4><%= m.getName() %></h4>
                <p><%= m.getDescription() %></p>

                <div class="membership-price">
                    ₹<%= m.getPrice() %>
                </div>

                <div class="membership-duration">
                    <%= m.getDurationDays() %> Days
                </div>

                <% if (currentUser != null) { %>
                    <button class="btn btn-buy btn-block"
                            onclick="payMembership(<%= m.getId() %>)">
                        Buy / Renew
                    </button>

                <% } else { %>
                    <a href="<%= request.getContextPath() %>/login.jsp"
                       class="btn btn-login btn-block">
                        Login to Buy
                    </a>
                <% } %>

            </div>
        </div>

        <% }} %>

    </div>
</div>

<!-- Razorpay Checkout -->
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<script>
async function payMembership(planId) {

    try {
        // ✅ STEP 1: Create pending membership row in DB
        let createMembershipRes = await fetch("<%= request.getContextPath() %>/buy-membership", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "planId=" + encodeURIComponent(planId)
        });

        let createMembershipData = await createMembershipRes.json();

        if (!createMembershipData.success) {
            alert("❌ " + createMembershipData.message);
            return;
        }

        let userMembershipId = createMembershipData.userMembershipId;

        // ✅ STEP 2: Create Razorpay Order
        let orderRes = await fetch("<%= request.getContextPath() %>/create-membership-order", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "userMembershipId=" + encodeURIComponent(userMembershipId)
        });

        let data = await orderRes.json();

        if (!data.success) {
            alert("❌ " + data.message);
            return;
        }

        // ✅ STEP 3: Razorpay Checkout
        var options = {
            key: data.key, // ✅ coming from backend
            amount: data.amount,
            currency: data.currency,
            name: "FitnessWorld",
            description: "Membership Payment",
            order_id: data.orderId,

            handler: async function (response) {

                // ✅ STEP 4: Verify payment
                let verifyRes = await fetch("<%= request.getContextPath() %>/verify-membership-payment", {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body:
                        "userMembershipId=" + encodeURIComponent(userMembershipId) +
                        "&razorpay_payment_id=" + encodeURIComponent(response.razorpay_payment_id) +
                        "&razorpay_order_id=" + encodeURIComponent(response.razorpay_order_id) +
                        "&razorpay_signature=" + encodeURIComponent(response.razorpay_signature)
                });

                let verifyData = await verifyRes.json();

                if (verifyData.success) {
                    alert("✅ Membership Activated Successfully!");
                    window.location.href = "<%= request.getContextPath() %>/user-dashboard";
                } else {
                    alert("❌ Payment Verification Failed: " + verifyData.message);
                }
            },

            theme: { color: "#ff2e2e" }
        };

        var rzp = new Razorpay(options);
        rzp.open();

    } catch (e) {
        console.error(e);
        alert("❌ Server error while creating membership order.");
    }
}
</script>



</body>
</html>
