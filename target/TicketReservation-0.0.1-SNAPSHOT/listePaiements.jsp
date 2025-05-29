<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Liste des Paiements</title></head>
<body>
    <h2>Liste des paiements</h2>
    <table border="1">
        <tr><th>ID</th><th>Utilisateur</th><th>Montant</th><th>Date</th></tr>
        <c:forEach var="p" items="${paiements}">
            <tr>
                <td>${p.id}</td>
                <td>${p.user.nom}</td>
                <td>${p.montant}</td>
                <td>${p.datePaiement}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
