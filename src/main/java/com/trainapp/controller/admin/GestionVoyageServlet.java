package com.trainapp.controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.VoyageDAO;
import com.trainapp.dao.GareDAO; // Assuming GareDAO is needed for origins/destinations
import com.trainapp.model.User;
import com.trainapp.model.Voyage;
import com.trainapp.model.Gare;

@WebServlet("/admin/voyages/*")
public class GestionVoyageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VoyageDAO voyageDAO;
    private GareDAO gareDAO; // Assuming GareDAO is needed
    
    @Override
    public void init() throws ServletException {
        voyageDAO = new VoyageDAO();
        gareDAO = new GareDAO(); // Initialize GareDAO
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
        // TODO: Implement logic to retrieve and list voyages
        List<Voyage> voyages = voyageDAO.getAll();
        request.setAttribute("voyages", voyages);
        request.getRequestDispatcher("/admin/listeVoyages.jsp").forward(request, response);
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
        // TODO: Implement logic to retrieve voyage data and prepare form data (e.g., list of gares)
        int id = Integer.parseInt(request.getParameter("id"));
        Voyage voyage = voyageDAO.getById(id);
        List<Gare> gares = gareDAO.getAll();
        
        request.setAttribute("voyage", voyage);
        request.setAttribute("gares", gares);
        request.getRequestDispatcher("/admin/modifierVoyage.jsp").forward(request, response);
    }
    
    private void ajouterVoyage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // TODO: Implement logic to create and save a new voyage
        // This will involve parsing form parameters and creating a Voyage object
        response.sendRedirect(request.getContextPath() + "/admin/voyages/liste");
    }
    
    private void modifierVoyage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // TODO: Implement logic to update an existing voyage
        // This will involve parsing form parameters and updating the Voyage object
        response.sendRedirect(request.getContextPath() + "/admin/voyages/liste");
    }
    
    private void supprimerVoyage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // TODO: Implement logic to delete a voyage
        int id = Integer.parseInt(request.getParameter("id"));
        voyageDAO.delete(id);
        response.sendRedirect(request.getContextPath() + "/admin/voyages/liste");
    }
} 