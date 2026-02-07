package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.gym_website.dao.UserDao;
import com.gym_website.entities.Message;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;
import com.gym_website.helper.PasswordHelper;

@WebServlet("/loginservlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdentifier = request.getParameter("loginIdentifier");
        String userPassword = request.getParameter("password");
        String redirect = request.getParameter("redirect");

        String contextPath = request.getContextPath();

        // ✅ BASIC VALIDATION
        if (userIdentifier == null || userIdentifier.trim().isEmpty()
                || userPassword == null || userPassword.trim().isEmpty()) {

            HttpSession session = request.getSession();
            session.setAttribute(
                    "msg",
                    new Message(
                            "Please enter Email/Phone and Password!",
                            "error",
                            "alert-danger"
                    )
            );

            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        try {
            UserDao dao =
                    new UserDao(ConnectionProvider.getConnection());

            // ✅ FETCH USER BY EMAIL / PHONE
            User u =
                    dao.getUserByEmailOrPhone(userIdentifier.trim());

            if (u == null) {
                HttpSession session = request.getSession();
                session.setAttribute(
                        "msg",
                        new Message(
                                "Invalid Email/Phone or Password!",
                                "error",
                                "alert-danger"
                        )
                );

                response.sendRedirect(contextPath + "/login.jsp");
                return;
            }

            // ✅ VERIFY PASSWORD (HASHED)
            boolean isValid =
                    PasswordHelper.verifyPassword(
                            userPassword,
                            u.getPassword()
                    );

            if (!isValid) {
                HttpSession session = request.getSession();
                session.setAttribute(
                        "msg",
                        new Message(
                                "Invalid Email/Phone or Password!",
                                "error",
                                "alert-danger"
                        )
                );

                response.sendRedirect(contextPath + "/login.jsp");
                return;
            }

            // ✅ LOGIN SUCCESS (SESSION FIXATION PROTECTION)
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("currentUser", u);

            // ✅ SAFE REDIRECT
            if (redirect != null
                    && !redirect.trim().isEmpty()
                    && !"null".equalsIgnoreCase(redirect)
                    && redirect.startsWith(contextPath)) {

                response.sendRedirect(redirect);
            } else {
                response.sendRedirect(
                        contextPath + "/user-dashboard"
                );
            }

        } catch (Exception e) {
            e.printStackTrace();

            HttpSession session = request.getSession();
            session.setAttribute(
                    "msg",
                    new Message(
                            "Server error. Try again.",
                            "error",
                            "alert-danger"
                    )
            );

            response.sendRedirect(contextPath + "/login.jsp");
        }
    }
}
