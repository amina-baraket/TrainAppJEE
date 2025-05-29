<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier un Voyage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/admin-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="main-container">
        <h2 class="page-title-admin">Modifier un Voyage</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
         <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/voyages/modifier" method="post" class="admin-form mt-4">
            <input type="hidden" name="id" value="${trajet.id}">
            
            <div class="mb-3">
                <label for="depart" class="form-label">Gare de Départ</label>
                <select class="form-select" id="depart" name="depart" required>
                    <option value="">Sélectionnez une gare</option>
                    <c:forEach items="${gares}" var="gare">
                        <option value="${gare.ville}" ${gare.ville eq trajet.depart ? 'selected' : ''}>
                            ${gare.nom} (${gare.ville})
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="destination" class="form-label">Gare de Destination</label>
                <select class="form-select" id="destination" name="destination" required>
                    <option value="">Sélectionnez une gare</option>
                    <c:forEach items="${gares}" var="gare">
                        <option value="${gare.ville}" ${gare.ville eq trajet.destination ? 'selected' : ''}>
                            ${gare.nom} (${gare.ville})
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="dateDepart" class="form-label">Date de Départ</label>
                <input type="date" class="form-control" id="dateDepart" name="dateDepart" 
                       value="<fmt:formatDate value='${trajet.date_depart}' pattern='yyyy-MM-dd'/>" required>
            </div>
            
            <div class="mb-3">
                <label for="heureDepart" class="form-label">Heure de Départ</label>
                <input type="time" class="form-control" id="heureDepart" name="heureDepart" 
                       value="<fmt:formatDate value='${trajet.heure_depart}' pattern='HH:mm'/>" required>
            </div>
            
            <div class="mb-3">
                <label for="heureArrivee" class="form-label">Heure d'Arrivée</label>
                <input type="time" class="form-control" id="heureArrivee" name="heureArrivee" 
                       value="<fmt:formatDate value='${trajet.heure_arrivee}' pattern='HH:mm'/>" required>
            </div>
            
            <div class="mb-3">
                <label for="prix" class="form-label">Prix de Base (€)</label>
                <input type="number" class="form-control" id="prix" name="prix" 
                       value="${trajet.prix}" step="0.01" min="0" required>
            </div>
            
            <div class="mb-3">
                <label for="placesDisponibles" class="form-label">Places Disponibles</label>
                <input type="number" class="form-control" id="placesDisponibles" name="placesDisponibles" 
                       value="${trajet.places_disponibles}" min="1" required>
            </div>
            
            <div class="mb-3">
                <label for="promotionPercentage" class="form-label">Pourcentage de Promotion (%)</label>
                <input type="number" class="form-control" id="promotionPercentage" name="promotionPercentage" 
                       value="${trajet.promotionPercentage}" min="0" max="100" step="0.01">
            </div>
            
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Enregistrer les modifications
                </button>
                <a href="${pageContext.request.contextPath}/admin/voyages/liste" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Annuler
                </a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Empêcher la sélection de la même gare pour le départ et la destination
        document.getElementById('depart').addEventListener('change', function() {
            var destination = document.getElementById('destination');
            for(var i = 0; i < destination.options.length; i++) {
                if(destination.options[i].value === this.value) {
                    destination.options[i].disabled = true;
                } else {
                    destination.options[i].disabled = false;
                }
            }
        });

        document.getElementById('destination').addEventListener('change', function() {
            var depart = document.getElementById('depart');
            for(var i = 0; i < depart.options.length; i++) {
                if(depart.options[i].value === this.value) {
                    depart.options[i].disabled = true;
                } else {
                    depart.options[i].disabled = false;
                }
            }
        });
    </script>
</body>
</html> 