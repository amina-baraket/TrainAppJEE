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
            background: linear-gradient(135deg, #dff6ff 0%, #e8f9fd 50%, #cceeff 100%);
            min-height: 100vh;
            padding: 30px;
            color: #004d66;
        }
        h2 {
            color: #004d66;
            font-weight: bold;
            text-shadow: 0 1px 2px rgba(0, 77, 102, 0.1);
        }
        table {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 77, 102, 0.1);
            border: 1px solid rgba(0, 201, 255, 0.2);
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background: linear-gradient(135deg, #004d66 0%, #006080 100%);
            color: white;
            font-weight: 600;
            border-bottom: 2px solid #00c9ff;
        }
        tr:nth-child(even) {
            background: linear-gradient(90deg, rgba(223, 246, 255, 0.3) 0%, rgba(232, 249, 253, 0.3) 100%);
        }
        tr:hover {
            background: linear-gradient(90deg, rgba(0, 201, 255, 0.1) 0%, rgba(223, 246, 255, 0.4) 100%);
            transform: translateY(-1px);
            transition: all 0.3s ease;
        }
        .btn-select {
            background: linear-gradient(135deg, #00c9ff 0%, #0080cc 100%);
            color: white;
            border: none;
            padding: 10px 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            box-shadow: 0 4px 12px rgba(0, 201, 255, 0.3);
        }
        .btn-select:hover {
            background: linear-gradient(135deg, #0080cc 0%, #004d66 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 201, 255, 0.4);
        }
        .alert {
            margin-top: 20px;
            border-radius: 10px;
            border: none;
        }
        .alert-danger {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a5a 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }
        .alert-info {
            background: linear-gradient(135deg, #e8f9fd 0%, #cceeff 100%);
            color: #004d66;
            border: 2px solid #00c9ff;
            box-shadow: 0 4px 15px rgba(0, 201, 255, 0.2);
        }
        .container {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px rgba(0, 77, 102, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .btn-secondary {
            background: linear-gradient(135deg, #004d66 0%, #006080 100%);
            border: none;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0, 77, 102, 0.3);
        }
        .btn-secondary:hover {
            background: linear-gradient(135deg, #006080 0%, #00c9ff 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 77, 102, 0.4);
        }
        p {
            color: #004d66;
            font-weight: 500;
            background: rgba(255, 255, 255, 0.6);
            padding: 12px 20px;
            border-radius: 8px;
            border-left: 4px solid #00c9ff;
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