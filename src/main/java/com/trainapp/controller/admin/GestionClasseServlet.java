package com.trainapp.controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.ClasseDAO;
import com.trainapp.model.Classe;
import com.trainapp.model.User;

@WebServlet("/admin/classes/*")
public class GestionClasseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClasseDAO classeDAO;
    
    @Override
    public void init() throws ServletException {
        classeDAO = new ClasseDAO();
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
            switch (action) {
                case "/liste":
                    listeClasses(request, response);
                    break;
                case "/ajouter":
                    afficherFormulaireAjout(request, response);
                    break;
                case "/modifier":
                    afficherFormulaireModification(request, response);
                    break;
                case "/supprimer":
                    supprimerClasse(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/classes/liste");
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
                    ajouterClasse(request, response);
                    break;
                case "/modifier":
                    modifierClasse(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/classes/liste");
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
        }
    }
    
    private void listeClasses(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Classe> classes = classeDAO.getAll();
        request.setAttribute("classes", classes);
        request.getRequestDispatcher("/admin/listeClasses.jsp").forward(request, response);
    }
    
    private void afficherFormulaireAjout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/ajouterClasse.jsp").forward(request, response);
    }
    
    private void afficherFormulaireModification(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Classe classe = classeDAO.getById(id);
        request.setAttribute("classe", classe);
        request.getRequestDispatcher("/admin/modifierClasse.jsp").forward(request, response);
    }
    
    private void ajouterClasse(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Classe classe = new Classe();
        classe.setNom(request.getParameter("nom"));
        classe.setCoefficientPrix(Double.parseDouble(request.getParameter("coefficientPrix")));
        classe.setNombrePlaces(Integer.parseInt(request.getParameter("nombrePlaces")));
        classe.setDescription(request.getParameter("description"));
        
        classeDAO.save(classe);
        response.sendRedirect(request.getContextPath() + "/admin/classes/liste");
    }
    
    private void modifierClasse(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Classe classe = classeDAO.getById(id);
        
        classe.setNom(request.getParameter("nom"));
        classe.setCoefficientPrix(Double.parseDouble(request.getParameter("coefficientPrix")));
        classe.setNombrePlaces(Integer.parseInt(request.getParameter("nombrePlaces")));
        classe.setDescription(request.getParameter("description"));
        
        classeDAO.update(classe);
        response.sendRedirect(request.getContextPath() + "/admin/classes/liste");
    }
    
    private void supprimerClasse(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        classeDAO.delete(id);
        response.sendRedirect(request.getContextPath() + "/admin/classes/liste");
    }
} 