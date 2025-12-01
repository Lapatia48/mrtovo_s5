<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Scoring des Employés - BusinessSuite RH</title>
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

        .btn-success {
            background: var(--success);
            color: var(--white);
        }

        .btn-success:hover {
            background: #157347;
        }

        /* Tableau des évaluations */
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

        /* Badges pour les notes */
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

        .badge-note {
            font-size: 0.875rem;
            padding: 0.5rem 1rem;
            font-weight: 700;
        }

        /* Étoiles pour les notes */
        .stars {
            color: #FFD700;
            font-size: 1.1rem;
            letter-spacing: 2px;
        }

        /* Actions */
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

        /* Indicateurs de performance */
        .performance-indicator {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.25rem 0.75rem;
            border-radius: var(--border-radius);
            font-size: 0.75rem;
            font-weight: 600;
        }

        .performance-excellent {
            background: rgba(25, 135, 84, 0.1);
            color: var(--success);
            border: 1px solid rgba(25, 135, 84, 0.2);
        }

        .performance-good {
            background: rgba(255, 193, 7, 0.1);
            color: #e6a700;
            border: 1px solid rgba(255, 193, 7, 0.2);
        }

        .performance-average {
            background: rgba(13, 202, 240, 0.1);
            color: var(--info);
            border: 1px solid rgba(13, 202, 240, 0.2);
        }

        .performance-poor {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger);
            border: 1px solid rgba(220, 53, 69, 0.2);
        }

        /* Statistiques */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            text-align: center;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--navy-blue);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            font-size: 0.875rem;
            color: var(--gray);
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
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
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
                min-width: 800px;
            }
            .filter-actions {
                flex-direction: column;
            }
            .stats-grid {
                grid-template-columns: 1fr;
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
        <jsp:include page="../sidebar/sidebarRh.jsp" />

        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Rapport d'Évaluation des Employés</h2>
                    <p>Suivi des performances et scoring mensuel des collaborateurs</p>
                </div>
                <div class="user-menu">
                    <a href="${pageContext.request.contextPath}/rh/employe" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Retour aux employés
                    </a>
                    <a href="${pageContext.request.contextPath}/accueilRh" class="btn btn-secondary">
                        <i class="fas fa-home"></i>
                        Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i>
                        Déconnexion
                    </a>
                </div>
            </div>

            <!-- Statistiques -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-value" id="totalEvaluations">${evaluations.size()}</div>
                    <div class="stat-label">Évaluations totales</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value" id="avgScore">0.0</div>
                    <div class="stat-label">Note moyenne</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value" id="excellentCount">0</div>
                    <div class="stat-label">Excellent</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value" id="goodCount">0</div>
                    <div class="stat-label">Bonnes performances</div>
                </div>
            </div>

            <!-- Section Filtres -->
            <div class="filter-section">
                <h3><i class="fas fa-filter"></i> Filtres des évaluations</h3>
                
                <div class="filter-grid">
                    <div class="filter-group global-search">
                        <label for="globalSearch">Recherche globale</label>
                        <input type="text" id="globalSearch" class="filter-input" placeholder="Rechercher dans tous les champs...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="nomFilter">Nom de l'employé</label>
                        <input type="text" id="nomFilter" class="filter-input" placeholder="Filtrer par nom...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="prenomFilter">Prénom de l'employé</label>
                        <input type="text" id="prenomFilter" class="filter-input" placeholder="Filtrer par prénom...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="moisFilter">Mois</label>
                        <select id="moisFilter" class="filter-select">
                            <option value="">Tous les mois</option>
                            <option value="Janvier">Janvier</option>
                            <option value="Février">Février</option>
                            <option value="Mars">Mars</option>
                            <option value="Avril">Avril</option>
                            <option value="Mai">Mai</option>
                            <option value="Juin">Juin</option>
                            <option value="Juillet">Juillet</option>
                            <option value="Août">Août</option>
                            <option value="Septembre">Septembre</option>
                            <option value="Octobre">Octobre</option>
                            <option value="Novembre">Novembre</option>
                            <option value="Décembre">Décembre</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="anneeFilter">Année</label>
                        <select id="anneeFilter" class="filter-select">
                            <option value="">Toutes les années</option>
                            <c:forEach var="year" begin="2020" end="2030">
                                <option value="${year}">${year}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="noteFilter">Note minimum</label>
                        <select id="noteFilter" class="filter-select">
                            <option value="">Toutes les notes</option>
                            <option value="1">1+</option>
                            <option value="2">2+</option>
                            <option value="3">3+</option>
                            <option value="4">4+</option>
                            <option value="5">5</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="performanceFilter">Niveau de performance</label>
                        <select id="performanceFilter" class="filter-select">
                            <option value="">Tous les niveaux</option>
                            <option value="excellent">Excellent (5)</option>
                            <option value="bon">Bon (4)</option>
                            <option value="moyen">Moyen (3)</option>
                            <option value="passable">Passable (2)</option>
                            <option value="insuffisant">Insuffisant (1)</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="noteSort">Trier par note</label>
                        <select id="noteSort" class="filter-select">
                            <option value="">Ordre par défaut</option>
                            <option value="desc">Note décroissante</option>
                            <option value="asc">Note croissante</option>
                        </select>
                    </div>
                </div>
                
                <div class="filter-actions">
                    <button onclick="resetFilters()" class="btn btn-secondary">
                        <i class="fas fa-undo"></i>
                        Réinitialiser
                    </button>
                    <button onclick="exportToCSV()" class="btn btn-success">
                        <i class="fas fa-file-export"></i>
                        Exporter en CSV
                    </button>
                </div>
            </div>

            <!-- Tableau des évaluations -->
            <div class="table-container">
                <div class="table-header">
                    <h3>Détail des évaluations</h3>
                    <div class="table-count" id="resultCount">
                        ${evaluations.size()} évaluation(s) trouvée(s)
                    </div>
                </div>
                
                <table class="data-table" id="evaluationsTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable(0)">Employé <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(1)">Mois <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(2)">Année <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(3)">Note <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(4)">Performance <i class="fas fa-sort"></i></th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="evaluationsBody">
                        <c:forEach var="e" items="${evaluations}">
                            <tr>
                                <td>
                                    <strong>${e.employe.nom} ${e.employe.prenom}</strong><br>
                                    <small style="color: var(--gray);">${e.employe.poste}</small>
                                </td>
                                <td>
                                    <span class="badge badge-info">${e.mois}</span>
                                </td>
                                <td>
                                    <strong>${e.annee}</strong>
                                </td>
                                <td>
                                    <div class="stars">
                                        <c:forEach begin="1" end="${e.note}">
                                            ⭐
                                        </c:forEach>
                                    </div>
                                    <span class="badge badge-note ${e.note >= 4.5 ? 'badge-success' : e.note >= 3.5 ? 'badge-warning' : e.note >= 2.5 ? 'badge-info' : 'badge-danger'}">
                                        ${e.note}/5
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${e.note >= 4.5}">
                                            <span class="performance-indicator performance-excellent">
                                                <i class="fas fa-trophy"></i> Excellent
                                            </span>
                                        </c:when>
                                        <c:when test="${e.note >= 3.5}">
                                            <span class="performance-indicator performance-good">
                                                <i class="fas fa-star"></i> Bon
                                            </span>
                                        </c:when>
                                        <c:when test="${e.note >= 2.5}">
                                            <span class="performance-indicator performance-average">
                                                <i class="fas fa-chart-line"></i> Moyen
                                            </span>
                                        </c:when>
                                        <c:when test="${e.note >= 1.5}">
                                            <span class="performance-indicator performance-poor">
                                                <i class="fas fa-exclamation-triangle"></i> Passable
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="performance-indicator performance-poor">
                                                <i class="fas fa-times-circle"></i> Insuffisant
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div id="noResults" class="no-results" style="display: none;">
                    <i class="fas fa-search"></i>
                    <h3>Aucune évaluation trouvée</h3>
                    <p>Aucune évaluation ne correspond aux critères de recherche sélectionnés.</p>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Variables globales
        let currentSortColumn = -1;
        let sortDirection = 1;
        let allEvaluations = [];

        // Initialiser les statistiques
        function initializeStats() {
            const rows = document.querySelectorAll('#evaluationsBody tr');
            let totalScore = 0;
            let excellentCount = 0;
            let goodCount = 0;
            let averageCount = 0;
            let poorCount = 0;

            rows.forEach(row => {
                const noteText = row.cells[3].querySelector('.badge-note').textContent;
                const note = parseFloat(noteText.split('/')[0]);
                totalScore += note;

                if (note >= 4.5) excellentCount++;
                else if (note >= 3.5) goodCount++;
                else if (note >= 2.5) averageCount++;
                else poorCount++;
            });

            const totalEvaluations = rows.length;
            const avgScore = totalEvaluations > 0 ? (totalScore / totalEvaluations).toFixed(1) : '0.0';

            document.getElementById('totalEvaluations').textContent = totalEvaluations;
            document.getElementById('avgScore').textContent = avgScore;
            document.getElementById('excellentCount').textContent = excellentCount;
            document.getElementById('goodCount').textContent = goodCount;

            // Stocker toutes les évaluations pour le filtrage
            allEvaluations = Array.from(rows);
        }

        // Écouteurs d'événements pour les filtres
        document.getElementById('globalSearch').addEventListener('input', filterTable);
        document.getElementById('nomFilter').addEventListener('input', filterTable);
        document.getElementById('prenomFilter').addEventListener('input', filterTable);
        document.getElementById('moisFilter').addEventListener('change', filterTable);
        document.getElementById('anneeFilter').addEventListener('change', filterTable);
        document.getElementById('noteFilter').addEventListener('change', filterTable);
        document.getElementById('performanceFilter').addEventListener('change', filterTable);
        document.getElementById('noteSort').addEventListener('change', applySorting);

        function filterTable() {
            const globalSearch = document.getElementById('globalSearch').value.toLowerCase();
            const nomFilter = document.getElementById('nomFilter').value.toLowerCase();
            const prenomFilter = document.getElementById('prenomFilter').value.toLowerCase();
            const moisFilter = document.getElementById('moisFilter').value;
            const anneeFilter = document.getElementById('anneeFilter').value;
            const noteFilter = document.getElementById('noteFilter').value;
            const performanceFilter = document.getElementById('performanceFilter').value;

            const rows = document.querySelectorAll('#evaluationsBody tr');
            let visibleCount = 0;

            rows.forEach(row => {
                const cells = row.getElementsByTagName('td');
                let showRow = true;

                // Filtre global
                if (globalSearch) {
                    let rowText = '';
                    for (let i = 0; i < cells.length; i++) {
                        rowText += cells[i].textContent.toLowerCase() + ' ';
                    }
                    if (!rowText.includes(globalSearch)) {
                        showRow = false;
                    }
                }

                // Filtre par nom
                if (showRow && nomFilter) {
                    const employeText = cells[0].textContent.toLowerCase();
                    if (!employeText.includes(nomFilter)) {
                        showRow = false;
                    }
                }

                // Filtre par prénom
                if (showRow && prenomFilter) {
                    const employeText = cells[0].textContent.toLowerCase();
                    if (!employeText.includes(prenomFilter)) {
                        showRow = false;
                    }
                }

                // Filtre par mois
                if (showRow && moisFilter !== '') {
                    const moisCell = cells[1].textContent.trim();
                    if (moisCell !== moisFilter) {
                        showRow = false;
                    }
                }

                // Filtre par année
                if (showRow && anneeFilter !== '') {
                    const anneeCell = cells[2].textContent.trim();
                    if (anneeCell !== anneeFilter) {
                        showRow = false;
                    }
                }

                // Filtre par note
                if (showRow && noteFilter !== '') {
                    const noteText = cells[3].querySelector('.badge-note').textContent;
                    const note = parseFloat(noteText.split('/')[0]);
                    const minNote = parseFloat(noteFilter);
                    
                    if (note < minNote) {
                        showRow = false;
                    }
                }

                // Filtre par performance
                if (showRow && performanceFilter !== '') {
                    const noteText = cells[3].querySelector('.badge-note').textContent;
                    const note = parseFloat(noteText.split('/')[0]);
                    let performanceLevel = '';
                    
                    if (note >= 4.5) performanceLevel = 'excellent';
                    else if (note >= 3.5) performanceLevel = 'bon';
                    else if (note >= 2.5) performanceLevel = 'moyen';
                    else if (note >= 1.5) performanceLevel = 'passable';
                    else performanceLevel = 'insuffisant';
                    
                    if (performanceLevel !== performanceFilter) {
                        showRow = false;
                    }
                }

                row.style.display = showRow ? '' : 'none';
                if (showRow) visibleCount++;
            });

            // Mettre à jour le compteur
            document.getElementById('resultCount').textContent = visibleCount + ' évaluation(s) trouvée(s)';
            
            // Afficher/masquer le message "Aucun résultat"
            document.getElementById('noResults').style.display = visibleCount === 0 ? 'block' : 'none';
        }

        function applySorting() {
            const noteSort = document.getElementById('noteSort').value;
            if (noteSort) {
                sortTableByColumn(3, noteSort);
            }
        }

        function sortTable(columnIndex) {
            const sortOrder = sortDirection === 1 ? 'asc' : 'desc';
            sortTableByColumn(columnIndex, sortOrder);
            
            // Inverser la direction pour le prochain clic
            sortDirection = -sortDirection;
        }

        function sortTableByColumn(columnIndex, order) {
            const tbody = document.getElementById('evaluationsBody');
            const rows = Array.from(tbody.getElementsByTagName('tr')).filter(row => row.style.display !== 'none');

            rows.sort((a, b) => {
                const aCell = a.getElementsByTagName('td')[columnIndex];
                const bCell = b.getElementsByTagName('td')[columnIndex];
                let aValue, bValue;

                // Gestion spéciale pour les colonnes
                if (columnIndex === 3) { // Note
                    const aNoteText = aCell.querySelector('.badge-note').textContent;
                    const bNoteText = bCell.querySelector('.badge-note').textContent;
                    aValue = parseFloat(aNoteText.split('/')[0]);
                    bValue = parseFloat(bNoteText.split('/')[0]);
                } else if (columnIndex === 2) { // Année
                    aValue = parseInt(aCell.textContent.trim());
                    bValue = parseInt(bCell.textContent.trim());
                } else if (columnIndex === 1) { // Mois
                    const moisOrder = {
                        'Janvier': 1, 'Février': 2, 'Mars': 3, 'Avril': 4, 'Mai': 5, 'Juin': 6,
                        'Juillet': 7, 'Août': 8, 'Septembre': 9, 'Octobre': 10, 'Novembre': 11, 'Décembre': 12
                    };
                    aValue = moisOrder[aCell.textContent.trim()] || 0;
                    bValue = moisOrder[bCell.textContent.trim()] || 0;
                } else {
                    aValue = aCell.textContent.toLowerCase();
                    bValue = bCell.textContent.toLowerCase();
                }

                let result = 0;
                if (aValue < bValue) result = -1;
                if (aValue > bValue) result = 1;

                return order === 'desc' ? -result : result;
            });

            // Réinsérer les lignes triées
            tbody.innerHTML = '';
            rows.forEach(row => tbody.appendChild(row));

            // Mettre à jour les indicateurs de tri
            updateSortIndicators(columnIndex, order);
        }

        function updateSortIndicators(columnIndex, order) {
            const headers = document.querySelectorAll('#evaluationsTable th');
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
            document.getElementById('moisFilter').value = '';
            document.getElementById('anneeFilter').value = '';
            document.getElementById('noteFilter').value = '';
            document.getElementById('performanceFilter').value = '';
            document.getElementById('noteSort').value = '';
            
            filterTable();
        }

        function exportToCSV() {
            const rows = document.querySelectorAll('#evaluationsBody tr');
            const csvData = [];
            
            // En-têtes
            csvData.push(['Employé', 'Mois', 'Année', 'Note', 'Performance']);
            
            // Données
            rows.forEach(row => {
                if (row.style.display !== 'none') {
                    const cells = row.getElementsByTagName('td');
                    const employe = cells[0].textContent.replace(/\n/g, ' ').trim();
                    const mois = cells[1].textContent.trim();
                    const annee = cells[2].textContent.trim();
                    const note = cells[3].querySelector('.badge-note').textContent;
                    const performance = cells[4].textContent.trim();
                    
                    csvData.push([employe, mois, annee, note, performance]);
                }
            });
            
            // Convertir en CSV
            const csvContent = csvData.map(row => 
                row.map(cell => `"${cell}"`).join(',')
            ).join('\n');
            
            // Créer et télécharger le fichier
            const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;