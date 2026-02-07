<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<%
    Boolean admin = (Boolean) session.getAttribute("admin");
    if (admin == null || !admin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?type=admin");
        return;
    }

    Locale india = new Locale("en", "IN");
    NumberFormat formatter = NumberFormat.getCurrencyInstance(india);

    List<Map<String,String>> earnings = new ArrayList<>();
    double[] monthly = new double[12];
    double totalEarnings = 0;

    try (Connection con = ConnectionProvider.getConnection()) {

        String sql =
                "SELECT um.payment_time, u.name AS user_name, u.email AS user_email, " +
                "mp.name AS plan_name, mp.price AS amount " +
                "FROM user_memberships um " +
                "JOIN users u ON um.user_id = u.id " +
                "JOIN membership_plans mp ON um.plan_id = mp.id " +
                "WHERE um.payment_status='PAID' " +
                "ORDER BY um.payment_time DESC";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Timestamp paymentTime = rs.getTimestamp("payment_time");
                double amount = rs.getDouble("amount");

                Map<String,String> row = new HashMap<>();
                row.put("date", paymentTime == null ? "-" : paymentTime.toString());
                row.put("user", rs.getString("user_name"));
                row.put("email", rs.getString("user_email"));
                row.put("plan", rs.getString("plan_name"));
                row.put("amount", formatter.format(amount));

                earnings.add(row);
                totalEarnings += amount;

                if (paymentTime != null) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTimeInMillis(paymentTime.getTime());
                    int monthIndex = cal.get(Calendar.MONTH);
                    monthly[monthIndex] += amount;
                }
            }
        }

    } catch(Exception e) {
        e.printStackTrace();
    }

    StringBuilder monthlyData = new StringBuilder();
    for (int i = 0; i < 12; i++) {
        monthlyData.append(String.format(Locale.US, "%.2f", monthly[i]));
        if (i < 11) monthlyData.append(", ");
    }
%>
