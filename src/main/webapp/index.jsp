<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrainApp - Votre Voyage Commence Ici</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #dff6ff, #e8f9fd, #cceeff);
            --secondary-gradient: linear-gradient(135deg, #ff9a9e, #fad0c4);
            --accent-gradient: linear-gradient(135deg, #00c9ff, #92fe9d);
            --success-gradient: linear-gradient(135deg, #a1ffce, #faffd1);
            --warning-gradient: linear-gradient(135deg, #ffe29f, #ffa99f);
            --purple-gradient: linear-gradient(135deg, #a18cd1, #fbc2eb);
            --glass-bg: rgba(255, 255, 255, 0.6);
            --glass-border: rgba(0, 0, 0, 0.1);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            background: var(--primary-gradient);
            color: #222;
        }

        .bg-particles {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .particle {
            position: absolute;
            width: 4px; height: 4px;
            background: rgba(0, 201, 255, 0.3);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .navbar {
            background: var(--glass-bg);
            backdrop-filter: blur(8px);
            border-bottom: 1px solid var(--glass-border);
        }

        .navbar-brand {
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-link {
            color: #333 !important;
        }

        .nav-link:hover {
            background: rgba(0, 0, 0, 0.05);
        }

        .hero-section {
            min-height: 90vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            text-align: center;
        }

        .hero-content h1 {
            font-size: 3rem;
            color: #004d66;
        }

        .hero-content p {
            font-size: 1.3rem;
            color: #333;
            margin-top: 1rem;
            line-height: 1.6;
        }

        .btn-modern {
            background: var(--accent-gradient);
            border: none;
            padding: 1rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            color: white;
            margin-top: 2rem;
            text-decoration: none;
            display: inline-flex;
            gap: 0.5rem;
            align-items: center;
            box-shadow: 0 8px 25px rgba(0, 201, 255, 0.3);
            transition: 0.4s ease;
        }

        .btn-modern:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 201, 255, 0.4);
        }

        .features-section {
            padding: 5rem 0;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            margin: 2rem;
            border-radius: 30px;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: 20px;
            text-align: center;
            transition: 0.3s ease;
            border: 1px solid var(--glass-border);
        }

        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .feature-title {
            color: #004d66;
            font-weight: bold;
        }

        .feature-desc {
            color: #333;
        }

        .stats-section {
            text-align: center;
            padding: 4rem 0;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 900;
        }

        .stat-label {
            font-size: 1.1rem;
            color: #444;
        }

        .text-purple {
            background: var(--purple-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .text-info {
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .text-success {
            background: var(--success-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .text-warning {
            background: var(--warning-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        footer {
            background: #ffffff;
            color: #333;
            padding: 1rem 0;
            text-align: center;
        }

        @media (max-width: 768px) {
            .hero-content h1 { font-size: 2.2rem; }
        }
    </style>
</head>
<body>
<div class="bg-particles"></div>

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-train"></i> TrainApp</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <c:if test="${sessionScope.user == null}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp"><i class="fas fa-sign-in-alt"></i> Connexion</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/register.jsp"><i class="fas fa-user-plus"></i> Inscription</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.user != null}">
                    <li class="nav-item">
                        <span class="nav-link"><i class="fas fa-user"></i> Bienvenue, ${sessionScope.user.prenom}</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/UserBilletsServlet">
                            <i class="fas fa-ticket-alt"></i> Mes Billets
                        </a>
                       

                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Déconnexion
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<header class="hero-section">
    <div class="hero-content">
        <h1>Trouvez Votre Prochain Voyage En Train</h1>
        <p>Recherchez des trajets, réservez vos billets et voyagez confortablement avec la technologie moderne.</p>
        <a href="${pageContext.request.contextPath}/RechercheTrajetServlet" class="btn-modern">
            <i class="fas fa-search"></i> Rechercher un Trajet
        </a>
    </div>
</header>

<section class="features-section">
    <div class="container">
        <div class="row text-center mb-5">
            <h2 class="fw-bold mb-4">Pourquoi Choisir TrainApp ?</h2>
            <p class="lead text-muted">Une expérience de voyage révolutionnaire</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon text-info"><i class="fas fa-bolt"></i></div>
                    <h3 class="feature-title">Réservation Rapide</h3>
                    <p class="feature-desc">Réservez vos billets en quelques clics avec notre interface intuitive et moderne.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon text-success"><i class="fas fa-shield-alt"></i></div>
                    <h3 class="feature-title">Paiement Sécurisé</h3>
                    <p class="feature-desc">Vos transactions sont protégées par les dernières technologies de sécurité.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon text-warning"><i class="fas fa-clock"></i></div>
                    <h3 class="feature-title">Temps Réel</h3>
                    <p class="feature-desc">Suivez vos trains en temps réel et recevez des notifications instantanées.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="stats-section">
    <div class="container">
        <div class="row">
            <div class="col-md-3 col-6 mb-4">
                <span class="stat-number text-info">50K+</span>
                <div class="stat-label">Voyageurs Satisfaits</div>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <span class="stat-number text-purple">200+</span>
                <div class="stat-label">Destinations</div>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <span class="stat-number text-success">24/7</span>
                <div class="stat-label">Support Client</div>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <span class="stat-number text-warning">99%</span>
                <div class="stat-label">Fiabilité</div>
            </div>
        </div>
    </div>
</section>

<footer>
    <div class="container">
        <p class="mb-0">&copy; 2025 TrainApp. Tous droits réservés. | Fait avec <i class="fas fa-heart text-danger"></i></p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function createParticles() {
        const container = document.querySelector('.bg-particles');
        for (let i = 0; i < 50; i++) {
            const particle = document.createElement('div');
            particle.className = 'particle';
            particle.style.left = Math.random() * 100 + '%';
            particle.style.top = Math.random() * 100 + '%';
            particle.style.animationDuration = 4 + Math.random() * 6 + 's';
            container.appendChild(particle);
        }
    }

    document.addEventListener("DOMContentLoaded", createParticles);
</script>
</body>
</html>
