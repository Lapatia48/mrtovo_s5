<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Postuler à une annonce - BusinessSuite</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* Conteneur principal */
        .container {
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
        }

        /* Carte principale */
        .card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 60px 50px;
            width: 100%;
            border: 1px solid var(--sand-dark);
            position: relative;
        }

        .card::before {
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
        .form-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .form-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--dark-fire);
            margin-bottom: 15px;
        }

        .form-subtitle {
            color: var(--gray);
            font-size: 1.1rem;
        }

        /* Grille du formulaire */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        /* Groupes de formulaire */
        .form-group {
            margin-bottom: 25px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--dark);
            font-size: 0.95rem;
        }

        /* Champs de formulaire */
        input[type="text"],
        input[type="email"],
        input[type="date"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid var(--gray-light);
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
            background: white;
            font-family: inherit;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="date"]:focus,
        input[type="number"]:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: var(--dark-fire);
            box-shadow: 0 0 0 3px rgba(82, 19, 12, 0.1);
        }

        textarea {
            resize: vertical;
            min-height: 120px;
        }

        select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%2352130C' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            background-size: 12px;
        }

        /* Section boutons */
        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 1px solid var(--sand-dark);
        }

        /* Bouton principal */
        .btn-primary {
            background: linear-gradient(135deg, var(--dark-fire), var(--chocolate));
            color: white;
            padding: 16px 40px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            box-shadow: 0 6px 20px rgba(82, 19, 12, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(82, 19, 12, 0.4);
        }

        /* Bouton secondaire */
        .btn-secondary {
            background: transparent;
            color: var(--gray);
            padding: 14px 30px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            border: 2px solid var(--gray-light);
        }

        .btn-secondary:hover {
            color: var(--dark-fire);
            border-color: var(--dark-fire);
            transform: translateY(-1px);
        }

        /* Indicateur de champ requis */
        .required::after {
            content: '*';
            color: var(--accent);
            margin-left: 4px;
        }

        /* Animation d'entrée */
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

        .card {
            animation: fadeInUp 0.6s ease-out;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .card {
                padding: 40px 30px;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .form-title {
                font-size: 2rem;
            }
            
            .form-actions {
                flex-direction: column;
                gap: 20px;
                align-items: stretch;
            }
            
            .btn-primary,
            .btn-secondary {
                text-align: center;
            }
        }

        @media (max-width: 480px) {
            .card {
                padding: 30px 20px;
            }
            
            .form-title {
                font-size: 1.8rem;
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
        <div class="card">
            <div class="form-header">
                <h1 class="form-title">Formulaire de candidature</h1>
                <p class="form-subtitle">Postulez à l'offre d'emploi en complétant vos informations</p>
            </div>

            <form action="${pageContext.request.contextPath}/postuleCandidat" method="post">
                <div class="form-grid">
                    <!-- Nom -->
                    <div class="form-group">
                        <label for="nom" class="required">Nom</label>
                        <input type="text" id="nom" name="nom" value="Ravelojaona" required>
                    </div>

                    <!-- Prénom -->
                    <div class="form-group">
                        <label for="prenom" class="required">Prénom</label>
                        <input type="text" id="prenom" name="prenom" value="lapatia" required>
                    </div>

                    <!-- Mail -->
                    <div class="form-group">
                        <label for="mail" class="required">Email</label>
                        <input type="email" id="mail" name="mail" value="a@gmail.com" required>
                    </div>

                    <!-- Adresse -->
                    <div class="form-group">
                        <label for="adresse" class="required">Adresse</label>
                        <input type="text" id="adresse" name="adresse" value="Majunga" required>
                    </div>

                    <!-- Date de naissance -->
                    <div class="form-group">
                        <label for="dateNaissance" class="required">Date de naissance</label>
                        <input type="date" id="dateNaissance" name="dateNaissance" value="2004-10-15" required>
                    </div>

                    <!-- Années d'expérience -->
                    <div class="form-group">
                        <label for="anneeExperience" class="required">Années d'expérience</label>
                        <input type="number" id="anneeExperience" name="anneeExperience" min="0" value="3" required>
                    </div>

                    <!-- Diplôme -->
                    <div class="form-group">
                        <label for="idDiplome" class="required">Diplôme</label>
                        <select id="idDiplome" name="idDiplome" required>
                            <c:forEach var="d" items="${diplome}">
                                <option value="${d.id}">${d.nomDiplome}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Renseignement -->
                    <div class="form-group full-width">
                        <label for="renseignement">Renseignement complémentaire</label>
                        <textarea id="renseignement" name="renseignement" placeholder="Décrivez votre expérience et compétences...">Tres experimente</textarea>
                    </div>
                </div>

                <!-- Champs cachés -->
                <input type="hidden" name="idAnnoncePostule" value="${annonce.id}">
                <input type="hidden" name="idDepartement" value="${annonce.idDepartement}">
                <input type="hidden" name="datePostule" value="<%= java.time.LocalDate.now() %>">

                <!-- Actions du formulaire -->
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/formLogCandidat2" class="btn-secondary">Annuler</a>
                    <button type="submit" class="btn-primary">Postuler ma candidature</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>