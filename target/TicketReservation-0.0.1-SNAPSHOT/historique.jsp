<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Historique</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Historique de vos voyages</h1>
<table>
    <tr><th>Trajet</th><th>Date</th><th>Statut</th></tr>
    <c:forEach items="${billets}" var="b">
        <tr>
            <td>${b.trajet.depart} - ${b.trajet.destination}</td>
            <td>${b.trajet.date_depart}</td>
            <td>${b.statut}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
