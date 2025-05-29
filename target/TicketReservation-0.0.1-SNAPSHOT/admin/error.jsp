<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Erreur - TrainApp Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="alert alert-danger">
            <h2>Erreur Interne du Serveur</h2>
            <p>Une erreur est survenue lors du traitement de votre requête.</p>
            
            <c:if test="${not empty error}">
                <p>Détails de l'erreur : ${error}</p>
            </c:if>
            
            <p>Veuillez contacter l'administrateur du système.</p>
        </div>
        
        <p><a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary">Retour au Tableau de Bord</a></p>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 