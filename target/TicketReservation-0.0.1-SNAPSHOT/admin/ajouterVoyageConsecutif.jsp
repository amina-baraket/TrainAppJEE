<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Voyage Consécutif</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Ajouter un Voyage Consécutif</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/voyages-consecutifs/ajouter" method="post" class="mt-4">
            <div class="mb-3">
                <label for="voyageInitial" class="form-label">Voyage Initial</label>
                <select class="form-select" id="voyageInitial" name="voyageInitial" required>
                    <option value="">Sélectionnez un voyage</option>
                    <c:forEach items="${voyages}" var="voyage">
                        <option value="${voyage.id}">
                            ${voyage.gareDepart.nom} → ${voyage.gareArrivee.nom} 
                            (${voyage.dateDepart})
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="voyageSuivant" class="form-label">Voyage Suivant</label>
                <select class="form-select" id="voyageSuivant" name="voyageSuivant" required>
                    <option value="">Sélectionnez un voyage</option>
                    <c:forEach items="${voyages}" var="voyage">
                        <option value="${voyage.id}">
                            ${voyage.gareDepart.nom} → ${voyage.gareArrivee.nom} 
                            (${voyage.dateDepart})
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="dureeAttente" class="form-label">Durée d'attente (minutes)</label>
                <input type="number" class="form-control" id="dureeAttente" name="dureeAttente" 
                       min="0" required>
                <div class="form-text">Temps d'attente entre les deux voyages</div>
            </div>
            
            <div class="mb-3">
                <button type="submit" class="btn btn-primary">Ajouter le voyage consécutif</button>
                <a href="${pageContext.request.contextPath}/admin/voyages-consecutifs/liste" class="btn btn-secondary">
                    Annuler
                </a>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Empêcher la sélection du même voyage pour initial et suivant
        document.getElementById('voyageInitial').addEventListener('change', function() {
            var voyageSuivant = document.getElementById('voyageSuivant');
            var selectedInitial = this.value;
            
            for (var i = 0; i < voyageSuivant.options.length; i++) {
                if (voyageSuivant.options[i].value === selectedInitial) {
                    voyageSuivant.options[i].disabled = true;
                } else {
                    voyageSuivant.options[i].disabled = false;
                }
            }
        });
    </script>
</body>
</html> 