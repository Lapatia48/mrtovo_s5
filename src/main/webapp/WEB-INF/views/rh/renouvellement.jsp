<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Renouvellement d'Essai - ${candidat.prenom} ${candidat.nom} - BusinessSuite RH</title>
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

        /* Grid Layout */
        .renouvellement-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        @media (max-width: 992px) {
            .renouvellement-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Cartes */
        .card {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
        }

        .card-header {
            background: var(--navy-blue);
            color: var(--white);
            padding: 1.5rem;
            border-bottom: 1px solid var(--navy-light);
        }

        .card-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .card-header h3 i {
            font-size: 1.1rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        /* Tableaux d'information */
        .info-table {
            width: 100%;
            border-collapse: collapse;
        }

        .info-table tr {
            border-bottom: 1px solid var(--gray-light);
        }

        .info-table tr:last-child {
            border-bottom: none;
        }

        .info-table td {
            padding: 0.875rem 0.5rem;
            vertical-align: top;
        }

        .info-table td:first-child {
            font-weight: 600;
            color: var(--navy-blue);
            width: 40%;
            padding-left: 0;
        }

        .info-table td:last-child {
            padding-right: 0;
        }

        /* Badges */
        .badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
        }

        .badge-success {
            background: var(--success);
            color: var(--white);
        }

        .badge-warning {
            background: var(--warning);
            color: var(--navy-blue);
        }

        .badge-info {
            background: var(--info);
            color: var(--white);
        }

        .badge-primary {
            background: var(--navy-blue);
            color: var(--white);
        }

        /* Formulaire */
        .form-section {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
        }

        .form-section-header {
            background: var(--navy-blue);
            color: var(--white);
            padding: 1.5rem;
            border-bottom: 1px solid var(--navy-light);
        }

        .form-section-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .form-section-body {
            padding: 1.5rem;
        }

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

        .form-select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--gray-light);
            border-radius: var(--border-radius);
            font-size: 0.875rem;
            transition: var(--transition);
            background: var(--white);
            cursor: pointer;
        }

        .form-select:focus {
            outline: none;
            border-color: var(--navy-blue);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
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
        }

        .btn-success:hover {
            background: #157347;
        }

        .btn-warning {
            background: var(--warning);
            color: var(--navy-blue);
        }

        .btn-warning:hover {
            background: #ffca2c;
        }

        /* Actions du formulaire */
        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--gray-light);
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

        @media (max-width: 576px) {
            .card-body {
                padding: 1rem;
            }
            .form-section-body {
                padding: 1rem;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar Navigation -->
        <jsp:include page="../sidebar/sidebarRh.jsp" />

        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Renouvellement d'Essai</h2>
                    <p>Renouvellement de la période d'essai pour ${candidat.prenom} ${candidat.nom}</p>
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

            <!-- Grid des informations -->
            <div class="renouvellement-grid">
                <!-- Carte Détails de l'annonce -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-bullhorn"></i> Détails de l'annonce</h3>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty candidat}">
                                <table class="info-table">
                                    <tr>
                                        <td>Poste :</td>
                                        <td><strong>${candidat.annoncePostulee}</strong></td>
                                    </tr>
                                    <tr>
                                        <td>Département :</td>
                                        <td>
                                            <span class="badge badge-info">${candidat.departement}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Salaire actuel :</td>
                                        <td>
                                            <strong>${candidat.salaire} Ar</strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Période actuelle :</td>
                                        <td>
                                            <span class="badge badge-warning">${candidat.periode} mois</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Note QCM :</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${candidat.noteQcm != null}">
                                                    <span class="badge ${candidat.noteQcm >= 75 ? 'badge-success' : candidat.noteQcm >= 50 ? 'badge-warning' : 'badge-info'}">
                                                        ${candidat.noteQcm}%
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-info">Non noté</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <p style="color: var(--gray); text-align: center; padding: 1rem;">
                                    <i class="fas fa-info-circle"></i> Informations sur l'annonce non disponibles
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Carte Détails du candidat -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-user"></i> Détails du candidat</h3>
                    </div>
                    <div class="card-body">
                        <table class="info-table">
                            <tr>
                                <td>Nom complet :</td>
                                <td><strong>${candidat.nom} ${candidat.prenom}</strong></td>
                            </tr>
                            <tr>
                                <td>Email :</td>
                                <td>${candidat.mail}</td>
                            </tr>
                            <tr>
                                <td>Adresse :</td>
                                <td>${candidat.adresse}</td>
                            </tr>
                            <tr>
                                <td>Date de naissance :</td>
                                <td>${candidat.dateNaissance}</td>
                            </tr>
                            <tr>
                                <td>Âge :</td>
                                <td>
                                    <span class="badge badge-info">${candidat.age} ans</span>
                                </td>
                            </tr>
                            <tr>
                                <td>Diplôme :</td>
                                <td>${candidat.diplome}</td>
                            </tr>
                            <tr>
                                <td>Expérience :</td>
                                <td>
                                    <span class="badge ${candidat.anneeExperience >= 3 ? 'badge-success' : candidat.anneeExperience >= 1 ? 'badge-warning' : 'badge-info'}">
                                        ${candidat.anneeExperience} ans
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td>Département souhaité :</td>
                                <td>
                                    <span class="badge badge-info">${candidat.departement}</span>
                                </td>
                            </tr>
                            <tr>
                                <td>Date de postulation :</td>
                                <td>${candidat.datePostule}</td>
                            </tr>
                            <c:if test="${not empty candidat.renseignement}">
                                <tr>
                                    <td>Informations supplémentaires :</td>
                                    <td style="font-style: italic;">${candidat.renseignement}</td>
                                </tr>
                            </c:if>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Formulaire de renouvellement d'essai -->
            <div class="form-section">
                <div class="form-section-header">
                    <h3><i class="fas fa-sync-alt"></i> Renouvellement d'essai</h3>
                </div>
                <div class="form-section-body">
                    <form method="post" action="${pageContext.request.contextPath}/essai/renouv/valider">
                        <input type="hidden" name="idCandidat" value="${candidat.idCandidat}">
                        
                        <div class="form-group">
                            <label for="statut" class="required"><i class="fas fa-tasks"></i> Décision :</label>
                            <select id="statut" name="statut" class="form-select" required>
                                <option value="">Sélectionner</option>
                                <option value="renouveler">Renouveler l'essai</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="periode" class="required"><i class="fas fa-calendar-alt"></i> Nouvelle période :</label>
                            <select name="periode" id="periode" class="form-select" required>
                                <option value="">Sélectionner</option>
                                <option value="3">3 mois</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="salaire" class="required"><i class="fas fa-money-bill-wave"></i> Nouveau salaire :</label>
                            <input type="number" id="salaire" name="salaire" value="${candidat.salaire}" 
                                   class="form-control" placeholder="Nouveau salaire en Ariary" required min="0">
                        </div>
                        
                        <div class="form-actions">
                            <button type="button" class="btn btn-secondary" onclick="window.history.back()">
                                <i class="fas fa-times"></i>
                                Annuler
                            </button>
                            <button type="submit" class="btn btn-warning">
                                <i class="fas fa-sync-alt"></i>
                                Valider le renouvellement
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Menu responsive
        document.addEventListener('DOMContentLoaded', function() {
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