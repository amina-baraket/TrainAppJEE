<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recherche de Trajet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #dff6ff, #e8f9fd, #cceeff);
            --secondary-gradient: linear-gradient(135deg, #ff9a9e, #fad0c4);
            --accent-gradient: linear-gradient(135deg, #004d66, #006080);
            --success-gradient: linear-gradient(135deg, #004d66, #006080);
            --warning-gradient: linear-gradient(135deg, #ffe29f, #ffa99f);
            --purple-gradient: linear-gradient(135deg, #004d66, #006080);
            --glass-bg: rgba(255, 255, 255, 0.6);
            --glass-border: rgba(0, 0, 0, 0.1);
            --card-shadow: 0 10px 30px rgba(0,0,0,0.05);
            --hover-shadow: 0 20px 40px rgba(0,0,0,0.08);
            --night-blue: #004d66;
        }

        body {
            background: var(--primary-gradient);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
        }

        .hero-section {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            border: 1px solid var(--glass-border);
            color: #222;
        }

        .page-title {
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            background: var(--purple-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            color: var(--night-blue);
        }

        .page-subtitle {
            font-size: 1.1rem;
            margin-bottom: 0;
            color: #555;
        }

        .search-card {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border-radius: 25px;
            padding: 2.5rem;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--glass-border);
            transition: all 0.3s ease;
            color: #444;
        }

        .search-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .form-label {
            font-weight: 600;
            color: #444;
            margin-bottom: 0.7rem;
            font-size: 0.95rem;
        }

        .form-select, .form-control {
            border: 2px solid #d0d7de;
            border-radius: 15px;
            padding: 0.8rem 1rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: white;
            color: #333;
        }

        .form-select:focus, .form-control:focus {
            border-color: #00c9ff;
            box-shadow: 0 0 0 0.2rem rgba(0, 201, 255, 0.3);
            transform: translateY(-2px);
            outline: none;
        }

        .btn-search {
            background: var(--accent-gradient);
            border: none;
            border-radius: 15px;
            padding: 0.8rem 2rem;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 77, 102, 0.4);
        }

        .btn-search:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 77, 102, 0.6);
            color: white;
        }

        .results-section {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border-radius: 25px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--glass-border);
            margin-top: 2rem;
            color: #444;
        }

        .results-title {
            font-weight: 700;
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #222;
        }

        .table {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border: none;
            color: #222;
        }

        .table thead th {
            background: var(--accent-gradient);
            color: white;
            font-weight: 600;
            border: none;
            padding: 1rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-color: #f0f4f8;
            font-size: 0.95rem;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background: var(--warning-gradient);
            transform: translateX(5px);
        }

        .btn-select {
            background: var(--success-gradient);
            border: none;
            border-radius: 20px;
            padding: 0.5rem 1.2rem;
            font-weight: 600;
            color: white;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(0, 77, 102, 0.3);
        }

        .btn-select:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 77, 102, 0.6);
            color: white;
        }

        .alert {
            border: none;
            border-radius: 15px;
            padding: 1.2rem;
            font-weight: 500;
            backdrop-filter: blur(10px);
            color: #333;
        }

        .alert-danger {
            background: rgba(255, 154, 158, 0.15);
            color: #a12a2a;
            border-left: 4px solid #ff6b6b;
        }

        .alert-info {
            background: rgba(204, 238, 255, 0.25);
            color: #055160;
            border-left: 4px solid #00c9ff;
        }

        .alert-warning {
            background: rgba(255, 226, 159, 0.25);
            color: #664d03;
            border-left: 4px solid #ffa99f;
        }

        .price-badge {
            background: var(--secondary-gradient);
            color: #5a2e2e;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .available-seats {
            background: var(--success-gradient);
            color: #224422;
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .icon-wrapper {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: rgba(255,255,255,0.7);
            border-radius: 50%;
            margin-right: 0.5rem;
            color: #00c9ff;
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 2rem;
            }
            
            .search-card {
                padding: 1.5rem;
                margin: 0 1rem;
            }
            
            .table-responsive {
                border-radius: 15px;
            }
        }

        .floating-elements {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .floating-elements::before,
        .floating-elements::after {
            content: '';
            position: absolute;
            width: 200px;
            height: 200px;
            background: rgba(255,255,255,0.15);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .floating-elements::before {
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-elements::after {
            bottom: 20%;
            right: 10%;
            animation-delay: 3s;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-20px);
            }
        }
    </style>
</head>
<body>
    <div class="floating-elements"></div>
    
    <div class="container py-5">
        <!-- En-tête avec titre -->
        <div class="hero-section text-center">
            <div class="icon-wrapper mx-auto mb-3">
                <i class="fas fa-train fa-lg"></i>
            </div>
            <h1 class="page-title">Recherche de Trajet</h1>
            <p class="page-subtitle">Trouvez votre voyage idéal en quelques clics</p>
        </div>

        <!-- Messages d'erreur ou de succès -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                ${error}
            </div>
        </c:if>

        <!-- Formulaire de recherche -->
        <div class="search-card">
            <form method="post" action="RechercheTrajetServlet">
                <div class="row g-4">
                    <div class="col-lg-3 col-md-6">
                        <label for="depart" class="form-label">
                            <i class="fas fa-map-marker-alt me-2 text-primary"></i>Départ
                        </label>
                        <select id="depart" name="departId" class="form-select" required>
                            <option value="">-- Sélectionnez une gare --</option>
                            <c:forEach items="${gares}" var="gare">
                                <option value="${gare.id}" ${gare.id == depart_recherche_id ? 'selected' : ''}>${gare.nom} (${gare.ville})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <label for="destination" class="form-label">
                            <i class="fas fa-flag-checkered me-2 text-success"></i>Destination
                        </label>
                        <select id="destination" name="destinationId" class="form-select" required>
                            <option value="">-- Sélectionnez une gare --</option>
                            <c:forEach items="${gares}" var="gare">
                                <option value="${gare.id}" ${gare.id == destination_recherche_id ? 'selected' : ''}>${gare.nom} (${gare.ville})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <label for="date_depart" class="form-label">
                            <i class="fas fa-calendar-alt me-2 text-warning"></i>Date de départ
                        </label>
                        <input type="date" id="date_depart" name="date_depart" class="form-control" required
                            value="${date_recherche}">
                    </div>

                    <div class="col-lg-3 col-md-6 d-flex align-items-end">
                        <button type="submit" class="btn btn-search w-100">
                            <i class="fas fa-search me-2"></i>Rechercher
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Résultats -->
        <c:if test="${not empty requestScope.trajets}">
            <div class="results-section">
                <h2 class="results-title">
                    <i class="fas fa-route me-2"></i>Trajets Disponibles
                </h2>
                <div class="table-responsive">
                    <table class="table table-hover align-middle text-center">
                        <thead>
                            <tr>
                                <th>Départ</th>
                                <th>Destination</th>
                                <th>Date départ</th>
                                <th>Heure départ</th>
                                <th>Heure arrivée</th>
                                <th>Prix</th>
                                <th>Places dispo</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.trajets}" var="trajet">
                                <tr>
                                    <td>${trajet.depart}</td>
                                    <td>${trajet.destination}</td>
                                    <td><fmt:formatDate value="${trajet.date_depart}" pattern="dd/MM/yyyy"/></td>
                                    <td><fmt:formatDate value="${trajet.heure_depart}" pattern="HH:mm"/></td>
                                    <td><fmt:formatDate value="${trajet.heure_arrivee}" pattern="HH:mm"/></td>
                                    <td><span class="price-badge"><fmt:formatNumber value="${trajet.prix}" pattern="#,##0.00"/> €</span></td>
                                    <td><span class="available-seats">${trajet.places_disponibles}</span></td>
                                    <td>
                                        <form action="SelectionVoyageServlet" method="post">
                                            <input type="hidden" name="trajetId" value="${trajet.id}">
                                            <button type="submit" class="btn btn-select">Sélectionner</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>

        <c:if test="${empty trajets and not empty date_recherche}">
            <div class="alert alert-warning text-center" role="alert">
                <i class="fas fa-info-circle me-2"></i>
                Aucun trajet trouvé pour cette recherche.
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>