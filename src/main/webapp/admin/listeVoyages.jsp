<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Voyages</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/admin-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="main-container">
        <h2 class="page-title-admin">Gestion des Voyages</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <div class="mb-3">
            <a href="${pageContext.request.contextPath}/admin/voyages/ajouter" class="modern-btn">
                <i class="fas fa-plus-circle"></i> Ajouter un voyage
            </a>
        </div>
        
        <div class="table-responsive">
            <table class="admin-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Départ</th>
                    <th>Destination</th>
                    <th>Date</th>
                    <th>Heure Départ</th>
                    <th>Heure Arrivée</th>
                    <th>Prix</th>
                    <th>Places</th>
                    <th>Promotion</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${voyages}" var="trajet">
                    <tr>
                        <td>${trajet.id}</td>
                        <td>${trajet.depart}</td>
                        <td>${trajet.destination}</td>
                        <td>${trajet.date_depart}</td>
                        <td>${trajet.heure_depart}</td>
                        <td>${trajet.heure_arrivee}</td>
                        <td>${trajet.prix} €</td>
                        <td>${trajet.places_disponibles}</td>
                        <td>
                            <c:if test="${trajet.promotionPercentage > 0}">
                                <span class="badge bg-success">${trajet.promotionPercentage}%</span>
                            </c:if>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/voyages/modifier?id=${trajet.id}" 
                               class="btn btn-sm btn-warning">
                                <i class="fas fa-edit"></i> Modifier
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/voyages/supprimer?id=${trajet.id}" 
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce voyage ?')">
                                <i class="fas fa-trash-alt"></i> Supprimer
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        
        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="modern-btn">
                <i class="fas fa-arrow-left"></i> Retour au tableau de bord
            </a>
        </div>

    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 