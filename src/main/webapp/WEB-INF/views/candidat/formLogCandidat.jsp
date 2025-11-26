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
    <h2>Login Candidat</h2>
    <form action="logCandidat" method="post">
        <label for="mail">Email :</label>
        <input type="email" id="mail" name="mail" value="lova.rasolofoson@gmail.com" required><br><br>

        <label for="prenom">Prenom :</label>
        <input type="text" id="prenom" name="prenom" value="Lova" required><br><br>

        <button type="submit">Se connecter</button>
    </form>
    
    <br><a href="${pageContext.request.contextPath}/entrer"><b>Annuler</b></a>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
</body>
</html>