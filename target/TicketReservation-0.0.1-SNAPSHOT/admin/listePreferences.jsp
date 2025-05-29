<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Préférences</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Gestion des Préférences</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <div class="mb-3">
            <a href="${pageContext.request.contextPath}/admin/preferences/ajouter" class="btn btn-primary">
                Ajouter une préférence
            </a>
        </div>
        
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Description</th>
                    <th>Coût supplémentaire</th>
                    <th>Statut</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${preferences}" var="preference">
                    <tr>
                        <td>${preference.id}</td>
                        <td>${preference.nom}</td>
                        <td>${preference.description}</td>
                        <td>${preference.coutSupplementaire} €</td>
                        <td>
                            <span class="badge ${preference.disponible ? 'bg-success' : 'bg-danger'}">
                                ${preference.disponible ? 'Disponible' : 'Indisponible'}
                            </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/preferences/modifier?id=${preference.id}" 
                               class="btn btn-sm btn-warning">Modifier</a>
                            <a href="${pageContext.request.contextPath}/admin/preferences/supprimer?id=${preference.id}" 
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette préférence ?')">Supprimer</a>
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