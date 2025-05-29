<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sélection du Voyage</title>
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

        .selection-card {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border-radius: 25px;
            padding: 2.5rem;
            box-shadow: var(--card-shadow);
            border: 1px solid var(--glass-border);
            transition: all 0.3s ease;
            color: #444;
            max-width: 600px;
            margin: 0 auto;
        }

        .selection-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .form-label {
            font-weight: 600;
            color: #444;
            margin-bottom: 0.7rem;
            font-size: 0.95rem;
        }

        .form-select {
            border: 2px solid #d0d7de;
            border-radius: 15px;
            padding: 0.8rem 1rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: white;
            color: #333;
        }

        .form-select:focus {
            border-color: var(--night-blue);
            box-shadow: 0 0 0 0.2rem rgba(0, 77, 102, 0.3);
            transform: translateY(-2px);
            outline: none;
        }

        .form-check {
            margin-bottom: 1rem;
            padding: 0.8rem;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.5);
            transition: all 0.3s ease;
        }

        .form-check:hover {
            background: rgba(255, 255, 255, 0.8);
            transform: translateX(5px);
        }

        .form-check-input {
            width: 1.2em;
            height: 1.2em;
            margin-top: 0.2em;
        }

        .form-check-input:checked {
            background-color: var(--night-blue);
            border-color: var(--night-blue);
        }

        .form-check-label {
            font-weight: 500;
            color: #444;
            margin-left: 0.5rem;
        }

        .btn-continue {
            background: var(--accent-gradient);
            border: none;
            border-radius: 15px;
            padding: 1rem 2rem;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 77, 102, 0.4);
            width: 100%;
            margin-top: 1rem;
        }

        .btn-continue:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 77, 102, 0.6);
            color: white;
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
            color: var(--night-blue);
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

        .preferences-title {
            font-weight: 600;
            color: var(--night-blue);
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }

        .invalid-feedback {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body>
    <div class="floating-elements"></div>
    
    <div class="container py-5">
        <!-- En-tête avec titre -->
        <div class="hero-section text-center">
            <div class="icon-wrapper mx-auto mb-3">
                <i class="fas fa-ticket-alt fa-lg"></i>
            </div>
            <h1 class="page-title">Choisissez vos options</h1>
            <p class="page-subtitle">Personnalisez votre voyage selon vos préférences</p>
        </div>

        <!-- Formulaire de sélection -->
        <div class="selection-card">
            <form action="SelectionVoyageServlet" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="trajetId" value="<%= request.getParameter("trajetId") %>">

                <div class="mb-4">
                    <label for="classe" class="form-label">
                        <i class="fas fa-chair me-2"></i>Classe
                    </label>
                    <select id="classe" name="classe" class="form-select" required>
                        <option value="">-- Sélectionnez une classe --</option>
                        <option value="1ère">1ère classe</option>
                        <option value="2ème">2ème classe</option>
                        <option value="économique">Économique</option>
                    </select>
                    <div class="invalid-feedback">
                        Veuillez sélectionner une classe.
                    </div>
                </div>

                <div class="mb-4">
                    <div class="preferences-title">
                        <i class="fas fa-star me-2"></i>Préférences
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="preferences" value="fenetre" id="fenetre">
                        <label class="form-check-label" for="fenetre">
                            <i class="fas fa-window-maximize me-2"></i>Côté fenêtre
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="preferences" value="famille" id="famille">
                        <label class="form-check-label" for="famille">
                            <i class="fas fa-users me-2"></i>Espace famille
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="preferences" value="non-fumeur" id="non-fumeur">
                        <label class="form-check-label" for="non-fumeur">
                            <i class="fas fa-smoking-ban me-2"></i>Wagon non-fumeur
                        </label>
                    </div>
                </div>

                <button type="submit" class="btn btn-continue">
                    <i class="fas fa-arrow-right me-2"></i>Continuer
                </button>
            </form>
        </div>
    </div>

    <script>
    // Bootstrap form validation
    (() => {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
