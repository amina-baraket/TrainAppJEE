/*package com.trainapp.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainapp.dao.PaiementDAO;
import com.trainapp.model.Paiement;
@WebServlet("/gererPaiements")
public class GererPaiementsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Paiement> paiements = PaiementDAO.listerPaiements();
        request.setAttribute("paiements", paiements);
        request.getRequestDispatcher("listePaiements.jsp").forward(request, response);
    }
}*/