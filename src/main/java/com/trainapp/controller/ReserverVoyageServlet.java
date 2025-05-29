package com.trainapp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.BilletDAO;
import com.trainapp.dao.ClasseDAO;
import com.trainapp.dao.PreferenceDAO;
import com.trainapp.dao.TrajetDAO;
import com.trainapp.model.Billet;
import com.trainapp.model.Classe;
import com.trainapp.model.Trajet;
import com.trainapp.model.User;





@WebServlet("/ReserverVoyageServlet")
public class ReserverVoyageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrajetDAO trajetDAO;
    private ClasseDAO classeDAO;
    private PreferenceDAO preferenceDAO;
    private BilletDAO billetDAO;

    @Override
    public void init() throws ServletException {
        trajetDAO = new TrajetDAO();
        classeDAO = new ClasseDAO();
        preferenceDAO = new PreferenceDAO();
        billetDAO = new BilletDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Don't create a new session if one doesn't exist
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        // 1. Vérifier si l'utilisateur est connecté
        if (user == null) {
            // Rediriger vers la page de connexion/inscription
            request.setAttribute("error", "Veuillez vous connecter pour réserver.");
            // Stocker l'URL demandée en session pour redirection après login
            if (session == null) { // Créer une nouvelle session si elle n'existe pas
                session = request.getSession(true);
            }
            session.setAttribute("redirect_url", request.getRequestURL().toString() + (request.getQueryString() != null ? "?" + request.getQueryString() : ""));
            
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 2. Récupérer les informations de la classe et préférences
        String classeIdParam = request.getParameter("classeId");
        String[] preferenceIds = request.getParameterValues("preferences"); // Get selected preference IDs

        // Retrieve the list of selected voyages from the session
        List<Trajet> selectedVoyages = (List<Trajet>) session.getAttribute("selectedVoyages");

        if (selectedVoyages == null || selectedVoyages.isEmpty() || classeIdParam == null || classeIdParam.isEmpty()) {
            request.setAttribute("error", "Informations de réservation manquantes.");
            request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);
            return;
        }

        try {
            int classeId = Integer.parseInt(classeIdParam);

            // 3. Récupérer l'objet Classe
            Classe classe = classeDAO.getById(classeId);

            if (classe == null) {
                request.setAttribute("error", "Classe introuvable.");
                request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);
                return;
            }

            // 4. Créer des Billets pour chaque trajet dans l'itinéraire
            List<Billet> billetsCrees = new ArrayList<>();
            double prixTotalItineraire = 0;

            for (Trajet trajet : selectedVoyages) {
                 // Create a new Billet for each Trajet
                Billet billet = new Billet();
                billet.setUser(user);
                billet.setTrajet(trajet);
                billet.setClasse(classe);
                billet.setDateAchat(new Date());
                billet.setStatut(Billet.Statut.ACHETE); // Assuming payment is handled later
                
                 // 5. Gérer les préférences pour ce billet (applying same preferences to all legs for now)
                 if (preferenceIds != null) {
                    for (String prefId : preferenceIds) {
                        try {
                            int id = Integer.parseInt(prefId);
                            com.trainapp.model.Preference preference = preferenceDAO.getById(id);
                            if (preference != null) {
                                billet.addPreference(preference); // Assuming Billet model has addPreference method
                            }
                        } catch (NumberFormatException e) {
                            System.err.println("ID de préférence invalide : " + prefId); // Log error
                        }
                    }
                }

                // 6. Calculer le prix pour ce billet
                double prixBase = trajet.getPrix();
                double coefficientPrix = classe.getCoefficientPrix();
                double prixBillet = prixBase * coefficientPrix;
                
                // Ajouter le coût des préférences sélectionnées
                if (billet.getPreferences() != null) {
                    for (com.trainapp.model.Preference preference : billet.getPreferences()) {
                        prixBillet += preference.getCoutSupplementaire();
                    }
                }

                billet.setPrixFinal(prixBillet);
                
                // Add to total price
                prixTotalItineraire += prixBillet;

                // For now, seat number is placeholder
                billet.setNumeroSiege("À attribuer");

                // Save the Billet (assuming save method handles individual billets)
                billetDAO.save(billet);

                billetsCrees.add(billet);
            }
            
             // Clear the selected voyages from session after creating tickets
            session.removeAttribute("selectedVoyages");

            // 7. Rediriger vers la page de paiement ou confirmation
            // You might pass the list of created billets or the total price
             request.setAttribute("billetsCrees", billetsCrees);
             request.setAttribute("prixTotalItineraire", prixTotalItineraire);

            request.getRequestDispatcher("/Paiement.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de classe ou de préférence invalide.");
            request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Une erreur est survenue lors de la réservation : " + e.getMessage());
            request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);
        }
    }
}
