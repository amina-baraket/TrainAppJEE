<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sélectionner les Options de Voyage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #dff6ff 0%, #e8f9fd 50%, #cceeff 100%);
            min-height: 100vh;
            padding: 30px;
            color: #004d66;
        }
        
        .container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 77, 102, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(0, 201, 255, 0.2);
        }
        
        h2 {
            color: #004d66;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0, 77, 102, 0.1);
            position: relative;
        }
        
        h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, #00c9ff, #004d66);
            border-radius: 2px;
        }
        
        h3 {
            color: #004d66;
            font-weight: 600;
            margin-bottom: 20px;
            position: relative;
            padding-left: 15px;
        }
        
        h3::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 25px;
            background: linear-gradient(180deg, #00c9ff, #004d66);
            border-radius: 2px;
        }
        
        .alert {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .alert-danger {
            background: linear-gradient(135deg, #ffebee, #ffcdd2);
            color: #c62828;
            border-left: 4px solid #f44336;
        }
        
        .alert-warning {
            background: linear-gradient(135deg, #fff8e1, #ffecb3);
            color: #f57c00;
            border-left: 4px solid #ff9800;
        }
        
        .selected-voyages-table {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 77, 102, 0.1);
            border: 1px solid rgba(0, 201, 255, 0.2);
        }
        
        .selected-voyages-table th {
            background: linear-gradient(135deg, #00c9ff, #004d66);
            color: white;
            padding: 15px 12px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            border: none;
        }
        
        .selected-voyages-table td {
            padding: 15px 12px;
            border-bottom: 1px solid #e8f9fd;
            vertical-align: middle;
            transition: background-color 0.3s ease;
        }
        
        .selected-voyages-table tr:nth-child(even) {
            background-color: #dff6ff;
        }
        
        .selected-voyages-table tr:hover {
            background-color: #cceeff;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 201, 255, 0.1);
        }
        
        form {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.9), rgba(232, 249, 253, 0.9));
            padding: 25px;
            margin-bottom: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 77, 102, 0.1);
            border: 1px solid rgba(0, 201, 255, 0.2);
            backdrop-filter: blur(5px);
        }
        
        .form-label {
            font-weight: 600;
            color: #004d66;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }
        
        .form-control, .form-select {
            border: 2px solid #e8f9fd;
            border-radius: 12px;
            padding: 12px 15px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
            color: #004d66;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #00c9ff;
            box-shadow: 0 0 0 0.2rem rgba(0, 201, 255, 0.25);
            background: white;
        }
        
        .form-check-input {
            border: 2px solid #cceeff;
            border-radius: 6px;
            width: 1.2em;
            height: 1.2em;
        }
        
        .form-check-input:checked {
            background-color: #00c9ff;
            border-color: #00c9ff;
        }
        
        .form-check-label {
            color: #004d66;
            font-weight: 500;
            margin-left: 8px;
        }
        
        .btn {
            border-radius: 12px;
            padding: 12px 25px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            border: none;
            position: relative;
            overflow: hidden;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #00c9ff, #004d66);
            color: white;
            box-shadow: 0 8px 20px rgba(0, 201, 255, 0.3);
        }
        
        .btn-success:hover {
            background: linear-gradient(135deg, #004d66, #00c9ff);
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(0, 201, 255, 0.4);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #cceeff, #00c9ff);
            color: #004d66;
            box-shadow: 0 8px 20px rgba(204, 238, 255, 0.3);
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #00c9ff, #cceeff);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(0, 201, 255, 0.4);
        }
        
        hr {
            border: none;
            height: 2px;
            background: linear-gradient(90deg, transparent, #cceeff, #00c9ff, #cceeff, transparent);
            margin: 40px 0;
            border-radius: 1px;
        }
        
        .card-custom {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.95), rgba(232, 249, 253, 0.95));
            border-radius: 20px;
            border: 1px solid rgba(0, 201, 255, 0.2);
            box-shadow: 0 10px 30px rgba(0, 77, 102, 0.1);
            backdrop-filter: blur(10px);
        }
        
        .row.g-3 .col-md-4, .row.g-3 .col-md-3 {
            margin-bottom: 15px;
        }
        
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .container {
                margin: 0;
                border-radius: 15px;
            }
            
            form {
                padding: 20px;
                border-radius: 15px;
            }
            
            .selected-voyages-table {
                font-size: 0.9rem;
            }
            
            .selected-voyages-table th,
            .selected-voyages-table td {
                padding: 10px 8px;
            }
        }
        
        /* Animation pour les éléments qui apparaissent */
        .fade-in {
            animation: fadeIn 0.6s ease-in-out;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5 fade-in">
        <h2 class="mb-4 text-center">Options de Voyage</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </c:if>

        <%-- Retrieve the list of selected voyages from the session --%>
        <c:set var="selectedVoyages" value="${sessionScope.selectedVoyages}"/>

        <c:if test="${empty selectedVoyages}">
             <div class="alert alert-warning text-center" role="alert">
                Aucun voyage sélectionné. Veuillez retourner à la <a href="RechercheTrajetServlet" style="color: #00c9ff; font-weight: 600;">recherche de trajets</a>.
            </div>
        </c:if>

        <c:if test="${not empty selectedVoyages}">
            <div class="card-custom p-4 mb-4">
                <h3 class="mb-3">Votre Itinéraire :</h3>
                 <table class="table table-striped table-hover selected-voyages-table mb-4">
                    <thead>
                        <tr>
                            <th>Départ</th>
                            <th>Destination</th>
                            <th>Date</th>
                            <th>Heure Départ</th>
                             <th>Heure Arrivée</th>
                            <th>Prix</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${selectedVoyages}" var="voyage">
                            <c:set var="gareDepartTrouvee" value="${null}"/>
                            <c:set var="gareDestinationTrouvee" value="${null}"/>

                            <%-- Find the departure Gare object --%>
                            <c:forEach items="${requestScope.gares}" var="gare">
                                <c:if test="${gare.ville eq voyage.depart}">
                                    <c:set var="gareDepartTrouvee" value="${gare}"/>
                                </c:if>
                            </c:forEach>

                            <%-- Find the destination Gare object --%>
                            <c:forEach items="${requestScope.gares}" var="gare">
                                 <c:if test="${gare.ville eq voyage.destination}">
                                    <c:set var="gareDestinationTrouvee" value="${gare}"/>
                                </c:if>
                            </c:forEach>

                            <tr>
                                <td>
                                    <c:if test="${not empty gareDepartTrouvee}">
                                        ${gareDepartTrouvee.nom} (${gareDepartTrouvee.ville})
                                    </c:if>
                                    <c:if test="${empty gareDepartTrouvee}">
                                        ${voyage.depart} (Gare introuvable)
                                    </c:if>
                                </td>
                                <td>
                                     <c:if test="${not empty gareDestinationTrouvee}">
                                        ${gareDestinationTrouvee.nom} (${gareDestinationTrouvee.ville})
                                    </c:if>
                                    <c:if test="${empty gareDestinationTrouvee}">
                                        ${voyage.destination} (Gare introuvable)
                                    </c:if>
                                </td>
                                 <td><fmt:formatDate value="${voyage.date_depart}" pattern="dd/MM/yyyy"/></td>
                                <td><fmt:formatDate value="${voyage.heure_depart}" pattern="HH:mm"/></td>
                                 <td><fmt:formatDate value="${voyage.heure_arrivee}" pattern="HH:mm"/></td>
                                <td><fmt:formatNumber value="${voyage.prix}" pattern="#,##0.00"/> €</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="card-custom p-4 mb-4">
                <h3 class="mb-3">Options pour le dernier voyage :</h3>
                <%-- Find the last voyage in the list to apply options to --%>
                <c:set var="lastVoyage" value="${selectedVoyages[fn:length(selectedVoyages) - 1]}"/>
                 <%-- Find the destination Gare object for the last voyage for the consecutive search form --%>
                 <c:set var="lastVoyageDestinationGare" value="${null}"/>
                 <c:forEach items="${requestScope.gares}" var="gare">
                     <c:if test="${gare.ville eq lastVoyage.destination}">
                         <c:set var="lastVoyageDestinationGare" value="${gare}"/>
                     </c:if>
                 </c:forEach>

                <form action="ReserverVoyageServlet" method="post">
                     <%-- Pass IDs of all selected trajets --%>
                     <c:forEach items="${selectedVoyages}" var="voyage">
                          <input type="hidden" name="trajetIds" value="${voyage.id}">
                     </c:forEach>
                     
                     <%-- Selection of class and preferences for the last voyage --%>
                     <%-- Note: This assumes options apply to the last leg. Adjust logic if options apply per leg --%>
                     
                     <%-- Sélection de la classe --%>
                     <div class="mb-3">
                         <label for="classe" class="form-label">Classe :</label>
                         <select id="classe" name="classeId" class="form-select" required>
                             <option value="">-- Sélectionnez une classe --</option>
                             <c:forEach items="${requestScope.classes}" var="classe">
                                 <option value="${classe.id}">${classe.nom} - ${classe.description} (Coefficient: ${classe.coefficientPrix})</option>
                             </c:forEach>
                         </select>
                     </div>

                     <%-- Préférences (exemple avec une zone de texte) --%>
                     <div class="mb-3">
                         <label for="preferences" class="form-label">Préférences (facultatif) :</label>
    <%--                      <textarea class="form-control" id="preferences" name="preferences" rows="3" --%>
    <%--                               placeholder="Ex: Côté fenêtre, Espace famille, etc."></textarea> --%>
                        <div id="preferences">
                            <c:forEach items="${requestScope.preferences}" var="pref">
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" value="${pref.id}" id="pref${pref.id}" name="preferences">
                                    <label class="form-check-label" for="pref${pref.id}">
                                        ${pref.nom} - ${pref.description}
                                    </label>
                                </div>
                            </c:forEach>
                        </div>
                     </div>

                     <button type="submit" class="btn btn-success">Réserver l'itinéraire</button>
    </form>
            </div>

            <hr class="my-5">

            <div class="card-custom p-4">
                <h3>Ajouter un autre voyage consécutif ?</h3>
                <%-- Formulaire pour rechercher un voyage consécutif (adapté pour utiliser les IDs de gare) --%>
                <form action="RechercheVoyageConsecutifServlet" method="post" class="row g-3 align-items-end">
                     <%-- Use the destination of the last voyage as the departure for the next search --%>
                     <input type="hidden" name="departId" value="${lastVoyageDestinationGare != null ? lastVoyageDestinationGare.id : ''}"> 

                    <div class="col-md-4">
                        <label for="destination_consecutif" class="form-label">Destination :</label>
                        <%-- Here, we could potentially filter the gares to only show those accessible from lastVoyage.gareDestination --%>
                        <select id="destination_consecutif" name="destinationId" class="form-select" required>
                             <option value="">-- Sélectionnez une gare --</option>
                            <c:forEach items="${requestScope.gares}" var="gare">
                                 <%-- Afficher seulement les gares differentes de la gare de départ du prochain voyage --%>
                                 <c:if test="${lastVoyageDestinationGare != null && gare.id != lastVoyageDestinationGare.id}">
                                    <option value="${gare.id}">${gare.nom} (${gare.ville})</option>
                                 </c:if>
                                 <c:if test="${lastVoyageDestinationGare == null}">
                                      <option value="${gare.id}">${gare.nom} (${gare.ville})</option>
                                 </c:if>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label for="date_consecutif" class="form-label">Date :</label>
                        <%-- The date should probably be equal to or after the arrival date of the last voyage --%>
                        <input type="date" id="date_consecutif" name="date_depart" class="form-control" required>
                    </div>
                    
                     <div class="col-md-3">
                        <button type="submit" class="btn btn-primary">Rechercher voyage consécutif</button>
                     </div>
    </form>
            </div>

        </c:if>

    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>