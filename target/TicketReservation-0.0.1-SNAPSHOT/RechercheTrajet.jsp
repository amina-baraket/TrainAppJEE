<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recherche de Trajet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <h2 class="mb-4 text-center">Recherche de Trajet</h2>

        <!-- Messages d'erreur ou de succès -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </c:if>

        <!-- Formulaire de recherche -->
        <form method="post" action="RechercheTrajetServlet" class="mb-5">
            <div class="row g-3 justify-content-center">
                <div class="col-md-3">
                    <label for="depart" class="form-label">Départ :</label>
                    <select id="depart" name="departId" class="form-select" required>
                        <option value="">-- Sélectionnez une gare --</option>
                        <c:forEach items="${gares}" var="gare">
                            <option value="${gare.id}" ${gare.id == depart_recherche_id ? 'selected' : ''}>${gare.nom} (${gare.ville})</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-3">
                    <label for="destination" class="form-label">Destination :</label>
                    <select id="destination" name="destinationId" class="form-select" required>
                         <option value="">-- Sélectionnez une gare --</option>
                        <c:forEach items="${gares}" var="gare">
                            <option value="${gare.id}" ${gare.id == destination_recherche_id ? 'selected' : ''}>${gare.nom} (${gare.ville})</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-3">
                    <label for="date_depart" class="form-label">Date :</label>
                    <input type="date" id="date_depart" name="date_depart" class="form-control" 
                           value="${date_recherche}" required>
                </div>

                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">Rechercher</button>
                </div>
            </div>
        </form>

        <!-- Résultats de la recherche -->
        <c:if test="${not empty requestScope.trajets}">
            <h3 class="mt-5 mb-3">Résultats de la recherche :</h3>
            <c:if test="${not empty requestScope.trajets}">
                 <table class="table table-striped">
                     <thead>
                        <tr>
                             <th>Départ</th>
                             <th>Destination</th>
                             <th>Date départ</th>
                            <th>Heure départ</th>
                            <th>Heure arrivée</th>
                             <th>Prix</th>
                            <th>Places disponibles</th>
                             <th></th> <%-- Colonne pour le bouton de sélection --%>
                        </tr>
                    </thead>
                    <tbody>
                         <c:forEach items="${requestScope.trajets}" var="trajet">
                            <tr>
                                 <td>${trajet.depart}</td>
                                 <td>${trajet.destination}</td>
                                 <td><fmt:formatDate value="${trajet.date_depart}" pattern="dd/MM/yyyy"/></td>
                                 <td><fmt:formatDate value="${trajet.heure_depart}" pattern="HH:mm"/></td>
                                 <td><fmt:formatDate value="${trajet.heure_arrivee}" pattern="HH:mm"/></td>
                                 <td><fmt:formatNumber value="${trajet.prix}" pattern="#,##0.00"/> €</td>
                                 <td>${trajet.places_disponibles}</td>
                                 <td>
                                     <%-- Formulaire pour sélectionner le trajet --%>
                                     <form action="SelectionVoyageServlet" method="post">
                                         <input type="hidden" name="trajetId" value="${trajet.id}">
                                         <button type="submit" class="btn btn-success btn-sm">Sélectionner</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty requestScope.trajets}">
                <div class="alert alert-info" role="alert">
                    Aucun trajet trouvé pour cette recherche.
            </div>
            </c:if>
        </c:if>

        <c:if test="${empty trajets and not empty date_recherche}">
            <div class="alert alert-warning text-center" role="alert">
                Aucun trajet trouvé pour cette recherche.
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>