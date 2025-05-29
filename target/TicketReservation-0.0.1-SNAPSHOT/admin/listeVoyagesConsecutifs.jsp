<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Voyages Consécutifs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Gestion des Voyages Consécutifs</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <div class="mb-3">
            <a href="${pageContext.request.contextPath}/admin/voyages-consecutifs/ajouter" class="btn btn-primary">
                Ajouter un voyage consécutif
            </a>
        </div>
        
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Voyage Initial</th>
                    <th>Voyage Suivant</th>
                    <th>Durée d'attente</th>
                    <th>Statut</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${voyagesConsecutifs}" var="vc">
                    <tr>
                        <td>${vc.id}</td>
                        <td>
                            ${vc.voyageInitial.gareDepart.nom} → ${vc.voyageInitial.gareArrivee.nom}<br>
                            <small class="text-muted">${vc.voyageInitial.dateDepart}</small>
                        </td>
                        <td>
                            ${vc.voyageSuivant.gareDepart.nom} → ${vc.voyageSuivant.gareArrivee.nom}<br>
                            <small class="text-muted">${vc.voyageSuivant.dateDepart}</small>
                        </td>
                        <td>${vc.dureeAttente} minutes</td>
                        <td>
                            <span class="badge ${vc.actif ? 'bg-success' : 'bg-danger'}">
                                ${vc.actif ? 'Actif' : 'Inactif'}
                            </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/voyages-consecutifs/modifier?id=${vc.id}" 
                               class="btn btn-sm btn-warning">Modifier</a>
                            <a href="${pageContext.request.contextPath}/admin/voyages-consecutifs/supprimer?id=${vc.id}" 
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce voyage consécutif ?')">Supprimer</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
            Retour au tableau de bord
        </a>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 