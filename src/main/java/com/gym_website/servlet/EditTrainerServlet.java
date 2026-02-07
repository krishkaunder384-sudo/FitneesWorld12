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

@WebServlet("/EditTrainer")
public class EditTrainerServlet extends HttpServlet {

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
            int id = Integer.parseInt(request.getParameter("id"));

            Trainer t = new Trainer();
            t.setId(id);
            t.setName(request.getParameter("name"));
            t.setSpecialization(request.getParameter("specialization"));
            t.setExperience(request.getParameter("experience"));
            t.setImage(request.getParameter("image"));
            t.setDescription(request.getParameter("description"));

            TrainerDao dao =
                    new TrainerDao(ConnectionProvider.getConnection());

            boolean updated = dao.updateTrainer(t);

            if (updated) {
                session.setAttribute("msg", "Trainer updated successfully ✔️");
            } else {
                session.setAttribute("msg", "Failed to update trainer.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Error updating trainer.");
        }

        response.sendRedirect(request.getContextPath() + "/trainer.jsp");
    }
}
