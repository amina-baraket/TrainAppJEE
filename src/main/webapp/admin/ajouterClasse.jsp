<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Classe</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Ajouter une Classe</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/classes/ajouter" method="post" class="mt-4">
            <div class="mb-3">
                <label for="nom" class="form-label">Nom de la classe</label>
                <input type="text" class="form-control" id="nom" name="nom" required>
            </div>
            
            <div class="mb-3">
                <label for="coefficientPrix" class="form-label">Coefficient de prix</label>
                <input type="number" class="form-control" id="coefficientPrix" name="coefficientPrix" 
                       step="0.01" min="1" required>
                <div class="form-text">Multiplicateur du prix de base (ex: 1.5 pour 50% plus cher)</div>
            </div>
            
            <div class="mb-3">
                <label for="nombrePlaces" class="form-label">Nombre de places</label>
                <input type="number" class="form-control" id="nombrePlaces" name="nombrePlaces" 
                       min="1" required>
            </div>
            
            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
            </div>
            
            <div class="mb-3">
                <button type="submit" class="btn btn-primary">Ajouter la classe</button>
                <a href="${pageContext.request.contextPath}/admin/classes/liste" class="btn btn-secondary">
                    Annuler
                </a>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 