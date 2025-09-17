<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h2>Liste des annonces</h2>

    <c:if test="${empty annonces}">
        <p>Aucune annonce disponible.</p>
    </c:if>

    <c:forEach var="annonce" items="${annonces}">
        <div style="border:1px solid #ccc; padding:10px; margin:10px 0;">
            <h3>${annonce.titre}</h3>
            <p><strong>Description :</strong> ${annonce.description}</p>
            <p><strong>Date de publication :</strong> ${annonce.datePublication}</p>
            <p><strong>Nombre de personnes utiles :</strong> ${annonce.nbPersonneUtile}</p>
            <p><strong>Salaire proposé :</strong> ${annonce.salaire}</p>
        </div>
    </c:forEach>
</body>

</html>