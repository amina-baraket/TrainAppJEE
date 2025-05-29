<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier une Gare</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Modifier une Gare</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/gares/modifier" method="post" class="mt-4">
            <input type="hidden" name="id" value="${gare.id}">
            
            <div class="mb-3">
                <label for="nom" class="form-label">Nom de la gare</label>
                <input type="text" class="form-control" id="nom" name="nom" value="${gare.nom}" required>
            </div>
            
            <div class="mb-3">
                <label for="ville" class="form-label">Ville</label>
                <input type="text" class="form-control" id="ville" name="ville" value="${gare.ville}" required>
            </div>
            
            <div class="mb-3">
                <label for="adresse" class="form-label">Adresse</label>
                <input type="text" class="form-control" id="adresse" name="adresse" value="${gare.adresse}" required>
            </div>
            
            <div class="mb-3">
                <label for="codePostal" class="form-label">Code Postal</label>
                <input type="text" class="form-control" id="codePostal" name="codePostal" value="${gare.codePostal}" required>
            </div>
            
            <div class="mb-3">
                <label for="pays" class="form-label">Pays</label>
                <input type="text" class="form-control" id="pays" name="pays" value="${gare.pays}" required>
            </div>
            
            <div class="mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="active" name="active" 
                           ${gare.active ? 'checked' : ''}>
                    <label class="form-check-label" for="active">
                        Gare active
                    </label>
                </div>
            </div>
            
            <div class="mb-3">
                <button type="submit" class="btn btn-primary">Enregistrer les modifications</button>
                <a href="${pageContext.request.contextPath}/admin/gares/liste" class="btn btn-secondary">Annuler</a>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 