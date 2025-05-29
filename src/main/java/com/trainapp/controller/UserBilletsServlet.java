package com.trainapp.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.BilletDAO;
import com.trainapp.dao.ClasseDAO;
import com.trainapp.dao.PreferenceDAO;
import com.trainapp.model.Billet;
import com.trainapp.model.Classe;
import com.trainapp.model.Preference;
import com.trainapp.model.User;

@WebServlet("/UserBilletsServlet")
public class UserBilletsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BilletDAO billetDAO;
    private ClasseDAO classeDAO;
    private PreferenceDAO preferenceDAO;

    public void init() throws ServletException {
        billetDAO = new BilletDAO();
        classeDAO = new ClasseDAO();
        preferenceDAO = new PreferenceDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        if (user == null) {
            // Redirect to login if user is not logged in
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Billet> userBillets = billetDAO.getBilletsByUser(user);
        
        // Fetch all classes to populate the dropdown in the JSP
        List<Classe> allClasses = classeDAO.getAll();
        
        // Fetch all preferences to populate the options in the JSP
        List<Preference> allPreferences = preferenceDAO.getAll();

        request.setAttribute("billets", userBillets);
        request.setAttribute("classes", allClasses);
        request.setAttribute("preferences", allPreferences); // Add the list of preferences to the request
        request.getRequestDispatcher("/mesBillets.jsp").forward(request, response);
    }
} 