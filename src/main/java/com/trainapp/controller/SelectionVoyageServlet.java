package com.trainapp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.ClasseDAO;
import com.trainapp.dao.GareDAO;
import com.trainapp.dao.PreferenceDAO;
import com.trainapp.dao.TrajetDAO;
import com.trainapp.model.Classe;
import com.trainapp.model.Gare;
import com.trainapp.model.Trajet;

@WebServlet("/SelectionVoyageServlet")
public class SelectionVoyageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrajetDAO trajetDAO;
    private ClasseDAO classeDAO;
    private PreferenceDAO preferenceDAO;
    private GareDAO gareDAO;

    public SelectionVoyageServlet() {
        super();
    }
    
    @Override
    public void init() throws ServletException {
        trajetDAO = new TrajetDAO();
        classeDAO = new ClasseDAO();
        preferenceDAO = new PreferenceDAO();
        gareDAO = new GareDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String trajetIdParam = req.getParameter("trajetId");
        if (trajetIdParam == null || trajetIdParam.isEmpty()) {
            req.setAttribute("error", "Aucun trajet sélectionné.");
            req.getRequestDispatcher("/RechercheTrajet.jsp").forward(req, resp);
            return;
        }

        try {
            int trajetId = Integer.parseInt(trajetIdParam);
            Trajet trajetSelectionne = trajetDAO.findById(trajetId);

            if (trajetSelectionne == null) {
                req.setAttribute("error", "Trajet introuvable.");
                req.getRequestDispatcher("/RechercheTrajet.jsp").forward(req, resp);
                return;
            }

            // Récupérer la liste des classes disponibles
            List<Classe> classes = classeDAO.getAll();
            System.out.println("Nombre de classes récupérées : " + (classes != null ? classes.size() : "null"));
            req.setAttribute("classes", classes);

            // Récupérer la liste des préférences disponibles
            List<com.trainapp.model.Preference> preferences = preferenceDAO.getAll();
            System.out.println("Nombre de préférences récupérées : " + (preferences != null ? preferences.size() : "null"));
            req.setAttribute("preferences", preferences);

        HttpSession session = req.getSession();
            // Initialize selected voyages list if it doesn't exist
            List<Trajet> selectedVoyages = (List<Trajet>) session.getAttribute("selectedVoyages");
             if (selectedVoyages == null) {
                selectedVoyages = new ArrayList<>();
            }
            // Add the newly selected voyage
            selectedVoyages.add(trajetSelectionne);
            // Store the updated list back in the session
            session.setAttribute("selectedVoyages", selectedVoyages);

            // Get the destination Gare object using the destination city name from the selected trajet
            // Assuming getByVille returns a list and we take the first one
            List<Gare> destinationGares = gareDAO.getByVille(trajetSelectionne.getDestination());
            Gare gareDestination = null;
            if (destinationGares != null && !destinationGares.isEmpty()) {
                gareDestination = destinationGares.get(0);
            }
            req.setAttribute("gareDestination", gareDestination);

            // Récupérer la liste de toutes les gares pour le dropdown de voyage consécutif
            List<Gare> gares = gareDAO.getAll();
            System.out.println("Nombre de gares récupérées : " + (gares != null ? gares.size() : "null"));
            req.setAttribute("gares", gares);

        req.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("error", "ID de trajet invalide.");
            req.getRequestDispatcher("/RechercheTrajet.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Une erreur est survenue lors de la sélection du trajet : " + e.getMessage());
            req.getRequestDispatcher("/RechercheTrajet.jsp").forward(req, resp);
        }
    }
}
