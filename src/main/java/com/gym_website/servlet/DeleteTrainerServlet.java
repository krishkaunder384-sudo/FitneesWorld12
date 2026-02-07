package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.gym_website.dao.TrainerDao;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/DeleteTrainer")
public class DeleteTrainerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            TrainerDao dao = new TrainerDao(ConnectionProvider.getConnection());
            boolean deleted = dao.deleteTrainer(id);

            if (deleted) {
                session.setAttribute("msg", "Trainer deleted successfully 🗑️");
            } else {
                session.setAttribute("msg", "Failed to delete trainer.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Error deleting trainer.");
        }

        response.sendRedirect("trainer.jsp");
    }
}
