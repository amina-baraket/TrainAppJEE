<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier une Classe</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/admin-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="main-container">
        <h2 class="page-title-admin">Modifier une Classe</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/classes/modifier" method="post" class="admin-form mt-4">
            <input type="hidden" name="id" value="${classe.id}">
            
            <div class="mb-3">
                <label for="nom" class="form-label">Nom de la classe</label>
                <input type="text" class="form-control" id="nom" name="nom" 
                       value="${classe.nom}" required>
            </div>
            
            <div class="mb-3">
                <label for="coefficientPrix" class="form-label">Coefficient de prix</label>
                <input type="number" class="form-control" id="coefficientPrix" name="coefficientPrix" 
                       step="0.01" min="1" value="${classe.coefficientPrix}" required>
                <div class="form-text">Multiplicateur du prix de base (ex: 1.5 pour 50% plus cher)</div>
            </div>
            
            <div class="mb-3">
                <label for="nombrePlaces" class="form-label">Nombre de places</label>
                <input type="number" class="form-control" id="nombrePlaces" name="nombrePlaces" 
                       min="1" value="${classe.nombrePlaces}" required>
            </div>
            
            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" 
                          rows="3">${classe.description}</textarea>
            </div>
            
            <div class="mb-3">
                <button type="submit" class="btn btn-primary">Enregistrer les modifications</button>
                <a href="${pageContext.request.contextPath}/admin/classes/liste" class="modern-btn">
                    <i class="fas fa-arrow-left"></i> Annuler
                </a>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 