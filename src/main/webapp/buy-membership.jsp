<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.gym_website.config.RazorpayConfig" %>

<%
    if (session.getAttribute("currentUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String userMembershipId = request.getParameter("userMembershipId");
    if (userMembershipId == null || userMembershipId.trim().isEmpty()) {
        response.sendRedirect("memberships");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Pay Membership | FitnessWorld</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- ✅ Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- ✅ Razorpay Checkout -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>

    <style>
        body {
            background: #0b0b0b;
            color: #e5e7eb;
            font-family: "Poppins", Arial, sans-serif;
            padding-top: 90px;
        }
        .pay-box {
            max-width: 520px;
            margin: 60px auto;
            background: rgba(20,20,20,0.95);
            padding: 32px;
            border-radius: 18px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.6);
            text-align: center;
        }
        .btn-pay {
            background: #22c55e;
            border: none;
            border-radius: 30px;
            padding: 12px 20px;
            font-weight: 800;
            color: #000;
            width: 100%;
        }
        .btn-pay:hover { background: #16a34a; }

        .btn-pay:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        .small-text {
            color: #9ca3af;
            font-size: 0.9rem;
        }
        .err-box {
            display: none;
            margin-top: 15px;
            background: rgba(239, 68, 68, 0.15);
            border: 1px solid rgba(239, 68, 68, 0.5);
            padding: 12px;
            border-radius: 12px;
            color: #fecaca;
            font-size: 0.9rem;
            text-align: left;
            word-break: break-word;
        }
    </style>
</head>

<body>

<%@ include file="navbar.jsp" %>

<div class="pay-box">
    <h3 class="mb-2">💳 Membership Payment</h3>

    <p class="small-text">
        Your membership is created as <b>PENDING</b>. Complete the payment to activate it.
    </p>

    <button id="payBtn" class="btn-pay mt-3" onclick="payMembership()">
        Pay Membership
    </button>

    <div id="errBox" class="err-box"></div>

    <a href="<%= request.getContextPath() %>/my-membership"
       class="btn btn-outline-light btn-block mt-3"
       style="border-radius:30px;">
        Back to My Membership
    </a>
</div>

<script>
    function showError(msg) {
        const box = document.getElementById("errBox");
        box.style.display = "block";
        box.innerHTML = msg;
    }

    async function payMembership() {

        const userMembershipId = "<%= userMembershipId %>";
        const payBtn = document.getElementById("payBtn");
        const errBox = document.getElementById("errBox");
        errBox.style.display = "none";
        errBox.innerHTML = "";

        payBtn.disabled = true;
        payBtn.innerText = "Creating Order...";

        try {
            const res = await fetch("<%= request.getContextPath() %>/create-membership-order", {
                method: "POST",
                headers: {"Content-Type": "application/x-www-form-urlencoded"},
                body: "userMembershipId=" + encodeURIComponent(userMembershipId)
            });

            // ✅ read raw text first (important)
            const text = await res.text();

            let data;
            try {
                data = JSON.parse(text);
            } catch (e) {
                throw new Error("Invalid JSON response from server. Raw: " + text);
            }

            if (!res.ok || !data.success) {
                showError("❌ " + (data.message || "Order creation failed")
                        + (data.error ? "<br><small>Server: " + data.error + "</small>" : ""));
                payBtn.disabled = false;
                payBtn.innerText = "Pay Membership";
                return;
            }

            payBtn.innerText = "Opening Razorpay...";

            const options = {
                key: "<%= RazorpayConfig.KEY_ID %>",
                amount: data.amount,
                currency: data.currency,
                name: "FitnessWorld",
                description: "Membership Payment",
                order_id: data.orderId,

                handler: function (response) {
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

                modal: {
                    ondismiss: function () {
                        payBtn.disabled = false;
                        payBtn.innerText = "Pay Membership";
                    }
                },

                theme: { color: "#ff2e2e" }
            };

            const rzp = new Razorpay(options);
            rzp.open();

        } catch (err) {
            console.error(err);
            showError("❌ " + err.message);
            payBtn.disabled = false;
            payBtn.innerText = "Pay Membership";
        }
    }
</script>

</body>
</html>
