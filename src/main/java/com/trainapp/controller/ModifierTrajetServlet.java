package com.trainapp.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainapp.dao.TrajetDAO;
import com.trainapp.model.Trajet;

@WebServlet("/modifierTrajet")
public class ModifierTrajetServlet extends HttpServlet {

    private TrajetDAO trajetDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        trajetDAO = new TrajetDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String depart = request.getParameter("depart");
        String arrivee = request.getParameter("arrivee");
        double prix = Double.parseDouble(request.getParameter("prix"));

        Trajet t = new Trajet();
        t.setId(id); // Set the ID for update
        t.setDepart(depart); // Set depart
        t.setDestination(arrivee); // Set destination (assuming 'arrivee' maps to destination)
        t.setPrix(prix); // Set prix
        // Note: You might need to set other properties of Trajet here if they are part of the update form

        trajetDAO.updateTrajet(t);

        response.sendRedirect("listerTrajets");
    }
}