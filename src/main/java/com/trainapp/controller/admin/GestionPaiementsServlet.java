package com.trainapp.controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.PaiementDAO;
import com.trainapp.dao.BilletDAO;
import com.trainapp.model.Paiement;
import com.trainapp.model.Billet;
import com.trainapp.model.User;

@WebServlet("/admin/paiements/*")
public class GestionPaiementsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PaiementDAO paiementDAO;
    private BilletDAO billetDAO;
    
    @Override
    public void init() throws ServletException {
        paiementDAO = new PaiementDAO();
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
        
        String action = request.getPathInfo();
        
        if (action == null || action.equals("/")) {
            listePaiements(request, response);
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
        
        String action = request.getPathInfo();
        
        if (action != null && action.equals("/rembourser")) {
            rembourserPaiement(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void listePaiements(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String statut = request.getParameter("statut");
            if (statut != null && !statut.isEmpty()) {
                request.setAttribute("paiements", paiementDAO.getByStatut(statut));
            } else {
                request.setAttribute("paiements", paiementDAO.getAll());
            }
            request.getRequestDispatcher("/admin/listePaiements.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la récupération des paiements : " + e.getMessage());
            request.getRequestDispatcher("/admin/listePaiements.jsp").forward(request, response);
        }
    }
    
    private void rembourserPaiement(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int paiementId = Integer.parseInt(request.getParameter("id"));
            String commentaire = request.getParameter("commentaire");
            
            Paiement paiement = paiementDAO.getById(paiementId);
            if (paiement == null) {
                request.setAttribute("error", "Paiement non trouvé");
                listePaiements(request, response);
                return;
            }
            
            Billet billet = paiement.getBillet();
            if (billet == null || !billet.getStatut().equals(Billet.Statut.ANNULE)) {
                request.setAttribute("error", "Le billet associé n'est pas annulé");
                listePaiements(request, response);
                return;
            }
            
            paiement.setStatut(Paiement.Statut.REMBOURSE);
            paiement.setCommentaire(commentaire);
            paiementDAO.update(paiement);
            
            request.setAttribute("success", "Le paiement a été remboursé avec succès");
            response.sendRedirect(request.getContextPath() + "/admin/paiements");
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du remboursement : " + e.getMessage());
            listePaiements(request, response);
        }
    }
} 