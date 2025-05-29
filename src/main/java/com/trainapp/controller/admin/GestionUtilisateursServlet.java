package com.trainapp.controller.admin;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.Userdao;
import com.trainapp.model.User;

@WebServlet("/admin/utilisateurs/*")
public class GestionUtilisateursServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(GestionUtilisateursServlet.class.getName());
    private Userdao userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new Userdao();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            logger.log(Level.WARNING, "Tentative d'accès non autorisé à la gestion des utilisateurs");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!user.isAdmin()) {
            logger.log(Level.WARNING, "Tentative d'accès non autorisé par l'utilisateur: " + user.getEmail());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getPathInfo();
        
        if (action == null || action.equals("/")) {
            listeUtilisateurs(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getPathInfo();
        
        if (action != null && action.equals("/changer-statut")) {
            changerStatutUtilisateur(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void listeUtilisateurs(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            
            // Récupérer les messages de la session
            String success = (String) session.getAttribute("success");
            String error = (String) session.getAttribute("error");
            
            // Les passer à la requête
            if (success != null) {
                request.setAttribute("success", success);
                session.removeAttribute("success");
                logger.log(Level.INFO, "Message de succès affiché: " + success);
            }
            if (error != null) {
                request.setAttribute("error", error);
                session.removeAttribute("error");
                logger.log(Level.WARNING, "Message d'erreur affiché: " + error);
            }
            
            // Récupérer et afficher la liste des utilisateurs
            request.setAttribute("utilisateurs", userDAO.getAll());
            request.getRequestDispatcher("/admin/listeUtilisateurs.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la récupération des utilisateurs", e);
            request.setAttribute("error", "Erreur lors de la récupération des utilisateurs : " + e.getMessage());
            request.getRequestDispatcher("/admin/listeUtilisateurs.jsp").forward(request, response);
        }
    }
    
    private void changerStatutUtilisateur(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            boolean actif = Boolean.parseBoolean(request.getParameter("actif"));
            
            User user = userDAO.getById(userId);
            if (user != null) {
                user.setActive(actif);
                userDAO.update(user);
                request.setAttribute("success", "Le statut de l'utilisateur a été modifié avec succès.");
                logger.log(Level.INFO, "Statut de l'utilisateur " + userId + " modifié à " + actif);
            } else {
                request.setAttribute("error", "Utilisateur non trouvé.");
                logger.log(Level.WARNING, "Tentative de modification du statut d'un utilisateur inexistant: " + userId);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la modification du statut", e);
            request.setAttribute("error", "Erreur lors de la modification du statut : " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/utilisateurs");
    }
} 