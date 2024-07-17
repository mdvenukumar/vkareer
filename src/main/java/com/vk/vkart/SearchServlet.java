package com.vk.vkart;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        // Store the query in the session or as a request attribute
        request.setAttribute("searchQuery", query);
        // Forward to the userjobs.jsp page
        request.getRequestDispatcher("userjobs.jsp").forward(request, response);
    }
}
