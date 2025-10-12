<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Business Management Suite</title>
    <style>
        /* Variables CSS - Palette Sand, Dark Fire & Chocolate */
        :root {
            --sand: #FFECD1;
            --sand-dark: #E8D4B9;
            --dark-fire: #52130C;
            --dark-fire-light: #6B2A23;
            --chocolate: #3E000C;
            --chocolate-light: #5A1A24;
            --light: #FFF9F0;
            --dark: #2C1810;
            --gray: #8C7E6E;
            --gray-light: #E8E0D5;
            --border-radius: 16px;
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
            font-family: 'Inter', sans-serif;
            background: var(--sand);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        /* Layout principal */
        .hero-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
        }

        /* Section contenu */
        .content-section {
            padding: 40px 0;
        }

        .brand {
            margin-bottom: 50px;
        }

        .brand-name {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--dark-fire);
            margin-bottom: 8px;
        }

        .brand-tagline {
            color: var(--gray);
            font-size: 1.1rem;
            font-weight: 500;
        }

        h1 {
            font-size: 3rem;
            font-weight: 700;
            color: var(--dark-fire);
            margin-bottom: 25px;
            line-height: 1.2;
        }

        .lead-text {
            font-size: 1.2rem;
            color: var(--chocolate);
            margin-bottom: 40px;
            line-height: 1.6;
            max-width: 400px;
        }

        /* Bouton principal */
        .btn-primary {
            display: inline-block;
            background: linear-gradient(135deg, var(--dark-fire), var(--chocolate));
            color: white;
            padding: 18px 45px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            transition: var(--transition);
            box-shadow: 0 6px 20px rgba(82, 19, 12, 0.3);
            margin-bottom: 40px;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(82, 19, 12, 0.4);
        }

        /* Indicateur de statut */
        .status-indicator {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 20px;
            background: var(--light);
            border-radius: var(--border-radius);
            border-left: 4px solid var(--dark-fire);
        }

        .status-dot {
            width: 10px;
            height: 10px;
            background: var(--dark-fire);
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        .status-text {
            color: var(--gray);
            font-size: 0.9rem;
            font-weight: 500;
        }

        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }

        /* Section visuelle */
        .visual-section {
            background: white;
            border-radius: var(--border-radius);
            padding: 50px;
            box-shadow: var(--box-shadow);
            border: 1px solid var(--sand-dark);
            position: relative;
        }

        .visual-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--dark-fire), var(--chocolate));
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        .features-list {
            margin-top: 10px;
        }

        .feature-item {
            display: flex;
            align-items: flex-start;
            gap: 20px;
            padding: 25px;
            margin-bottom: 20px;
            background: var(--light);
            border-radius: var(--border-radius);
            border: 1px solid var(--sand-dark);
            transition: var(--transition);
        }

        .feature-item:hover {
            transform: translateX(10px);
            border-color: var(--dark-fire);
        }

        .feature-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--dark-fire), var(--chocolate));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.3rem;
            flex-shrink: 0;
        }

        .feature-content h3 {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-fire);
            margin-bottom: 8px;
        }

        .feature-content p {
            color: var(--gray);
            line-height: 1.5;
            font-size: 0.95rem;
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

        .content-section > * {
            animation: fadeInUp 0.6s ease-out;
            animation-fill-mode: both;
        }

        .brand { animation-delay: 0.1s; }
        h1 { animation-delay: 0.2s; }
        .lead-text { animation-delay: 0.3s; }
        .btn-primary { animation-delay: 0.4s; }
        .status-indicator { animation-delay: 0.5s; }

        .feature-item:nth-child(1) { animation: fadeInUp 0.6s ease-out 0.6s both; }
        .feature-item:nth-child(2) { animation: fadeInUp 0.6s ease-out 0.7s both; }
        .feature-item:nth-child(3) { animation: fadeInUp 0.6s ease-out 0.8s both; }

        /* Responsive */
        @media (max-width: 968px) {
            .hero-grid {
                grid-template-columns: 1fr;
                gap: 40px;
            }
            
            .content-section {
                text-align: center;
                padding: 20px 0;
            }
            
            .lead-text {
                margin: 0 auto 40px;
            }
            
            h1 {
                font-size: 2.5rem;
            }
        }

        @media (max-width: 480px) {
            .visual-section {
                padding: 30px 20px;
            }
            
            .feature-item {
                flex-direction: column;
                text-align: center;
                padding: 20px;
            }
            
            .brand-name {
                font-size: 2rem;
            }
            
            h1 {
                font-size: 2rem;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="hero-grid">
            <!-- Section contenu -->
            <div class="content-section">
                <div class="brand">
                    <div class="brand-name">BusinessSuite</div>
                    <div class="brand-tagline">Gestion d'entreprise premium</div>
                </div>
                
                <h1>Bienvenue</h1>
                <p class="lead-text">Accedez a votre espace de travail professionnel concu pour optimiser votre productivite et simplifier votre gestion d'entreprise.</p>
                
                <a href="${pageContext.request.contextPath}/entrer" class="btn-primary">Commencer l'experience</a>

                <div class="status-indicator">
                    <div class="status-dot"></div>
                    <div class="status-text">Plateforme securisee - Pret a l'emploi</div>
                </div>
            </div>

            <!-- Section visuelle -->
            <div class="visual-section">
                <div class="features-list">
                    <div class="feature-item">
                        <div class="feature-icon">⚡</div>
                        <div class="feature-content">
                            <h3>Performance Optimale</h3>
                            <p>Interface rapide et reactive pour professionnels exigeants</p>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">🔒</div>
                        <div class="feature-content">
                            <h3>Securite Renforcee</h3>
                            <p>Protection avancee de vos donnees sensibles</p>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">📊</div>
                        <div class="feature-content">
                            <h3>Analytics Complets</h3>
                            <p>Tableaux de bord pour une prise de decision eclairee</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>