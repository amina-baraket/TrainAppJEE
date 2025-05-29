package com.trainapp.controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.GareDAO;
import com.trainapp.model.Gare;
import com.trainapp.model.User;

@WebServlet("/admin/gares/*")
public class GestionGareServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GareDAO gareDAO;
    
    @Override
    public void init() throws ServletException {
        gareDAO = new GareDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Vérification que l'utilisateur est connecté et est admin
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getPathInfo();
        
        try {
            if (action == null) {
                response.sendRedirect(request.getContextPath() + "/admin/gares/liste");
                return;
            }
            
            switch (action) {
                case "/liste":
                    listeGares(request, response);
                    break;
                case "/ajouter":
                    afficherFormulaireAjout(request, response);
                    break;
                case "/modifier":
                    afficherFormulaireModification(request, response);
                    break;
                case "/supprimer":
                    supprimerGare(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/gares/liste");
                    break;
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
                    ajouterGare(request, response);
                    break;
                case "/modifier":
                    modifierGare(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/gares/liste");
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
        }
    }
    
    private void listeGares(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Gare> gares = gareDAO.getAll();
        request.setAttribute("gares", gares);
        request.getRequestDispatcher("/admin/listeGares.jsp").forward(request, response);
    }
    
    private void afficherFormulaireAjout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/ajouterGare.jsp").forward(request, response);
    }
    
    private void afficherFormulaireModification(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Gare gare = gareDAO.getById(id);
        request.setAttribute("gare", gare);
        request.getRequestDispatcher("/admin/modifierGare.jsp").forward(request, response);
    }
    
    private void ajouterGare(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Gare gare = new Gare();
            gare.setNom(request.getParameter("nom"));
            gare.setVille(request.getParameter("ville"));
            gare.setAdresse(request.getParameter("adresse"));
            gare.setCodePostal(request.getParameter("codePostal"));
            gare.setPays(request.getParameter("pays"));
            gare.setActive(true); // Par défaut, une nouvelle gare est active
            
            gareDAO.save(gare);
            response.sendRedirect(request.getContextPath() + "/admin/gares/liste");
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/admin/ajouterGare.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue lors de l'ajout de la gare : " + e.getMessage());
            request.getRequestDispatcher("/admin/ajouterGare.jsp").forward(request, response);
        }
    }
    
    private void modifierGare(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Gare gare = gareDAO.getById(id);
        
        gare.setNom(request.getParameter("nom"));
        gare.setVille(request.getParameter("ville"));
        gare.setAdresse(request.getParameter("adresse"));
        gare.setCodePostal(request.getParameter("codePostal"));
        gare.setPays(request.getParameter("pays"));
        gare.setActive(request.getParameter("active") != null);
        
        gareDAO.update(gare);
        response.sendRedirect(request.getContextPath() + "/admin/gares/liste");
    }
    
    private void supprimerGare(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        gareDAO.delete(id);
        response.sendRedirect(request.getContextPath() + "/admin/gares/liste");
    }
} 