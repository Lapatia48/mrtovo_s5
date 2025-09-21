<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des candidats</title>
</head>
<body>
<h2>Liste des candidats</h2>

<!-- Formulaire de filtre par diplôme -->
<form method="get" action="${pageContext.request.contextPath}/rh/candidats/filtrer">

    <label for="nom">Nom :</label>
    <input type="text" id="nom" name="nom" />

    <label for="diplome">Diplôme :</label>
    <select name="diplome" id="diplome">
        <option value="">-- Sélectionner --</option>
        <!-- Boucle sur les diplômes récupérés depuis la base -->
        <c:forEach var="d" items="${diplomes}">
            <option value="${d.nomDiplome}">${d.nomDiplome}</option>
        </c:forEach>
    </select>

    <label for="departement">Poste :</label>
    <select name="departement" id="departement">
        <option value="">-- Sélectionner --</option>
        <!-- Boucle sur les départements récupérés depuis la base -->
        <c:forEach var="dept" items="${departements}">
            <option value="${dept.libelleDepartement}">${dept.libelleDepartement}</option>
        </c:forEach>
    </select>

    <label for="age">Age</label>
    <select name="age" id="age">
        <option value="">-- Sélectionner --</option>
        <option value="asc">Croissant</option>
        <option value="desc">Decroissant</option>
    </select>

    <label for="anneeExperience">Annee d'experience</label>
    <select name="anneeExperience" id="anneeExperience">
        <option value="">-- Sélectionner --</option>
        <option value="asc">Croissant</option>
        <option value="desc">Decroissant</option>
    </select>

    <label for="datePostule">Date de postulation</label>
    <select name="datePostule" id="datePostule">
        <option value="">-- Sélectionner --</option>
        <option value="asc">Croissant</option>
        <option value="desc">Decroissant</option>
    </select>

    <button type="submit">Filtrer</button>
</form>

<!-- Tableau des candidats -->
<table border="1" cellpadding="5">
    <tr>
        <th>Nom</th>
        <th>Prénom</th>
        <th>Email</th>
        <th>Adresse</th>
        <th>Date de naissance</th>
        <th>Age</th>
        <th>Poste</th>
        <th>Année d'expérience</th>
        <th>Diplôme</th>
        <th>Date de postulation</th>
    </tr>
    <c:forEach var="c" items="${candidats}">
        <tr>
            <td>${c.nom}</td>
            <td>${c.prenom}</td>
            <td>${c.mail}</td>
            <td>${c.adresse}</td>
            <td>${c.dateNaissance}</td>
            <td>${c.age}ans</td>
            <td>${c.departement}</td>
            <td>${c.anneeExperience}</td>
            <td>${c.diplome}</td>
            <td>${c.datePostule}</td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
