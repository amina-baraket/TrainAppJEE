<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sélection du Voyage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-4" style="max-width: 500px;">
    <h2 class="mb-4 text-center">Choisissez vos options</h2>

    <form action="SelectionVoyageServlet" method="post" class="needs-validation" novalidate>
        <input type="hidden" name="trajetId" value="<%= request.getParameter("trajetId") %>">

        <div class="mb-3">
            <label for="classe" class="form-label">Classe :</label>
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

        <fieldset class="mb-4">
            <legend class="col-form-label">Préférences :</legend>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" name="preferences" value="fenetre" id="fenetre">
                <label class="form-check-label" for="fenetre">Côté fenêtre</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" name="preferences" value="famille" id="famille">
                <label class="form-check-label" for="famille">Espace famille</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" name="preferences" value="non-fumeur" id="non-fumeur">
                <label class="form-check-label" for="non-fumeur">Wagon non-fumeur</label>
            </div>
        </fieldset>

        <button type="submit" class="btn btn-primary w-100">Continuer</button>
    </form>
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
