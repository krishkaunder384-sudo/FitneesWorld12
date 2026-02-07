package com.gym_website.admin.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gym_website.dao.UserMembershipDao;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/admin/user-memberships")
public class AdminUserMembershipServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ===== ✅ STANDARD ADMIN AUTH CHECK =====
        Boolean admin = (session != null)
                ? (Boolean) session.getAttribute("admin")
                : null;

        if (admin == null || !admin) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?type=admin"
            );
            return;
        }

        List<Map<String, String>> memberships = new ArrayList<>();

        try {
            UserMembershipDao dao =
                    new UserMembershipDao(ConnectionProvider.getConnection());

            ResultSet rs = dao.getAllUserMemberships();

            while (rs.next()) {
                Map<String, String> m = new HashMap<>();
                m.put("userName", rs.getString("user_name"));
                m.put("email", rs.getString("email"));
                m.put("plan", rs.getString("plan_name"));
                m.put("start", rs.getString("start_date"));
                m.put("end", rs.getString("end_date"));
                m.put("status", rs.getString("status"));
                memberships.add(m);
            }

            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("memberships", memberships);

        request.getRequestDispatcher(
                "/AdminDashboardPage/admin-user-memberships.jsp"
        ).forward(request, response);
    }
}
