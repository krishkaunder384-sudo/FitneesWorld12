package com.gym_website.servlet;

import com.gym_website.dao.UserWorkoutDao;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/workout-history")
public class WorkoutHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        UserWorkoutDao dao = new UserWorkoutDao(ConnectionProvider.getConnection());

        List<Map<String, String>> workouts = dao.getUserWorkouts(currentUser.getId());

        request.setAttribute("workouts", workouts);

        request.getRequestDispatcher("workout-history.jsp").forward(request, response);
    }
}
