<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord Administrateur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #dff6ff 0%, #e8f9fd 50%, #cceeff 100%);
            --secondary-gradient: linear-gradient(135deg, #00c9ff 0%, #0099cc 100%);
            --success-gradient: linear-gradient(135deg, #00c9ff 0%, #66d9ff 100%);
            --warning-gradient: linear-gradient(135deg, #00c9ff 0%, #33d4ff 100%);
            --info-gradient: linear-gradient(135deg, #cceeff 0%, #99e5ff 100%);
            --accent-color: #00c9ff;
            --text-primary: #004d66;
            --card-bg: rgba(255, 255, 255, 0.9);
            --shadow-light: 0 10px 30px rgba(0, 77, 102, 0.1);
            --shadow-heavy: 0 20px 60px rgba(0, 77, 102, 0.15);
        }

        body {
            background: linear-gradient(135deg, #dff6ff 0%, #e8f9fd 50%, #cceeff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px 0;
        }

        .main-container {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            box-shadow: var(--shadow-heavy);
            border: 1px solid rgba(255,255,255,0.2);
            padding: 40px;
            margin: 20px auto;
            max-width: 1400px;
        }

        .page-title {
            background: linear-gradient(135deg, #00c9ff 0%, #004d66 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 50px;
            position: relative;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(135deg, #00c9ff 0%, #004d66 100%);
            border-radius: 2px;
        }

        .management-card {
            background: var(--card-bg);
            border-radius: 20px;
            box-shadow: var(--shadow-light);
            border: none;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            overflow: hidden;
            position: relative;
            height: 100%;
        }

        .management-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--accent-color);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .management-card:hover::before {
            transform: scaleX(1);
        }

        .management-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-heavy);
        }

        .management-card .card-body {
            padding: 30px;
        }

        .management-card .card-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .management-card .card-title i {
            font-size: 1.5rem;
            color: var(--accent-color);
        }

        .management-card .card-text {
            color: #006b80;
            margin-bottom: 25px;
            line-height: 1.6;
        }

        .modern-btn {
            background: linear-gradient(135deg, #00c9ff 0%, #0099cc 100%);
            border: none;
            border-radius: 12px;
            padding: 12px 30px;
            color: white;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(0, 201, 255, 0.3);
            position: relative;
            overflow: hidden;
        }

        .modern-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .modern-btn:hover::before {
            left: 100%;
        }

        .modern-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(0, 201, 255, 0.4);
            color: white;
        }

        .stats-section {
            margin-top: 60px;
        }

        .stats-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 30px;
            position: relative;
            display: inline-block;
        }

        .stats-title::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 50px;
            height: 3px;
            background: var(--accent-color);
            border-radius: 2px;
        }

        .stat-card {
            border-radius: 20px;
            border: none;
            box-shadow: var(--shadow-light);
            transition: all 0.3s ease;
            overflow: hidden;
            position: relative;
            height: 140px;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            opacity: 0.1;
            background-size: 100px 100px;
            background-repeat: no-repeat;
            background-position: right 20px top 20px;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-heavy);
        }

        .stat-card.bg-primary {
            background: linear-gradient(135deg, #00c9ff 0%, #66d9ff 100%) !important;
        }

        .stat-card.bg-success {
            background: linear-gradient(135deg, #004d66 0%, #006b80 100%) !important;
        }

        .stat-card.bg-warning {
            background: linear-gradient(135deg, #cceeff 0%, #99e5ff 100%) !important;
            color: #004d66 !important;
        }

        .stat-card.bg-info {
            background: linear-gradient(135deg, #e8f9fd 0%, #dff6ff 100%) !important;
            color: #004d66 !important;
        }

        .stat-card .card-body {
            padding: 25px;
            position: relative;
            z-index: 2;
        }

        .stat-card .card-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 10px;
            opacity: 0.9;
        }

        .stat-card .display-6 {
            font-size: 2.5rem;
            font-weight: 700;
            margin: 0;
        }

        .logout-section {
            margin-top: 50px;
            text-align: center;
        }

        .logout-btn {
            background: linear-gradient(135deg, #004d66 0%, #006b80 100%);
            border: none;
            border-radius: 12px;
            padding: 15px 40px;
            color: white;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(0, 77, 102, 0.3);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(0, 77, 102, 0.4);
            color: white;
        }

        .section-divider {
            height: 2px;
            background: linear-gradient(90deg, transparent, var(--accent-color), transparent);
            margin: 40px 0;
            border: none;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .management-card {
            animation: fadeInUp 0.6s ease forwards;
        }

        .management-card:nth-child(1) { animation-delay: 0.1s; }
        .management-card:nth-child(2) { animation-delay: 0.2s; }
        .management-card:nth-child(3) { animation-delay: 0.3s; }
        .management-card:nth-child(4) { animation-delay: 0.4s; }
        .management-card:nth-child(5) { animation-delay: 0.5s; }
        .management-card:nth-child(6) { animation-delay: 0.6s; }

        .stat-card {
            animation: fadeInUp 0.6s ease forwards;
        }

        .stat-card:nth-child(1) { animation-delay: 0.7s; }
        .stat-card:nth-child(2) { animation-delay: 0.8s; }
        .stat-card:nth-child(3) { animation-delay: 0.9s; }
        .stat-card:nth-child(4) { animation-delay: 1s; }

        @media (max-width: 768px) {
            .main-container {
                margin: 10px;
                padding: 20px;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .management-card .card-body {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <h1 class="page-title">Tableau de Bord Administrateur</h1>
        
        <div class="row g-4">
            <!-- Gestion des Gares -->
            <div class="col-lg-4 col-md-6">
                <div class="card management-card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-building"></i> Gestion des Gares
                        </h5>
                        <p class="card-text">Gerer les gares de depart et d'arrivee avec une interface intuitive</p>
                        <a href="${pageContext.request.contextPath}/admin/gares" class="modern-btn">
                            Acceder
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Gestion des Voyages -->
            <div class="col-lg-4 col-md-6">
                <div class="card management-card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-train-front"></i> Gestion des Voyages
                        </h5>
                        <p class="card-text">Gerer les voyages et les trajets en temps reel</p>
                        <a href="${pageContext.request.contextPath}/admin/voyages" class="modern-btn">
                            Acceder
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Gestion des Voyages Consécutifs -->
            <div class="col-lg-4 col-md-6">
                <div class="card management-card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-arrow-left-right"></i> Voyages Consecutifs
                        </h5>
                        <p class="card-text">Gerer les voyages consecutifs et les correspondances</p>
                        <a href="${pageContext.request.contextPath}/admin/voyages-consecutifs" class="modern-btn">
                            Acceder
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Gestion des Utilisateurs -->
            <div class="col-lg-4 col-md-6">
                <div class="card management-card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-people"></i> Gestion des Utilisateurs
                        </h5>
                        <p class="card-text">Gerer les utilisateurs et leurs comptes en toute securite</p>
                        <a href="${pageContext.request.contextPath}/admin/utilisateurs" class="modern-btn">
                            Acceder
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Demandes d'Annulation -->
            <div class="col-lg-4 col-md-6">
                <div class="card management-card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-x-circle"></i> Demandes d'Annulation
                        </h5>
                        <p class="card-text">Gerer les demandes d'annulation de billets efficacement</p>
                        <a href="${pageContext.request.contextPath}/admin/demandes-annulation" class="modern-btn">
                            Acceder
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Gestion des Paiements -->
            <div class="col-lg-4 col-md-6">
                <div class="card management-card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-credit-card"></i> Gestion des Paiements
                        </h5>
                        <p class="card-text">Gerer les paiements </p>
                        <a href="${pageContext.request.contextPath}/admin/paiements" class="modern-btn">
                            Acceder
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <hr class="section-divider">
        
        <!-- Statistiques -->
        <div class="stats-section">
            <h3 class="stats-title">Statistiques</h3>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="card stat-card bg-primary text-white">
                        <div class="card-body">
                            <h5 class="card-title">
                                <i class="bi bi-train-front me-2"></i>Voyages
                            </h5>
                            <p class="card-text display-6">${nombreVoyages}</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="card stat-card bg-success text-white">
                        <div class="card-body">
                            <h5 class="card-title">
                                <i class="bi bi-ticket-perforated me-2"></i>Billets Vendus
                            </h5>
                            <p class="card-text display-6">${nombreBillets}</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="card stat-card bg-warning text-dark">
                        <div class="card-body">
                            <h5 class="card-title">
                                <i class="bi bi-clock-history me-2"></i>Demandes en Attente
                            </h5>
                            <p class="card-text display-6">${demandesEnAttente}</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="card stat-card bg-info text-dark">
                        <div class="card-body">
                            <h5 class="card-title">
                                <i class="bi bi-people me-2"></i>Utilisateurs
                            </h5>
                            <p class="card-text display-6">${nombreUtilisateurs}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="logout-section">
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                <i class="bi bi-box-arrow-right"></i> Deconnexion
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>