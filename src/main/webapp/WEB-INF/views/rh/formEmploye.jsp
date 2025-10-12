<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Formulaire d'Embauche - ${candidat.prenom} ${candidat.nom} - BusinessSuite RH</title>
    <style>
        /* Variables CSS - Palette Navy Blue + Cream + White */
        :root {
            --navy-blue: #1A365D;
            --navy-light: #2D4A7C;
            --navy-dark: #0F1F3D;
            --cream: #F8F9FA;
            --cream-dark: #E9ECEF;
            --white: #FFFFFF;
            --gray: #6C757D;
            --gray-light: #DEE2E6;
            --gray-lighter: #F8F9FA;
            --accent: #2563EB;
            --success: #198754;
            --warning: #FFC107;
            --danger: #DC3545;
            --info: #0DCAF0;
            --border-radius: 8px;
            --box-shadow: 0 2px 10px rgba(26, 54, 93, 0.08);
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
            line-height: 1.5;
            color: var(--navy-blue);
            background: var(--cream);
            min-height: 100vh;
        }

        /* Layout Principal */
        .admin-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Navigation */
        .sidebar {
            width: 280px;
            background: var(--navy-blue);
            color: var(--white);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: var(--transition);
            z-index: 1000;
        }

        .sidebar-header {
            padding: 2rem 1.5rem;
            border-bottom: 1px solid var(--navy-light);
        }

        .sidebar-header h1 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .sidebar-header p {
            font-size: 0.875rem;
            color: var(--gray-light);
            opacity: 0.8;
        }

        .nav-menu {
            padding: 1.5rem 0;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.875rem 1.5rem;
            color: var(--white);
            text-decoration: none;
            transition: var(--transition);
            border-left: 3px solid transparent;
        }

        .nav-link:hover, .nav-link.active {
            background: var(--navy-light);
            border-left-color: var(--accent);
        }

        .nav-link i {
            margin-right: 0.75rem;
            width: 20px;
            text-align: center;
        }

        /* Contenu Principal */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }

        /* Top Bar */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .page-title h2 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--navy-blue);
            margin-bottom: 0.25rem;
        }

        .page-title p {
            color: var(--gray);
            font-size: 0.9rem;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logout-btn {
            background: var(--navy-blue);
            color: var(--white);
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            transition: var(--transition);
        }

        .logout-btn:hover {
            background: var(--navy-light);
        }

        /* Message d'erreur */
        .error-message {
            background: var(--danger);
            color: var(--white);
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 2rem;
            box-shadow: var(--box-shadow);
        }

        /* Sections du formulaire */
        .form-section {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-bottom: 2rem;
            overflow: hidden;
        }

        .section-header {
            background: var(--navy-blue);
            color: var(--white);
            padding: 1.5rem;
            border-bottom: 1px solid var(--navy-light);
        }

        .section-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-body {
            padding: 1.5rem;
        }

        /* Grille du formulaire */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Groupes de formulaire */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: var(--navy-blue);
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--gray-light);
            border-radius: var(--border-radius);
            font-size: 0.875rem;
            transition: var(--transition);
            background: var(--white);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--navy-blue);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .form-control:read-only {
            background-color: var(--gray-lighter);
            color: var(--gray);
            cursor: not-allowed;
        }

        .form-textarea {
            resize: vertical;
            min-height: 80px;
        }

        /* Boutons */
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 500;
            font-size: 0.875rem;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--navy-blue);
            color: var(--white);
        }

        .btn-primary:hover {
            background: var(--navy-light);
        }

        .btn-secondary {
            background: var(--gray-light);
            color: var(--navy-blue);
        }

        .btn-secondary:hover {
            background: var(--gray);
            color: var(--white);
        }

        .btn-success {
            background: var(--success);
            color: var(--white);
            padding: 1rem 2rem;
            font-size: 1rem;
        }

        .btn-success:hover {
            background: #157347;
        }

        .btn-danger {
            background: var(--danger);
            color: var(--white);
        }

        .btn-danger:hover {
            background: #bb2d3b;
        }

        /* Actions du formulaire */
        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--gray-light);
        }

        /* Badges */
        .badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
        }

        .badge-info {
            background: var(--info);
            color: var(--white);
        }

        /* Indicateurs de champ requis */
        .required::after {
            content: " *";
            color: var(--danger);
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .sidebar {
                width: 250px;
            }
            .main-content {
                margin-left: 250px;
            }
        }

        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
            .top-bar {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
            .form-actions {
                flex-direction: column;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar Navigation -->
        <nav class="sidebar">
            <div class="sidebar-header">
                <h1>BusinessSuite RH</h1>
                <p>Gestion des ressources humaines</p>
            </div>
            <div class="nav-menu">
                <div class="nav-item">
                    <a href="${pageContext.request.contextPath}/accueilRh" class="nav-link">
                        <i class="fas fa-tachometer-alt"></i>
                        Tableau de Bord
                    </a>
                </div>
                <div class="nav-item">
                    <a href="${pageContext.request.contextPath}/rh/candidats" class="nav-link">
                        <i class="fas fa-users"></i>
                        Tout les candidats
                    </a>
                </div>
                <div class="nav-item">
                    <a href="${pageContext.request.contextPath}/rh/listCandidatRefuse" class="nav-link">
                        <i class="fas fa-user-times"></i>
                        Candidats Refusés
                    </a>
                </div>
                <div class="nav-item">
                    <a href="${pageContext.request.contextPath}/rh/essai" class="nav-link">
                        <i class="fas fa-clock"></i>
                        Période d'Essai
                    </a>
                </div>
                <div class="nav-item">
                    <a href="${pageContext.request.contextPath}/rh/essaiRenouv" class="nav-link">
                        <i class="fas fa-sync-alt"></i>
                        Renouvellement Essai
                    </a>
                </div>
                <div class="nav-item">
                    <a href="${pageContext.request.contextPath}/rh/employe" class="nav-link">
                        <i class="fas fa-user-tie"></i>
                        Employés
                    </a>
                </div>
            </div>
        </nav>

        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Formulaire d'Embauche</h2>
                    <p>Embauche définitive de ${candidat.prenom} ${candidat.nom}</p>
                </div>
                <div class="user-menu">
                    <a href="${pageContext.request.contextPath}/rh/essai" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Retour à la liste
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i>
                        Déconnexion
                    </a>
                </div>
            </div>

            <!-- Message d'erreur -->
            <c:if test="${not empty error}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/essai/embauche/valider" id="embaucheForm">
                <input type="hidden" name="idCandidat" value="${candidat.idCandidat}" required>

                <!-- Section Informations personnelles -->
                <div class="form-section">
                    <div class="section-header">
                        <h3><i class="fas fa-user"></i> Informations personnelles</h3>
                    </div>
                    <div class="section-body">
                        <div class="form-grid">
                            <div class="form-group">
                                <label class="required"><i class="fas fa-signature"></i> Nom</label>
                                <input type="text" name="nom" value="${candidat.nom}" 
                                       class="form-control" readonly required>
                            </div>
                            <div class="form-group">
                                <label class="required"><i class="fas fa-signature"></i> Prénom</label>
                                <input type="text" name="prenom" value="${candidat.prenom}" 
                                       class="form-control" readonly required>
                            </div>
                            <div class="form-group">
                                <label class="required"><i class="fas fa-envelope"></i> Email</label>
                                <input type="email" name="mail" value="${candidat.mail}" 
                                       class="form-control" readonly required>
                            </div>
                            <div class="form-group">
                                <label class="required"><i class="fas fa-map-marker-alt"></i> Adresse</label>
                                <input type="text" name="adresse" value="${candidat.adresse}" 
                                       class="form-control" readonly required>
                            </div>
                            <div class="form-group">
                                <label class="required"><i class="fas fa-birthday-cake"></i> Date de naissance</label>
                                <input type="text" name="dateNaissance" value="${candidat.dateNaissance}" 
                                       class="form-control" readonly required>
                            </div>
                            <div class="form-group">
                                <label class="required"><i class="fas fa-graduation-cap"></i> Diplôme</label>
                                <input type="text" name="diplome" value="${candidat.diplome}" 
                                       class="form-control" readonly required>
                            </div>
                            <div class="form-group">
                                <label class="required"><i class="fas fa-briefcase"></i> Expérience</label>
                                <input type="text" name="anneeExperience" value="${candidat.anneeExperience} ans" 
                                       class="form-control" readonly required>
                            </div>
                            <div class="form-group">
                                <label class="required"><i class="fas fa-building"></i> Département</label>
                                <input type="text" name="departement" value="${candidat.departement}" 
                                       class="form-control" readonly required>
                            </div>
                            <div class="form-group">
                                <label class="required"><i class="fas fa-briefcase"></i> Poste initial</label>
                                <input type="text" name="annoncePostulee" value="${candidat.annoncePostulee}" 
                                       class="form-control" readonly required>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Section Informations d'embauche -->
                <div class="form-section">
                    <div class="section-header">
                        <h3><i class="fas fa-file-contract"></i> Informations d'embauche</h3>
                    </div>
                    <div class="section-body">
                        <div class="form-grid">
                            <div class="form-group">
                                <label class="required"><i class="fas fa-lock"></i> Mot de passe</label>
                                <input type="password" name="motDePasse" class="form-control" required 
                                       placeholder="Définir le mot de passe de connexion"
                                       minlength="6">
                                <small style="color: var(--gray); font-size: 0.75rem;">
                                    Minimum 6 caractères
                                </small>
                            </div>
                            <div class="form-group">
                                <label class="required"><i class="fas fa-lock"></i> Confirmer le mot de passe</label>
                                <input type="password" name="confirmationMotDePasse" class="form-control" required 
                                       placeholder="Confirmer le mot de passe">
                            </div>
                            <div class="form-group">
                                <label class="required"><i class="fas fa-calendar-alt"></i> Date d'embauche</label>
                                <input type="date" name="dateEmbauche" value="${dateEmbauche}" 
                                       class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="required"><i class="fas fa-user-tie"></i> Poste attribué</label>
                                <input type="text" name="poste" value="${candidat.annoncePostulee}" 
                                       class="form-control" required placeholder="Poste définitif">
                            </div>
                            <div class="form-group">
                                <label class="required"><i class="fas fa-money-bill-wave"></i> Salaire définitif</label>
                                <input type="number" name="salaire" value="${candidat.salaire}" 
                                       class="form-control" required placeholder="Salaire en Ariary" min="0">
                            </div>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-info-circle"></i> Informations complémentaires</label>
                            <textarea name="renseignement" class="form-control form-textarea" 
                                      placeholder="Informations supplémentaires sur l'employé">${candidat.renseignement}</textarea>
                        </div>
                    </div>
                </div>

                <!-- Actions du formulaire -->
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="window.history.back()">
                        <i class="fas fa-times"></i>
                        Annuler
                    </button>
                    <button type="submit" class="btn btn-success" onclick="return validerFormulaire()">
                        <i class="fas fa-user-check"></i>
                        Valider l'embauche
                    </button>
                </div>
            </form>
        </main>
    </div>

    <script>
        function validerFormulaire() {
            const motDePasse = document.getElementsByName('motDePasse')[0].value;
            const confirmation = document.getElementsByName('confirmationMotDePasse')[0].value;
            const salaire = document.getElementsByName('salaire')[0].value;
            const dateEmbauche = document.getElementsByName('dateEmbauche')[0].value;
            
            // Validation des mots de passe
            if (motDePasse !== confirmation) {
                alert('❌ Les mots de passe ne correspondent pas');
                document.getElementsByName('motDePasse')[0].focus();
                return false;
            }
            
            if (motDePasse.length < 6) {
                alert('❌ Le mot de passe doit contenir au moins 6 caractères');
                document.getElementsByName('motDePasse')[0].focus();
                return false;
            }
            
            // Validation du salaire
            if (salaire <= 0) {
                alert('❌ Le salaire doit être supérieur à 0');
                document.getElementsByName('salaire')[0].focus();
                return false;
            }
            
            // Validation de la date
            if (!dateEmbauche) {
                alert('❌ Veuillez sélectionner une date d\'embauche');
                document.getElementsByName('dateEmbauche')[0].focus();
                return false;
            }
            
            const confirmationMessage = `Êtes-vous sûr de vouloir embaucher définitivement ${candidat.prenom} ${candidat.nom} ?\n\nPoste: ${document.getElementsByName('poste')[0].value}\nSalaire: ${salaire} Ar\nDate d'embauche: ${dateEmbauche}`;
            
            return confirm(confirmationMessage);
        }

        // Focus sur le premier champ modifiable
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementsByName('motDePasse')[0].focus();
            
            // Menu responsive
            const menuToggle = document.createElement('button');
            menuToggle.innerHTML = '<i class="fas fa-bars"></i>';
            menuToggle.style.cssText = `
                position: fixed;
                top: 1rem;
                left: 1rem;
                background: var(--navy-blue);
                color: white;
                border: none;
                padding: 0.5rem;
                border-radius: var(--border-radius);
                cursor: pointer;
                z-index: 1001;
                display: none;
            `;
            
            document.body.appendChild(menuToggle);
            
            menuToggle.addEventListener('click', function() {
                document.querySelector('.sidebar').classList.toggle('active');
            });

            function handleResize() {
                if (window.innerWidth <= 992) {
                    menuToggle.style.display = 'block';
                } else {
                    menuToggle.style.display = 'none';
                    document.querySelector('.sidebar').classList.remove('active');
                }
            }

            window.addEventListener('resize', handleResize);
            handleResize();
        });
    </script>
</body>
</html>