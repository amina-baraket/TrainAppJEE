<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inscription</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <div class="floating-elements"></div>
    
    <div class="container py-5">
        <!-- Hero section -->
        <div class="hero-section text-center mb-5">
            <div class="icon-wrapper mx-auto mb-3">
                <i class="fas fa-user-plus fa-lg"></i>
            </div>
            <h1 class="page-title">Inscription</h1>
            <p class="page-subtitle">Créez votre compte</p>
        </div>

        <div class="glass-card mx-auto" style="max-width: 500px;">
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="<%= request.getContextPath() %>/register" method="post">
                <div class="mb-3">
                    <label for="nom" class="form-label">
                        <i class="fas fa-user me-2"></i>Nom
                    </label>
                    <input type="text" class="form-control" id="nom" name="nom" required>
                </div>
                <div class="mb-3">
                    <label for="prenom" class="form-label">
                        <i class="fas fa-user me-2"></i>Prénom
                    </label>
                    <input type="text" class="form-control" id="prenom" name="prenom" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">
                         <i class="fas fa-envelope me-2"></i>Email
                    </label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">
                        <i class="fas fa-lock me-2"></i>Mot de passe
                    </label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">
                        <i class="fas fa-lock me-2"></i>Confirmer le mot de passe
                    </label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-user-plus me-2"></i>S'inscrire
                </button>
            </form>
            
            <div class="text-center mt-3">
                <p>Déjà un compte ? <a href="login.jsp"><i class="fas fa-sign-in-alt me-1"></i>Se connecter</a></p>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
