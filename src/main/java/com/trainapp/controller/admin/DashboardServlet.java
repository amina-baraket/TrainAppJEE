package com.trainapp.controller.admin;

import com.trainapp.dao.VoyageDAO;
import com.trainapp.dao.BilletDAO;
import com.trainapp.dao.DemandeAnnulationDAO;
import com.trainapp.dao.Userdao;
import com.trainapp.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class DashboardServlet extends HttpServlet {
    private VoyageDAO voyageDAO;
    private BilletDAO billetDAO;
    private DemandeAnnulationDAO demandeAnnulationDAO;
    private Userdao userDAO;
    
    @Override
    public void init() throws ServletException {
        voyageDAO = new VoyageDAO();
        billetDAO = new BilletDAO();
        demandeAnnulationDAO = new DemandeAnnulationDAO();
        userDAO = new Userdao();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Récupérer les statistiques
        long nombreVoyages = voyageDAO.count();
        long nombreBillets = billetDAO.count();
        long demandesEnAttente = demandeAnnulationDAO.countByStatut("EN_ATTENTE");
        long nombreUtilisateurs = userDAO.count();
        
        // Ajouter les statistiques à la requête
        request.setAttribute("nombreVoyages", nombreVoyages);
        request.setAttribute("nombreBillets", nombreBillets);
        request.setAttribute("demandesEnAttente", demandesEnAttente);
        request.setAttribute("nombreUtilisateurs", nombreUtilisateurs);
        
        // Afficher le tableau de bord
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
} 