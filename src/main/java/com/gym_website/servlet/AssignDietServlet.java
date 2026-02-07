package com.gym_website.servlet;

import com.gym_website.dao.UserDietDao;
import com.gym_website.entities.Trainer;
import com.gym_website.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/assign-diet")
public class AssignDietServlet extends HttpServlet {

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
            int dietId = Integer.parseInt(request.getParameter("dietId"));

            UserDietDao dao =
                    new UserDietDao(ConnectionProvider.getConnection());

            boolean ok =
                    dao.assignDiet(userId, dietId, trainer.getId());

            if (ok) {
                session.setAttribute(
                        "msg",
                        "✅ Diet Assigned Successfully!"
                );
            } else {
                session.setAttribute(
                        "msg",
                        "⚠️ Diet already assigned or invalid data!"
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute(
                    "msg",
                    "❌ Error while assigning diet!"
            );
        }

        response.sendRedirect(
                request.getContextPath() + "/trainer-dashboard"
        );
    }
}
