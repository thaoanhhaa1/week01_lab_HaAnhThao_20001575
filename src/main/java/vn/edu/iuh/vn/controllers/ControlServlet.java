package vn.edu.iuh.vn.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mariadb.jdbc.Driver;
import vn.edu.iuh.vn.db.Database;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = {"/ControlServlet"})
public class ControlServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Database.getEntityManager();
        resp.setContentType("text/html");
        String action = req.getParameter("action");

        PrintWriter writer = resp.getWriter();

        writer.println("<h1>Hello</h1>");
        writer.println("<h1>"+action+"</h1>");

    }
}
