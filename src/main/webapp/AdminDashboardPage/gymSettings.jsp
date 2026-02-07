<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.gym_website.admin.dao.SettingsBean" %>
<%@ page import="com.gym_website.helper.ConnectionProvider" %>

<%
   Boolean admin = (Boolean) session.getAttribute("admin");
           if (admin == null || !admin) {
               response.sendRedirect(request.getContextPath() + "/login.jsp?type=admin");
               return;
           }  %>


    SettingsBean settings = new SettingsBean();

    String sql = "SELECT gymName, contactEmail, contactPhone, address, socialMediaLinks, businessHours FROM settings WHERE id = 1";

    try (Connection conn = ConnectionProvider.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        if (rs.next()) {
            settings.setGymName(rs.getString("gymName"));
            settings.setContactEmail(rs.getString("contactEmail"));
            settings.setContactPhone(rs.getString("contactPhone"));
            settings.setAddress(rs.getString("address"));
            settings.setSocialMediaLinks(rs.getString("socialMediaLinks"));
            settings.setBusinessHours(rs.getString("businessHours"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    // ✅ Optional messages after update
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Settings | FitnessWorld Admin</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            background: #f4f6f9;
            font-family: "Poppins", Arial, sans-serif;
        }

        .page-container {
            margin-left: 270px;
            padding: 40px;
        }

        /* HEADER */
        .page-header {
            background: #ffffff;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.12);
            margin-bottom: 30px;
        }

        .page-header span {
            color: #ff2e2e;
        }

        /* CARD */
        .settings-card {
            background: #ffffff;
            padding: 35px;
            border-radius: 22px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.12);
            max-width: 900px;
        }

        label {
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 6px;
        }

        .form-control {
            height: 46px;
            border-radius: 10px;
        }

        textarea.form-control {
            height: auto;
        }

        .btn-save {
            background: #ff2e2e;
            border: none;
            height: 46px;
            padding: 0 30px;
            border-radius: 30px;
            font-weight: 600;
            color: #fff;
            transition: all 0.3s ease;
        }

        .btn-save:hover {
            background: #e60023;
            transform: translateY(-1px);
        }

        @media (max-width: 992px) {
            .page-container {
                margin-left: 0;
                padding: 25px;
            }
        }
    </style>
</head>

<body>

<!-- ✅ COMMON ADMIN SIDEBAR -->
<%@ include file="adminSidebar.jsp" %>

<div class="page-container">

    <!-- HEADER -->
    <div class="page-header">
        <h2>Platform <span>Settings</span></h2>
        <p class="text-muted mb-0">
            Manage gym details, contact information, and public-facing settings.
        </p>
    </div>

    <% if (success != null) { %>
        <div class="alert alert-success"><%= success %></div>
    <% } %>

    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <!-- SETTINGS FORM -->
    <div class="settings-card">

        <form action="<%= request.getContextPath() %>/admin-update-settings" method="post">


            <div class="form-group">
                <label>Gym Name</label>
                <input type="text" class="form-control"
                       name="gymName"
                       value="<%= settings.getGymName() == null ? "" : settings.getGymName() %>" required>
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label>Contact Email</label>
                    <input type="email" class="form-control"
                           name="contactEmail"
                           value="<%= settings.getContactEmail() == null ? "" : settings.getContactEmail() %>" required>
                </div>

                <div class="form-group col-md-6">
                    <label>Contact Phone</label>
                    <input type="tel" class="form-control"
                           name="contactPhone"
                           value="<%= settings.getContactPhone() == null ? "" : settings.getContactPhone() %>" required>
                </div>
            </div>

            <div class="form-group">
                <label>Address</label>
                <textarea class="form-control" name="address" rows="3"><%= settings.getAddress() == null ? "" : settings.getAddress() %></textarea>
            </div>

            <div class="form-group">
                <label>Social Media Links</label>
                <input type="text" class="form-control"
                       name="socialMediaLinks"
                       value="<%= settings.getSocialMediaLinks() == null ? "" : settings.getSocialMediaLinks() %>">
            </div>

            <div class="form-group">
                <label>Business Hours</label>
                <textarea class="form-control" name="businessHours" rows="3"><%= settings.getBusinessHours() == null ? "" : settings.getBusinessHours() %></textarea>
            </div>

            <div class="text-right mt-4">
                <button type="submit" class="btn btn-save">
                    <i class="fa fa-save mr-1"></i> Save Changes
                </button>
            </div>

        </form>

    </div>

</div>

</body>
</html>
