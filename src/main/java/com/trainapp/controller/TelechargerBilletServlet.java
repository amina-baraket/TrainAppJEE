package com.trainapp.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.trainapp.dao.BilletDAO;
import com.trainapp.model.Billet;






@WebServlet("/user/telechargerBillet")
public class TelechargerBilletServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int billetId = Integer.parseInt(request.getParameter("billetId"));
        BilletDAO billetDAO = new BilletDAO();
        Billet billet = billetDAO.getBilletById(billetId);

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=billet_" + billetId + ".pdf");

        try {
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();
            document.add(new Paragraph("Billet ID: " + billet.getId()));
            document.add(new Paragraph("Trajet: " + billet.getTrajet().getDepart() + " - " + billet.getTrajet().getDestination()));
            document.add(new Paragraph("Date: " + billet.getTrajet().getDate_depart()));
            document.add(new Paragraph("Classe: " + billet.getClasse()));
            document.add(new Paragraph("Préférences: " + billet.getPreferences()));
            document.close();
        } catch (DocumentException e) {
            throw new IOException(e.getMessage());
        }
    }
}
