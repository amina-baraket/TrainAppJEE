package com.trainapp.controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.VoyageConsecutifDAO;
import com.trainapp.dao.VoyageDAO;
import com.trainapp.model.User;
import com.trainapp.model.Voyage;
import com.trainapp.model.VoyageConsecutif;

@WebServlet("/admin/voyages-consecutifs/*")
public class GestionVoyageConsecutifServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VoyageConsecutifDAO voyageConsecutifDAO;
    private VoyageDAO voyageDAO;
    
    @Override
    public void init() throws ServletException {
        voyageConsecutifDAO = new VoyageConsecutifDAO();
        voyageDAO = new VoyageDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getPathInfo();
        
        try {
            if (action == null || action.equals("/") || action.equals("")) {
                listeVoyagesConsecutifs(request, response);
            } else {
                switch (action) {
                    case "/liste":
                        listeVoyagesConsecutifs(request, response);
                        break;
                    case "/ajouter":
                        afficherFormulaireAjout(request, response);
                        break;
                    case "/modifier":
                        afficherFormulaireModification(request, response);
                        break;
                    case "/supprimer":
                        supprimerVoyageConsecutif(request, response);
                        break;
                    default:
                        response.sendError(HttpServletResponse.SC_NOT_FOUND);
                        break;
                }
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
            switch (action) {
                case "/ajouter":
                    ajouterVoyageConsecutif(request, response);
                    break;
                case "/modifier":
                    modifierVoyageConsecutif(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/voyages-consecutifs/liste");
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
        }
    }
    
    private void listeVoyagesConsecutifs(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<VoyageConsecutif> voyagesConsecutifs = voyageConsecutifDAO.getAll();
        request.setAttribute("voyagesConsecutifs", voyagesConsecutifs);
        request.getRequestDispatcher("/admin/listeVoyagesConsecutifs.jsp").forward(request, response);
    }
    
    private void afficherFormulaireAjout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Voyage> voyages = voyageDAO.getAll();
        request.setAttribute("voyages", voyages);
        request.getRequestDispatcher("/admin/ajouterVoyageConsecutif.jsp").forward(request, response);
    }
    
    private void afficherFormulaireModification(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        VoyageConsecutif voyageConsecutif = voyageConsecutifDAO.getById(id);
        List<Voyage> voyages = voyageDAO.getAll();
        
        request.setAttribute("voyageConsecutif", voyageConsecutif);
        request.setAttribute("voyages", voyages);
        request.getRequestDispatcher("/admin/modifierVoyageConsecutif.jsp").forward(request, response);
    }
    
    private void ajouterVoyageConsecutif(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        VoyageConsecutif voyageConsecutif = new VoyageConsecutif();
        
        int voyageInitialId = Integer.parseInt(request.getParameter("voyageInitial"));
        int voyageSuivantId = Integer.parseInt(request.getParameter("voyageSuivant"));
        
        Voyage voyageInitial = voyageDAO.getById(voyageInitialId);
        Voyage voyageSuivant = voyageDAO.getById(voyageSuivantId);
        
        voyageConsecutif.setVoyageInitial(voyageInitial);
        voyageConsecutif.setVoyageSuivant(voyageSuivant);
        voyageConsecutif.setDureeAttente(Integer.parseInt(request.getParameter("dureeAttente")));
        voyageConsecutif.setActif(true);
        
        voyageConsecutifDAO.save(voyageConsecutif);
        response.sendRedirect(request.getContextPath() + "/admin/voyages-consecutifs/liste");
    }
    
    private void modifierVoyageConsecutif(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        VoyageConsecutif voyageConsecutif = voyageConsecutifDAO.getById(id);
        
        int voyageInitialId = Integer.parseInt(request.getParameter("voyageInitial"));
        int voyageSuivantId = Integer.parseInt(request.getParameter("voyageSuivant"));
        
        Voyage voyageInitial = voyageDAO.getById(voyageInitialId);
        Voyage voyageSuivant = voyageDAO.getById(voyageSuivantId);
        
        voyageConsecutif.setVoyageInitial(voyageInitial);
        voyageConsecutif.setVoyageSuivant(voyageSuivant);
        voyageConsecutif.setDureeAttente(Integer.parseInt(request.getParameter("dureeAttente")));
        voyageConsecutif.setActif(request.getParameter("actif") != null);
        
        voyageConsecutifDAO.update(voyageConsecutif);
        response.sendRedirect(request.getContextPath() + "/admin/voyages-consecutifs/liste");
    }
    
    private void supprimerVoyageConsecutif(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        voyageConsecutifDAO.delete(id);
        response.sendRedirect(request.getContextPath() + "/admin/voyages-consecutifs/liste");
    }
} 