package com.trainapp.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

@WebServlet("/RechercheVoyageConsecutifServlet")
public class RechercheVoyageConsecutifServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrajetDAO trajetDAO;
    private GareDAO gareDAO;

    public RechercheVoyageConsecutifServlet() {
        super();
    }
    
    @Override
    public void init() throws ServletException {
        trajetDAO = new TrajetDAO();
        gareDAO = new GareDAO(); // Initialize GareDAO
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String departIdParam = request.getParameter("departId");
        String destinationIdParam = request.getParameter("destinationId");
        String dateDepartParam = request.getParameter("date_depart");

        if (departIdParam == null || departIdParam.isEmpty() || destinationIdParam == null || destinationIdParam.isEmpty() || dateDepartParam == null || dateDepartParam.isEmpty()) {
            // Handle missing parameters - potentially redirect back to the previous page with an error
            request.setAttribute("error", "Veuillez remplir tous les champs obligatoires pour le voyage consécutif.");
            // We need gares to be available even on error page for the form
            List<Gare> gares = gareDAO.getAll();
            request.setAttribute("gares", gares);
            request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);
            return;
        }

        try {
            int departId = Integer.parseInt(departIdParam);
            int destinationId = Integer.parseInt(destinationIdParam);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Assuming date format from HTML date input
            java.util.Date utilDate = sdf.parse(dateDepartParam);
            Date sqlDate = new Date(utilDate.getTime());

            List<Trajet> trajets = trajetDAO.rechercherTrajetsParDateEtGares(sqlDate, departId, destinationId);

            request.setAttribute("trajetsConsecutifs", trajets);
            request.setAttribute("searchDate", dateDepartParam);
            request.setAttribute("departId", departId);
            request.setAttribute("destinationId", destinationId);

            // Add list of all gares to request scope for the JSP
            List<Gare> gares = gareDAO.getAll();
            request.setAttribute("gares", gares);

            request.getRequestDispatcher("/ListeVoyagesConsecutifs.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de gare invalide.");
            // We need gares to be available even on error page for the form
            List<Gare> gares = gareDAO.getAll();
            request.setAttribute("gares", gares);
            request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);
        } catch (ParseException e) {
            request.setAttribute("error", "Format de date invalide. Veuillez utiliser le format JJ/MM/AAAA.");
            // We need gares to be available even on error page for the form
            List<Gare> gares = gareDAO.getAll();
            request.setAttribute("gares", gares);
            request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Une erreur est survenue lors de la recherche de voyages consécutifs : " + e.getMessage());
            // We need gares to be available even on error page for the form
            List<Gare> gares = gareDAO.getAll();
            request.setAttribute("gares", gares);
            request.getRequestDispatcher("/ChoixVoyageSuivant.jsp").forward(request, response);
        }
    }
} 