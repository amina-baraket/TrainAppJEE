package com.trainapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.trainapp.dao.Userdao;
import com.trainapp.model.User;
import java.util.List;

@WebServlet("/check-admin")
public class CheckAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Userdao userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new Userdao();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            List<User> users = userDAO.getAll();
            
            out.println("<html><head><title>Vérification des Administrateurs</title>");
            out.println("<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'>");
            out.println("</head><body class='container mt-5'>");
            out.println("<h2>Liste des Utilisateurs Administrateurs</h2>");
            
            boolean foundAdmin = false;
            out.println("<table class='table table-striped'>");
            out.println("<thead><tr><th>ID</th><th>Nom</th><th>Prénom</th><th>Email</th><th>Rôle</th><th>Statut</th></tr></thead>");
            out.println("<tbody>");
            
            for (User user : users) {
                if ("ADMIN".equals(user.getRole())) {
                    foundAdmin = true;
                    out.println("<tr>");
                    out.println("<td>" + user.getId() + "</td>");
                    out.println("<td>" + user.getNom() + "</td>");
                    out.println("<td>" + user.getPrenom() + "</td>");
                    out.println("<td>" + user.getEmail() + "</td>");
                    out.println("<td>" + user.getRole() + "</td>");
                    out.println("<td>" + (user.isActive() ? "Actif" : "Inactif") + "</td>");
                    out.println("</tr>");
                }
            }
            
            out.println("</tbody></table>");
            
            if (!foundAdmin) {
                out.println("<div class='alert alert-warning'>Aucun utilisateur administrateur trouvé.</div>");
            }
            
            out.println("<a href='login.jsp' class='btn btn-primary'>Retour à la connexion</a>");
            out.println("</body></html>");
            
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>Erreur lors de la vérification : " + e.getMessage() + "</div>");
        }
    }
} 