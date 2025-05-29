<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Utilisateurs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Gestion des Utilisateurs</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Email</th>
                        <th>Rôle</th>
                        <th>Statut</th>
                        <th>Date d'inscription</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${utilisateurs}" var="utilisateur">
                        <tr>
                            <td>${utilisateur.id}</td>
                            <td>${utilisateur.nom}</td>
                            <td>${utilisateur.prenom}</td>
                            <td>${utilisateur.email}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${utilisateur.admin}">
                                        <span class="badge bg-danger">Administrateur</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-info">Utilisateur</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${utilisateur.active}">
                                        <span class="badge bg-success">Actif</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Inactif</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <fmt:formatDate value="${utilisateur.dateInscription}" 
                                              pattern="dd/MM/yyyy"/>
                            </td>
                            <td>
                                <c:if test="${utilisateur.id != sessionScope.user.id}">
                                    <form action="${pageContext.request.contextPath}/admin/utilisateurs/changer-statut" 
                                          method="post" class="d-inline">
                                        <input type="hidden" name="id" value="${utilisateur.id}">
                                        <input type="hidden" name="actif" value="${!utilisateur.active}">
                                        <button type="submit" class="btn btn-sm ${utilisateur.active ? 'btn-danger' : 'btn-success'}"
                                                onclick="return confirm('Êtes-vous sûr de vouloir  cet utilisateur ?')">
                                            ${utilisateur.active ? 'Désactiver' : 'Activer'}
                                        </button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
                Retour au tableau de bord
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 