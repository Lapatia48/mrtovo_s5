<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire de Pointage - BusinessSuite RH</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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

        /* Carte du formulaire */
        .form-card {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .form-header {
            background: linear-gradient(135deg, var(--navy-blue) 0%, var(--navy-light) 100%);
            color: var(--white);
            padding: 2rem;
        }

        .form-header h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .form-header p {
            opacity: 0.9;
            margin-bottom: 0;
        }

        .type-badge {
            font-size: 1.1em;
            padding: 0.75rem 1.5rem;
            border-radius: 20px;
            font-weight: 600;
        }

        .form-body {
            padding: 2rem;
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

        .badge-danger {
            background: var(--danger);
            color: var(--white);
        }

        .badge-info {
            background: var(--info);
            color: var(--white);
        }

        .badge-primary {
            background: var(--navy-blue);
            color: var(--white);
        }

        .badge-secondary {
            background: var(--gray);
            color: var(--white);
        }

        /* Avatar */
        .avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 16px;
            color: var(--white);
            background: var(--navy-blue);
        }

        /* Formulaires */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--navy-blue);
            margin-bottom: 0.5rem;
            display: block;
        }

        .form-control, .form-select {
            padding: 0.75rem;
            border: 1px solid var(--gray-light);
            border-radius: var(--border-radius);
            font-size: 0.875rem;
            transition: var(--transition);
            background: var(--white);
            width: 100%;
        }

        .form-control:focus, .form-select:focus {
            outline: none;
            border-color: var(--navy-blue);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .input-group {
            display: flex;
            align-items: stretch;
        }

        .input-group .form-control {
            flex: 1;
        }

        .input-group-text {
            background: var(--gray-lighter);
            border: 1px solid var(--gray-light);
            padding: 0.75rem 1rem;
            color: var(--gray);
            font-size: 0.875rem;
        }

        /* Alertes */
        .alert {
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-info {
            background: rgba(13, 202, 240, 0.1);
            border: 1px solid rgba(13, 202, 240, 0.2);
            color: var(--info);
        }

        .alert-warning {
            background: rgba(255, 193, 7, 0.1);
            border: 1px solid rgba(255, 193, 7, 0.2);
            color: var(--warning);
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

        /* Form Check */
        .form-check {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
        }

        .form-check-input {
            margin-right: 0.5rem;
        }

        .form-check-label {
            font-weight: 500;
        }

        .form-check-inline {
            display: inline-flex;
            margin-right: 1rem;
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
            .form-body {
                padding: 1.5rem;
            }
            .form-header {
                padding: 1.5rem;
            }
        }

        @media (max-width: 576px) {
            .form-header .d-flex {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar Navigation -->
        <jsp:include page="sidebarRh.jsp" />

        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Formulaire de Pointage</h2>
                    <p>Gestion des absences, retards et présences</p>
                </div>
                <div class="user-menu">
                    <a href="${pageContext.request.contextPath}/rh/conge/pointage" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Retour
                    </a>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <!-- Carte du formulaire -->
                    <div class="form-card">
                        <!-- En-tête avec infos employé -->
                        <div class="form-header">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h3>
                                        <c:choose>
                                            <c:when test="${typeEvenement == 'absence'}">
                                                <i class="fas fa-file-contract me-2"></i>Déclarer une Absence
                                            </c:when>
                                            <c:when test="${typeEvenement == 'retard'}">
                                                <i class="fas fa-clock me-2"></i>Déclarer un Retard
                                            </c:when>
                                            <c:when test="${typeEvenement == 'maladie'}">
                                                <i class="fas fa-head-side-cough me-2"></i>Déclarer une Maladie
                                            </c:when>
                                            <c:when test="${typeEvenement == 'mission'}">
                                                <i class="fas fa-briefcase me-2"></i>Déclarer une Mission/Formation
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-clipboard-check me-2"></i>Pointage
                                            </c:otherwise>
                                        </c:choose>
                                    </h3>
                                    <p>Formulaire de pointage</p>
                                </div>
                                <span class="type-badge 
                                    <c:choose>
                                        <c:when test="${typeEvenement == 'absence'}">badge-primary</c:when>
                                        <c:when test="${typeEvenement == 'retard'}">badge-warning</c:when>
                                        <c:when test="${typeEvenement == 'maladie'}">badge-danger</c:when>
                                        <c:when test="${typeEvenement == 'mission'}">badge-info</c:when>
                                        <c:otherwise>badge-secondary</c:otherwise>
                                    </c:choose>">
                                    ${typeEvenement}
                                </span>
                            </div>
                        </div>

                        <div class="form-body">
                            <!-- Informations employé -->
                            <div class="form-group">
                                <h5 class="form-label">Employé concerné</h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar me-3">
                                                <c:choose>
                                                    <c:when test="${not empty employe.prenom and not empty employe.nom}">
                                                        ${employe.prenom.charAt(0)}${employe.nom.charAt(0)}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ??
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <strong class="fs-5">
                                                    <c:choose>
                                                        <c:when test="${not empty employe.prenom and not empty employe.nom}">
                                                            ${employe.prenom} ${employe.nom}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Non renseigné</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </strong>
                                                <br>
                                                <span class="text-muted">
                                                    ${employe.departement} • ${employe.poste}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="form-label">Soldes actuels</h6>
                                        <div class="d-flex gap-2">
                                            <span class="badge badge-primary">
                                                ${employe.soldeAnnuelActuel}j annuel
                                            </span>
                                            <span class="badge badge-warning">
                                                ${employe.soldeExceptionnelActuel}j exceptionnel
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <form action="${pageContext.request.contextPath}/rh/conge/pointage/sauvegarder" method="post">
                                <!-- Champs cachés -->
                                <input type="hidden" name="employeId" value="${employe.id}">
                                <input type="hidden" name="typeEvenement" value="${typeEvenement}">

                                <!-- Section dynamique selon le type -->
                                <div class="form-group">
                                    <c:choose>
                                        <c:when test="${typeEvenement == 'absence'}">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label class="form-label">Type d'absence</label>
                                                    <div>
                                                        <div class="form-check form-check-inline">
                                                            <input class="form-check-input" type="radio" name="sousType" id="justifiee" value="justifiee" checked>
                                                            <label class="form-check-label" for="justifiee">Justifiée</label>
                                                        </div>
                                                        <div class="form-check form-check-inline">
                                                            <input class="form-check-input" type="radio" name="sousType" id="nonJustifiee" value="non_justifiee">
                                                            <label class="form-check-label" for="nonJustifiee">Non justifiée</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">Durée</label>
                                                    <div class="input-group">
                                                        <input type="number" class="form-control" name="dureeJours" step="0.5" min="0.5" max="30" value="1.0" required>
                                                        <span class="input-group-text">jour(s)</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:when>

                                        <c:when test="${typeEvenement == 'retard'}">
                                            <input type="hidden" name="sousType" value="retard_simple">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label class="form-label">Durée du retard</label>
                                                    <div class="row g-2">
                                                        <div class="col-6">
                                                            <div class="input-group">
                                                                <input type="number" class="form-control" name="heuresRetard" min="0" max="8" value="0">
                                                                <span class="input-group-text">h</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="input-group">
                                                                <input type="number" class="form-control" name="minutesRetard" min="0" max="59" value="0">
                                                                <span class="input-group-text">min</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <small class="text-muted">1 heure = 0.125 jour de quota exceptionnel</small>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="alert alert-info">
                                                        <i class="fas fa-info-circle me-2"></i>
                                                        <strong>Impact calculé :</strong>
                                                        <span id="impactRetard">0 jour</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:when>

                                        <c:when test="${typeEvenement == 'maladie'}">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label class="form-label">Avec certificat médical ?</label>
                                                    <div>
                                                        <div class="form-check form-check-inline">
                                                            <input class="form-check-input" type="radio" name="sousType" id="avecCertificat" value="avec_certificat" checked>
                                                            <label class="form-check-label" for="avecCertificat">Avec certificat</label>
                                                        </div>
                                                        <div class="form-check form-check-inline">
                                                            <input class="form-check-input" type="radio" name="sousType" id="sansCertificat" value="sans_certificat">
                                                            <label class="form-check-label" for="sansCertificat">Sans certificat</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">Durée</label>
                                                    <div class="input-group">
                                                        <input type="number" class="form-control" name="dureeJours" step="0.5" min="0.5" max="30" value="1.0" required>
                                                        <span class="input-group-text">jour(s)</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:when>

                                        <c:when test="${typeEvenement == 'mission'}">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label class="form-label">Type</label>
                                                    <div>
                                                        <div class="form-check form-check-inline">
                                                            <input class="form-check-input" type="radio" name="sousType" id="mission" value="mission" checked>
                                                            <label class="form-check-label" for="mission">Mission</label>
                                                        </div>
                                                        <div class="form-check form-check-inline">
                                                            <input class="form-check-input" type="radio" name="sousType" id="formation" value="formation">
                                                            <label class="form-check-label" for="formation">Formation</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">Durée</label>
                                                    <div class="input-group">
                                                        <input type="number" class="form-control" name="dureeJours" step="0.5" min="0.5" max="30" value="1.0" required>
                                                        <span class="input-group-text">jour(s)</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </div>

                                <!-- Champs communs à tous les types -->
                                <div class="row form-group">
                                    <div class="col-md-6">
                                        <label class="form-label">Date de l'événement</label>
                                        <input type="date" class="form-control" name="dateEvenement" 
                                               value="${aujourdhui}" max="${aujourdhui}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Impact estimé</label>
                                        <div class="alert alert-warning">
                                            <i class="fas fa-calculator me-2"></i>
                                            <span id="impactEstime">Calcul en cours...</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Motif</label>
                                    <textarea class="form-control" name="motif" rows="3" 
                                              placeholder="Décrivez la raison de ce pointage..." required></textarea>
                                </div>

                                <!-- Boutons d'action -->
                                <div class="d-flex justify-content-between pt-3">
                                    <a href="${pageContext.request.contextPath}/rh/conge/pointage" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left me-2"></i>Retour
                                    </a>
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-save me-2"></i>Enregistrer le pointage
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Calcul automatique de l'impact pour les retards
        function calculerImpactRetard() {
            const heures = parseInt(document.querySelector('input[name="heuresRetard"]').value) || 0;
            const minutes = parseInt(document.querySelector('input[name="minutesRetard"]').value) || 0;
            
            const totalMinutes = (heures * 60) + minutes;
            const impactJours = (totalMinutes / 60) * 0.125; // 1h = 0.125 jour
            
            document.getElementById('impactRetard').textContent = impactJours.toFixed(3) + ' jour';
            document.getElementById('impactEstime').textContent = 
                impactJours.toFixed(3) + ' jour sur quota exceptionnel';
        }

        // Calcul pour les autres types
        function calculerImpactGeneral() {
            const dureeInput = document.querySelector('input[name="dureeJours"]');
            if (dureeInput) {
                const duree = parseFloat(dureeInput.value) || 0;
                const typeEvenement = '${typeEvenement}';
                
                let impactText = '';
                switch(typeEvenement) {
                    case 'absence':
                        impactText = duree + ' jour sur quota annuel';
                        break;
                    case 'maladie':
                        impactText = duree + ' jour sur quota exceptionnel';
                        break;
                    case 'mission':
                        impactText = duree + ' jour (non déduit)';
                        break;
                    default:
                        impactText = 'Calculé automatiquement';
                }
                
                document.getElementById('impactEstime').textContent = impactText;
            }
        }

        // Écouter les changements
        document.addEventListener('DOMContentLoaded', function() {
            // Pour les retards
            const heuresInput = document.querySelector('input[name="heuresRetard"]');
            const minutesInput = document.querySelector('input[name="minutesRetard"]');
            
            if (heuresInput && minutesInput) {
                heuresInput.addEventListener('input', calculerImpactRetard);
                minutesInput.addEventListener('input', calculerImpactRetard);
                calculerImpactRetard(); // Calcul initial
            }

            // Pour les autres types
            const dureeInput = document.querySelector('input[name="dureeJours"]');
            if (dureeInput) {
                dureeInput.addEventListener('input', calculerImpactGeneral);
                calculerImpactGeneral(); // Calcul initial
            }

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