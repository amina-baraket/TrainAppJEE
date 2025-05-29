<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Paiements</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Gestion des Paiements</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <div class="mb-3">
            <div class="btn-group" role="group">
                <a href="${pageContext.request.contextPath}/admin/paiements" 
                   class="btn btn-outline-primary ${empty param.statut ? 'active' : ''}">
                    Tous
                </a>
                <a href="${pageContext.request.contextPath}/admin/paiements?statut=EN_ATTENTE" 
                   class="btn btn-outline-primary ${param.statut == 'EN_ATTENTE' ? 'active' : ''}">
                    En attente
                </a>
                <a href="${pageContext.request.contextPath}/admin/paiements?statut=VALIDE" 
                   class="btn btn-outline-primary ${param.statut == 'VALIDE' ? 'active' : ''}">
                    Validés
                </a>
                <a href="${pageContext.request.contextPath}/admin/paiements?statut=REMBOURSE" 
                   class="btn btn-outline-primary ${param.statut == 'REMBOURSE' ? 'active' : ''}">
                    Remboursés
                </a>
            </div>
        </div>
        
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Billet</th>
                        <th>Montant</th>
                        <th>Date</th>
                        <th>Statut</th>
                        <th>Commentaire</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${paiements}" var="paiement">
                        <tr>
                            <td>${paiement.id}</td>
                            <td>${paiement.billet.id}</td>
                            <td>
                                <fmt:formatNumber value="${paiement.montant}" 
                                                type="currency" 
                                                currencySymbol="€"/>
                            </td>
                            <td>
                                <fmt:formatDate value="${paiement.datePaiement}" 
                                              pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${paiement.statut == 'EN_ATTENTE'}">
                                        <span class="badge bg-warning">En attente</span>
                                    </c:when>
                                    <c:when test="${paiement.statut == 'VALIDE'}">
                                        <span class="badge bg-success">Validé</span>
                                    </c:when>
                                    <c:when test="${paiement.statut == 'REMBOURSE'}">
                                        <span class="badge bg-info">Remboursé</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>${paiement.commentaire}</td>
                            <td>
                                <c:if test="${paiement.statut == 'VALIDE' && paiement.billet.statut == 'ANNULE'}">
                                    <button type="button" class="btn btn-primary btn-sm" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#modalRembourser${paiement.id}">
                                        Rembourser
                                    </button>
                                    
                                    <!-- Modal pour rembourser le paiement -->
                                    <div class="modal fade" id="modalRembourser${paiement.id}" tabindex="-1">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Rembourser le paiement</h5>
                                                    <button type="button" class="btn-close" 
                                                            data-bs-dismiss="modal"></button>
                                                </div>
                                                <form action="${pageContext.request.contextPath}/admin/paiements/rembourser" 
                                                      method="post">
                                                    <div class="modal-body">
                                                        <input type="hidden" name="id" value="${paiement.id}">
                                                        
                                                        <div class="mb-3">
                                                            <label for="commentaire" class="form-label">
                                                                Commentaire
                                                            </label>
                                                            <textarea class="form-control" id="commentaire" 
                                                                      name="commentaire" rows="3"></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" 
                                                                data-bs-dismiss="modal">Annuler</button>
                                                        <button type="submit" class="btn btn-primary">
                                                            Confirmer le remboursement
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
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