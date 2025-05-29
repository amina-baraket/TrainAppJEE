<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Mes Billets</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <%-- Font Awesome for icons --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .sidebar {
            /* basic styling for the sidebar if needed, can be enhanced later */
            padding: 15px;
            background-color: #f8f9fa;
            border-right: 1px solid #dee2e6;
        }
         @media (max-width: 768px) {
            .sidebar {
                border-right: none;
                border-bottom: 1px solid #dee2e6;
            }
        }
    </style>
</head>
<body>

<div class="container-fluid mt-4">
    <div class="row">
        <%-- Sidebar Column --%>
        <c:if test="${sessionScope.user != null}">
            <div class="col-md-3 col-lg-2 sidebar">
                <h5 class="mb-3">Welcome, ${sessionScope.user.prenom}</h5>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/user/billets">
                            <i class="fas fa-ticket-alt me-2"></i>Mes Billets
                        </a>
                    </li>
                    <%-- Add other user links here later --%>
                </ul>
            </div>
        </c:if>

        <%-- Main Content Column --%>
        <div class="col-md-${sessionScope.user != null ? '9' : '12'} col-lg-${sessionScope.user != null ? '10' : '12'}">
            <h1 class="mb-4">Mes Billets</h1>

            <%-- Display success message if cancellation was requested --%>
            <c:if test="${param.message == 'cancellation_requested'}">
                <div class="alert alert-success" role="alert">
                    Votre demande d'annulation a bien été enregistrée et est en attente de confirmation par l'administrateur.
                </div>
            </c:if>

            <%-- Display success message if modification was successful --%>
            <c:if test="${param.message == 'modification_success'}">
                <div class="alert alert-success" role="alert">
                    Votre réservation a été modifiée avec succès.
                </div>
            </c:if>

            <%-- Display error message if any --%>
            <c:if test="${param.error != null}">
                <div class="alert alert-danger" role="alert">
                    Erreur : ${param.error}
                </div>
            </c:if>

            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Trajet</th>
                        <th>Date</th>
                        <th>Classe</th>
                        <th>Prix</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${billets}" var="b">
                        <tr>
                            <td>${b.trajet.depart} - ${b.trajet.destination}</td>
                            <td>${b.trajet.date_depart}</td>
                            <td>${b.classe.nom}</td>
                            <td>${b.prixFinal} €</td>
                            <td>
                                <span class="badge 
                                    <c:choose>
                                        <c:when test="${b.statut == 'ACHETE'}">bg-success</c:when>
                                        <c:when test="${b.statut == 'EN_ATTENTE_ANNULATION'}">bg-warning</c:when>
                                        <c:when test="${b.statut == 'ANNULE'}">bg-danger</c:when>
                                        <c:when test="${b.statut == 'UTILISE'}">bg-secondary</c:when>
                                        <c:otherwise>bg-secondary</c:otherwise>
                                    </c:choose>
                                ">${b.statut}</span>
                            </td>
                            <td>
                                <%-- Actions for each ticket - displayed side-by-side --%>
                                <div class="d-flex gap-1">
                                    <c:choose>
                                        <c:when test="${b.statut == 'ACHETE'}">
                                            <%-- Show Modify and Cancel buttons for ACHETE tickets --%>
                                            <%-- Modifier Button (will open modal) --%>
                                            <button type="button" class="btn btn-primary btn-sm py-0 px-2" data-bs-toggle="modal" data-bs-target="#modifierBilletModal" 
                                                data-billet-id="${b.id}" 
                                                data-current-classe="${b.classe.nom}" 
                                                data-current-preferences="<c:forEach items='${b.preferences}' var='pref'>${pref.id},</c:forEach>"
                                                title="Modifier">
                                                <i class="fas fa-edit"></i> Modifier
                                            </button>

                                            <%-- Annuler Form and Button --%>
                                            <form action="user/demanderAnnulation" method="post" class="d-inline-block m-0">
                                                <input type="hidden" name="billetId" value="${b.id}">
                                                <button type="submit" class="btn btn-danger btn-sm py-0 px-2" title="Annuler">
                                                    <i class="fas fa-times"></i> Annuler
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:when test="${b.statut == 'EN_ATTENTE_ANNULATION'}">
                                            <%-- Show a message for pending cancellation --%>
                                            <span class="badge bg-warning">Annulation en attente</span>
                                        </c:when>
                                        <c:when test="${b.statut == 'ANNULE'}">
                                            <%-- Show a badge for cancelled tickets --%>
                                            <span class="badge bg-danger">Annulé</span>
                                        </c:when>
                                        <c:when test="${b.statut == 'UTILISE'}">
                                            <%-- Show a badge for used tickets --%>
                                            <span class="badge bg-secondary">Utilisé</span>
                                        </c:when>
                                        <c:otherwise>
                                            <%-- Default case for other statuses --%>
                                            ${b.statut}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%-- Modifier Billet Modal Structure (initially hidden) --%>
<div class="modal fade" id="modifierBilletModal" tabindex="-1" aria-labelledby="modifierBilletModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modifierBilletModalLabel">Modifier la Réservation</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="user/modifierBillet" method="post" id="modalModifierForm">
          <div class="modal-body">
              <input type="hidden" name="billetId" id="modalBilletId">
              
              <%-- Classe Selection in Modal --%>
              <div class="mb-3">
                  <label for="modalClasse" class="form-label">Classe:</label>
                  <select name="classe" id="modalClasse" class="form-select">
                      <%-- Options will be populated by JavaScript or can be pre-populated here --%>
                       <c:forEach items="${classes}" var="classe">
                          <option value="${classe.nom}">${classe.nom}</option>
                      </c:forEach>
                  </select>
              </div>

              <%-- Preferences Checkboxes in Modal --%>
              <div class="mb-3">
                  <label class="form-label">Préférences :</label>
                  <div>
                      <%-- Checkboxes will be populated by JavaScript or can be pre-populated here --%>
                       <c:forEach items="${preferences}" var="preference">
                          <div class="form-check form-check-inline">
                              <input class="form-check-input" type="checkbox" name="preferences" value="${preference.id}" id="modalPref_${preference.id}">
                              <label class="form-check-label" for="modalPref_${preference.id}">${preference.nom}</label>
                          </div>
                      </c:forEach>
                  </div>
              </div>

          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
            <button type="submit" class="btn btn-primary">Enregistrer les Modifications</button>
          </div>
      </form>
    </div>
  </div>
</div>

<%-- Include Bootstrap JS for modal functionality --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // JavaScript to handle modal data population
    var modifierBilletModal = document.getElementById('modifierBilletModal');
    modifierBilletModal.addEventListener('show.bs.modal', function (event) {
        // Button that triggered the modal
        var button = event.relatedTarget;

        // Extract info from data-bs-* attributes
        var billetId = button.getAttribute('data-billet-id');
        var currentClasse = button.getAttribute('data-current-classe');
        var currentPreferences = button.getAttribute('data-current-preferences'); // This will be a comma-separated string of IDs

        // Update the modal's content.
        var modalBilletIdInput = modifierBilletModal.querySelector('#modalBilletId');
        var modalClasseSelect = modifierBilletModal.querySelector('#modalClasse');
        var modalPreferencesDiv = modifierBilletModal.querySelector('.modal-body div:nth-child(2) div'); // Adjust selector if needed

        modalBilletIdInput.value = billetId;

        // Set the current class in the dropdown
        for (var i = 0; i < modalClasseSelect.options.length; i++) {
            if (modalClasseSelect.options[i].value === currentClasse) {
                modalClasseSelect.selectedIndex = i;
                break;
            }
        }

        // Set the current preferences in the checkboxes
        var currentPrefIds = currentPreferences ? currentPreferences.split(',').map(id => parseInt(id.trim())).filter(id => !isNaN(id)) : [];
        var checkboxes = modalPreferencesDiv.querySelectorAll('input[type="checkbox"]');
        checkboxes.forEach(function(checkbox) {
            var prefId = parseInt(checkbox.value);
            if (currentPrefIds.includes(prefId)) {
                checkbox.checked = true;
            } else {
                checkbox.checked = false;
            }
        });
    });
</script>

</body>
</html>
