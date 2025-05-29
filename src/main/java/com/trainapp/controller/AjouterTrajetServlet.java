package com.trainapp.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainapp.dao.TrajetDAO;
import com.trainapp.model.Trajet;

@WebServlet("/admin/ajouterTrajet")
public class AjouterTrajetServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String depart = request.getParameter("depart");
        String destination = request.getParameter("destination");
        Date dateDepart = Date.valueOf(request.getParameter("date_depart"));
        Time heureDepart = Time.valueOf(request.getParameter("heure_depart"));
        Time heureArrivee = Time.valueOf(request.getParameter("heure_arrivee"));
        double prix = Double.parseDouble(request.getParameter("prix"));
        int placesDisponibles = Integer.parseInt(request.getParameter("places_disponibles"));

        Trajet trajet = new Trajet();
        trajet.setDepart(depart);
        trajet.setDestination(destination);
        trajet.setDate_depart(dateDepart);
        trajet.setHeure_depart(heureDepart);
        trajet.setHeure_arrivee(heureArrivee);
        trajet.setPrix(prix);
        trajet.setPlaces_disponibles(placesDisponibles);

        TrajetDAO trajetDAO = new TrajetDAO();
        trajetDAO.saveTrajet(trajet);  

        response.sendRedirect("listeTrajets.jsp");
    }
}