package com.trainapp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainapp.dao.BilletDAO;
import com.trainapp.dao.PaiementDAO;
import com.trainapp.model.Billet;
import com.trainapp.model.Paiement;
import com.trainapp.model.User;

@WebServlet("/PaiementServlet")
public class PaiementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BilletDAO billetDAO;
    private PaiementDAO paiementDAO;

    @Override
    public void init() throws ServletException {
        billetDAO = new BilletDAO();
        paiementDAO = new PaiementDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        // Check if user is logged in
        if (user == null) {
            request.setAttribute("error", "Veuillez vous connecter pour finaliser le paiement.");
             if (session == null) { // Create a new session if it doesn't exist
                session = request.getSession(true);
            }
            session.setAttribute("redirect_url", request.getRequestURL().toString() + (request.getQueryString() != null ? "?" + request.getQueryString() : ""));
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Get billet IDs from the form
        String[] billetIdsParam = request.getParameterValues("billetIds");
        if (billetIdsParam == null || billetIdsParam.length == 0) {
            request.setAttribute("error", "Aucun billet à traiter pour le paiement.");
            // Need to pass billet info back to paiement.jsp even if there's an error
            // Assuming billets are stored in session or can be re-fetched if needed
             List<Billet> billetsAPayer = (List<Billet>) session.getAttribute("billetsAPayer"); // Attempt to retrieve from session
             if(billetsAPayer == null) { // If not in session, try to re-fetch (less ideal)
                 billetsAPayer = new ArrayList<>();
                 // This re-fetching based on IDs might be complex if details are lost
                 // Consider storing full billet objects or relevant info in session earlier
             }
             request.setAttribute("billetsCrees", billetsAPayer);
             // Need to calculate prixTotalItineraire as well
             double prixTotalAPayer = 0;
             if (billetsAPayer != null) {
                 for(Billet b : billetsAPayer) {
                     prixTotalAPayer += b.getPrixFinal();
                 }
             }
             request.setAttribute("prixTotalItineraire", prixTotalAPayer);

            request.getRequestDispatcher("/paiement.jsp").forward(request, response);
            return;
        }

        List<Billet> billetsPayes = new ArrayList<>();
        double totalMontantPaiement = 0;

        try {
            // Simulate payment processing (in a real app, this would be external)
            boolean paymentSuccessful = simulatePayment(request); // Placeholder for simulated payment

            if (paymentSuccessful) {
                for (String billetIdStr : billetIdsParam) {
                    try {
                        int billetId = Integer.parseInt(billetIdStr);
                        Billet billet = billetDAO.getById(billetId);

                        if (billet != null && billet.getUser().getId() == user.getId()) { // Verify billet belongs to the user
                            // Update billet status to ACHETE
                            billet.setStatut(Billet.Statut.ACHETE);
                            billetDAO.update(billet); // Assuming update method exists and works
                            billetsPayes.add(billet);
                            totalMontantPaiement += billet.getPrixFinal();
                        } else {
                             System.err.println("Attempted to process invalid or unauthorized billet ID: " + billetIdStr);
                        }
                    } catch (NumberFormatException e) {
                         System.err.println("Invalid billet ID format: " + billetIdStr);
                    }
                }

                if (!billetsPayes.isEmpty()) {
                    // 4. Create and save the Paiement object after successful payment
                    Paiement paiement = new Paiement();
                    paiement.setMontant(totalMontantPaiement);
                    paiement.setDatePaiement(new Date());
                    paiement.setUser(user);
                    paiement.setStatut(Paiement.Statut.VALIDE); // Set payment status to VALIDÉ using the enum

                    paiementDAO.save(paiement); // Save the payment

                    // Optional: Link billets to the payment if your Paiement model supports it (e.g., ManyToMany)
                    // if (paiement.getBillets() != null) { // Assuming Paiement has a getBillets method
                    //     paiement.getBillets().addAll(billetsPayes);
                    //    paiementDAO.update(paiement); // Update payment to link billets
                    // }

                     request.setAttribute("billetsPayes", billetsPayes);
                    request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
                } else {
                     request.setAttribute("error", "Aucun billet valide traité pour le paiement.");
                     // Need to pass billet info back in case of no valid billets
                     List<Billet> billetsAPayer = (List<Billet>) session.getAttribute("billetsAPayer");
                     double prixTotalAPayer = 0;
                     if(billetsAPayer != null) {
                         for(Billet b : billetsAPayer) prixTotalAPayer += b.getPrixFinal();
                     }
                     request.setAttribute("billetsCrees", billetsAPayer);
                     request.setAttribute("prixTotalItineraire", prixTotalAPayer);

                    request.getRequestDispatcher("/paiement.jsp").forward(request, response);
                }

            } else { // Payment simulation failed
                // Handle payment failure
                request.setAttribute("error", "Le paiement a échoué. Veuillez réessayer.");
                 // Keep billet information in request scope to display on payment page
                 List<Billet> billetsAPayer = (List<Billet>) session.getAttribute("billetsAPayer");
                 double prixTotalAPayer = 0;
                 if(billetsAPayer != null) {
                     for(Billet b : billetsAPayer) prixTotalAPayer += b.getPrixFinal();
                 }
                 request.setAttribute("billetsCrees", billetsAPayer); // Reuse attribute name expected by paiement.jsp
                 request.setAttribute("prixTotalItineraire", prixTotalAPayer); // Reuse attribute name

                request.getRequestDispatcher("/paiement.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Une erreur est survenue lors du traitement du paiement : " + e.getMessage());
             // Keep billet information in request scope to display on payment page in case of error
             List<Billet> billetsAPayer = (List<Billet>) session.getAttribute("billetsAPayer");
             double prixTotalAPayer = 0;
             if(billetsAPayer != null) {
                 for(Billet b : billetsAPayer) prixTotalAPayer += b.getPrixFinal();
             }
             request.setAttribute("billetsCrees", billetsAPayer);
             request.setAttribute("prixTotalItineraire", prixTotalAPayer);
            request.getRequestDispatcher("/paiement.jsp").forward(request, response);
        }
    }

    // Placeholder method to simulate payment processing
    private boolean simulatePayment(HttpServletRequest request) {
        // In a real application, integrate with a payment gateway here.
        // For this simulation, always return true for success.
        System.out.println("Simulating payment processing...");
        // You could add some logic here to simulate failure based on certain input
        return true; // Simulate success
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Prevent GET access to the payment processing servlet
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported for this URL.");
    }

} 