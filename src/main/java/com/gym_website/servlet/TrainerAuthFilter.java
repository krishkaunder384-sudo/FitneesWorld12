package com.gym_website.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter({
        "/trainer-dashboard",
        "/trainer-bookings",
        "/add-diet.jsp",
        "/add-workout.jsp",
        "/trainer-bookings.jsp",
        "/trainer-dashboard.jsp"
})
public class TrainerAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentTrainer") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?type=trainer"
            );
            return;
        }

        chain.doFilter(req, res);
    }
}
