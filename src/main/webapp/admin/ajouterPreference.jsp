<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Préférence</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/admin-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="main-container">
        <h2 class="page-title-admin">Ajouter une Préférence</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/preferences/ajouter" method="post" class="admin-form mt-4">
            <div class="mb-3">
                <label for="nom" class="form-label">Nom de la préférence</label>
                <input type="text" class="form-control" id="nom" name="nom" required>
                <div class="form-text">Ex: Fenêtre, Espace famille, Non-fumeur</div>
            </div>
            
            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
            </div>
            
            <div class="mb-3">
                <label for="coutSupplementaire" class="form-label">Coût supplémentaire (€)</label>
                <input type="number" class="form-control" id="coutSupplementaire" name="coutSupplementaire" 
                       step="0.01" min="0" required>
                <div class="form-text">Montant supplémentaire à payer pour cette préférence</div>
            </div>
            
            <div class="mb-3">
                <button type="submit" class="btn btn-primary">Ajouter la préférence</button>
                <a href="${pageContext.request.contextPath}/admin/preferences/liste" class="modern-btn">
                    <i class="fas fa-arrow-left"></i> Annuler
                </a>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 