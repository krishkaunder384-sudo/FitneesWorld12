package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.gym_website.dao.TrainerDao;
import com.gym_website.entities.Trainer;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/AddTrainer")
public class AddTrainerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
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

        try {
            // 📥 Read form data
            String name = request.getParameter("name");
            String specialization = request.getParameter("specialization");
            String experience = request.getParameter("experience");
            String image = request.getParameter("image");
            String description = request.getParameter("description");

            // 🧱 Build Trainer object
            Trainer trainer = new Trainer();
            trainer.setName(name);
            trainer.setSpecialization(specialization);
            trainer.setExperience(experience);
            trainer.setImage(image);
            trainer.setDescription(description);

            // 💾 Save to DB
            TrainerDao dao = new TrainerDao(ConnectionProvider.getConnection());
            boolean saved = dao.addTrainer(trainer);

            if (saved) {
                session.setAttribute("msg", "Trainer added successfully ✔️");
            } else {
                session.setAttribute("msg", "Failed to add trainer.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Something went wrong while adding trainer.");
        }

        // 🔁 Redirect back to trainer page
        response.sendRedirect(request.getContextPath() + "/trainer.jsp");
    }
}
