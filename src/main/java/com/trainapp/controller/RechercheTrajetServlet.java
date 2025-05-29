package com.trainapp.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainapp.dao.GareDAO;
import com.trainapp.dao.TrajetDAO;
import com.trainapp.model.Gare;
import com.trainapp.model.Trajet;

/**
 * Servlet implementation class RechercheTrajetServlet
 */
@WebServlet("/RechercheTrajetServlet")
public class RechercheTrajetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TrajetDAO trajetDAO;
	private GareDAO gareDAO;
       
    @Override
    public void init() throws ServletException {
        trajetDAO = new TrajetDAO();
        gareDAO = new GareDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("--- Entrée dans RechercheTrajetServlet doGet ---"); // Added debug print
		// Rediriger vers la page de recherche si accès en GET
		try {
			List<Gare> gares = gareDAO.getAll(); // Get all stations
            System.out.println("Nombre de gares récupérées (GET): " + (gares != null ? gares.size() : "null")); // Debug print
			request.setAttribute("gares", gares); // Pass stations to JSP
			request.getRequestDispatcher("RechercheTrajet.jsp").forward(request, response);
		} catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des gares : " + e.getMessage());
            request.getRequestDispatcher("RechercheTrajet.jsp").forward(request, response);
        }

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			System.out.println("--- Entrée dans RechercheTrajetServlet doPost ---"); // Debug print
			// Récupération des paramètres
			String departIdParam = request.getParameter("departId");
			String destinationIdParam = request.getParameter("destinationId");
            String dateDepartParam = request.getParameter("date_depart"); // Get date parameter as string

            System.out.println("Debug: Received departIdParam: " + departIdParam); // Debug print
            System.out.println("Debug: Received destinationIdParam: " + destinationIdParam); // Debug print
            System.out.println("Debug: Received dateDepartParam: " + dateDepartParam); // Debug print

			Date dateDepart = null;
            if (dateDepartParam != null && !dateDepartParam.isEmpty()) {
                dateDepart = Date.valueOf(dateDepartParam);
            }

			// Convert IDs to integers
            int departId = -1;
            int destinationId = -1;
            if (departIdParam != null && !departIdParam.isEmpty()) {
                 departId = Integer.parseInt(departIdParam);
            }
             if (destinationIdParam != null && !destinationIdParam.isEmpty()) {
                 destinationId = Integer.parseInt(destinationIdParam);
            }

			// Validation des paramètres
			if (departId == -1 || destinationId == -1 || dateDepart == null) {
				request.setAttribute("error", "Veuillez remplir tous les champs obligatoires");
                // Pass stations back to JSP in case of error
                List<Gare> gares = gareDAO.getAll();
                System.out.println("Nombre de gares récupérées (POST - validation erreur): " + (gares != null ? gares.size() : "null")); // Debug print
                request.setAttribute("gares", gares);
				request.getRequestDispatcher("RechercheTrajet.jsp").forward(request, response);
				return;
			}

			// Recherche des trajets par IDs de gare et date
			List<Trajet> trajets = trajetDAO.rechercherTrajetsParDateEtGares(dateDepart, departId, destinationId);

			// Ajout des résultats à la requête
			request.setAttribute("trajets", trajets);
			request.setAttribute("date_recherche", dateDepart.toString());
			request.setAttribute("depart_recherche_id", departId); // Pass IDs back
			request.setAttribute("destination_recherche_id", destinationId); // Pass IDs back
            
            // Pass stations back to JSP
            List<Gare> gares = gareDAO.getAll();
             System.out.println("Nombre de gares récupérées (POST - succès): " + (gares != null ? gares.size() : "null")); // Debug print
            request.setAttribute("gares", gares);

			// Redirection vers la page de recherche avec les résultats
			request.getRequestDispatcher("RechercheTrajet.jsp").forward(request, response);

		} catch (NumberFormatException e) {
            // Handle invalid ID format
            request.setAttribute("error", "ID de gare invalide.");
             List<Gare> gares = gareDAO.getAll();
             System.out.println("Nombre de gares récupérées (POST - NumberFormatException): " + (gares != null ? gares.size() : "null")); // Debug print
            request.setAttribute("gares", gares);
            request.getRequestDispatcher("RechercheTrajet.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace(); // Pour le débogage
			request.setAttribute("error", "Une erreur est survenue lors de la recherche : " + e.getMessage());
             List<Gare> gares = gareDAO.getAll();
             System.out.println("Nombre de gares récupérées (POST - Exception): " + (gares != null ? gares.size() : "null")); // Debug print
            request.setAttribute("gares", gares);
			request.getRequestDispatcher("RechercheTrajet.jsp").forward(request, response);
		}
    }
}
