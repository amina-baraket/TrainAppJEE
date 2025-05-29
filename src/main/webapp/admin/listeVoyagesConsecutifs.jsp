<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Voyages Consécutifs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/admin-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="main-container">
        <h2 class="page-title-admin">Liste des Voyages Consécutifs</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </c:if>
         <c:if test="${not empty success}">
            <div class="alert alert-success" role="alert">
                ${success}
            </div>
        </c:if>
        
        <c:if test="${empty voyagesConsecutifs}">
            <div class="alert alert-info text-center" role="alert">
                Aucun voyage consécutif trouvé.
            </div>
        </c:if>

        <c:if test="${not empty voyagesConsecutifs}">
            <table class="table table-striped table-hover mt-4">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Voyage Initial</th>
                        <th>Voyage Suivant</th>
                        <th>Durée d'Attente (min)</th>
                        <th>Actif</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${voyagesConsecutifs}" var="vc">
                        <tr>
                            <td>${vc.id}</td>
                            <td>
                                <c:if test="${not empty vc.voyageInitial}">
                                    ${vc.voyageInitial.trajet.depart} à ${vc.voyageInitial.trajet.destination} (<fmt:formatDate value='${vc.voyageInitial.trajet.date_depart}' pattern='dd/MM/yyyy HH:mm'/>)
                                </c:if>
                                <c:if test="${empty vc.voyageInitial}">
                                    N/A
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${not empty vc.voyageSuivant}">
                                     ${vc.voyageSuivant.trajet.depart} à ${vc.voyageSuivant.trajet.destination} (<fmt:formatDate value='${vc.voyageSuivant.trajet.date_depart}' pattern='dd/MM/yyyy HH:mm'/>)
                                </c:if>
                                <c:if test="${empty vc.voyageSuivant}">
                                    N/A
                                </c:if>
                            </td>
                            <td>${vc.dureeAttente}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${vc.actif}">
                                        <span class="badge bg-success">Oui</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Non</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="actions-cell">
                                <a href="${pageContext.request.contextPath}/admin/voyages-consecutifs/modifier?id=${vc.id}" class="btn btn-sm btn-warning me-1" title="Modifier">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/voyages-consecutifs/supprimer?id=${vc.id}" class="btn btn-sm btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce voyage consécutif ?');" title="Supprimer">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <div class="mt-4 text-center">
             <a href="${pageContext.request.contextPath}/admin/voyages-consecutifs/ajouter" class="btn btn-primary me-2">
                <i class="fas fa-plus"></i> Ajouter un Voyage Consécutif
            </a>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Retour au Tableau de Bord
            </a>
        </div>

    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 