package com.trainapp.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.BilletDAO;
import com.trainapp.dao.DemandeAnnulationDAO;
import com.trainapp.model.Billet;
import com.trainapp.model.DemandeAnnulation;
import com.trainapp.model.User;

@WebServlet("/user/demanderAnnulation")
public class DemanderAnnulationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BilletDAO billetDAO;
    private DemandeAnnulationDAO demandeAnnulationDAO;

    public void init() throws ServletException {
        billetDAO = new BilletDAO();
        demandeAnnulationDAO = new DemandeAnnulationDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String billetIdParam = request.getParameter("billetId");

        if (billetIdParam == null || billetIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?error=missing_billet_id_for_cancellation");
            return;
        }

        try {
            int billetId = Integer.parseInt(billetIdParam);

            Billet billetToCancel = billetDAO.getBilletById(billetId);

            if (billetToCancel == null) {
                response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?error=billet_not_found_for_cancellation");
                return;
            }

            if (billetToCancel.getUser() == null || billetToCancel.getUser().getId() != user.getId()) {
                 response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?error=unauthorized_cancellation");
                 return;
            }

            DemandeAnnulation demande = new DemandeAnnulation();
            demande.setBillet(billetToCancel);
            demande.setUser(user);
            demande.setMotif("Demande via interface utilisateur");

            demandeAnnulationDAO.save(demande);

            response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?message=cancellation_requested");

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?error=invalid_billet_id_format_cancellation");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/UserBilletsServlet?error=cancellation_submission_failed");
        }
    }
}
