<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Résultats Recherche Voyages Consécutifs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            padding: 30px;
            color: #333;
        }
        h2 {
            color: #004d99;
        }
        table {
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #007acc;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .btn-select {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-select:hover {
            background-color: #218838;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <h2 class="mb-4 text-center">Résultats de Recherche de Voyages Consécutifs</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </c:if>
        
        <c:if test="${empty trajetsConsecutifs}">
            <div class="alert alert-info text-center" role="alert">
                Aucun voyage consécutif trouvé pour les critères spécifiés.
            </div>
        </c:if>

        <c:if test="${not empty trajetsConsecutifs}">
            <p>Trajets trouvés pour le ${searchDate} au départ de la gare sélectionnée :</p>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Départ</th>
                        <th>Destination</th>
                        <th>Date</th>
                        <th>Heure Départ</th>
                        <th>Heure Arrivée</th>
                        <th>Prix</th>
                        <th>Places Disponibles</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.trajetsConsecutifs}" var="trajet">
                        <c:set var="gareDepartTrouvee" value="${null}"/>
                        <c:set var="gareDestinationTrouvee" value="${null}"/>

                        <%-- Find the departure Gare object --%>
                        <c:forEach items="${requestScope.gares}" var="gare">
                            <c:if test="${gare.ville eq trajet.depart}">
                                <c:set var="gareDepartTrouvee" value="${gare}"/>
                            </c:if>
                        </c:forEach>

                        <%-- Find the destination Gare object --%>
                        <c:forEach items="${requestScope.gares}" var="gare">
                             <c:if test="${gare.ville eq trajet.destination}">
                                <c:set var="gareDestinationTrouvee" value="${gare}"/>
                            </c:if>
                        </c:forEach>

                        <tr>
                            <td>
                                <c:if test="${not empty gareDepartTrouvee}">
                                    ${gareDepartTrouvee.nom} (${gareDepartTrouvee.ville})
                                </c:if>
                                <c:if test="${empty gareDepartTrouvee}">
                                    ${trajet.depart} (Gare introuvable)
                                </c:if>
                            </td>
                            <td>
                                 <c:if test="${not empty gareDestinationTrouvee}">
                                    ${gareDestinationTrouvee.nom} (${gareDestinationTrouvee.ville})
                                </c:if>
                                <c:if test="${empty gareDestinationTrouvee}">
                                    ${trajet.destination} (Gare introuvable)
                                </c:if>
                            </td>
                            <td><fmt:formatDate value="${trajet.date_depart}" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatDate value="${trajet.heure_depart}" pattern="HH:mm"/></td>
                            <td><fmt:formatDate value="${trajet.heure_arrivee}" pattern="HH:mm"/></td>
                            <td><fmt:formatNumber value="${trajet.prix}" pattern="#,##0.00"/> €</td>
                            <td>${trajet.places_disponibles}</td>
                            <td>
                                <%-- Form to select this consecutive voyage --%>
                                <form action="${pageContext.request.contextPath}/AjouterVoyageConsecutifServlet" method="post">
                                    <input type="hidden" name="trajetId" value="${trajet.id}">
                                    <button type="submit" class="btn btn-select">Sélectionner ce voyage</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <div class="mt-4">
            <a href="ChoixVoyageSuivant.jsp" class="btn btn-secondary">Retour aux options du voyage précédent</a>
        </div>

    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 