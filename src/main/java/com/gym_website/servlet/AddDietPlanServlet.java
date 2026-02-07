package com.gym_website.servlet;

import com.gym_website.dao.DietPlanDao;
import com.gym_website.entities.DietPlan;
import com.gym_website.entities.Trainer;
import com.gym_website.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/add-diet-plan")
public class AddDietPlanServlet extends HttpServlet {

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
            String goal = request.getParameter("goal");

            String caloriesStr = request.getParameter("calories");
            String dietType = request.getParameter("dietType");
            String mealsPerDayStr = request.getParameter("mealsPerDay");
            String proteinGStr = request.getParameter("proteinG");
            String carbsGStr = request.getParameter("carbsG");
            String fatsGStr = request.getParameter("fatsG");
            String waterLitersStr = request.getParameter("waterLiters");
            String foodsToAvoid = request.getParameter("foodsToAvoid");

            if (foodsToAvoid == null) foodsToAvoid = "";

            // ✅ parse safe
            int calories = Integer.parseInt(caloriesStr.trim());
            int mealsPerDay = Integer.parseInt(mealsPerDayStr.trim());
            int proteinG = Integer.parseInt(proteinGStr.trim());
            int carbsG = Integer.parseInt(carbsGStr.trim());
            int fatsG = Integer.parseInt(fatsGStr.trim());
            double waterLiters = Double.parseDouble(waterLitersStr.trim());

            DietPlan dp = new DietPlan();
            dp.setTitle(title);
            dp.setDescription(description);
            dp.setGoal(goal);
            dp.setCalories(calories);

            dp.setDietType(dietType);
            dp.setMealsPerDay(mealsPerDay);
            dp.setProteinG(proteinG);
            dp.setCarbsG(carbsG);
            dp.setFatsG(fatsG);
            dp.setWaterLiters(waterLiters);
            dp.setFoodsToAvoid(foodsToAvoid);

            dp.setTrainerId(trainer.getId());

            DietPlanDao dao =
                    new DietPlanDao(ConnectionProvider.getConnection());

            boolean ok = dao.addDietPlan(dp);

            if (ok) {
                session.setAttribute("msg", "✅ Diet Plan Added Successfully!");
            } else {
                session.setAttribute(
                        "msg",
                        "❌ Insert failed. Check server console for SQL error."
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "❌ Diet Error: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/add-diet.jsp");
    }
}
