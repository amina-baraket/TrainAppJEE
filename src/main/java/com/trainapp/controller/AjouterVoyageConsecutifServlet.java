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
import com.trainapp.dao.PreferenceDAO;
import com.trainapp.dao.TrajetDAO;
import com.trainapp.model.Classe;
import com.trainapp.model.Trajet;

@WebServlet("/AjouterVoyageConsecutifServlet")
public class AjouterVoyageConsecutifServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrajetDAO trajetDAO;
    private ClasseDAO classeDAO;
    private PreferenceDAO preferenceDAO;

    public AjouterVoyageConsecutifServlet() {
        super();
    }
    
    @Override
    public void init() throws ServletException {
        trajetDAO = new TrajetDAO();
        classeDAO = new ClasseDAO();
        preferenceDAO = new PreferenceDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String trajetIdParam = request.getParameter("trajetId");
        if (trajetIdParam == null || trajetIdParam.isEmpty()) {
            // Handle missing trajetId - fetch classes and preferences before forwarding
            request.setAttribute("error", "ID de trajet manquant.");
             List<Classe> classes = classeDAO.getAll();
            request.setAttribute("classes", classes);
            List<com.trainapp.model.Preference> preferences = preferenceDAO.getAll();
            request.setAttribute("preferences", preferences);
            request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);
            return;
        }

        try {
            int trajetId = Integer.parseInt(trajetIdParam);
            Trajet selectedTrajet = trajetDAO.findById(trajetId);

            if (selectedTrajet == null) {
                // Handle trajet not found - fetch classes and preferences before forwarding
                 request.setAttribute("error", "Trajet introuvable.");
                 List<Classe> classes = classeDAO.getAll();
                request.setAttribute("classes", classes);
                List<com.trainapp.model.Preference> preferences = preferenceDAO.getAll();
                request.setAttribute("preferences", preferences);
                 request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            
            // Get the current list of selected voyages from the session
            List<Trajet> selectedVoyages = (List<Trajet>) session.getAttribute("selectedVoyages");
            if (selectedVoyages == null) {
                selectedVoyages = new ArrayList<>();
            }

            // Add the newly selected consecutive voyage
            selectedVoyages.add(selectedTrajet);

            // Store the updated list back in the session
            session.setAttribute("selectedVoyages", selectedVoyages);

            // Fetch classes and preferences and forward back to the ChoixVoyageSuivant.jsp page
            List<Classe> classes = classeDAO.getAll();
            request.setAttribute("classes", classes);
            List<com.trainapp.model.Preference> preferences = preferenceDAO.getAll();
            request.setAttribute("preferences", preferences);

            request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Handle invalid trajetId format - fetch classes and preferences before forwarding
             request.setAttribute("error", "ID de trajet invalide.");
             List<Classe> classes = classeDAO.getAll();
            request.setAttribute("classes", classes);
            List<com.trainapp.model.Preference> preferences = preferenceDAO.getAll();
            request.setAttribute("preferences", preferences);
             request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Handle other potential exceptions - fetch classes and preferences before forwarding
             request.setAttribute("error", "Une erreur est survenue lors de l'ajout du voyage consécutif : " + e.getMessage());
             List<Classe> classes = classeDAO.getAll();
            request.setAttribute("classes", classes);
            List<com.trainapp.model.Preference> preferences = preferenceDAO.getAll();
            request.setAttribute("preferences", preferences);
             request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);
        }
    }
} 