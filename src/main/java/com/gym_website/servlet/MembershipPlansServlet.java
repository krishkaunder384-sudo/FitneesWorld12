package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.gym_website.dao.MembershipDao;
import com.gym_website.entities.Membership;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/memberships")
public class MembershipPlansServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        MembershipDao dao =
                new MembershipDao(ConnectionProvider.getConnection());

        List<Membership> plans = dao.getAllActivePlans();

        request.setAttribute("plans", plans);

        // ✅ FIXED PATH
        request.getRequestDispatcher("/memberships.jsp")
                .forward(request, response);
    }
}
