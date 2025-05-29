<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sélectionner les Options de Voyage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            padding: 30px;
            color: #333;
        }
        h3 {
            color: #004d99;
        }
        form {
            background: white;
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            max-width: 400px;
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }
        input[type="text"], input[type="date"], select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 4px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        input[type="submit"] {
            margin-top: 20px;
            background-color: #007acc;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #005f99;
        }
        hr {
            margin: 40px 0;
            border: none;
            border-top: 1px solid #ccc;
        }
        .selected-voyages-table th,
        .selected-voyages-table td {
            padding: 8px;
            text-align: left;
        }
         .selected-voyages-table th {
            background-color: #007acc;
            color: white;
        }
         .selected-voyages-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <h2 class="mb-4 text-center">Options de Voyage</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </c:if>

        <%-- Retrieve the list of selected voyages from the session --%>
        <c:set var="selectedVoyages" value="${sessionScope.selectedVoyages}"/>

        <c:if test="${empty selectedVoyages}">
             <div class="alert alert-warning text-center" role="alert">
                Aucun voyage sélectionné. Veuillez retourner à la <a href="RechercheTrajetServlet">recherche de trajets</a>.
            </div>
        </c:if>

        <c:if test="${not empty selectedVoyages}">
            <h3 class="mb-3">Votre Itinéraire :</h3>
             <table class="table table-striped table-hover selected-voyages-table mb-4">
                <thead>
                    <tr>
                        <th>Départ</th>
                        <th>Destination</th>
                        <th>Date</th>
                        <th>Heure Départ</th>
                         <th>Heure Arrivée</th>
                        <th>Prix</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${selectedVoyages}" var="voyage">
                        <c:set var="gareDepartTrouvee" value="${null}"/>
                        <c:set var="gareDestinationTrouvee" value="${null}"/>

                        <%-- Find the departure Gare object --%>
                        <c:forEach items="${requestScope.gares}" var="gare">
                            <c:if test="${gare.ville eq voyage.depart}">
                                <c:set var="gareDepartTrouvee" value="${gare}"/>
                            </c:if>
                        </c:forEach>

                        <%-- Find the destination Gare object --%>
                        <c:forEach items="${requestScope.gares}" var="gare">
                             <c:if test="${gare.ville eq voyage.destination}">
                                <c:set var="gareDestinationTrouvee" value="${gare}"/>
                            </c:if>
                        </c:forEach>

                        <tr>
                            <td>
                                <c:if test="${not empty gareDepartTrouvee}">
                                    ${gareDepartTrouvee.nom} (${gareDepartTrouvee.ville})
                                </c:if>
                                <c:if test="${empty gareDepartTrouvee}">
                                    ${voyage.depart} (Gare introuvable)
                                </c:if>
                            </td>
                            <td>
                                 <c:if test="${not empty gareDestinationTrouvee}">
                                    ${gareDestinationTrouvee.nom} (${gareDestinationTrouvee.ville})
                                </c:if>
                                <c:if test="${empty gareDestinationTrouvee}">
                                    ${voyage.destination} (Gare introuvable)
                                </c:if>
                            </td>
                             <td><fmt:formatDate value="${voyage.date_depart}" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatDate value="${voyage.heure_depart}" pattern="HH:mm"/></td>
                             <td><fmt:formatDate value="${voyage.heure_arrivee}" pattern="HH:mm"/></td>
                            <td><fmt:formatNumber value="${voyage.prix}" pattern="#,##0.00"/> €</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <h3 class="mb-3">Options pour le dernier voyage :</h3>
            <%-- Find the last voyage in the list to apply options to --%>
            <c:set var="lastVoyage" value="${selectedVoyages[fn:length(selectedVoyages) - 1]}"/>
             <%-- Find the destination Gare object for the last voyage for the consecutive search form --%>
             <c:set var="lastVoyageDestinationGare" value="${null}"/>
             <c:forEach items="${requestScope.gares}" var="gare">
                 <c:if test="${gare.ville eq lastVoyage.destination}">
                     <c:set var="lastVoyageDestinationGare" value="${gare}"/>
                 </c:if>
             </c:forEach>

            <form action="ReserverVoyageServlet" method="post">
                 <%-- Pass IDs of all selected trajets --%>
                 <c:forEach items="${selectedVoyages}" var="voyage">
                      <input type="hidden" name="trajetIds" value="${voyage.id}">
                 </c:forEach>
                 
                 <%-- Selection of class and preferences for the last voyage --%>
                 <%-- Note: This assumes options apply to the last leg. Adjust logic if options apply per leg --%>
                 
                 <%-- Sélection de la classe --%>
                 <div class="mb-3">
                     <label for="classe" class="form-label">Classe :</label>
                     <select id="classe" name="classeId" class="form-select" required>
                         <option value="">-- Sélectionnez une classe --</option>
                         <c:forEach items="${requestScope.classes}" var="classe">
                             <option value="${classe.id}">${classe.nom} - ${classe.description} (Coefficient: ${classe.coefficientPrix})</option>
                         </c:forEach>
                     </select>
                 </div>

                 <%-- Préférences (exemple avec une zone de texte) --%>
                 <div class="mb-3">
                     <label for="preferences" class="form-label">Préférences (facultatif) :</label>
<%--                      <textarea class="form-control" id="preferences" name="preferences" rows="3" --%>
<%--                               placeholder="Ex: Côté fenêtre, Espace famille, etc."></textarea> --%>
                    <div id="preferences">
                        <c:forEach items="${requestScope.preferences}" var="pref">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="${pref.id}" id="pref${pref.id}" name="preferences">
                                <label class="form-check-label" for="pref${pref.id}">
                                    ${pref.nom} - ${pref.description}
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                 </div>

                 <button type="submit" class="btn btn-success">Réserver l'itinéraire</button>
</form>

            <hr class="my-5">

            <h3>Ajouter un autre voyage consécutif ?</h3>
            <%-- Formulaire pour rechercher un voyage consécutif (adapté pour utiliser les IDs de gare) --%>
            <form action="RechercheVoyageConsecutifServlet" method="post" class="row g-3 align-items-end">
                 <%-- Use the destination of the last voyage as the departure for the next search --%>
                 <input type="hidden" name="departId" value="${lastVoyageDestinationGare != null ? lastVoyageDestinationGare.id : ''}"> 

                <div class="col-md-4">
                    <label for="destination_consecutif" class="form-label">Destination :</label>
                    <%-- Here, we could potentially filter the gares to only show those accessible from lastVoyage.gareDestination --%>
                    <select id="destination_consecutif" name="destinationId" class="form-select" required>
                         <option value="">-- Sélectionnez une gare --</option>
                        <c:forEach items="${requestScope.gares}" var="gare">
                             <%-- Afficher seulement les gares differentes de la gare de départ du prochain voyage --%>
                             <c:if test="${lastVoyageDestinationGare != null && gare.id != lastVoyageDestinationGare.id}">
                                <option value="${gare.id}">${gare.nom} (${gare.ville})</option>
                             </c:if>
                             <c:if test="${lastVoyageDestinationGare == null}">
                                  <option value="${gare.id}">${gare.nom} (${gare.ville})</option>
                             </c:if>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-3">
                    <label for="date_consecutif" class="form-label">Date :</label>
                    <%-- The date should probably be equal to or after the arrival date of the last voyage --%>
                    <input type="date" id="date_consecutif" name="date_depart" class="form-control" required>
                </div>
                
                 <div class="col-md-3">
                    <button type="submit" class="btn btn-primary">Rechercher voyage consécutif</button>
                 </div>
</form>

        </c:if>

    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
