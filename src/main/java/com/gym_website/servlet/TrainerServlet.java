package com.gym_website.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.gym_website.dao.UserDao;
import com.gym_website.entities.User;
import com.gym_website.helper.ConnectionProvider;

@WebServlet("/TrainerServlet")
@MultipartConfig
public class TrainerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public TrainerServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        String check = request.getParameter("check");
        if (check == null) {
            out.println("Checkbox not checked.");
            return; // Stop further processing if the checkbox is not checked
        }

        String name = request.getParameter("user_name");
        String email = request.getParameter("user_email");
        String mobile = request.getParameter("user_mobile");
        String password = request.getParameter("user_password");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");

        // Validate required fields
        if (name == null || name.trim().isEmpty()) {
            out.println("Name cannot be empty.");
            return;
        }

        // Create a user object
        User user = new User(name, email, mobile, password, address, dob, gender);

        UserDao dao = new UserDao(ConnectionProvider.getConnection());
        if (dao.saveUser(user)) {
            out.println("done"); // User registration successful
        } else {
            out.println("Error during registration."); // Registration error
        }
    }
}
