<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>create qcm</title>
</head>
<body>
    <h1>Créer un nouveau QCM</h1>
    
    <form action="${pageContext.request.contextPath}/manager/insertQcm" method="post">
        <!-- Sélection du département -->
        <div>
            <label>Département:</label>
            <select name="id_departement" required>
                <option value="">Choisir un département</option>
                <c:forEach var="departement" items="${departements}">
                    <option value="${departement.id}">${departement.libelleDepartement}</option>
                </c:forEach>
            </select>
        </div>
        
        <!-- Question -->
        <div>
            <label>Question:</label>
            <input type="text" name="question" placeholder="Entrez la question" required style="width: 400px;">
        </div>
        
        <!-- Réponses -->
        <div>
            <label>Réponses:</label>
            <div id="reponses-container">
                <!-- Réponse 1 -->
                <div class="reponse-item">
                    <input type="text" name="reponses" placeholder="Réponse 1" required>
                    <input type="radio" name="reponse_correcte" value="0" required> Correcte
                </div>
                <!-- Réponse 2 -->
                <div class="reponse-item">
                    <input type="text" name="reponses" placeholder="Réponse 2" required>
                    <input type="radio" name="reponse_correcte" value="1" required> Correcte
                </div>
                <!-- Réponse 3 -->
                <div class="reponse-item">
                    <input type="text" name="reponses" placeholder="Réponse 3" required>
                    <input type="radio" name="reponse_correcte" value="2" required> Correcte
                </div>
            </div>
            <button type="button" onclick="ajouterReponse()">+ Ajouter une réponse</button>
        </div>
        
        <button type="submit">Créer le QCM</button>
    </form>



    <script>
        let reponseCount = 3; // Commence avec 3 réponses
        
        function ajouterReponse() {
            reponseCount++;
            const container = document.getElementById('reponses-container');
            
            const div = document.createElement('div');
            div.className = 'reponse-item';
            div.innerHTML = `
                <input type="text" name="reponses" placeholder="Réponse ${reponseCount}" required>
                <input type="radio" name="reponse_correcte" value="${reponseCount - 1}" required> Correcte
                <button type="button" onclick="supprimerReponse(this)">Supprimer</button>
            `;
            container.appendChild(div);
        }
        
        function supprimerReponse(button) {
            if (document.querySelectorAll('.reponse-item').length > 2) {
                button.parentElement.remove();
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