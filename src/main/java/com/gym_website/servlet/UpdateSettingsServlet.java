package com.gym_website.admin.servlet;

import com.gym_website.helper.ConnectionProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/admin-update-settings")
public class UpdateSettingsServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ===== ✅ STANDARD ADMIN AUTH CHECK =====
        Boolean admin = (session != null)
                ? (Boolean) session.getAttribute("admin")
                : null;

        if (admin == null || !admin) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?type=admin"
            );
            return;
        }

        String gymName = request.getParameter("gymName");
        String contactEmail = request.getParameter("contactEmail");
        String contactPhone = request.getParameter("contactPhone");
        String address = request.getParameter("address");
        String socialMediaLinks = request.getParameter("socialMediaLinks");
        String businessHours = request.getParameter("businessHours");

        if (gymName == null || gymName.trim().isEmpty()) {
            response.sendRedirect(
                    request.getContextPath()
                            + "/AdminDashboardPage/gymSettings.jsp?error=Gym+Name+required"
            );
            return;
        }

        String sql =
                "UPDATE settings SET gymName=?, contactEmail=?, contactPhone=?, address=?, socialMediaLinks=?, businessHours=? " +
                        "WHERE id=1";

        try (Connection con = ConnectionProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, gymName);
            ps.setString(2, contactEmail);
            ps.setString(3, contactPhone);
            ps.setString(4, address);
            ps.setString(5, socialMediaLinks);
            ps.setString(6, businessHours);

            int updated = ps.executeUpdate();

            if (updated > 0) {
                response.sendRedirect(
                        request.getContextPath()
                                + "/AdminDashboardPage/gymSettings.jsp?success=Settings+updated+successfully"
                );
            } else {
                response.sendRedirect(
                        request.getContextPath()
                                + "/AdminDashboardPage/gymSettings.jsp?error=Settings+not+updated"
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                    request.getContextPath()
                            + "/AdminDashboardPage/gymSettings.jsp?error=Server+error+updating+settings"
            );
        }
    }
}
