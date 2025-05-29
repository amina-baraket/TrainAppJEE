/*package com.trainapp.controller;

import com.trainapp.dao.PaiementDAO;
import com.trainapp.model.Paiement;
import com.trainapp.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Date;

@WebServlet("/ajouterPaiement")
public class AjouterPaiementServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double montant = Double.parseDouble(request.getParameter("montant"));
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            User utilisateur = (User) session.getAttribute("user");

            Paiement paiement = new Paiement();
            paiement.setMontant(montant);
            paiement.setDatePaiement(new Date());
            paiement.setUser(utilisateur);

            PaiementDAO.ajouterPaiement(paiement);

            response.sendRedirect("gererPaiements");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}*/
