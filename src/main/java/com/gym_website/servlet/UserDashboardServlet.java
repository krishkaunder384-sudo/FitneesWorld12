package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.gym_website.dao.*;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/user-dashboard")
public class UserDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            BookingDao bdao = new BookingDao(ConnectionProvider.getConnection());
            UserWorkoutDao wdao = new UserWorkoutDao(ConnectionProvider.getConnection());
            UserDietDao ddao = new UserDietDao(ConnectionProvider.getConnection());
            UserMembershipDao mdao = new UserMembershipDao(ConnectionProvider.getConnection());

            // ✅ Workouts + diets
            request.setAttribute("workouts", wdao.getUserWorkouts(user.getId()));
            request.setAttribute("diets", ddao.getUserDiets(user.getId()));

            // ✅ Bookings
            request.setAttribute("bookings", bdao.getBookingsByUser(user.getId()));

            // ✅ Membership
            var rs = mdao.getLatestMembership(user.getId());
            if (rs.next()) {
                request.setAttribute("planName", rs.getString("plan_name"));
                request.setAttribute("membershipStatus", rs.getString("status"));
                request.setAttribute("endDate", rs.getDate("end_date"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("user-dashboard.jsp").forward(request, response);
    }
}
