<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QCM</title>
</head>
<body>
    <h2>QCM</h2>

    <p style="color: green;">${message}</p>

    <form action="submitQCM" method="post">
        <c:forEach var="question" items="${questions}">
            <div style="margin-bottom: 20px;">
                <p><strong>Question ${question.id} :</strong> ${question.question}</p>

                <c:forEach var="reponse" items="${reponsesParQuestion[question.id]}">
                    <input type="radio"
                        name="q${question.id}"
                        value="${reponse.id}"
                        id="r${reponse.id}"
                        <c:if test="${bonneReponseMap[question.id] == reponse.id}">checked</c:if>>
                    <label for="r${reponse.id}">${reponse.reponse}</label><br>
                </c:forEach>
            </div>
        </c:forEach>


        <input type="submit" value="Valider">
    </form>

</body>
</html>
