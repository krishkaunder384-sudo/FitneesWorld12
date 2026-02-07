<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gyms List</title>
    <style>
        /* Your CSS for card styling here */
        /* Basic Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Body Styling */
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f4f4f4;
    color: #333;
    line-height: 1.6;
    padding: 2rem;
}

/* Header Styling */
h2 {
    margin-bottom: 1.5rem;
    color: #333;
    font-size: 2.5rem;
}

/* Scrollable Cards */
.scrollable-cards {
    display: flex;
    flex-wrap: nowrap;
    overflow-x: auto;
    padding: 1rem 0;
    gap: 1rem;
}

.scrollable-cards::-webkit-scrollbar {
    height: 8px;
}

.scrollable-cards::-webkit-scrollbar-thumb {
    background-color: #ff6b6b;
    border-radius: 10px;
}

.scrollable-cards::-webkit-scrollbar-track {
    background-color: #f4f4f4;
}

/* Styling for Individual Cards */
.service-item {
    flex: 0 0 auto;
    width: calc(25% - 1rem); /* 4 items per row */
    background-color: white;
    border-radius: 10px;
    padding: 1.5rem;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease-in-out;
    text-align: center;
    overflow: hidden;
}

.service-item h3 {
    color: #ff6b6b;
    font-size: 1.5rem;
    margin-bottom: 1rem;
}

.service-item p {
    color: #666;
    font-size: 1rem;
    margin-bottom: 1.5rem;
}

.service-item a {
    text-decoration: none;
    color: #fff;
    background-color: #ff6b6b;
    padding: 0.5rem 1rem;
    border-radius: 5px;
    font-size: 1rem;
    transition: background-color 0.3s ease-in-out;
}

.service-item a:hover {
    background-color: #e05757;
}

/* Responsive Design */
@media (max-width: 768px) {
    .service-item {
        width: calc(50% - 1rem); /* 2 items per row */
    }
}

@media (max-width: 480px) {
    .service-item {
        width: calc(100% - 1rem); /* 1 item per row */
    }
}
        
    </style>
</head>
<body>
    <h2>Available Gyms</h2>
    <div class="scrollable-cards">
        <%
            String jdbcURL = "jdbc:mysql://localhost:3306/gym";
            String dbUser = "root";
            String dbPassword = "admin";
            String sql = "SELECT id, gymName, socialMediaLinks FROM gyms";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gym", "root", "admin");
                     PreparedStatement stmt = conn.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String gymName = rs.getString("gymName");
                        String socialMediaLinks = rs.getString("socialMediaLinks");
        %>
        <div class="service-item">
            <h3><%= gymName %></h3>
            <p><%= socialMediaLinks %></p>
            <a href="gymTemplate.jsp?id=<%= id %>">View Details</a>
        </div>
        <%
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
</body>
</html>
