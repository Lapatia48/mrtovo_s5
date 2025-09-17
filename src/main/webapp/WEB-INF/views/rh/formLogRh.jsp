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
    <h2>Login Ressource humaine</h2>
    <form action="logRh" method="post">
        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" value="ressource humaine" required><br><br>

        <label for="motDePasse">Mot de passe :</label>
        <input type="password" id="motDePasse" name="motDePasse" value="mdprh123" required><br><br>

        <button type="submit">Se connecter</button>
    </form>

    <br><a href="${pageContext.request.contextPath}/entrer"><b>Annuler</b></a>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
</body>
</html>