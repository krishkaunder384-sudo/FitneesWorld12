package com.gym_website.servlet;

import com.gym_website.dao.BookingDao;
import com.gym_website.dao.DietPlanDao;
import com.gym_website.dao.WorkoutPlanDao;
import com.gym_website.entities.DietPlan;
import com.gym_website.entities.Trainer;
import com.gym_website.entities.User;
import com.gym_website.entities.WorkoutPlan;
import com.gym_website.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/trainer-dashboard")
public class TrainerDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
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

        // DAO
        WorkoutPlanDao workoutDao =
                new WorkoutPlanDao(ConnectionProvider.getConnection());
        DietPlanDao dietDao =
                new DietPlanDao(ConnectionProvider.getConnection());
        BookingDao bookingDao =
                new BookingDao(ConnectionProvider.getConnection());

        // TRAINER-SPECIFIC DATA
        List<WorkoutPlan> workouts =
                workoutDao.getWorkoutsByTrainer(trainer.getId());
        List<DietPlan> diets =
                dietDao.getDietsByTrainer(trainer.getId());

        if (workouts == null) workouts = new ArrayList<>();
        if (diets == null) diets = new ArrayList<>();

        // MEMBERS WHO BOOKED SESSIONS
        List<User> users =
                bookingDao.getUsersForTrainer(trainer.getId());
        if (users == null) users = new ArrayList<>();

        // BOOKING STATS
        int totalBookings =
                bookingDao.getTotalBookingsByTrainer(trainer.getId());
        int pendingBookings =
                bookingDao.getBookingCountByTrainerAndStatus(
                        trainer.getId(), "PENDING");
        int approvedBookings =
                bookingDao.getBookingCountByTrainerAndStatus(
                        trainer.getId(), "APPROVED");
        int cancelledBookings =
                bookingDao.getBookingCountByTrainerAndStatus(
                        trainer.getId(), "CANCELLED");

        // SEND DATA TO JSP
        request.setAttribute("users", users);
        request.setAttribute("workouts", workouts);
        request.setAttribute("diets", diets);

        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("pendingBookings", pendingBookings);
        request.setAttribute("approvedBookings", approvedBookings);
        request.setAttribute("cancelledBookings", cancelledBookings);

        request.getRequestDispatcher(
                "trainer-dashboard.jsp"
        ).forward(request, response);
    }
}
