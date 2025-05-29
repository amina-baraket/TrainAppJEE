<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.trainapp.model.Trajet" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Résultats de la recherche</title>
</head>
<body>

<h2>Résultats de la recherche</h2>

<%
    List<Trajet> trajets = (List<Trajet>) request.getAttribute("trajets");

    if (trajets != null && !trajets.isEmpty()) {
%>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Départ</th>
            <th>Destination</th>
            <th>Date départ</th>
            <th>Heure départ</th>
            <th>Heure arrivée</th>
            <th>Prix</th>
            <th>Places disponibles</th>
        </tr>
    <%
        for (Trajet t : trajets) {
    %>
        <tr>
            <td><%= t.getDepart() %></td>
            <td><%= t.getDestination() %></td>
            <td><%= t.getDate_depart() %></td>
            <td><%= t.getHeure_depart() %></td>
            <td><%= t.getHeure_arrivee() %></td>
            <td><%= t.getPrix() %> €</td>
            <td><%= t.getPlaces_disponibles() %></td>
        </tr>
    <%
        }
    %>
    </table>
<%
    } else {
%>
    <p>Aucun trajet trouvé.</p>
<%
    }
%>

<p><a href="RechercheTrajet.jsp">Nouvelle recherche</a></p>

</body>
</html>
