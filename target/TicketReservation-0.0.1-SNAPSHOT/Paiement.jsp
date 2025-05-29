<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Page de Paiement</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            padding: 30px;
            color: #333;
        }
        h2, h3 {
            color: #004d99;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .table th,
        .table td {
            padding: 12px;
            text-align: left;
        }
        .table th {
            background-color: #007acc;
            color: white;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0,0,0,.05);
        }
        .total-section {
            margin-top: 20px;
            font-size: 1.2em;
            font-weight: bold;
            text-align: right;
        }
         .payment-form {
            margin-top: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <h2 class="mb-4 text-center">Finaliser Votre Réservation</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </c:if>

        <c:set var="billets" value="${requestScope.billetsCrees}"/>
        <c:set var="prixTotal" value="${requestScope.prixTotalItineraire}"/>

        <c:if test="${empty billets}">
            <div class="alert alert-warning text-center" role="alert">
                Aucun billet trouvé pour le paiement. Veuillez <a href="RechercheTrajetServlet">rechercher un voyage</a>.
            </div>
        </c:if>

        <c:if test="${not empty billets}">
            <h3>Récapitulatif de Votre Commande :</h3>

            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Départ</th>
                        <th>Destination</th>
                        <th>Date</th>
                        <th>Heure Départ</th>
                        <th>Classe</th>
                        <th>Prix</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${billets}" var="billet">
                        <tr>
                            <td>${billet.trajet.depart}</td> <%-- Assuming Trajet has getDepart() method --%>
                            <td>${billet.trajet.destination}</td> <%-- Assuming Trajet has getDestination() method --%>
                             <td><fmt:formatDate value="${billet.trajet.date_depart}" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatDate value="${billet.trajet.heure_depart}" pattern="HH:mm"/></td>
                            <td>${billet.classe.nom}</td> <%-- Assuming Classe has getNom() method --%>
                            <td><fmt:formatNumber value="${billet.prixFinal}" pattern="#,##0.00"/> €</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="total-section">
                Total à payer : <fmt:formatNumber value="${prixTotal}" pattern="#,##0.00"/> €
            </div>

            <div class="payment-form">
                <h3>Informations de Paiement</h3>
                 <form action="${pageContext.request.contextPath}/PaiementServlet" method="post" class="needs-validation" novalidate>
                     <%-- Hidden fields to pass billet IDs --%>
                     <c:forEach items="${billets}" var="billet">
                          <input type="hidden" name="billetIds" value="${billet.id}">
                     </c:forEach>

                     <div class="row mb-3">
                         <div class="col-md-6">
                             <label for="cardNumber" class="form-label">Numéro de carte</label>
                             <input type="text" class="form-control" id="cardNumber" name="cardNumber" 
                                    pattern="[0-9]{13,19}" required placeholder="XXXX XXXX XXXX XXXX">
                             <div class="invalid-feedback">
                                 Veuillez entrer un numéro de carte valide.
                             </div>
                         </div>
                         <div class="col-md-3">
                             <label for="expiryDate" class="form-label">Date d'expiration</label>
                             <input type="text" class="form-control" id="expiryDate" name="expiryDate" 
                                    pattern="(0[1-9]|1[0-2])\/[0-9]{2}" required placeholder="MM/AA">
                             <div class="invalid-feedback">
                                 Format invalide (MM/AA).
                             </div>
                         </div>
                         <div class="col-md-3">
                             <label for="cvv" class="form-label">CVV</label>
                             <input type="text" class="form-control" id="cvv" name="cvv" 
                                    pattern="[0-9]{3,4}" required placeholder="XXX">
                             <div class="invalid-feedback">
                                 Code de sécurité invalide.
                             </div>
                         </div>
                     </div>

                     <div class="row mb-3">
                         <div class="col-md-6">
                             <label for="cardholderName" class="form-label">Nom du titulaire</label>
                             <input type="text" class="form-control" id="cardholderName" name="cardholderName" required>
                             <div class="invalid-feedback">
                                 Le nom du titulaire est requis.
                             </div>
                         </div>
                         <div class="col-md-6">
                             <label for="email" class="form-label">Email</label>
                             <input type="email" class="form-control" id="email" name="email" required>
                             <div class="invalid-feedback">
                                 Une adresse email valide est requise.
                             </div>
                         </div>
                     </div>

                     <div class="d-grid gap-2">
                         <button type="submit" class="btn btn-success">Procéder au Paiement</button>
                     </div>
    </form>
            </div>

        </c:if>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
     <script>
     // Example: Add some basic client-side validation feedback using Bootstrap
     (() => {
       'use strict'

       // Fetch all the forms we want to apply custom Bootstrap validation styles to
       const forms = document.querySelectorAll('.needs-validation')

       // Loop over them and prevent submission
       Array.from(forms).forEach(form => {
         form.addEventListener('submit', event => {
           if (!form.checkValidity()) {
             event.preventDefault()
             event.stopPropagation()
           }

           form.classList.add('was-validated')
         }, false)
       })
     })()
     </script>
</body>
</html>
