/*package com.trainapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ValiderAnnulationServlet
 */
/*@WebServlet("/validerAnnulation")
public class ValiderAnnulationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int annulationId = Integer.parseInt(request.getParameter("id"));
        boolean valider = Boolean.parseBoolean(request.getParameter("valider"));
        AnnulationDAO.validerAnnulation(annulationId, valider);
        response.sendRedirect("listeAnnulations");
    }
}
*/