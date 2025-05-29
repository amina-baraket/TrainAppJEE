package com.trainapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.logging.Logger;
import java.util.logging.Level;

import com.trainapp.dao.Userdao;
import com.trainapp.model.User;

@WebServlet("/admin/utilisateurs/changer-statut")
public class SetUserStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(SetUserStatusServlet.class.getName());
    private Userdao userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new Userdao();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            logger.log(Level.WARNING, "Tentative d'accès non autorisé à la modification de statut");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        if (!currentUser.isAdmin()) {
            logger.log(Level.WARNING, "Tentative d'accès non autorisé par l'utilisateur: " + currentUser.getEmail());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            boolean actif = Boolean.parseBoolean(request.getParameter("actif"));
            
            // Empêcher un admin de se désactiver lui-même
            if (userId == currentUser.getId()) {
                logger.log(Level.WARNING, "Tentative de l'admin de modifier son propre statut: " + currentUser.getEmail());
                session.setAttribute("error", "Vous ne pouvez pas modifier votre propre statut.");
                response.sendRedirect(request.getContextPath() + "/admin/utilisateurs");
                return;
            }
            
            User user = userDAO.getById(userId);
            if (user != null) {
                user.setActive(actif);
                userDAO.update(user);
                session.setAttribute("success", "Le statut de l'utilisateur a été modifié avec succès.");
                logger.log(Level.INFO, "Statut de l'utilisateur " + userId + " modifié à " + actif + " par " + currentUser.getEmail());
            } else {
                session.setAttribute("error", "Utilisateur non trouvé.");
                logger.log(Level.WARNING, "Tentative de modification du statut d'un utilisateur inexistant: " + userId);
            }
        } catch (NumberFormatException e) {
            logger.log(Level.WARNING, "ID utilisateur invalide", e);
            session.setAttribute("error", "ID utilisateur invalide.");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la modification du statut", e);
            session.setAttribute("error", "Erreur lors de la modification du statut : " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/utilisateurs");
    }
}
