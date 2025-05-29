<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Liste des Trajets</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Liste des Trajets</h1>
<table>
    <tr>
        <th>Départ</th><th>Destination</th><th>Date</th><th>Heure Départ</th><th>Heure Arrivée</th><th>Prix</th><th>Places</th>
    </tr>
    <c:forEach items="${trajets}" var="trajet">
        <tr>
            <td>${trajet.depart}</td>
            <td>${trajet.destination}</td>
            <td>${trajet.date_depart}</td>
            <td>${trajet.heure_depart}</td>
            <td>${trajet.heure_arrivee}</td>
            <td>${trajet.prix}</td>
            <td>${trajet.places_disponibles}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
