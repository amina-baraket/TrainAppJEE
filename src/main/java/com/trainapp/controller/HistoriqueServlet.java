package com.trainapp.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainapp.dao.BilletDAO;
import com.trainapp.model.Billet;
import com.trainapp.model.User;

@WebServlet("/historique")
public class HistoriqueServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        BilletDAO billetDAO = new BilletDAO();
        List<Billet> billets = billetDAO.getBilletsUtilisesByUser(user);
        request.setAttribute("billets", billets);
        request.getRequestDispatcher("/historique.jsp").forward(request, response);
    }
}
