<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Offres d'emploi - BusinessSuite</title>
    <style>
        /* Variables CSS - Palette Dark Fire & Sand */
        :root {
            --dark-fire: #52130C;    /* Rouge bordeaux profond */
            --dark-fire-light: #6B2A23;
            --sand: #FFECD1;         /* Beige sable clair */
            --sand-dark: #E8D4B9;
            --accent: #C44536;       /* Terre cuite */
            --accent-light: #D67A6F;
            --chocolate: #3E000C;    /* Chocolate pour départements */
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
            font-family: 'Playfair Display', 'Georgia', serif;
            line-height: 1.6;
            color: var(--dark);
            background: linear-gradient(135deg, var(--sand) 0%, var(--light) 100%);
            min-height: 100vh;
        }

        /* Header */
        .header {
            background: var(--dark-fire);
            padding: 20px 0;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 4px 20px rgba(82, 19, 12, 0.2);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            font-size: 2rem;
            font-weight: 700;
            color: var(--sand);
            letter-spacing: -0.5px;
        }

        .logo span {
            color: var(--accent-light);
        }

        /* Bouton de déconnexion */
        .logout-btn {
            background: transparent;
            color: var(--sand);
            padding: 12px 30px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            border: 2px solid var(--sand);
            font-family: 'Inter', sans-serif;
        }

        .logout-btn:hover {
            background: var(--sand);
            color: var(--dark-fire);
            transform: translateY(-2px);
        }

        /* Conteneur principal */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 60px 20px;
        }

        /* En-tête de page */
        .page-header {
            text-align: center;
            margin-bottom: 60px;
        }

        .page-title {
            font-size: 3rem;
            font-weight: 700;
            color: var(--dark-fire);
            margin-bottom: 20px;
            letter-spacing: -1px;
        }

        .page-subtitle {
            color: var(--gray);
            font-size: 1.3rem;
            font-weight: 400;
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.8;
        }

        /* Grille d'annonces */
        .jobs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(420px, 1fr));
            gap: 35px;
            margin-bottom: 60px;
        }

        /* Carte d'annonce */
        .job-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 0;
            transition: var(--transition);
            overflow: hidden;
            border: 1px solid var(--sand-dark);
            position: relative;
        }

        .job-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--dark-fire), var(--accent));
        }

        .job-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 20px 50px rgba(82, 19, 12, 0.15);
        }

        /* En-tête de carte */
        .job-card-header {
            background: linear-gradient(135deg, var(--dark-fire), var(--dark-fire-light));
            padding: 30px;
            color: var(--sand);
            position: relative;
        }

        .job-title {
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 15px;
            line-height: 1.3;
        }

        /* Styles spécifiques pour les départements */
        .job-department {
            background: var(--chocolate);
            color: var(--sand);
            padding: 8px 20px;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-block;
            font-family: 'Inter', sans-serif;
            border: 2px solid var(--chocolate-light);
            box-shadow: 0 2px 10px rgba(62, 0, 12, 0.3);
        }

        .department-informatique {
            background: linear-gradient(135deg, var(--chocolate), #5A1A24);
            border-color: #6B2A23;
        }

        .department-marketing {
            background: linear-gradient(135deg, var(--chocolate), #4A0F1A);
            border-color: #5A1A24;
        }

        .department-rh {
            background: linear-gradient(135deg, var(--chocolate), #3A0510);
            border-color: #4A0F1A;
        }

        /* Corps de la carte */
        .job-card-body {
            padding: 35px 30px 30px;
            background: white;
        }

        .job-info {
            margin-bottom: 30px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--sand-dark);
        }

        .info-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }

        .info-label {
            font-weight: 600;
            color: var(--dark);
            font-size: 1rem;
            font-family: 'Inter', sans-serif;
        }

        .info-value {
            color: var(--gray);
            text-align: right;
            max-width: 60%;
            line-height: 1.5;
        }

        .salary {
            color: var(--accent);
            font-weight: 700;
            font-size: 1.2rem;
        }

        .age-range {
            background: var(--sand);
            color: var(--dark);
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* Pied de carte */
        .job-card-footer {
            padding: 25px 30px;
            background: var(--sand);
            border-top: 1px solid var(--sand-dark);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .post-date {
            color: var(--gray);
            font-size: 0.95rem;
            font-family: 'Inter', sans-serif;
        }

        /* Bouton postuler */
        .apply-btn {
            background: var(--dark-fire);
            color: var(--sand);
            padding: 14px 35px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            font-family: 'Inter', sans-serif;
            letter-spacing: 0.5px;
        }

        .apply-btn:hover {
            background: var(--accent);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(196, 69, 54, 0.3);
        }

        /* Badge pour nombre de postes */
        .positions-badge {
            background: var(--chocolate);
            color: var(--sand);
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
        }

        /* État vide */
        .empty-state {
            text-align: center;
            padding: 100px 40px;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            border: 2px dashed var(--sand-dark);
        }

        .empty-icon {
            width: 100px;
            height: 100px;
            background: var(--sand);
            border-radius: 50%;
            margin: 0 auto 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--dark-fire);
            border: 3px solid var(--sand-dark);
        }

        .empty-icon svg {
            width: 40px;
            height: 40px;
        }

        .empty-title {
            font-size: 1.8rem;
            color: var(--dark-fire);
            margin-bottom: 15px;
        }

        .empty-text {
            color: var(--gray);
            max-width: 400px;
            margin: 0 auto;
            line-height: 1.8;
            font-size: 1.1rem;
        }

        /* Animation d'entrée */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .job-card {
            animation: fadeInUp 0.6s ease-out;
            animation-fill-mode: both;
        }

        .job-card:nth-child(1) { animation-delay: 0.1s; }
        .job-card:nth-child(2) { animation-delay: 0.2s; }
        .job-card:nth-child(3) { animation-delay: 0.3s; }
        .job-card:nth-child(4) { animation-delay: 0.4s; }

        /* Responsive */
        @media (max-width: 900px) {
            .jobs-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }
            
            .page-title {
                font-size: 2.5rem;
            }
            
            .page-subtitle {
                font-size: 1.1rem;
            }
            
            .job-card-footer {
                flex-direction: column;
                gap: 20px;
                align-items: flex-start;
            }
            
            .job-card-header,
            .job-card-body {
                padding: 25px 20px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 40px 15px;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .info-row {
                flex-direction: column;
                gap: 8px;
            }
            
            .info-value {
                text-align: left;
                max-width: 100%;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <header class="header">
        <div class="header-content">
            <div class="logo">Career<span>Haven</span></div>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se Déconnecter</a>
        </div>
    </header>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Opportunités Professionnelles</h1>
            <p class="page-subtitle">Découvrez des carrières qui correspondent à vos ambitions et votre expertise</p>
        </div>

        <c:if test="${empty annonces}">
            <div class="empty-state">
                <div class="empty-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                        <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                        <circle cx="12" cy="10" r="3"></circle>
                    </svg>
                </div>
                <h3 class="empty-title">Aucune offre disponible</h3>
                <p class="empty-text">Nous mettons constamment à jour nos offres. Revenez bientôt pour découvrir de nouvelles opportunités passionnantes.</p>
            </div>
        </c:if>

        <div class="jobs-grid">
            <c:forEach var="annonce" items="${annonces}">
                <div class="job-card">
                    <div class="job-card-header">
                        <h3 class="job-title">${annonce.titre}</h3>
                        <c:choose>
                            <c:when test="${departements[annonce.id] == 'INFORMATIQUE'}">
                                <div class="job-department department-informatique">${departements[annonce.id]}</div>
                            </c:when>
                            <c:when test="${departements[annonce.id] == 'MARKETING'}">
                                <div class="job-department department-marketing">${departements[annonce.id]}</div>
                            </c:when>
                            <c:when test="${departements[annonce.id] == 'RESSOURCE HUMAINES'}">
                                <div class="job-department department-rh">${departements[annonce.id]}</div>
                            </c:when>
                            <c:otherwise>
                                <div class="job-department">${departements[annonce.id]}</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="job-card-body">
                        <div class="job-info">
                            <div class="info-row">
                                <span class="info-label">Description</span>
                                <span class="info-value">${annonce.description}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Tranche d'âge</span>
                                <span class="info-value age-range">${annonce.ageMin} - ${annonce.ageMax} ans</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Rémunération</span>
                                <span class="info-value salary">${annonce.salaire}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Postes disponibles</span>
                                <span class="info-value">
                                    <span class="positions-badge">${annonce.nbPersonneUtile} poste(s)</span>
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="job-card-footer">
                        <div class="post-date">Publié le ${annonce.datePublication}</div>
                        <a href="${pageContext.request.contextPath}/postuleCandidat?id_annonce=${annonce.id}" class="apply-btn">Postuler maintenant</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>