<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Accueil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="text-center">
        <h1 class="mb-4">Bienvenue sur le site de réservation</h1>
        <p class="lead text-success">${message}</p>
        <a href="RechercheTrajet.jsp" class="btn btn-primary mt-3">Faire une nouvelle recherche</a>
        <p><a href="<%= request.getContextPath() %>/UserBilletsServlet">Mes Billets</a></p>
    </div>
</div>

</body>
</html>
