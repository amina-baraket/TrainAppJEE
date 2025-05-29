package com.trainapp.controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.GareDAO;
import com.trainapp.dao.TrajetDAO; // Assuming GareDAO is needed for origins/destinations
import com.trainapp.dao.VoyageDAO;
import com.trainapp.model.Gare;
import com.trainapp.model.Trajet;
import com.trainapp.model.User;

@WebServlet("/admin/voyages/*")
public class GestionVoyageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VoyageDAO voyageDAO;
    private GareDAO gareDAO; // Assuming GareDAO is needed
    private TrajetDAO trajetDAO; // Initialize TrajetDAO
    
    @Override
    public void init() throws ServletException {
        voyageDAO = new VoyageDAO();
        gareDAO = new GareDAO(); // Initialize GareDAO
        trajetDAO = new TrajetDAO(); // Initialize TrajetDAO
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Vérification que l'utilisateur est connecté et est admin
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getPathInfo();
        
        try {
            if (action == null || action.equals("/") || action.equals("/liste")) {
                listeVoyages(request, response);
            } else if (action.equals("/ajouter")) {
                afficherFormulaireAjout(request, response);
            } else if (action.equals("/modifier")) {
                afficherFormulaireModification(request, response);
            } else if (action.equals("/supprimer")) {
                supprimerVoyage(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getPathInfo();
        
        try {
            if (action != null && action.equals("/ajouter")) {
                ajouterVoyage(request, response);
            } else if (action != null && action.equals("/modifier")) {
                modifierVoyage(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
        }
    }
    
    private void listeVoyages(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Récupérer tous les trajets
            List<Trajet> trajets = trajetDAO.getAllTrajets();
            request.setAttribute("voyages", trajets);
            request.getRequestDispatcher("/admin/listeVoyages.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue lors de la récupération des voyages : " + e.getMessage());
            request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
        }
    }
    
    private void afficherFormulaireAjout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // TODO: Implement logic to prepare data for add form (e.g., list of gares)
        List<Gare> gares = gareDAO.getAll();
        request.setAttribute("gares", gares);
        request.getRequestDispatcher("/admin/ajouterVoyage.jsp").forward(request, response);
    }
    
    private void afficherFormulaireModification(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Trajet trajet = trajetDAO.findById(id);
            
            if (trajet == null) {
                request.setAttribute("error", "Trajet non trouvé.");
                listeVoyages(request, response);
                return;
            }

            List<Gare> gares = gareDAO.getAll();
            request.setAttribute("trajet", trajet);
            request.setAttribute("gares", gares);
            request.getRequestDispatcher("/admin/modifierVoyage.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de trajet invalide.");
            listeVoyages(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            listeVoyages(request, response);
        }
    }
    
    private void ajouterVoyage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Récupérer les paramètres du formulaire
            String depart = request.getParameter("depart");
            String destination = request.getParameter("destination");
            java.sql.Date dateDepart = java.sql.Date.valueOf(request.getParameter("dateDepart"));
            java.sql.Time heureDepart = java.sql.Time.valueOf(request.getParameter("heureDepart") + ":00");
            java.sql.Time heureArrivee = java.sql.Time.valueOf(request.getParameter("heureArrivee") + ":00");
            double prix = Double.parseDouble(request.getParameter("prix"));
            int placesDisponibles = Integer.parseInt(request.getParameter("placesDisponibles"));
            double promotionPercentage = Double.parseDouble(request.getParameter("promotionPercentage"));

            // Créer un nouveau trajet
            Trajet trajet = new Trajet();
            trajet.setDepart(depart);
            trajet.setDestination(destination);
            trajet.setDate_depart(dateDepart);
            trajet.setHeure_depart(heureDepart);
            trajet.setHeure_arrivee(heureArrivee);
            trajet.setPrix(prix);
            trajet.setPlaces_disponibles(placesDisponibles);
            trajet.setPromotionPercentage(promotionPercentage);

            // Sauvegarder le trajet
            trajetDAO.saveTrajet(trajet);

            // Rediriger vers la liste des voyages avec un message de succès
            request.setAttribute("success", "Le voyage a été ajouté avec succès.");
            listeVoyages(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue lors de l'ajout du voyage : " + e.getMessage());
            afficherFormulaireAjout(request, response);
        }
    }
    
    private void modifierVoyage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Trajet trajetToUpdate = trajetDAO.findById(id);

            if (trajetToUpdate == null) {
                request.setAttribute("error", "Trajet non trouvé pour la modification.");
                listeVoyages(request, response);
                return;
            }

            // Récupérer les paramètres du formulaire
            String depart = request.getParameter("depart");
            String destination = request.getParameter("destination");
            java.sql.Date dateDepart = java.sql.Date.valueOf(request.getParameter("dateDepart"));
            java.sql.Time heureDepart = java.sql.Time.valueOf(request.getParameter("heureDepart") + ":00");
            java.sql.Time heureArrivee = java.sql.Time.valueOf(request.getParameter("heureArrivee") + ":00");
            double prix = Double.parseDouble(request.getParameter("prix"));
            int placesDisponibles = Integer.parseInt(request.getParameter("placesDisponibles"));
            double promotionPercentage = Double.parseDouble(request.getParameter("promotionPercentage"));

            // Mettre à jour les propriétés du trajet
            trajetToUpdate.setDepart(depart);
            trajetToUpdate.setDestination(destination);
            trajetToUpdate.setDate_depart(dateDepart);
            trajetToUpdate.setHeure_depart(heureDepart);
            trajetToUpdate.setHeure_arrivee(heureArrivee);
            trajetToUpdate.setPrix(prix);
            trajetToUpdate.setPlaces_disponibles(placesDisponibles);
            trajetToUpdate.setPromotionPercentage(promotionPercentage);

            // Sauvegarder les modifications
            trajetDAO.updateTrajet(trajetToUpdate);

            request.setAttribute("success", "Le voyage a été modifié avec succès.");
            listeVoyages(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Format de données invalide.");
            listeVoyages(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue lors de la modification du voyage : " + e.getMessage());
            listeVoyages(request, response);
        }
    }
    
    private void supprimerVoyage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            trajetDAO.deleteTrajet(id);
            request.setAttribute("success", "Le voyage a été supprimé avec succès.");
            listeVoyages(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de voyage invalide.");
            listeVoyages(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue lors de la suppression du voyage : " + e.getMessage());
            listeVoyages(request, response);
        }
    }
} 