package com.trainapp.controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.PreferenceDAO;
import com.trainapp.model.Preference;
import com.trainapp.model.User;

@WebServlet("/admin/preferences/*")
public class GestionPreferenceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PreferenceDAO preferenceDAO;
    
    @Override
    public void init() throws ServletException {
        preferenceDAO = new PreferenceDAO();
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
                    listePreferences(request, response);
                    break;
                case "/ajouter":
                    afficherFormulaireAjout(request, response);
                    break;
                case "/modifier":
                    afficherFormulaireModification(request, response);
                    break;
                case "/supprimer":
                    supprimerPreference(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/preferences/liste");
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
                    ajouterPreference(request, response);
                    break;
                case "/modifier":
                    modifierPreference(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/preferences/liste");
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            request.getRequestDispatcher("/admin/error.jsp").forward(request, response);
        }
    }
    
    private void listePreferences(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Preference> preferences = preferenceDAO.getAll();
        request.setAttribute("preferences", preferences);
        request.getRequestDispatcher("/admin/listePreferences.jsp").forward(request, response);
    }
    
    private void afficherFormulaireAjout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/ajouterPreference.jsp").forward(request, response);
    }
    
    private void afficherFormulaireModification(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Preference preference = preferenceDAO.getById(id);
        request.setAttribute("preference", preference);
        request.getRequestDispatcher("/admin/modifierPreference.jsp").forward(request, response);
    }
    
    private void ajouterPreference(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Preference preference = new Preference();
        preference.setNom(request.getParameter("nom"));
        preference.setDescription(request.getParameter("description"));
        preference.setCoutSupplementaire(Double.parseDouble(request.getParameter("coutSupplementaire")));
        preference.setDisponible(true);
        
        preferenceDAO.save(preference);
        response.sendRedirect(request.getContextPath() + "/admin/preferences/liste");
    }
    
    private void modifierPreference(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Preference preference = preferenceDAO.getById(id);
        
        preference.setNom(request.getParameter("nom"));
        preference.setDescription(request.getParameter("description"));
        preference.setCoutSupplementaire(Double.parseDouble(request.getParameter("coutSupplementaire")));
        preference.setDisponible(request.getParameter("disponible") != null);
        
        preferenceDAO.update(preference);
        response.sendRedirect(request.getContextPath() + "/admin/preferences/liste");
    }
    
    private void supprimerPreference(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        preferenceDAO.delete(id);
        response.sendRedirect(request.getContextPath() + "/admin/preferences/liste");
    }
} 