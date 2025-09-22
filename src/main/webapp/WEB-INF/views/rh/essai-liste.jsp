<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Candidats en Essai</title></head>
<body>
<h2>Candidats ayant validé l'entretien</h2>

<table border="1">
    <tr><th>Nom</th><th>Prénom</th><th>Email</th><th>Action</th></tr>
    <c:forEach var="c" items="${candidats}">
        <tr>
            <td>${c.nom}</td>
            <td>${c.prenom}</td>
            <td>${c.mail}</td>
            <td>
                <form action="${pageContext.request.contextPath}/rh/essai/valider/${c.id}" method="post">
                    <input type="hidden" name="periode" value="3" />
                    <button type="submit">Passer en essai</button>
                </form>

            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
