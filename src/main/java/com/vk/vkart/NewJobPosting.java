package com.vk.vkart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/newjob")
public class NewJobPosting extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jobRole = request.getParameter("jobrole");
        String company = request.getParameter("company");
        String education = request.getParameter("education");
        String location = request.getParameter("location");
        String jobLink = request.getParameter("joblink");
        String skills = request.getParameter("skills");

        try {
            Connection conn = DatabaseConnection.initializeDatabase();
            String sql = "INSERT INTO job_postings (job_role, company, education_criteria, location, job_link, technical_skills) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobRole);
            pstmt.setString(2, company);
            pstmt.setString(3, education);
            pstmt.setString(4, location);
            pstmt.setString(5, jobLink);
            pstmt.setString(6, skills);
            pstmt.executeUpdate();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminPage.jsp");
    }
}
