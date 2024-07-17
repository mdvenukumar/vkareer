package com.vk.vkart;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class AdminLogin extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if ("venu".equals(username) && "1234".equals(password)) {
            req.getSession().setAttribute("username", username);
            res.sendRedirect("adminPage.jsp");
        } else {
            res.sendRedirect("adminLogin.jsp");
        }
    }
}
