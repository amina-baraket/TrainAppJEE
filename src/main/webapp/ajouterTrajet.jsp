<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Ajouter un Trajet</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Ajouter un Nouveau Trajet</h1>
<form action="ajouterTrajet" method="post">
    <input type="text" name="depart" placeholder="Ville de départ" required>
    <input type="text" name="destination" placeholder="Ville d’arrivée" required>
    <input type="date" name="date_depart" required>
    <input type="time" name="heure_depart" required>
    <input type="time" name="heure_arrivee" required>
    <input type="number" name="prix" step="0.01" placeholder="Prix" required>
    <input type="number" name="places_disponibles" placeholder="Places disponibles" required>
    <button type="submit">Ajouter</button>
</form>
</body>
</html>
