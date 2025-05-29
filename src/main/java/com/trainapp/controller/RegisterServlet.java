package com.trainapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainapp.dao.Userdao;
import com.trainapp.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Userdao userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new Userdao();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation des champs
        if (nom == null || prenom == null || email == null || password == null || confirmPassword == null ||
            nom.trim().isEmpty() || prenom.trim().isEmpty() || email.trim().isEmpty() || 
            password.trim().isEmpty() || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "Veuillez remplir tous les champs");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Vérification du mot de passe
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Les mots de passe ne correspondent pas");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        try {
            // Création du nouvel utilisateur
            User user = new User(nom, prenom, email, password);
            userDAO.save(user);
            
            // Redirection vers la page de login avec un message de succès
            request.setAttribute("success", "Inscription réussie ! Vous pouvez maintenant vous connecter.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue lors de l'inscription");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
