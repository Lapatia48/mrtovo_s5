<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Postuler à une annonce</title>
</head>
<body>
    <h2>Formulaire de candidature</h2>

    <form action="${pageContext.request.contextPath}/postuleCandidat" method="post">

        <!-- Nom -->
        <div>
            <label for="nom">Nom :</label>
            <input type="text" id="nom" name="nom" value="Ravelojaona" required>
        </div>

        <!-- Prénom -->
        <div>
            <label for="prenom">Prénom :</label>
            <input type="text" id="prenom" name="prenom" value="lapatia" required>
        </div>

        <!-- Mail -->
        <div>
            <label for="mail">Email :</label>
            <input type="email" id="mail" name="mail" value="a@gmail.com" required>
        </div>

        <!-- Adresse --> 
        <div>
            <label for="adresse">Adresse :</label>
            <input type="text" id="adresse" name="adresse" value="Majunga" required>
        </div>

        <!-- Date de naissance -->
        <div>
            <label for="dateNaissance">Date de naissance :</label>
            <input type="date" id="dateNaissance" name="dateNaissance" value="15/10/2004" required>
        </div>

        <!-- Renseignement -->
        <div>
            <label for="renseignement">Renseignement :</label><br>
            <textarea id="renseignement" name="renseignement" rows="4" cols="50" value="Tres experimente"></textarea>
        </div>

        <!-- Diplôme (liste déroulante) -->
        <div>
            <label for="idDiplome">Diplôme :</label>
            <select id="idDiplome" name="idDiplome" required>
                <c:forEach var="d" items="${diplome}">
                    <option value="${d.id}">${d.nomDiplome}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Années d'expérience -->
        <div>
            <label for="anneeExperience">Années d'expérience :</label>
            <input type="number" id="anneeExperience" name="anneeExperience" min="0" value="3" required>
        </div>

        <!-- Champs cachés -->
        <input type="hidden" name="idAnnoncePostule" value="${annonce.id}">
        <input type="hidden" name="idDepartement" value="${annonce.idDepartement}">
        <input type="hidden" name="datePostule" value="<%= java.time.LocalDate.now() %>">

        <!-- Bouton -->
        <div>
            <button type="submit">Postuler</button>
        </div>
    </form>
    <a href="${pageContext.request.contextPath}/formLogCandidat2">Annuler</a> 
    

</body>
</html>
