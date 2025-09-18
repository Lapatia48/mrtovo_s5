<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier l'annonce</title>
</head>
<body>
    <a href="${pageContext.request.contextPath}/listAnnonceManager">Liste des annonces</a>
    <h2>Modifier l'annonce</h2>

    <!-- Formulaire pour mettre à jour une annonce -->
    <form action="${pageContext.request.contextPath}/updateAnnonce" method="post">
        <!-- On passe l'id caché pour identifier l'annonce -->
        <input type="hidden" name="id" value="${annonce.id}">

        <div>
            <label for="titre">Titre :</label>
            <input type="text" id="titre" name="titre" value="${annonce.titre}" required>
        </div>

        <div>
            <label for="description">Description :</label><br>
            <textarea id="description" name="description" rows="4" cols="50">${annonce.description}</textarea>
        </div>

        <div>
            <label for="ageMin">Âge minimum :</label>
            <input type="number" id="ageMin" name="ageMin" min="0" value="${annonce.ageMin}">
        </div>

        <div>
            <label for="ageMax">Âge maximum :</label>
            <input type="number" id="ageMax" name="ageMax" min="0" value="${annonce.ageMax}">
        </div>

        <div>
            <label for="idDepartement">Département :</label>
            <select id="idDepartement" name="idDepartement">
                <c:forEach var="dep" items="${departements}">
                    <option value="${dep.id}" <c:if test="${dep.id == annonce.idDepartement}">selected</c:if>>
                        ${dep.libelleDepartement}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div>
            <label for="idDiplomeRequis">Diplôme requis :</label>
            <select id="idDiplomeRequis" name="idDiplomeRequis">
                <c:forEach var="d" items="${diplomes}">
                    <option value="${d.id}" <c:if test="${d.id == annonce.idDiplomeRequis}">selected</c:if>>
                        ${d.nomDiplome}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div>
            <label for="nbPersonneUtile">Nombre de personnes utiles :</label>
            <input type="number" id="nbPersonneUtile" name="nbPersonneUtile" min="1" value="${annonce.nbPersonneUtile}">
        </div>

        <div>
            <label for="salaire">Salaire proposé :</label>
            <input type="number" id="salaire" name="salaire" min="0" value="${annonce.salaire}">
        </div>

        <div>
            <button type="submit">Mettre à jour l'annonce</button>
        </div>
    </form>

    <c:if test="${not empty message}">
        <p style="color:rgb(0, 255, 153);">${message}</p>
    </c:if>
</body>
</html>
