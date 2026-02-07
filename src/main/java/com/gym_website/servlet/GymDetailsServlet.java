package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.gym_website.dao.GymDao;
import com.gym_website.entities.Gym;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/gym-details")
public class GymDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        try {
            GymDao dao = new GymDao(ConnectionProvider.getConnection());
            Gym gym = dao.getGymById(Integer.parseInt(id));

            if (gym == null) {
                response.sendRedirect("error.jsp");
                return;
            }

            request.setAttribute("gym", gym);
            request.getRequestDispatcher("gym-details.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
