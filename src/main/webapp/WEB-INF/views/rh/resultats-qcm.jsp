<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultats QCM</title>
</head>
<body>
    <h1>Resultats du QCM</h1>

    <p>
        <a href="${pageContext.request.contextPath}/rh/qcm/admis">Voir les candidats admis</a> |
        <a href="${pageContext.request.contextPath}/rh/qcm/refuses">Voir les candidats refusés</a>
    </p>

    <h2>Resume</h2>
    <p>Il y a ${admis.size()} candidats admis et ${refuses.size()} candidats refuses.</p>
</body>
</html>
