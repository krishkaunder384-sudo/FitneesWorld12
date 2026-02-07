package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.gym_website.dao.TrainerDao;
import com.gym_website.entities.Message;
import com.gym_website.entities.Trainer;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/trainerloginservlet")
public class TrainerLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String loginIdentifier = request.getParameter("loginIdentifier");
        String password = request.getParameter("password");

        TrainerDao dao = new TrainerDao(ConnectionProvider.getConnection());
        Trainer trainer = dao.login(loginIdentifier, password);

        HttpSession session = request.getSession();
        String contextPath = request.getContextPath();

        if (trainer != null) {
            session.setAttribute("currentTrainer", trainer);
            response.sendRedirect(contextPath + "/trainer-dashboard");
            return;
        }

        // ❌ trainer login failed
        session.setAttribute("msg",
                new Message("Invalid Trainer Credentials!", "error", "alert alert-danger"));

        response.sendRedirect(contextPath + "/login.jsp?type=trainer");
    }
}
