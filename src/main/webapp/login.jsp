<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
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
                <i class="fas fa-user-circle fa-lg"></i>
            </div>
            <h1 class="page-title">Connexion</h1>
            <p class="page-subtitle">Connectez-vous à votre compte</p>
        </div>

        <div class="glass-card mx-auto" style="max-width: 400px;">
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success" role="alert">
                     <i class="fas fa-check-circle me-2"></i>
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>
            
            <form action="<%= request.getContextPath() %>/login" method="post">
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
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-sign-in-alt me-2"></i>Se connecter
                </button>
            </form>
            
            <div class="text-center mt-3">
                <p>Pas encore de compte ? <a href="register.jsp"><i class="fas fa-user-plus me-1"></i>S'inscrire</a></p>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
