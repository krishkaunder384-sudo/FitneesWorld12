package com.gym_website.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/AdminDashboardPage/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        // Admin object stored during login
        Object admin = (session != null) ? session.getAttribute("admin") : null;

        if (admin == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?type=admin"
            );
            return;
        }

        chain.doFilter(req, res);
    }
}
