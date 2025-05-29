<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier un Voyage Consécutif</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/admin-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="main-container">
        <h2 class="page-title-admin">Modifier un Voyage Consécutif</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/voyages-consecutifs/modifier" method="post" class="admin-form mt-4">
            <input type="hidden" name="id" value="${voyageConsecutif.id}">
            
            <div class="mb-3">
                <label for="voyageInitial" class="form-label">Voyage Initial</label>
                <select class="form-select" id="voyageInitial" name="voyageInitial" required>
                    <option value="">Sélectionnez un voyage</option>
                    <c:forEach items="${voyages}" var="voyage">
                        <option value="${voyage.id}" ${voyage.id == voyageConsecutif.voyageInitial.id ? 'selected' : ''}>
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
                        <option value="${voyage.id}" ${voyage.id == voyageConsecutif.voyageSuivant.id ? 'selected' : ''}>
                            ${voyage.gareDepart.nom} → ${voyage.gareArrivee.nom} 
                            (${voyage.dateDepart})
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="dureeAttente" class="form-label">Durée d'attente (minutes)</label>
                <input type="number" class="form-control" id="dureeAttente" name="dureeAttente" 
                       min="0" value="${voyageConsecutif.dureeAttente}" required>
                <div class="form-text">Temps d'attente entre les deux voyages</div>
            </div>
            
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="actif" name="actif" 
                       ${voyageConsecutif.actif ? 'checked' : ''}>
                <label class="form-check-label" for="actif">Actif</label>
            </div>
            
            <div class="mb-3">
                <button type="submit" class="btn btn-primary">Enregistrer les modifications</button>
                <a href="${pageContext.request.contextPath}/admin/voyages-consecutifs/liste" class="modern-btn">
                    <i class="fas fa-arrow-left"></i> Annuler
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