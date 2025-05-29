package com.trainapp.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.Userdao;
import com.trainapp.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Userdao userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new Userdao();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Veuillez remplir tous les champs");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        User user = userDAO.checkLogin(email, password);
        
        if (user != null) {
            if (!user.isActive()) {
                request.setAttribute("error", "Votre compte est désactivé. Veuillez contacter l'administrateur.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            // Vérifier s'il y a une URL de redirection stockée en session
            String redirectURL = (String) session.getAttribute("redirect_url");
            if (redirectURL != null && !redirectURL.isEmpty()) {
                // Rediriger vers la page de paiement après login pour finaliser la réservation
                session.removeAttribute("redirect_url"); // Supprimer l'URL de redirection stockée
                response.sendRedirect(request.getContextPath() + "/paiement.jsp");
            } else if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            } else {
                // Redirect to the home page after successful login
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } else {
            request.setAttribute("error", "Email ou mot de passe incorrect");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}