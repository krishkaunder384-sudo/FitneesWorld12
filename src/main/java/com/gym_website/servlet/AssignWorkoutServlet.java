package com.gym_website.servlet;

import com.gym_website.dao.UserWorkoutDao;
import com.gym_website.entities.Trainer;
import com.gym_website.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/assign-workout")
public class AssignWorkoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ===== ✅ STANDARD TRAINER AUTH CHECK =====
        if (session == null || session.getAttribute("currentTrainer") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?type=trainer"
            );
            return;
        }

        Trainer trainer = (Trainer) session.getAttribute("currentTrainer");

        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            int workoutId = Integer.parseInt(request.getParameter("workoutId"));

            UserWorkoutDao dao =
                    new UserWorkoutDao(ConnectionProvider.getConnection());

            boolean ok =
                    dao.assignWorkoutToUser(userId, workoutId, trainer.getId());

            if (ok) {
                session.setAttribute(
                        "msg",
                        "✅ Workout Assigned Successfully!"
                );
            } else {
                session.setAttribute(
                        "msg",
                        "❌ Workout already assigned / invalid!"
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute(
                    "msg",
                    "❌ Server Error while assigning workout!"
            );
        }

        // redirect back to dashboard
        response.sendRedirect(
                request.getContextPath() + "/trainer-dashboard"
        );
    }
}
