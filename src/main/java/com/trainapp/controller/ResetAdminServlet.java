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
import com.trainapp.util.JPAUtil;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

@WebServlet("/TicketReservation/reset-admin")
public class ResetAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DEFAULT_ADMIN_EMAIL = "admin@trainapp.com";
    private static final String DEFAULT_ADMIN_PASSWORD = "admin123";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            // Recherche du compte admin
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.email = :email", 
                User.class);
            query.setParameter("email", DEFAULT_ADMIN_EMAIL);
            
            List<User> results = query.getResultList();
            User admin;
            
            transaction.begin();
            
            if (results.isEmpty()) {
                // Créer un nouveau compte admin
                admin = new User("Admin", "System", DEFAULT_ADMIN_EMAIL, DEFAULT_ADMIN_PASSWORD);
                admin.setRole("ADMIN");
                admin.setActive(true);
                em.persist(admin);
            } else {
                // Réinitialiser le compte admin existant
                admin = results.get(0);
                admin.setNom("Admin");
                admin.setPrenom("System");
                admin.setPassword(DEFAULT_ADMIN_PASSWORD);
                admin.setRole("ADMIN");
                admin.setActive(true);
                em.merge(admin);
            }
            
            transaction.commit();
            
            out.println("<html><head><title>Réinitialisation Admin</title>");
            out.println("<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'>");
            out.println("</head><body class='container mt-5'>");
            out.println("<div class='alert alert-success'>");
            out.println("<h4>Compte administrateur réinitialisé avec succès !</h4>");
            out.println("<p>Email : " + DEFAULT_ADMIN_EMAIL + "</p>");
            out.println("<p>Mot de passe : " + DEFAULT_ADMIN_PASSWORD + "</p>");
            out.println("</div>");
            out.println("<a href='login.jsp' class='btn btn-primary'>Retour à la connexion</a>");
            out.println("</body></html>");
            
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            out.println("<div class='alert alert-danger'>Erreur lors de la réinitialisation : " + e.getMessage() + "</div>");
        } finally {
            em.close();
        }
    }
} 