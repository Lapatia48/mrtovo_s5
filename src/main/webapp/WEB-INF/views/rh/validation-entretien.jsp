<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Validation Entretien</title>
</head>
<body>
<h2>Validation des candidats admis au QCM</h2>

<table border="1">
    <tr>
        <th>ID Candidat</th>
        <th>Nom</th>
        <th>Prénom</th>
        <th>Email</th>
        <th>Action</th>
    </tr>
    <c:forEach var="c" items="${candidats}">
        <tr>
            <td>${c.idCandidat}</td>
            <td>${c.nom}</td>
            <td>${c.prenom}</td>
            <td>${c.mail}</td>
            <td>
                <form action="${pageContext.request.contextPath}/rh/qcm/validation-entretien/${c.idCandidat}" method="post">
                    <button type="submit" name="statut" value="Valide">Oui</button>
                    <button type="submit" name="statut" value="Refuse">Non</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
    <a href="${pageContext.request.contextPath}/rh/essai/liste">Voir candidats à l'essai</a>


</body>
</html>
