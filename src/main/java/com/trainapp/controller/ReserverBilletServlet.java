package com.trainapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainapp.dao.BilletDAO;
import com.trainapp.model.Billet;
import com.trainapp.model.Trajet;
import com.trainapp.model.User;
import com.trainapp.dao.TrajetDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ReserverBilletServlet")
public class ReserverBilletServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int trajetId = Integer.parseInt(request.getParameter("trajetId"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Assurez-vous que l'objet est mis en session

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        TrajetDAO trajetDAO = new TrajetDAO();
        Trajet trajet = trajetDAO.findById(trajetId);

        if (trajet != null && trajet.getPlaces_disponibles() > 0) {
            Billet billet = new Billet();
            billet.setUser(user);
            billet.setTrajet(trajet);
           /* billet.setStatut("acheté");*/

            BilletDAO billetDAO = new BilletDAO();
            billetDAO.ajouterBillet(billet);

            trajet.setPlaces_disponibles(trajet.getPlaces_disponibles() - 1);
            trajetDAO.updateTrajet(trajet);

            request.setAttribute("message", "Billet réservé avec succès !");
        } else {
            request.setAttribute("message", "Plus de places disponibles !");
        }

        request.getRequestDispatcher("Home.jsp").forward(request, response);
    }
}