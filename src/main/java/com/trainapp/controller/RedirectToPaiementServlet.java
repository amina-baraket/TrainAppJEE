package com.trainapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RedirectToPaiementServlet")
public class RedirectToPaiementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RedirectToPaiementServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            // Utilisateur connecté : aller à la page de paiement
            req.getRequestDispatcher("/Paiement.jsp").forward(req, resp);
        } else {
            // Utilisateur non connecté : redirection vers login
            resp.sendRedirect("login.jsp");
        }
    }
}
