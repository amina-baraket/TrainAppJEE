<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Accueil - TrainApp</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="container mt-5">
    <div class="jumbotron text-center">
        <h1 class="display-4">Bienvenue sur TrainApp !</h1>
        <p class="lead">Votre plateforme pour trouver et réserver vos billets de train facilement.</p>
        <hr class="my-4">
        <p>Prêt à voyager ? Recherchez votre prochain trajet dès maintenant.</p>
        <a class="btn btn-primary btn-lg" href="<%= request.getContextPath() %>/RechercheTrajetServlet" role="button">Rechercher un Trajet</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 