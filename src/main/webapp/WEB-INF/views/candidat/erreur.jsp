<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur - BusinessSuite</title>
    <style>
        /* Variables CSS - Palette Dark Fire, Sand & Chocolate */
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* Conteneur principal */
        .container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Carte d'erreur */
        .error-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 60px 50px;
            width: 100%;
            border: 1px solid var(--sand-dark);
            position: relative;
            text-align: center;
        }

        .error-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--dark-fire), var(--chocolate));
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        /* Icône d'erreur */
        .error-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--accent), var(--dark-fire));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            color: white;
            font-size: 2rem;
        }

        /* Titre d'erreur */
        .error-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-fire);
            margin-bottom: 20px;
        }

        /* Message d'erreur */
        .error-message {
            background: linear-gradient(135deg, var(--light), var(--sand));
            border: 2px solid var(--accent-light);
            border-radius: var(--border-radius);
            padding: 25px 30px;
            margin: 30px 0;
            position: relative;
        }

        .error-message::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(135deg, var(--accent), var(--dark-fire));
            border-radius: var(--border-radius);
            z-index: -1;
            opacity: 0.1;
        }

        .error-text {
            color: var(--chocolate);
            font-size: 1.1rem;
            font-weight: 500;
            line-height: 1.6;
            margin: 0;
        }

        /* Bouton de retour */
        .back-button {
            display: inline-block;
            background: linear-gradient(135deg, var(--dark-fire), var(--chocolate));
            color: white;
            padding: 14px 35px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            box-shadow: 0 6px 20px rgba(82, 19, 12, 0.3);
            margin-top: 20px;
        }

        .back-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(82, 19, 12, 0.4);
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

        .error-card {
            animation: fadeInUp 0.6s ease-out;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .error-card {
                padding: 40px 30px;
            }
            
            .error-title {
                font-size: 1.5rem;
            }
            
            .error-icon {
                width: 70px;
                height: 70px;
                font-size: 1.8rem;
            }
        }

        @media (max-width: 480px) {
            .error-card {
                padding: 30px 20px;
            }
            
            .error-message {
                padding: 20px;
            }
            
            .error-text {
                font-size: 1rem;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="error-card">
            <div class="error-icon">!</div>
            
            <h1 class="error-title">Une erreur est survenue</h1>
            
            <div class="error-message">
                <p class="error-text">${error}</p>
            </div>
            
            <a href="javascript:history.back()" class="back-button">Retour</a>
        </div>
    </div>
</body>
</html>