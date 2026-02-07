package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;

import com.gym_website.dao.UserMembershipDao;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/my-membership")
public class MyMembershipServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try (Connection con = ConnectionProvider.getConnection()) {

            UserMembershipDao dao = new UserMembershipDao(con);

            // ✅ Auto-expire old memberships
            dao.expireOldMemberships();

            // ✅ IMPORTANT: get latest membership row for this user
            ResultSet rs = dao.getLatestMembership(user.getId());

            if (rs.next()) {

                request.setAttribute("userMembershipId", rs.getInt("id"));
                request.setAttribute("planName", rs.getString("plan_name"));
                request.setAttribute("price", rs.getDouble("price"));

                request.setAttribute("startDate", rs.getDate("start_date"));
                request.setAttribute("endDate", rs.getDate("end_date"));

                request.setAttribute("status", rs.getString("status"));               // ACTIVE / EXPIRED / PENDING
                request.setAttribute("paymentStatus", rs.getString("payment_status")); // PAID / UNPAID

            } else {

                // ✅ set all as null (avoid JSP issues)
                request.setAttribute("userMembershipId", null);
                request.setAttribute("planName", null);
                request.setAttribute("price", null);
                request.setAttribute("startDate", null);
                request.setAttribute("endDate", null);
                request.setAttribute("status", null);
                request.setAttribute("paymentStatus", null);
            }

            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/my-membership.jsp").forward(request, response);
    }
}
