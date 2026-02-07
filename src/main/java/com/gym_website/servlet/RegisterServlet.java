package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.gym_website.dao.UserDao;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;
import com.gym_website.helper.MailHelper;
import com.gym_website.helper.PasswordHelper;

@WebServlet("/registerservlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ✅ Checkbox validation
            String check = request.getParameter("check");
            if (check == null) {
                response.sendRedirect(request.getContextPath()
                        + "/signup.jsp?error=Please+accept+Terms+and+Privacy+Policy");
                return;
            }

            // ✅ Read inputs
            String name = request.getParameter("user_name");
            String email = request.getParameter("user_email");
            String mobile = request.getParameter("user_mobile");
            String address = request.getParameter("address");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");

            String password = request.getParameter("user_password");
            String confirmPassword = request.getParameter("confirm_password");

            // ✅ Basic validations
            if (name == null || name.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Name+cannot+be+empty");
                return;
            }

            if (email == null || email.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Email+cannot+be+empty");
                return;
            }

            if (password == null || password.length() < 6) {
                response.sendRedirect(request.getContextPath()
                        + "/signup.jsp?error=Password+must+be+atleast+6+characters");
                return;
            }

            if (confirmPassword == null || !password.equals(confirmPassword)) {
                response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Passwords+do+not+match");
                return;
            }

            if (gender == null || gender.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Please+select+gender");
                return;
            }

            // ✅ Check email already exists
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            if (dao.emailExists(email.trim())) {
                response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Email+already+exists");
                return;
            }

            // ✅ IMPORTANT: BCrypt Hash Password before saving
            String hashedPassword = PasswordHelper.hashPassword(password);

            // ✅ Create user object
            User user = new User(name, email, mobile, hashedPassword, address, dob, gender);

            boolean saved = dao.saveUser(user);

            if (saved) {

                // ✅ Send welcome email
                try {
                    String subject = "Welcome to FitnessWorld ✅";

                    String html =
                            "<div style='font-family:Arial;padding:20px'>" +
                                    "<h2 style='color:#ff2e2e'>Welcome to FitnessWorld 💪</h2>" +
                                    "<p>Hello <b>" + name + "</b>,</p>" +
                                    "<p>Your account has been created successfully ✅</p>" +
                                    "<p>You can now login and start your fitness journey.</p>" +
                                    "<br>" +
                                    "<p style='color:#777'>Regards,<br>FitnessWorld Team</p>" +
                                    "</div>";

                    MailHelper.sendEmail(email, subject, html);

                } catch (Exception mailEx) {
                    mailEx.printStackTrace();
                    // even if email fails -> account must still be created
                }

                // ✅ Redirect to login page
                response.sendRedirect(request.getContextPath()
                        + "/login.jsp?success=Account+created+successfully.+Please+login");

            } else {
                response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Error+during+registration");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=Server+error+try+again");
        }
    }
}
