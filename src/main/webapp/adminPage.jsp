<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, com.vk.vkart.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VKareer - Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f7f7f7;
            color: #404145;
        }
        .header {
            background-color: #ffffff;
            box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
            padding: 20px 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }
        .nav-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }
        .logo {
            font-size: 28px;
            font-weight: 700;
            color: #404145;
            text-decoration: none;
        }
        .main-container {
            max-width: 1400px;
            margin: 100px auto 0;
            padding: 0 20px;
        }
        .welcome-message {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 30px;
            color: #404145;
        }
        .job-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }
        .job-card {
            background-color: #ffffff;
            border: 1px solid #dadbdd;
            border-radius: 4px;
            overflow: hidden;
            transition: box-shadow 0.3s ease;
        }
        .job-card:hover {
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .job-header {
            padding: 20px;
            border-bottom: 1px solid #dadbdd;
        }
        .job-title {
            font-size: 18px;
            font-weight: 600;
            color: #404145;
            margin-bottom: 5px;
        }
        .company-name {
            font-size: 14px;
            color: #74767e;
        }
        .job-body {
            padding: 20px;
        }
        .job-detail {
            font-size: 14px;
            margin-bottom: 15px;
        }
        .tags {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            margin-bottom: 15px;
        }
        .tag {
            background-color: #efeff0;
            color: #74767e;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
        }
        .delete-btn {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #ff5722;
            color: #ffffff;
            text-align: center;
            text-decoration: none;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .delete-btn:hover {
            background-color: #e64a19;
        }
        .logout-btn, .new-job-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #1dbf73;
            color: #ffffff;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 600;
            transition: background-color 0.3s ease;
            margin-left: 10px;
            cursor: pointer;
        }
        .logout-btn:hover, .new-job-btn:hover {
            background-color: #19a463;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1001;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 4px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-group textarea {
            height: 100px;
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .job-card {
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .job-body {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .job-detail {
            font-size: 14px;
            margin-bottom: 15px;
            word-break: break-word;
        }

        .job-detail a {
            display: inline-block;
            max-width: 100%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .tags {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            margin-bottom: 15px;
            flex-grow: 1;
        }

        .delete-btn {
            margin-top: auto;
        }
    </style>
</head>
<body>
<header class="header">
    <nav class="nav-container">
        <a href="index.jsp" class="logo">VKareer</a>
        <div>
            <span class="new-job-btn" id="newJobBtn">New Job</span>
            <a href="logout" class="logout-btn">Logout</a>
        </div>
    </nav>
</header>

<main class="main-container">
    <%
        String message = (String) request.getAttribute("message");
        if (message != null && !message.isEmpty()) {
    %>
    <div class="message">
        <%= message %>
    </div>
    <%
        }
    %>

    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("adminLogin.jsp");
        } else {
    %>
    <h1 class="welcome-message">Welcome, <%= username %>!</h1>

    <div class="job-grid">
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                conn = DatabaseConnection.initializeDatabase();
                stmt = conn.createStatement();
                String sql = "SELECT * FROM job_postings";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    String jobLink = rs.getString("job_link");
                    if (!jobLink.startsWith("http://") && !jobLink.startsWith("https://")) {
                        jobLink = "http://" + jobLink;
                    }

                    String[] skills = rs.getString("technical_skills").split(",");
        %>
        <div class="job-card">
            <div class="job-header">
                <h2 class="job-title"><%= rs.getString("job_role").toUpperCase() %></h2>
                <p class="company-name"><%= rs.getString("company") %></p>
            </div>
            <div class="job-body">
                <p class="job-detail"><strong>Education:</strong> <%= rs.getString("education_criteria") %></p>
                <div class="tags">
                    <%
                        String[] locations = rs.getString("location").split(",");
                        for (String location : locations) {
                    %>
                    <span class="tag"><%= location.trim() %></span>
                    <%
                        }
                    %>
                </div>
                <p class="job-detail"><strong>Apply Link:</strong> <br><a href="<%= jobLink %>" target="_blank"><%= rs.getString("job_link") %></a></p>
                <div class="tags">
                    <%
                        for (String skill : skills) {
                    %>
                    <span class="tag"><%= skill.trim() %></span>
                    <%
                        }
                    %>
                </div>
                <form action="deletejob" method="post">
                    <input type="hidden" name="jobid" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="delete-btn">Delete Job</button>
                </form>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
    <%
        }
    %>
</main>

<!-- New Job Modal -->
<div id="newJobModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Add New Job</h2>
        <form action="newjob" method="post">
            <div class="form-group">
                <label for="jobrole">Job Role:</label>
                <input type="text" id="jobrole" name="jobrole" required>
            </div>
            <div class="form-group">
                <label for="company">Company:</label>
                <input type="text" id="company" name="company" required>
            </div>
            <div class="form-group">
                <label for="education">Education Criteria:</label>
                <input type="text" id="education" name="education" required>
            </div>
            <div class="form-group">
                <label for="location">Location:</label>
                <input type="text" id="location" name="location" required>
            </div>
            <div class="form-group">
                <label for="joblink">Job Link:</label>
                <input type="text" id="joblink" name="joblink" required>
            </div>
            <div class="form-group">
                <label for="skills">Technical Skills (comma-separated):</label>
                <textarea id="skills" name="skills" required></textarea>
            </div>
            <button type="submit" class="new-job-btn">Add Job</button>
        </form>
    </div>
</div>

<script>
    // Get the modal
    var modal = document.getElementById("newJobModal");

    // Get the button that opens the modal
    var btn = document.getElementById("newJobBtn");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks the button, open the modal
    btn.onclick = function() {
        modal.style.display = "block";
    }

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
</body>
</html>