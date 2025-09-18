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
    <h1>Bienvenue sur la page d'accueil</h1>
    <a href="${pageContext.request.contextPath}/formLogCandidat2">Chercher un emploi</a><br>
    <!-- <a href="${pageContext.request.contextPath}/formLogCandidat">Login Candidat</a><br> -->
    <a href="${pageContext.request.contextPath}/formLogRh">Login Ressource humaine</a><br>
    <a href="${pageContext.request.contextPath}/formLogManager">Login Manager</a><br>
    <a href="${pageContext.request.contextPath}/formLogAdmin">Login Admin</a><br>
</body>
</html>