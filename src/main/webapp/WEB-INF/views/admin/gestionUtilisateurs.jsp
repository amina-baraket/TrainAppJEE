<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Utilisateurs - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="admin-container">
        <div class="admin-sidebar">
            <div class="admin-logo">
                <i class="fas fa-user-shield"></i>
                <span>Admin Panel</span>
            </div>
            <nav class="admin-nav">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/trajets" class="nav-item">
                    <i class="fas fa-route"></i>
                    <span>Gestion Trajets</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/utilisateurs" class="nav-item active">
                    <i class="fas fa-users"></i>
                    <span>Gestion Utilisateurs</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/reservations" class="nav-item">
                    <i class="fas fa-ticket-alt"></i>
                    <span>Gestion Réservations</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/statistiques" class="nav-item">
                    <i class="fas fa-chart-bar"></i>
                    <span>Statistiques</span>
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="nav-item">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Déconnexion</span>
                </a>
            </nav>
        </div>

        <div class="admin-content">
            <div class="admin-header">
                <h1>Gestion des Utilisateurs</h1>
                <div class="admin-user">
                    <i class="fas fa-user-circle"></i>
                    <span>${sessionScope.user.nom} ${sessionScope.user.prenom}</span>
                </div>
            </div>

            <div class="admin-card">
                <div class="card-header">
                    <h2>Liste des Utilisateurs</h2>
                    <div class="search-box">
                        <input type="text" id="searchInput" placeholder="Rechercher un utilisateur...">
                        <i class="fas fa-search"></i>
                    </div>
                </div>

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nom</th>
                                <th>Prénom</th>
                                <th>Email</th>
                                <th>Téléphone</th>
                                <th>Rôle</th>
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
                                    <td>${utilisateur.telephone}</td>
                                    <td>
                                        <span class="role-badge ${utilisateur.role.toLowerCase()}">
                                            ${utilisateur.role}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-edit" onclick="editUser('${utilisateur.id}')">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="btn-delete" onclick="deleteUser('${utilisateur.id}')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Fonction de recherche
        document.getElementById('searchInput').addEventListener('keyup', function() {
            const searchText = this.value.toLowerCase();
            const rows = document.querySelectorAll('tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchText) ? '' : 'none';
            });
        });

        // Fonction d'édition
        function editUser(id) {
            // Implémenter la logique d'édition
            console.log('Éditer utilisateur:', id);
        }

        // Fonction de suppression
        function deleteUser(id) {
            if (confirm('Êtes-vous sûr de vouloir supprimer cet utilisateur ?')) {
                // Implémenter la logique de suppression
                console.log('Supprimer utilisateur:', id);
            }
        }
    </script>
</body>
</html> 