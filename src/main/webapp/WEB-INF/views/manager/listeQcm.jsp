<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des QCM</title>
</head>
<body>
    <div>
        <select id="departementFilter">
            <option value="all">Tous les départements</option>
            <c:forEach var="departement" items="${departements}">
                <option value="${departement.id}">${departement.libelleDepartement}</option>
            </c:forEach>
        </select>
    </div>

    <c:if test="${empty questionsReponses}">
        <div>Aucun QCM disponible</div>
    </c:if>

    <div id="qcmContainer">
        <c:forEach var="departement" items="${departements}">
            <c:set var="hasQuestions" value="false" />
            <c:forEach var="qr" items="${questionsReponses}">
                <c:if test="${qr.idDepartement == departement.id}">
                    <c:set var="hasQuestions" value="true" />
                </c:if>
            </c:forEach>
            
            <c:if test="${hasQuestions}">
                <div class="departement-section" data-departement="${departement.id}">
                    <h2>${departement.libelleDepartement}</h2>
                    
                    <c:forEach var="qr" items="${questionsReponses}">
                        <c:if test="${qr.idDepartement == departement.id}">
                            <c:set var="questionDejaAffichee" value="false" />
                            <c:forEach var="dejaVu" items="${questionsReponses}">
                                <c:if test="${dejaVu.questionId == qr.questionId && questionsReponses.indexOf(dejaVu) < questionsReponses.indexOf(qr)}">
                                    <c:set var="questionDejaAffichee" value="true" />
                                </c:if>
                            </c:forEach>
                            
                            <c:if test="${not questionDejaAffichee}">
                                <div class="question-card">
                                    <h3>${qr.question}</h3>
                                    <div>
                                        <a href="${pageContext.request.contextPath}/manager/modifierQcm?id_question=${qr.questionId}">Modifier</a>
                                        <a href="${pageContext.request.contextPath}/manager/supprimerQcm?id_question=${qr.questionId}">Supprimer</a>
                                    </div>
                                    <div class="reponses-list">
                                        <c:forEach var="reponse" items="${questionsReponses}">
                                            <c:if test="${reponse.questionId == qr.questionId}">
                                                <div class="reponse-item">
                                                    ${reponse.reponse}
                                                    <c:if test="${reponse.estVraie}">✓</c:if>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </div>
            </c:if>
        </c:forEach>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const filter = document.getElementById('departementFilter');
            const sections = document.querySelectorAll('.departement-section');
            
            filter.addEventListener('change', function() {
                const selectedValue = this.value;
                
                sections.forEach(section => {
                    const departementId = section.getAttribute('data-departement');
                    if (selectedValue === 'all' || departementId === selectedValue) {
                        section.style.display = 'block';
                    } else {
                        section.style.display = 'none';
                    }
                });
            });
        });
    </script>
</body>
</html>