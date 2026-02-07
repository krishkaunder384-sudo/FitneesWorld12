package com.gym_website.servlet;

import com.gym_website.dao.WorkoutPlanDao;
import com.gym_website.entities.Trainer;
import com.gym_website.entities.WorkoutPlan;
import com.gym_website.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/add-workout-plan")
public class AddWorkoutPlanServlet extends HttpServlet {

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
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String level = request.getParameter("level");
            int durationWeeks = Integer.parseInt(
                    request.getParameter("durationWeeks")
            );

            // ✅ NEW FIELDS
            String goal = request.getParameter("goal");
            int daysPerWeek = Integer.parseInt(
                    request.getParameter("daysPerWeek")
            );
            String equipment = request.getParameter("equipment");
            String splitType = request.getParameter("splitType");
            String videoLink = request.getParameter("videoLink");
            String notes = request.getParameter("notes");

            // null safety
            if (videoLink == null) videoLink = "";
            if (notes == null) notes = "";

            WorkoutPlan wp = new WorkoutPlan();
            wp.setTitle(title);
            wp.setDescription(description);
            wp.setLevel(level);
            wp.setDurationWeeks(durationWeeks);

            wp.setGoal(goal);
            wp.setDaysPerWeek(daysPerWeek);
            wp.setEquipment(equipment);
            wp.setSplitType(splitType);
            wp.setVideoLink(videoLink);
            wp.setNotes(notes);

            wp.setTrainerId(trainer.getId()); // ✅ VERY IMPORTANT

            WorkoutPlanDao dao =
                    new WorkoutPlanDao(ConnectionProvider.getConnection());

            boolean ok = dao.addWorkoutPlan(wp);

            if (ok) {
                session.setAttribute(
                        "msg",
                        "✅ Workout Plan Added Successfully!"
                );
            } else {
                session.setAttribute(
                        "msg",
                        "❌ Failed to add workout plan."
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute(
                    "msg",
                    "❌ Server error while adding workout plan."
            );
        }

        response.sendRedirect(
                request.getContextPath() + "/add-workout.jsp"
        );
    }
}
