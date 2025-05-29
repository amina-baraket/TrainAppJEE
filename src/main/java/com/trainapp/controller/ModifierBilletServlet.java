package com.trainapp.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.BilletDAO;
import com.trainapp.dao.ClasseDAO;
import com.trainapp.model.Billet;
import com.trainapp.model.Classe;
import com.trainapp.model.User;

@WebServlet("/user/modifierBillet")
public class ModifierBilletServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BilletDAO billetDAO;
    private ClasseDAO classeDAO; // Need ClasseDAO to find the Classe object

    public void init() throws ServletException {
        billetDAO = new BilletDAO();
        classeDAO = new ClasseDAO(); // Initialize ClasseDAO
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        // Check if user is logged in (optional, depending on security setup, but good practice)
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String billetIdParam = request.getParameter("billetId");
        String classeNom = request.getParameter("classe"); // Getting the class name for now
        System.out.println("Debug: Received class name for modification: " + classeNom); // Debug print
        String preferences = request.getParameter("preferences"); // Getting preferences string

        if (billetIdParam == null || billetIdParam.isEmpty() || classeNom == null || classeNom.isEmpty()) {
            // Handle missing parameters
             response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?error=missing_modification_params");
            return;
        }

        try {
            int billetId = Integer.parseInt(billetIdParam);
            
            // 1. Get the existing Billet
            Billet billetToModify = billetDAO.getById(billetId); // Assuming getById is available in BilletDAO

            if (billetToModify == null) {
                response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?error=billet_not_found");
                return;
            }

             // 2. Check if the billet belongs to the logged-in user
            if (billetToModify.getUser() == null || billetToModify.getUser().getId() != user.getId()) {
                 response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?error=unauthorized_modification");
                 return;
            }

            // 3. Find the new Classe object based on the submitted name (requires DAO method)
            // This part needs implementation in ClasseDAO or a helper method
            Classe newClasse = classeDAO.getByNom(classeNom);

            if (newClasse == null) {
                 response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?error=invalid_classe");
                 return;
            }

            // 4. Update Billet properties
            billetToModify.setClasse(newClasse);
            // For preferences, the JSP currently sends a text string. If preferences are meant to be linked entities,
            // this part needs more complex logic to parse the string and link Preference objects.
            // For now, we can potentially store the string in a comment field if available in Billet model.
            // Assuming preferences are stored as a string for simplicity for now.
            // billetToModify.setCommentaire(preferences); // Uncomment if Billet model has commentaire field

            // 5. Save the updated Billet
            billetDAO.update(billetToModify); // Assuming update method is available in BilletDAO

            // 6. Redirect with success message
            response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?message=modification_success");

        } catch (NumberFormatException e) {
            // Handle invalid billet ID format
            response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?error=invalid_billet_id_format");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle other potential errors
            response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?error=modification_failed");
    }
    }
}
