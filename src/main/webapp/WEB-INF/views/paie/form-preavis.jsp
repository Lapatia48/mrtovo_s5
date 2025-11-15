<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Demande de Préavis</title>
    <style>
        .container { max-width: 600px; margin: 20px auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        select, input { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .btn { padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .btn:hover { background: #0056b3; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Demande de Préavis</h2>
        
        <div class="info-employe">
            <h3>Employé : ${employe.prenom} ${employe.nom}</h3>
            <p>Poste : ${employe.poste}</p>
            <p>Salaire de base : ${employe.salaire} Ar</p>
        </div>

        <form action="${pageContext.request.contextPath}/rh/paie/calculerPreavis" method="post">
            <input type="hidden" name="id_emp" value="${employe.id}">
            
            <div class="form-group">
                <label for="motif">Motif du préavis :</label>
                <select id="motif" name="motif" required>
                    <option value="renvoi">Renvoi</option>
                    <option value="demission">Démission</option>
                </select>
            </div>

            <div class="form-group">
                <label for="duree_preavis">Durée du préavis :</label>
                <select id="duree_preavis" name="duree_preavis" required>
                    <option value="3">3 mois</option>
                </select>
            </div>

            <div class="form-group">
                <label for="quota_conge">Quota de congé restant (jours) :</label>
                <input type="number" id="quota_conge" name="quota_conge" value="${quotaConge}" required min="0">
                <a href="${pageContext.request.contextPath}/rh/paie/preavis" class="btn btn-secondary">Retour</a>
            <button type="submit" class="btn">Calculer le préavis</button>
        </form>
    </div>
</body>
</html>