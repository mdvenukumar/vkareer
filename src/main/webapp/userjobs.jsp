<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, com.vk.vkart.DatabaseConnection" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VKareer - Job Listings</title>
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
        .search-bar {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 30px;
        }
        .search-bar input,
        .search-bar select {
            flex: 1;
            min-width: 200px;
            padding: 15px;
            font-size: 16px;
            border: 1px solid #dadbdd;
            border-radius: 4px;
        }
        .search-bar button {
            padding: 15px 30px;
            background-color: #1dbf73;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .search-bar button:hover {
            background-color: #19a463;
        }
        .job-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 30px;
        }
        .job-card {
            background-color: #ffffff;
            border: 1px solid #dadbdd;
            border-radius: 4px;
            overflow: hidden;
            transition: box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            height: 100%;
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
            display: flex;
            flex-direction: column;
            flex-grow: 1;
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
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
        }
        .location-tag {
            background-color: #e1f5fe;
            color: #0288d1;
        }
        .skill-tag {
            background-color: #f1f8e9;
            color: #689f38;
        }
        .apply-btn {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #1dbf73;
            color: #ffffff;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 600;
            transition: background-color 0.3s ease;
            margin-top: auto;
        }
        .apply-btn:hover {
            background-color: #19a463;
        }
        .no-jobs-message {
            text-align: center;
            font-size: 18px;
            margin-bottom: 30px;
            color: #404145;
        }
        @media (max-width: 768px) {
            .search-bar {
                flex-direction: column;
            }
            .search-bar input,
            .search-bar select,
            .search-bar button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<header class="header">
    <nav class="nav-container">
        <a href="index.jsp" class="logo">VKareer</a>
    </nav>
</header>

<main class="main-container">
    <form action="SearchServlet" method="GET" class="search-bar">
        <input type="text" name="query" placeholder="Search for jobs" value="${param.query}">
        <select name="location">
            <option value="">All Locations</option>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    conn = DatabaseConnection.initializeDatabase();
                    String sql = "SELECT DISTINCT location FROM job_postings";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        String location = rs.getString("location");
                        String[] locations = location.split(",");
                        for (String loc : locations) {
                            loc = loc.trim();
            %>
            <option value="<%= loc %>" <%= loc.equals(request.getParameter("location")) ? "selected" : "" %>><%= loc %></option>
            <%
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </select>
        <select name="skill">
            <option value="">All Skills</option>
            <%
                try {
                    conn = DatabaseConnection.initializeDatabase();
                    String sql = "SELECT DISTINCT technical_skills FROM job_postings";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        String skills = rs.getString("technical_skills");
                        String[] skillArray = skills.split(",");
                        for (String skill : skillArray) {
                            skill = skill.trim();
            %>
            <option value="<%= skill %>" <%= skill.equals(request.getParameter("skill")) ? "selected" : "" %>><%= skill %></option>
            <%
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </select>
        <button type="submit">Search</button>
    </form>

    <%
        boolean hasJobs = false;
        List<Map<String, String>> allJobs = new ArrayList<>();

        try {
            conn = DatabaseConnection.initializeDatabase();
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM job_postings WHERE 1=1");
            List<String> params = new ArrayList<>();

            String searchQuery = request.getParameter("query");
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                sqlBuilder.append(" AND (job_role LIKE ? OR company LIKE ? OR technical_skills LIKE ?)");
                String likeQuery = "%" + searchQuery.trim() + "%";
                params.add(likeQuery);
                params.add(likeQuery);
                params.add(likeQuery);
            }

            String locationFilter = request.getParameter("location");
            if (locationFilter != null && !locationFilter.isEmpty()) {
                sqlBuilder.append(" AND location LIKE ?");
                params.add("%" + locationFilter + "%");
            }

            String skillFilter = request.getParameter("skill");
            if (skillFilter != null && !skillFilter.isEmpty()) {
                sqlBuilder.append(" AND technical_skills LIKE ?");
                params.add("%" + skillFilter + "%");
            }

            pstmt = conn.prepareStatement(sqlBuilder.toString());
            for (int i = 0; i < params.size(); i++) {
                pstmt.setString(i + 1, params.get(i));
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                hasJobs = true;
                Map<String, String> job = new HashMap<>();
                job.put("job_role", rs.getString("job_role"));
                job.put("company", rs.getString("company"));
                job.put("education_criteria", rs.getString("education_criteria"));
                job.put("technical_skills", rs.getString("technical_skills"));
                job.put("location", rs.getString("location"));
                job.put("job_link", rs.getString("job_link"));
                allJobs.add(job);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        if (!hasJobs) {
    %>
    <p class="no-jobs-message">No jobs found matching your criteria. Here are some other available jobs:</p>
    <%
        }
    %>

    <div class="job-grid">
        <%
            for (Map<String, String> job : allJobs) {
                String jobLink = job.get("job_link");
                if (!jobLink.startsWith("http://") && !jobLink.startsWith("https://")) {
                    jobLink = "http://" + jobLink;
                }

                String[] skills = job.get("technical_skills").split(",");
                String[] locations = job.get("location").split(",");
        %>
        <div class="job-card">
            <div class="job-header">
                <h2 class="job-title"><%= job.get("job_role") %></h2>
                <p class="company-name"><%= job.get("company") %></p>
            </div>
            <div class="job-body">
                <p class="job-detail"><strong>Education:</strong> <%= job.get("education_criteria") %></p>
                <div class="tags">
                    <% for (String location : locations) { %>
                    <span class="tag location-tag"><%= location.trim() %></span>
                    <% } %>
                </div>
                <div class="tags">
                    <% for (String skill : skills) { %>
                    <span class="tag skill-tag"><%= skill.trim() %></span>
                    <% } %>
                </div>
                <a href="<%= jobLink %>" class="apply-btn" target="_blank">Apply Now</a>
            </div>
        </div>
        <%
            }
        %>
    </div>
</main>
</body>
</html>