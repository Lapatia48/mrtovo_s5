<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Résultat QCM - BusinessSuite</title>
    <style>
        /* Variables CSS - Palette Dark Fire & Sand */
        :root {
            --dark-fire: #52130C;
            --sand: #FFECD1;
            --chocolate: #3E000C;
            --light: #FFF9F0;
            --dark: #2C1810;
            --gray: #8C7E6E;
            --border-radius: 16px;
            --box-shadow: 0 8px 30px rgba(82, 19, 12, 0.08);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--sand);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 60px;
            max-width: 500px;
            width: 100%;
            text-align: center;
            border-top: 6px solid var(--dark-fire);
        }

        h1 {
            color: var(--dark-fire);
            font-size: 2.2rem;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .subtitle {
            color: var(--gray);
            margin-bottom: 40px;
            font-size: 1.1rem;
        }

        .candidate-info {
            background: var(--light);
            padding: 20px;
            border-radius: var(--border-radius);
            margin-bottom: 30px;
            border-left: 4px solid var(--dark-fire);
        }

        .info-line {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }

        .info-label {
            font-weight: 600;
            color: var(--dark);
        }

        .info-value {
            color: var(--chocolate);
            font-weight: 500;
        }

        .results {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-bottom: 30px;
        }

        .result-box {
            padding: 20px 15px;
            background: var(--light);
            border-radius: var(--border-radius);
            border: 2px solid transparent;
        }

        .result-box:hover {
            border-color: var(--dark-fire);
        }

        .number {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-fire);
            margin-bottom: 5px;
        }

        .label {
            font-size: 0.85rem;
            color: var(--gray);
            font-weight: 600;
            text-transform: uppercase;
        }

        .final-result {
            background: linear-gradient(135deg, var(--light), var(--sand));
            padding: 25px;
            border-radius: var(--border-radius);
            margin: 30px 0;
            border: 2px solid var(--dark-fire);
        }

        .result-text {
            font-size: 1.1rem;
            color: var(--gray);
            margin-bottom: 10px;
            font-weight: 600;
        }

        .result-value {
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--chocolate);
        }

        .home-btn {
            display: inline-block;
            background: var(--dark-fire);
            color: white;
            padding: 15px 35px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .home-btn:hover {
            background: var(--chocolate);
            transform: translateY(-2px);
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Résultat QCM</h1>
        <div class="subtitle">Votre performance au questionnaire</div>

        <div class="candidate-info">
            <div class="info-line">
                <span class="info-label">Candidat</span>
                <span class="info-value">${nomCandidat}</span>
            </div>
            <div class="info-line">
                <span class="info-label">Département</span>
                <span class="info-value">${departement}</span>
            </div>
        </div>

        <div class="results">
            <div class="result-box">
                <div class="number">${totalQuestions}</div>
                <div class="label">Questions</div>
            </div>
            <div class="result-box">
                <div class="number">${bonnesReponses}</div>
                <div class="label">Correctes</div>
            </div>
            <div class="result-box">
                <div class="number">${note}%</div>
                <div class="label">Note</div>
            </div>
        </div>

        <div class="final-result">
            <div class="result-text">Résultat final</div>
            <div class="result-value">${resultat}</div>
        </div>

        <a href="${pageContext.request.contextPath}/entrer" class="home-btn">Retour à l'accueil</a>
    </div>
</body>
</html>