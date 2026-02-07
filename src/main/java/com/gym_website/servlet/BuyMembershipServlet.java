package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

import com.gym_website.dao.UserMembershipDao;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;
import org.json.JSONObject;

@WebServlet("/buy-membership")
public class BuyMembershipServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject res = new JSONObject();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.setStatus(401);
            res.put("success", false);
            res.put("message", "Login required");
            response.getWriter().print(res.toString());
            return;
        }

        User user = (User) session.getAttribute("currentUser");

        String planIdStr = request.getParameter("planId");
        if (planIdStr == null || planIdStr.isBlank()) {
            response.setStatus(400);
            res.put("success", false);
            res.put("message", "planId required");
            response.getWriter().print(res.toString());
            return;
        }

        int planId;
        try {
            planId = Integer.parseInt(planIdStr.trim());
        } catch (Exception e) {
            response.setStatus(400);
            res.put("success", false);
            res.put("message", "Invalid planId");
            response.getWriter().print(res.toString());
            return;
        }

        try (Connection con = ConnectionProvider.getConnection()) {

            UserMembershipDao dao = new UserMembershipDao(con);

            // ✅ fetch plan duration
            int durationDays;
            try (PreparedStatement psPlan =
                         con.prepareStatement("SELECT duration_days FROM membership_plans WHERE id=?")) {
                psPlan.setInt(1, planId);

                try (ResultSet planRs = psPlan.executeQuery()) {
                    if (!planRs.next()) {
                        response.setStatus(404);
                        res.put("success", false);
                        res.put("message", "Membership plan not found");
                        response.getWriter().print(res.toString());
                        return;
                    }
                    durationDays = planRs.getInt("duration_days");
                }
            }

            LocalDate startDate = LocalDate.now();

            // ✅ If user already has ACTIVE membership, start after old end date
            try (ResultSet activeRs = dao.getActiveMembership(user.getId())) {
                if (activeRs.next()) {
                    LocalDate oldEnd = activeRs.getDate("end_date").toLocalDate();
                    startDate = oldEnd.plusDays(1);
                }
            }

            LocalDate endDate = startDate.plusDays(durationDays);

            // ✅ create pending membership row (DO NOT activate yet)
            int userMembershipId = dao.createPendingMembership(
                    user.getId(),
                    planId,
                    startDate,
                    endDate
            );

            if (userMembershipId == -1) {
                response.setStatus(500);
                res.put("success", false);
                res.put("message", "Could not create pending membership");
                response.getWriter().print(res.toString());
                return;
            }

            // ✅ JSON response
            res.put("success", true);
            res.put("userMembershipId", userMembershipId);
            res.put("planId", planId);
            res.put("startDate", startDate.toString());
            res.put("endDate", endDate.toString());

            response.setStatus(200);
            response.getWriter().print(res.toString());

        } catch (Exception e) {
            e.printStackTrace();

            response.setStatus(500);
            res.put("success", false);
            res.put("message", "Server error while creating membership");
            res.put("error", e.toString());
            response.getWriter().print(res.toString());
        }
    }
}
