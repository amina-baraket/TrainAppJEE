<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord Administrateur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Tableau de Bord Administrateur</h2>
        
        <div class="row mt-4">
            <!-- Gestion des Gares -->
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-building"></i> Gestion des Gares
                        </h5>
                        <p class="card-text">Gérer les gares de départ et d'arrivée</p>
                        <a href="${pageContext.request.contextPath}/admin/gares" class="btn btn-primary">
                            Accéder
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Gestion des Voyages -->
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-train-front"></i> Gestion des Voyages
                        </h5>
                        <p class="card-text">Gérer les voyages et les trajets</p>
                        <a href="${pageContext.request.contextPath}/admin/voyages" class="btn btn-primary">
                            Accéder
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Gestion des Voyages Consécutifs -->
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-arrow-left-right"></i> Voyages Consécutifs
                        </h5>
                        <p class="card-text">Gérer les voyages consécutifs</p>
                        <a href="${pageContext.request.contextPath}/admin/voyages-consecutifs" class="btn btn-primary">
                            Accéder
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Gestion des Utilisateurs -->
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-people"></i> Gestion des Utilisateurs
                        </h5>
                        <p class="card-text">Gérer les utilisateurs et leurs comptes</p>
                        <a href="${pageContext.request.contextPath}/admin/utilisateurs" class="btn btn-primary">
                            Accéder
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Demandes d'Annulation -->
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-x-circle"></i> Demandes d'Annulation
                        </h5>
                        <p class="card-text">Gérer les demandes d'annulation de billets</p>
                        <a href="${pageContext.request.contextPath}/admin/demandes-annulation" class="btn btn-primary">
                            Accéder
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Gestion des Paiements -->
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-credit-card"></i> Gestion des Paiements
                        </h5>
                        <p class="card-text">Gérer les paiements et les remboursements</p>
                        <a href="${pageContext.request.contextPath}/admin/paiements" class="btn btn-primary">
                            Accéder
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Statistiques -->
        <div class="row mt-4">
            <div class="col-12">
                <h3>Statistiques</h3>
                <div class="row">
                    <div class="col-md-3 mb-4">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <h5 class="card-title">Voyages</h5>
                                <p class="card-text display-6">${nombreVoyages}</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <h5 class="card-title">Billets Vendus</h5>
                                <p class="card-text display-6">${nombreBillets}</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card bg-warning text-dark">
                            <div class="card-body">
                                <h5 class="card-title">Demandes en Attente</h5>
                                <p class="card-text display-6">${demandesEnAttente}</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <h5 class="card-title">Utilisateurs</h5>
                                <p class="card-text display-6">${nombreUtilisateurs}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                <i class="bi bi-box-arrow-right"></i> Déconnexion
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 