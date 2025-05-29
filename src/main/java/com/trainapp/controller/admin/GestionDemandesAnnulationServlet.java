package com.trainapp.controller.admin;

import com.trainapp.dao.DemandeAnnulationDAO;
import com.trainapp.dao.BilletDAO;
import com.trainapp.model.DemandeAnnulation;
import com.trainapp.model.Billet;
import com.trainapp.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/demandes-annulation/*")
public class GestionDemandesAnnulationServlet extends HttpServlet {
    private DemandeAnnulationDAO demandeAnnulationDAO;
    private BilletDAO billetDAO;
    
    @Override
    public void init() throws ServletException {
        demandeAnnulationDAO = new DemandeAnnulationDAO();
        billetDAO = new BilletDAO();
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
        
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            listeDemandes(request, response);
        } else if (pathInfo.equals("/traiter")) {
            traiterDemande(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.equals("/traiter")) {
            traiterDemande(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void listeDemandes(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String statut = request.getParameter("statut");
        List<DemandeAnnulation> demandes;
        
        if (statut != null && !statut.isEmpty()) {
            demandes = demandeAnnulationDAO.getByStatut(statut);
        } else {
            demandes = demandeAnnulationDAO.getAll();
        }
        
        request.setAttribute("demandes", demandes);
        request.getRequestDispatcher("/admin/listeDemandesAnnulation.jsp")
               .forward(request, response);
    }
    
    private void traiterDemande(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int demandeId = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");
        String commentaire = request.getParameter("commentaire");
        
        DemandeAnnulation demande = demandeAnnulationDAO.getById(demandeId);
        if (demande == null) {
            request.setAttribute("error", "Demande non trouvée");
            listeDemandes(request, response);
            return;
        }
        
        if ("accepter".equals(action)) {
            demande.setStatut("ACCEPTEE");
            Billet billet = demande.getBillet();
            billet.setStatut(Billet.Statut.ANNULE);
            billetDAO.update(billet);
        } else if ("refuser".equals(action)) {
            demande.setStatut("REFUSEE");
        } else {
            request.setAttribute("error", "Action invalide");
            listeDemandes(request, response);
            return;
        }
        
        demande.setDateTraitement(new Date());
        demande.setCommentaireAdmin(commentaire);
        demandeAnnulationDAO.update(demande);
        
        request.setAttribute("success", "La demande a été traitée avec succès");
        listeDemandes(request, response);
    }
} 