<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.gym_website.entities.User" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String bookingId = request.getParameter("bookingId");
%>

<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<div class="container" style="max-width:450px; padding-top:90px;">

    <div class="card shadow p-4 text-center">
        <h3 class="mb-3">Confirm Payment</h3>

        <p class="text-muted mb-2">
            Booking ID: <strong><%= bookingId %></strong>
        </p>

        <h4 class="text-primary mb-4">₹999</h4>

        <button type="button" class="btn btn-success btn-block" onclick="startPayment()">
            Pay Now
        </button>

        <form id="paymentForm" action="<%=request.getContextPath()%>/verify-payment" method="post">
            <input type="hidden" name="bookingId" value="<%= bookingId %>">
            <input type="hidden" name="razorpay_payment_id" id="razorpay_payment_id">
            <input type="hidden" name="razorpay_order_id" id="razorpay_order_id">
            <input type="hidden" name="razorpay_signature" id="razorpay_signature">
        </form>

        <a href="<%= request.getContextPath() %>/my-bookings"
           class="btn btn-light btn-block mt-3">
            Cancel
        </a>
    </div>

</div>

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<script>
async function startPayment() {
    const bookingId = "<%= bookingId %>";

    try {
        // ✅ create order (call servlet)
        const res = await fetch("<%=request.getContextPath()%>/create-razorpay-order", {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: "bookingId=" + encodeURIComponent(bookingId)
        });

        const data = await res.json();

        if (!res.ok || !data.success) {
            console.error("Order create failed:", data);
            alert(data.message || "Failed to create order.");
            return;
        }

        // ✅ Razorpay expects order_id
        const orderId = data.orderId;

        var options = {
            // ✅ MUST be your real KEY_ID (test key)
            "key": "rzp_test_S8Xbuo9s4e7CrI",

            "amount": data.amount,
            "currency": data.currency,
            "name": "FitnessWorld",
            "description": "Trainer Session Booking",
            "order_id": orderId,

            "handler": function (response){
                document.getElementById("razorpay_payment_id").value = response.razorpay_payment_id;
                document.getElementById("razorpay_order_id").value = response.razorpay_order_id;
                document.getElementById("razorpay_signature").value = response.razorpay_signature;

                document.getElementById("paymentForm").submit();
            },

            "prefill": {
                "name": "<%= currentUser.getName() %>",
                "email": "<%= currentUser.getEmail() %>"
            },

            "theme": {"color": "#ff2e2e"}
        };

        var rzp1 = new Razorpay(options);

        rzp1.on('payment.failed', function (response){
            console.error("Payment failed:", response.error);
            alert("Payment Failed: " + response.error.description);
        });

        rzp1.open();

    } catch (err) {
        console.error(err);
        alert("Server error while starting payment.");
    }
}
</script>


</body>
</html>
