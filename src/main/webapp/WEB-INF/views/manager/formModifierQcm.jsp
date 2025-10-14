<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier un QCM</title>
</head>
<body>
    <h1>Modifier le QCM</h1>
    
    <form action="${pageContext.request.contextPath}/manager/updateQcm" method="post">
        <input type="hidden" name="id_question" value="${questionId}">
        
        <!-- Sélection du département -->
        <div>
            <label>Département:</label>
            <select name="id_departement" required>
                <c:forEach var="departement" items="${departements}">
                    <option value="${departement.id}" 
                        <c:if test="${departement.id == idDepartement}">selected</c:if>>
                        ${departement.libelleDepartement}
                    </option>
                </c:forEach>
            </select>
        </div>
        
        <!-- Question -->
        <div>
            <label>Question:</label>
            <input type="text" name="question" value="${questionText}" required style="width: 400px;">
        </div>
        
        <!-- Réponses -->
        <div>
            <label>Réponses:</label>
            <div id="reponses-container">
                <c:forEach var="reponse" items="${qcmDetails}" varStatus="status">
                    <div class="reponse-item">
                        <input type="text" name="reponses" value="${reponse.reponse}" required>
                        <input type="radio" name="reponse_correcte" value="${status.index}" 
                            <c:if test="${reponse.estVraie}">checked</c:if> required> Correcte
                        <c:if test="${status.index >= 2}">
                            <button type="button" onclick="supprimerReponse(this)">Supprimer</button>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
            <button type="button" onclick="ajouterReponse()">+ Ajouter une réponse</button>
        </div>
        
        <button type="submit">Modifier le QCM</button>
        <a href="${pageContext.request.contextPath}/manager/listQcm">Annuler</a>
    </form>
        <script>
        let reponseCount = ${qcmDetails.size()};
        
        function ajouterReponse() {
            reponseCount++;
            const container = document.getElementById('reponses-container');
            
            const div = document.createElement('div');
            div.className = 'reponse-item';
            div.innerHTML = `
                <input type="text" name="reponses" placeholder="Réponse ${reponseCount}" required>
                <input type="radio" name="reponse_correcte" value="${reponseCount - 1}"> Correcte
                <button type="button" onclick="supprimerReponse(this)">Supprimer</button>
            `;
            container.appendChild(div);
        }
        
        function supprimerReponse(button) {
            if (document.querySelectorAll('.reponse-item').length > 2) {
                button.parentElement.remove();
                reponseCount--;
                // Recalculer les valeurs des radio buttons
                const radios = document.querySelectorAll('input[name="reponse_correcte"]');
                radios.forEach((radio, index) => {
                    radio.value = index;
                });
            } else {
                alert('Au moins 2 réponses sont nécessaires');
            }
        }
    </script>
</body>
</html>