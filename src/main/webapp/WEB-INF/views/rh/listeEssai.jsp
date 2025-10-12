<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Période d'Essai - BusinessSuite RH</title>
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

        /* Message de succès */
        .success-message {
            background: var(--success);
            color: var(--white);
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 2rem;
            box-shadow: var(--box-shadow);
        }

        /* Section Filtres */
        .filter-section {
            background: var(--white);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-bottom: 2rem;
        }

        .filter-section h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--navy-blue);
            margin-bottom: 1rem;
        }

        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .filter-group label {
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--navy-blue);
        }

        .filter-input, .filter-select {
            padding: 0.75rem;
            border: 1px solid var(--gray-light);
            border-radius: var(--border-radius);
            font-size: 0.875rem;
            transition: var(--transition);
            background: var(--white);
        }

        .filter-input:focus, .filter-select:focus {
            outline: none;
            border-color: var(--navy-blue);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .global-search {
            grid-column: 1 / -1;
        }

        .global-search input {
            width: 100%;
            padding: 0.875rem;
            font-size: 0.9rem;
        }

        .filter-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--gray-light);
        }

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

        /* Tableau des candidats en essai */
        .table-container {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
        }

        .table-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--gray-light);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--navy-blue);
        }

        .table-count {
            color: var(--gray);
            font-size: 0.875rem;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.875rem;
        }

        .data-table th {
            background: var(--gray-lighter);
            color: var(--navy-blue);
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            border-bottom: 1px solid var(--gray-light);
            cursor: pointer;
            user-select: none;
            transition: var(--transition);
        }

        .data-table th:hover {
            background: var(--gray-light);
        }

        .data-table th i {
            margin-left: 0.5rem;
            opacity: 0.5;
        }

        .data-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .data-table tbody tr:hover {
            background: var(--gray-lighter);
        }

        .data-table tbody tr:last-child td {
            border-bottom: none;
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

        /* Actions */
        .actions-cell {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .action-link {
            color: var(--navy-blue);
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 0.75rem;
            border-radius: var(--border-radius);
            transition: var(--transition);
            border: 1px solid transparent;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.8rem;
            white-space: nowrap;
        }

        .action-link:hover {
            background: var(--navy-blue);
            color: var(--white);
            border-color: var(--navy-blue);
        }

        .action-link.success {
            background: var(--success);
            color: var(--white);
            border-color: var(--success);
        }

        .action-link.success:hover {
            background: #157347;
            border-color: #157347;
        }

        .action-link.warning {
            background: var(--warning);
            color: var(--navy-blue);
            border-color: var(--warning);
        }

        .action-link.warning:hover {
            background: #ffca2c;
            border-color: #ffca2c;
        }

        .action-link.danger {
            background: var(--danger);
            color: var(--white);
            border-color: var(--danger);
        }

        .action-link.danger:hover {
            background: #bb2d3b;
            border-color: #bb2d3b;
        }

        /* Message aucun résultat */
        .no-results {
            text-align: center;
            padding: 3rem;
            color: var(--gray);
        }

        .no-results i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
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
            .filter-grid {
                grid-template-columns: 1fr;
            }
            .actions-cell {
                flex-direction: column;
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
            .table-container {
                overflow-x: auto;
            }
            .data-table {
                min-width: 1400px;
            }
            .filter-actions {
                flex-direction: column;
            }
        }

        @media (max-width: 576px) {
            .table-header {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
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
                    <a href="${pageContext.request.contextPath}/rh/essai" class="nav-link active">
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
                    <h2>Période d'Essai</h2>
                    <p>Gestion des candidats en cours d'évaluation</p>
                </div>
                <div class="user-menu">
                    <a href="${pageContext.request.contextPath}/accueilRh" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Retour au Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i>
                        Déconnexion
                    </a>
                </div>
            </div>

            <!-- Message de succès -->
            <c:if test="${not empty success}">
                <div class="success-message">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>

            <!-- Section Filtres -->
            <div class="filter-section">
                <h3><i class="fas fa-filter"></i> Filtres des candidats en essai</h3>
                
                <div class="filter-grid">
                    <div class="filter-group global-search">
                        <label for="globalSearch">Recherche globale</label>
                        <input type="text" id="globalSearch" class="filter-input" placeholder="Rechercher dans tous les champs...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="nomFilter">Nom</label>
                        <input type="text" id="nomFilter" class="filter-input" placeholder="Filtrer par nom...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="prenomFilter">Prénom</label>
                        <input type="text" id="prenomFilter" class="filter-input" placeholder="Filtrer par prénom...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="emailFilter">Email</label>
                        <input type="text" id="emailFilter" class="filter-input" placeholder="Filtrer par email...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="departementFilter">Département</label>
                        <input type="text" id="departementFilter" class="filter-input" placeholder="Filtrer par département...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="diplomeFilter">Diplôme</label>
                        <input type="text" id="diplomeFilter" class="filter-input" placeholder="Filtrer par diplôme...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="annonceFilter">Annonce</label>
                        <input type="text" id="annonceFilter" class="filter-input" placeholder="Filtrer par annonce...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="ageFilter">Âge</label>
                        <select id="ageFilter" class="filter-select">
                            <option value="">Tous les âges</option>
                            <option value="18">18+ ans</option>
                            <option value="18-35">18 à 35 ans</option>
                            <option value="35">35+ ans</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="experienceFilter">Expérience</label>
                        <select id="experienceFilter" class="filter-select">
                            <option value="">Toutes les expériences</option>
                            <option value="0">0 an</option>
                            <option value="1">1+ an</option>
                            <option value="2">2+ ans</option>
                            <option value="3">3+ ans</option>
                            <option value="4">4+ ans</option>
                            <option value="5">5+ ans</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="periodeFilter">Période d'essai</label>
                        <select id="periodeFilter" class="filter-select">
                            <option value="">Toutes les périodes</option>
                            <option value="3">3 mois</option>
                            <option value="6">6 mois</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="salaireFilter">Salaire minimum</label>
                        <select id="salaireFilter" class="filter-select">
                            <option value="">Tous les salaires</option>
                            <option value="500000">500,000 Ar+</option>
                            <option value="1000000">1,000,000 Ar+</option>
                            <option value="1500000">1,500,000 Ar+</option>
                            <option value="2000000">2,000,000 Ar+</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="noteQcmFilter">Note QCM</label>
                        <select id="noteQcmFilter" class="filter-select">
                            <option value="">Toutes les notes</option>
                            <option value="50-">Moins de 50%</option>
                            <option value="50+">50% et plus</option>
                            <option value="75+">75% et plus</option>
                            <option value="100">100%</option>
                            <option value="non-note">Non noté</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="dateSort">Tri par date</label>
                        <select id="dateSort" class="filter-select">
                            <option value="">Ordre par défaut</option>
                            <option value="asc">Date croissante</option>
                            <option value="desc">Date décroissante</option>
                        </select>
                    </div>
                </div>
                
                <div class="filter-actions">
                    <button onclick="resetFilters()" class="btn btn-secondary">
                        <i class="fas fa-undo"></i>
                        Réinitialiser
                    </button>
                </div>
            </div>

            <!-- Tableau des candidats en essai -->
            <div class="table-container">
                <div class="table-header">
                    <h3>Liste des candidats en période d'essai</h3>
                    <div class="table-count" id="resultCount">
                        ${essaiDetails.size()} candidat(s) en essai
                    </div>
                </div>
                
                <table class="data-table" id="candidatsTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable(0)">Nom <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(1)">Prénom <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(2)">Email <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(3)">Âge <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(4)">Expérience <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(5)">Diplôme <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(6)">Département <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(7)">Poste <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(8)">Note QCM <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(9)">Salaire <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(10)">Période <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(11)">Date postulation <i class="fas fa-sort"></i></th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="candidatsBody">
                        <c:forEach var="e" items="${essaiDetails}">
                            <tr>
                                <td><strong>${e.nom}</strong></td>
                                <td>${e.prenom}</td>
                                <td>${e.mail}</td>
                                <td>
                                    <span class="badge badge-info">${e.age} ans</span>
                                </td>
                                <td>
                                    <span class="badge ${e.anneeExperience >= 3 ? 'badge-success' : e.anneeExperience >= 1 ? 'badge-warning' : 'badge-info'}">
                                        ${e.anneeExperience} ans
                                    </span>
                                </td>
                                <td>${e.diplome}</td>
                                <td>${e.departement}</td>
                                <td>
                                    <span class="badge badge-primary">${e.annoncePostulee}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${e.noteQcm != null}">
                                            <span class="badge ${e.noteQcm >= 75 ? 'badge-success' : e.noteQcm >= 50 ? 'badge-warning' : 'badge-danger'}">
                                                ${e.noteQcm}%
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-info">Non noté</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <strong>${e.salaire} Ar</strong>
                                </td>
                                <td>
                                    <span class="badge ${e.periode == 3 ? 'badge-warning' : 'badge-info'}">
                                        ${e.periode} mois
                                    </span>
                                </td>
                                <td>${e.datePostule}</td>
                                <td class="actions-cell">
                                    <a href="${pageContext.request.contextPath}/rh/candidats/pdf?id_cand=${e.idCandidat}" class="action-link" title="Exporter en PDF">
                                        <i class="fas fa-file-pdf"></i>
                                        PDF
                                    </a>
                                    <a href="${pageContext.request.contextPath}/essai/embauche?id_cand=${e.idCandidat}" class="action-link success" title="Embaucher définitivement">
                                        <i class="fas fa-user-check"></i>
                                        Embaucher
                                    </a>
                                    <a href="${pageContext.request.contextPath}/essai/renouv?id_cand=${e.idCandidat}" class="action-link warning" title="Renouveler la période d'essai">
                                        <i class="fas fa-sync-alt"></i>
                                        Renouveler
                                    </a>
                                    <a href="${pageContext.request.contextPath}/essai/refuse?id_cand=${e.idCandidat}" class="action-link danger" title="Refuser le candidat">
                                        <i class="fas fa-user-times"></i>
                                        Refuser
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div id="noResults" class="no-results" style="display: none;">
                    <i class="fas fa-search"></i>
                    <h3>Aucun candidat en période d'essai trouvé</h3>
                    <p>Aucun candidat ne correspond aux critères de recherche sélectionnés.</p>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Le script JavaScript adapté pour les candidats en essai
        let currentSortColumn = -1;
        let sortDirection = 1;

        // Écouteurs d'événements pour les filtres
        document.getElementById('globalSearch').addEventListener('input', filterTable);
        document.getElementById('nomFilter').addEventListener('input', filterTable);
        document.getElementById('prenomFilter').addEventListener('input', filterTable);
        document.getElementById('emailFilter').addEventListener('input', filterTable);
        document.getElementById('departementFilter').addEventListener('input', filterTable);
        document.getElementById('diplomeFilter').addEventListener('input', filterTable);
        document.getElementById('annonceFilter').addEventListener('input', filterTable);
        document.getElementById('ageFilter').addEventListener('change', filterTable);
        document.getElementById('experienceFilter').addEventListener('change', filterTable);
        document.getElementById('periodeFilter').addEventListener('change', filterTable);
        document.getElementById('salaireFilter').addEventListener('change', filterTable);
        document.getElementById('noteQcmFilter').addEventListener('change', filterTable);
        document.getElementById('dateSort').addEventListener('change', applySorting);

        function filterTable() {
            const globalSearch = document.getElementById('globalSearch').value.toLowerCase();
            const nomFilter = document.getElementById('nomFilter').value.toLowerCase();
            const prenomFilter = document.getElementById('prenomFilter').value.toLowerCase();
            const emailFilter = document.getElementById('emailFilter').value.toLowerCase();
            const departementFilter = document.getElementById('departementFilter').value.toLowerCase();
            const diplomeFilter = document.getElementById('diplomeFilter').value.toLowerCase();
            const annonceFilter = document.getElementById('annonceFilter').value.toLowerCase();
            const ageFilter = document.getElementById('ageFilter').value;
            const experienceFilter = document.getElementById('experienceFilter').value;
            const periodeFilter = document.getElementById('periodeFilter').value;
            const salaireFilter = document.getElementById('salaireFilter').value;
            const noteQcmFilter = document.getElementById('noteQcmFilter').value;

            const rows = document.querySelectorAll('#candidatsBody tr');
            let visibleCount = 0;

            rows.forEach(row => {
                const cells = row.getElementsByTagName('td');
                let showRow = true;

                // Filtre global
                if (globalSearch) {
                    let rowText = '';
                    for (let i = 0; i < cells.length - 1; i++) { // -1 pour exclure la colonne Actions
                        rowText += cells[i].textContent.toLowerCase() + ' ';
                    }
                    if (!rowText.includes(globalSearch)) {
                        showRow = false;
                    }
                }

                // Filtres individuels
                if (showRow && nomFilter && !cells[0].textContent.toLowerCase().includes(nomFilter)) {
                    showRow = false;
                }
                if (showRow && prenomFilter && !cells[1].textContent.toLowerCase().includes(prenomFilter)) {
                    showRow = false;
                }
                if (showRow && emailFilter && !cells[2].textContent.toLowerCase().includes(emailFilter)) {
                    showRow = false;
                }
                if (showRow && departementFilter && !cells[6].textContent.toLowerCase().includes(departementFilter)) {
                    showRow = false;
                }
                if (showRow && diplomeFilter && !cells[5].textContent.toLowerCase().includes(diplomeFilter)) {
                    showRow = false;
                }
                if (showRow && annonceFilter && !cells[7].textContent.toLowerCase().includes(annonceFilter)) {
                    showRow = false;
                }

                // Filtre par âge
                if (showRow && ageFilter !== '') {
                    const ageCell = cells[3].textContent;
                    const ageMatch = ageCell.match(/(\d+)/);
                    if (ageMatch) {
                        const age = parseInt(ageMatch[1]);
                        
                        if (ageFilter === '18') {
                            if (age < 18) showRow = false;
                        } else if (ageFilter === '18-35') {
                            if (age < 18 || age > 35) showRow = false;
                        } else if (ageFilter === '35') {
                            if (age < 35) showRow = false;
                        }
                    } else {
                        showRow = false;
                    }
                }

                // Filtre par expérience
                if (showRow && experienceFilter !== '') {
                    const expCell = cells[4].textContent;
                    const expMatch = expCell.match(/(\d+)/);
                    if (expMatch) {
                        const experience = parseInt(expMatch[1]);
                        const minExperience = parseInt(experienceFilter);
                        
                        if (experience < minExperience) {
                            showRow = false;
                        }
                    } else {
                        showRow = false;
                    }
                }

                // Filtre par période d'essai
                if (showRow && periodeFilter !== '') {
                    const periodeCell = cells[10].textContent;
                    const periodeMatch = periodeCell.match(/(\d+)/);
                    if (periodeMatch) {
                        const periode = parseInt(periodeMatch[1]);
                        if (periode !== parseInt(periodeFilter)) {
                            showRow = false;
                        }
                    } else {
                        showRow = false;
                    }
                }

                // Filtre par salaire minimum
                if (showRow && salaireFilter !== '') {
                    const salaireCell = cells[9].textContent;
                    const salaireMatch = salaireCell.match(/(\d+)/);
                    if (salaireMatch) {
                        const salaire = parseInt(salaireMatch[1].replace(/,/g, ''));
                        const minSalaire = parseInt(salaireFilter);
                        
                        if (salaire < minSalaire) {
                            showRow = false;
                        }
                    } else {
                        showRow = false;
                    }
                }

                // Filtre par note QCM
                if (showRow && noteQcmFilter !== '') {
                    const noteQcmCell = cells[8].textContent.trim();
                    
                    if (noteQcmFilter === "non-note") {
                        if (!noteQcmCell.includes("Non noté")) {
                            showRow = false;
                        }
                    } 
                    else if (noteQcmCell !== "Non noté") {
                        const noteMatch = noteQcmCell.match(/(\d+)%/);
                        if (noteMatch) {
                            const note = parseInt(noteMatch[1]);
                            
                            switch(noteQcmFilter) {
                                case "50-":
                                    if (note >= 50) showRow = false;
                                    break;
                                case "50+":
                                    if (note < 50) showRow = false;
                                    break;
                                case "75+":
                                    if (note < 75) showRow = false;
                                    break;
                                case "100":
                                    if (note !== 100) showRow = false;
                                    break;
                            }
                        }
                    } else {
                        showRow = false;
                    }
                }

                row.style.display = showRow ? '' : 'none';
                if (showRow) visibleCount++;
            });

            // Mettre à jour le compteur
            document.getElementById('resultCount').textContent = visibleCount + ' candidat(s) en essai';
            
            // Afficher/masquer le message "Aucun résultat"
            document.getElementById('noResults').style.display = visibleCount === 0 ? 'block' : 'none';
        }

        function applySorting() {
            const dateSort = document.getElementById('dateSort').value;
            if (dateSort) {
                sortTableByColumn(11, dateSort);
            }
        }

        function sortTable(columnIndex) {
            const sortOrder = sortDirection === 1 ? 'asc' : 'desc';
            sortTableByColumn(columnIndex, sortOrder);
            
            // Inverser la direction pour le prochain clic
            sortDirection = -sortDirection;
        }

        function sortTableByColumn(columnIndex, order) {
            const tbody = document.getElementById('candidatsBody');
            const rows = Array.from(tbody.getElementsByTagName('tr'));

            rows.sort((a, b) => {
                const aCell = a.getElementsByTagName('td')[columnIndex].textContent;
                const bCell = b.getElementsByTagName('td')[columnIndex].textContent;

                let aValue, bValue;

                // Gestion spéciale pour les colonnes numériques
                if (columnIndex === 3 || columnIndex === 4 || columnIndex === 8 || columnIndex === 9 || columnIndex === 10) { 
                    // Âge, Expérience, Note QCM, Salaire, Période
                    aValue = extractNumber(aCell);
                    bValue = extractNumber(bCell);
                } else if (columnIndex === 11) { // Date
                    aValue = new Date(aCell);
                    bValue = new Date(bCell);
                } else {
                    aValue = aCell.toLowerCase();
                    bValue = bCell.toLowerCase();
                }

                let result = 0;
                if (aValue < bValue) result = -1;
                if (aValue > bValue) result = 1;

                return order === 'desc' ? -result : result;
            });

            // Réinsérer les lignes triées
            rows.forEach(row => tbody.appendChild(row));

            // Mettre à jour les indicateurs de tri
            updateSortIndicators(columnIndex, order);
        }

        function extractNumber(text) {
            // Essayer d'extraire un pourcentage d'abord
            const percentMatch = text.match(/(\d+)%/);
            if (percentMatch) {
                return parseInt(percentMatch[1]);
            }
            
            // Sinon, chercher un nombre simple
            const match = text.match(/(\d+)/);
            return match ? parseInt(match[1]) : 0;
        }

        function updateSortIndicators(columnIndex, order) {
            const headers = document.querySelectorAll('#candidatsTable th');
            headers.forEach((header, index) => {
                header.innerHTML = header.innerHTML.replace(/<i class="fas fa-sort-(up|down)"><\/i>/, '') + '<i class="fas fa-sort"></i>';
                if (index === columnIndex) {
                    header.innerHTML = header.innerHTML.replace('<i class="fas fa-sort"></i>', 
                        order === 'asc' ? '<i class="fas fa-sort-up"></i>' : '<i class="fas fa-sort-down"></i>');
                }
            });
        }

        function resetFilters() {
            document.getElementById('globalSearch').value = '';
            document.getElementById('nomFilter').value = '';
            document.getElementById('prenomFilter').value = '';
            document.getElementById('emailFilter').value = '';
            document.getElementById('departementFilter').value = '';
            document.getElementById('diplomeFilter').value = '';
            document.getElementById('annonceFilter').value = '';
            document.getElementById('ageFilter').value = '';
            document.getElementById('experienceFilter').value = '';
            document.getElementById('periodeFilter').value = '';
            document.getElementById('salaireFilter').value = '';
            document.getElementById('noteQcmFilter').value = '';
            document.getElementById('dateSort').value = '';
            
            filterTable();
        }

        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            filterTable();
            
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