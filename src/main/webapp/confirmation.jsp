<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirmation de Paiement</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            padding: 30px;
            color: #333;
        }
        h2 {
            color: #28a745; /* Green for success */
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 0.25rem;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <h2 class="mb-4">Paiement Réussi !</h2>

        <div class="alert alert-success" role="alert">
            Votre paiement a été effectué avec succès et votre réservation est confirmée.
        </div>

        <p>Merci pour votre achat.</p>

        <%-- You could add more details here if needed, e.g., links to view tickets --%>
        <div class="mt-4">
            <a href="RechercheTrajetServlet" class="btn btn-primary">Retour à la recherche de trajets</a>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 