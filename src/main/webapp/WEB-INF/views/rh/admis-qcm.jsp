<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Candidats admis</title>
</head>
<body>
    <h2>Liste des candidats admis au QCM</h2>
    <table border="1">
        <tr>
            <th>ID Candidat</th><th>Nom</th><th>Prenom</th><th>Email</th>
        </tr>
        <c:forEach var="c" items="${admis}">
            <tr>
                <td>${c.idCandidat}</td>
                <td>${c.nom}</td>
                <td>${c.prenom}</td>
                <td>${c.mail}</td>
            </tr>
        </c:forEach>
    </table>

    <p><a href="${pageContext.request.contextPath}/rh/qcm/traiter"> Retour aux resultats</a></p>
</body>
</html>
