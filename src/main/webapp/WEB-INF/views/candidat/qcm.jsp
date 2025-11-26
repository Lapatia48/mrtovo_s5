<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Questionnaire - BusinessSuite</title>
    <style>
        /* Variables CSS - Palette Dark Fire & Sand */
        :root {
            --dark-fire: #52130C;
            --dark-fire-light: #6B2A23;
            --sand: #FFECD1;
            --sand-dark: #E8D4B9;
            --accent: #C44536;
            --accent-light: #D67A6F;
            --chocolate: #3E000C;
            --chocolate-light: #5A1A24;
            --light: #FFF9F0;
            --dark: #2C1810;
            --gray: #8C7E6E;
            --gray-light: #E8E0D5;
            --border-radius: 12px;
            --box-shadow: 0 8px 30px rgba(82, 19, 12, 0.08);
            --transition: all 0.3s ease;
        }

        /* Reset et styles de base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', sans-serif;
            line-height: 1.6;
            color: var(--dark);
            background: linear-gradient(135deg, var(--sand) 0%, var(--light) 100%);
            min-height: 100vh;
            padding: 20px;
        }

        /* Conteneur principal */
        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        /* Carte principale */
        .qcm-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 60px 50px;
            border: 1px solid var(--sand-dark);
            position: relative;
        }

        .qcm-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--dark-fire), var(--chocolate));
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        /* En-tête */
        .qcm-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .qcm-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--dark-fire);
            margin-bottom: 15px;
        }

        .qcm-subtitle {
            color: var(--gray);
            font-size: 1.1rem;
        }

        /* Message */
        .info-message {
            background: linear-gradient(135deg, var(--sand), var(--light));
            color: var(--chocolate);
            padding: 20px 25px;
            border-radius: var(--border-radius);
            margin-bottom: 40px;
            text-align: center;
            font-weight: 600;
            border-left: 4px solid var(--accent);
            box-shadow: 0 4px 15px rgba(82, 19, 12, 0.1);
        }

        /* Questions */
        .question-container {
            background: var(--light);
            border-radius: var(--border-radius);
            padding: 35px 30px;
            margin-bottom: 30px;
            border: 1px solid var(--sand-dark);
            transition: var(--transition);
        }

        .question-container:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .question-number {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--dark-fire);
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .question-text {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 25px;
            line-height: 1.5;
        }

        /* Réponses */
        .answers-container {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .answer-option {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            padding: 18px 20px;
            background: white;
            border: 2px solid var(--gray-light);
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: var(--transition);
        }

        .answer-option:hover {
            border-color: var(--dark-fire);
            transform: translateX(5px);
        }

        .answer-option input[type="radio"] {
            margin-top: 2px;
            accent-color: var(--dark-fire);
            transform: scale(1.2);
        }

        .answer-label {
            color: var(--dark);
            font-weight: 500;
            line-height: 1.5;
            flex: 1;
        }

        /* Indicateur de bonne réponse */
        .correct-answer {
            background: linear-gradient(135deg, var(--sand), var(--light));
            border-color: var(--accent);
            position: relative;
        }

        .correct-answer::before {
            content: '✓';
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--accent);
            font-weight: bold;
            font-size: 1.2rem;
        }

        /* Bouton de validation */
        .submit-section {
            text-align: center;
            margin-top: 50px;
            padding-top: 40px;
            border-top: 1px solid var(--sand-dark);
        }

        .submit-btn {
            background: linear-gradient(135deg, var(--dark-fire), var(--chocolate));
            color: white;
            padding: 18px 45px;
            border-radius: var(--border-radius);
            border: none;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 6px 20px rgba(82, 19, 12, 0.3);
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(82, 19, 12, 0.4);
        }

        /* Informations candidat */
        .candidate-info {
            background: var(--sand);
            padding: 20px 25px;
            border-radius: var(--border-radius);
            margin-bottom: 40px;
            border-left: 4px solid var(--dark-fire);
        }

        .candidate-name {
            font-weight: 600;
            color: var(--dark-fire);
            margin-bottom: 5px;
        }

        .candidate-department {
            color: var(--gray);
            font-size: 0.95rem;
        }

        /* Indicateur de progression */
        .progress-indicator {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            padding: 20px;
            background: var(--light);
            border-radius: var(--border-radius);
            border: 1px solid var(--sand-dark);
        }

        .progress-text {
            font-weight: 600;
            color: var(--dark-fire);
        }

        .progress-count {
            background: var(--dark-fire);
            color: var(--sand);
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .question-container {
            animation: fadeInUp 0.6s ease-out;
            animation-fill-mode: both;
        }

        .question-container:nth-child(1) { animation-delay: 0.1s; }
        .question-container:nth-child(2) { animation-delay: 0.2s; }
        .question-container:nth-child(3) { animation-delay: 0.3s; }
        .question-container:nth-child(4) { animation-delay: 0.4s; }

        /* Responsive */
        @media (max-width: 768px) {
            .qcm-card {
                padding: 40px 30px;
            }
            
            .qcm-title {
                font-size: 2rem;
            }
            
            .question-container {
                padding: 25px 20px;
            }
            
            .answer-option {
                padding: 15px;
            }
            
            .progress-indicator {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
        }

        @media (max-width: 480px) {
            .qcm-card {
                padding: 30px 20px;
            }
            
            .qcm-title {
                font-size: 1.8rem;
            }
            
            .question-text {
                font-size: 1.1rem;
            }
            
            body {
                padding: 15px;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="qcm-card">
            <div class="qcm-header">
                <h1 class="qcm-title">Questionnaire de compétences</h1>
                <p class="qcm-subtitle">Répondez aux questions suivantes pour compléter votre candidature</p>
            </div>

            <c:if test="${not empty message}">
                <div class="info-message">
                    ${message}
                </div>
            </c:if>

            <div class="progress-indicator">
                <div class="progress-text">Progression du questionnaire</div>
                <div class="progress-count">${questions.size()} questions</div>
            </div>

            <div class="candidate-info">
                <div class="candidate-name">Candidat : ${candidat.nom}</div>
                <div class="candidate-department">Département concerné</div>
            </div>

            <form action="submitQCM" method="post">
                <input type="hidden" name="idDepartement" value="${idDepartement}">
                <input type="hidden" name="idCandidat" value="${candidat.id}">
                <input type="hidden" name="nomCandidat" value="${candidat.nom}">
                
                <c:forEach var="question" items="${questions}">
                    <div class="question-container">
                        <div class="question-number">Question ${question.id}</div>
                        <h3 class="question-text">${question.question}</h3>
                        
                        <div class="answers-container">
                            <c:forEach var="reponse" items="${reponsesParQuestion[question.id]}">
                                <label class="answer-option ${bonneReponseMap[question.id] == reponse.id ? 'correct-answer' : ''}">
                                    <input type="radio"
                                        name="q${question.id}"
                                        value="${reponse.id}"
                                        id="r${reponse.id}"
                                        <c:if test="${bonneReponseMap[question.id] == reponse.id}">checked</c:if>>
                                    <span class="answer-label">${reponse.reponse}</span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>

                <div class="submit-section">
                    <button type="submit" class="submit-btn">Valider le questionnaire</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>