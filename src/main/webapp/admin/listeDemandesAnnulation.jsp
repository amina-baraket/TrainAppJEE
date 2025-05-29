<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Demandes d'Annulation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Gestion des Demandes d'Annulation</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <div class="mb-3">
            <div class="btn-group" role="group">
                <a href="${pageContext.request.contextPath}/admin/demandes-annulation" 
                   class="btn btn-outline-primary ${empty param.statut ? 'active' : ''}">
                    Toutes
                </a>
                <a href="${pageContext.request.contextPath}/admin/demandes-annulation?statut=EN_ATTENTE" 
                   class="btn btn-outline-primary ${param.statut == 'EN_ATTENTE' ? 'active' : ''}">
                    En attente
                </a>
                <a href="${pageContext.request.contextPath}/admin/demandes-annulation?statut=ACCEPTEE" 
                   class="btn btn-outline-primary ${param.statut == 'ACCEPTEE' ? 'active' : ''}">
                    Acceptées
                </a>
                <a href="${pageContext.request.contextPath}/admin/demandes-annulation?statut=REFUSEE" 
                   class="btn btn-outline-primary ${param.statut == 'REFUSEE' ? 'active' : ''}">
                    Refusées
                </a>
            </div>
        </div>
        
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Utilisateur</th>
                        <th>Billet</th>
                        <th>Motif</th>
                        <th>Date demande</th>
                        <th>Statut</th>
                        <th>Date traitement</th>
                        <th>Commentaire</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${demandes}" var="demande">
                        <tr>
                            <td>${demande.id}</td>
                            <td>${demande.user.nom} ${demande.user.prenom}</td>
                            <td>${demande.billet.id}</td>
                            <td>${demande.motif}</td>
                            <td>
                                <fmt:formatDate value="${demande.dateDemande}" 
                                              pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${demande.statut == 'EN_ATTENTE'}">
                                        <span class="badge bg-warning">En attente</span>
                                    </c:when>
                                    <c:when test="${demande.statut == 'ACCEPTEE'}">
                                        <span class="badge bg-success">Acceptée</span>
                                    </c:when>
                                    <c:when test="${demande.statut == 'REFUSEE'}">
                                        <span class="badge bg-danger">Refusée</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${not empty demande.dateTraitement}">
                                    <fmt:formatDate value="${demande.dateTraitement}" 
                                                  pattern="dd/MM/yyyy HH:mm"/>
                                </c:if>
                            </td>
                            <td>${demande.commentaireAdmin}</td>
                            <td>
                                <c:if test="${demande.statut == 'EN_ATTENTE'}">
                                    <button type="button" class="btn btn-success btn-sm" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#modalTraiter${demande.id}">
                                        Traiter
                                    </button>
                                    
                                    <!-- Modal pour traiter la demande -->
                                    <div class="modal fade" id="modalTraiter${demande.id}" tabindex="-1">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Traiter la demande</h5>
                                                    <button type="button" class="btn-close" 
                                                            data-bs-dismiss="modal"></button>
                                                </div>
                                                <form action="${pageContext.request.contextPath}/admin/demandes-annulation/traiter" 
                                                      method="post">
                                                    <div class="modal-body">
                                                        <input type="hidden" name="id" value="${demande.id}">
                                                        
                                                        <div class="mb-3">
                                                            <label class="form-label">Action</label>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" 
                                                                       name="action" value="accepter" required>
                                                                <label class="form-check-label">
                                                                    Accepter
                                                                </label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" 
                                                                       name="action" value="refuser" required>
                                                                <label class="form-check-label">
                                                                    Refuser
                                                                </label>
                                                            </div>
                                                        </div>
                                                        
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
                                                            Confirmer
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