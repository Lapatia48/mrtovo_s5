<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Résultat QCM</title>
</head>
<body>
    <h2>Résultat du QCM</h2>

    <p><strong>Candidat :</strong> ${nomCandidat}</p>
    <p><strong>Département :</strong> ${departement}</p>
    <hr>
    <p>Total de questions : ${totalQuestions}</p>
    <p>Nombre de réponses correctes : ${bonnesReponses}</p>
    <p>Note : ${note}%</p>

    <p>Resultat: <b>${resultat}</b></p>

    <a href="${pageContext.request.contextPath}/entrer">Accueil</a>
</body>
</html>
