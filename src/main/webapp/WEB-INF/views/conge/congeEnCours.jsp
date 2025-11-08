<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Congés en Cours - BusinessSuite RH</title>
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

        .btn-warning {
            background: var(--warning);
            color: var(--navy-blue);
        }

        .btn-warning:hover {
            background: #e0a800;
        }

        .btn-info {
            background: var(--info);
            color: var(--white);
        }

        .btn-info:hover {
            background: #0baccc;
        }

        /* Tableau des congés */
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

        /* Indicateur de progression */
        .progress-container {
            width: 100%;
            background: var(--gray-light);
            border-radius: 10px;
            overflow: hidden;
            height: 6px;
            margin-top: 0.25rem;
        }

        .progress-bar {
            height: 100%;
            background: var(--success);
            border-radius: 10px;
            transition: width 0.3s ease;
        }

        /* Indicateur de statut */
        .status-indicator {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
        }

        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
        }

        .status-active {
            background: var(--success);
        }

        .status-ending {
            background: var(--warning);
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

        /* Carte de statistiques */
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            text-align: center;
        }

        .stat-card i {
            font-size: 2rem;
            margin-bottom: 0.75rem;
        }

        .stat-card.success i { color: var(--success); }
        .stat-card.warning i { color: var(--warning); }
        .stat-card.info i { color: var(--info); }
        .stat-card.primary i { color: var(--navy-blue); }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--navy-blue);
            margin-bottom: 0.25rem;
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
            .stats-cards {
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
                min-width: 1200px;
            }
            .filter-actions {
                flex-direction: column;
            }
            .stats-cards {
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
                    <h2>Congés en Cours</h2>
                    <p>Suivi des congés actuellement en cours dans l'entreprise</p>
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

            <!-- Cartes de statistiques -->
            <div class="stats-cards">
                <div class="stat-card success">
                    <i class="fas fa-plane"></i>
                    <div class="stat-number" id="totalConges">${congesEnCours.size()}</div>
                    <div class="stat-label">Congés en Cours</div>
                </div>
                <div class="stat-card warning">
                    <i class="fas fa-clock"></i>
                    <div class="stat-number" id="congesFinissant">0</div>
                    <div class="stat-label">Finissent cette semaine</div>
                </div>
                <div class="stat-card info">
                    <i class="fas fa-users"></i>
                    <div class="stat-number" id="totalPersonnes">0</div>
                    <div class="stat-label">Personnes absentes</div>
                </div>
                <div class="stat-card primary">
                    <i class="fas fa-calendar-alt"></i>
                    <div class="stat-number" id="moyenneDuree">0</div>
                    <div class="stat-label">Jours moyens</div>
                </div>
            </div>

            <!-- Section Filtres -->
            <div class="filter-section">
                <h3><i class="fas fa-filter"></i> Filtres des congés en cours</h3>
                
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
                        <label for="departementFilter">Département</label>
                        <input type="text" id="departementFilter" class="filter-input" placeholder="Filtrer par département...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="posteFilter">Poste</label>
                        <input type="text" id="posteFilter" class="filter-input" placeholder="Filtrer par poste...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="dateDebutFilter">Date de début</label>
                        <input type="date" id="dateDebutFilter" class="filter-input">
                    </div>
                    
                    <div class="filter-group">
                        <label for="dateFinFilter">Date de fin</label>
                        <input type="date" id="dateFinFilter" class="filter-input">
                    </div>
                    
                    <div class="filter-group">
                        <label for="dureeFilter">Durée</label>
                        <select id="dureeFilter" class="filter-select">
                            <option value="">Toutes les durées</option>
                            <option value="1-3">1-3 jours</option>
                            <option value="4-7">4-7 jours</option>
                            <option value="8-14">8-14 jours</option>
                            <option value="15">15+ jours</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="statutFilter">État du congé</label>
                        <select id="statutFilter" class="filter-select">
                            <option value="">Tous les états</option>
                            <option value="actif">En cours</option>
                            <option value="finition">Bientôt terminé</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="dateValidationSort">Tri par date de validation</label>
                        <select id="dateValidationSort" class="filter-select">
                            <option value="">Ordre par défaut</option>
                            <option value="asc">Plus anciennes</option>
                            <option value="desc">Plus récentes</option>
                        </select>
                    </div>
                </div>
                
                <div class="filter-actions">
                    <button onclick="resetFilters()" class="btn btn-secondary">
                        <i class="fas fa-undo"></i>
                        Réinitialiser
                    </button>
                    <button onclick="exportToExcel()" class="btn btn-success">
                        <i class="fas fa-file-excel"></i>
                        Exporter Excel
                    </button>
                    <button onclick="generateReport()" class="btn btn-info">
                        <i class="fas fa-chart-bar"></i>
                        Rapport
                    </button>
                </div>
            </div>

            <!-- Tableau des congés en cours -->
            <div class="table-container">
                <div class="table-header">
                    <h3>Liste des congés en cours</h3>
                    <div class="table-count" id="resultCount">
                        ${congesEnCours.size()} congé(s) en cours
                    </div>
                </div>
                
                <table class="data-table" id="congesTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable(0)">ID <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(1)">Nom <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(2)">Prénom <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(3)">Département <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(4)">Poste <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(5)">Date Début <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(6)">Date Fin <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(7)">Durée <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(9)">Date Demande <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(10)">Date Validation <i class="fas fa-sort"></i></th>
                            <th>Statut</th>
                        </tr>
                    </thead>
                    <tbody id="congesBody">
                        <c:forEach var="conge" items="${congesEnCours}">
                            <tr>
                                <td><strong>#${conge.id}</strong></td>
                                <td><strong>${conge.nom}</strong></td>
                                <td>${conge.prenom}</td>
                                <td>
                                    <span class="badge badge-primary">${conge.departement}</span>
                                </td>
                                <td>
                                    <span class="badge badge-info">${conge.poste}</span>
                                </td>
                                <td>${conge.dateDebut}</td>
                                <td>${conge.dateFin}</td>
                                <td>
                                    <span class="badge ${conge.duree >= 10 ? 'badge-warning' : 'badge-success'}">
                                        ${conge.duree} jour(s)
                                    </span>
                                </td>
                                <td>${conge.dateDemande}</td>
                                <td>${conge.dateValidation}</td>
                                <td class="status-indicator">En cours</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div id="noResults" class="no-results" style="display: none;">
                    <i class="fas fa-beach"></i>
                    <h3>Aucun congé en cours</h3>
                    <p>Aucun congé en cours ne correspond aux critères de recherche sélectionnés.</p>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Variables globales pour le tri
        let currentSortColumn = -1;
        let sortDirection = 1;

        // Calcul des statistiques
        function calculateStats() {
            const rows = document.querySelectorAll('#congesBody tr');
            let totalConges = rows.length;
            let congesFinissant = 0;
            let totalPersonnes = new Set();
            let totalDuree = 0;

            rows.forEach(row => {
                const cells = row.getElementsByTagName('td');
                const nom = cells[1].textContent;
                const prenom = cells[2].textContent;
                const dureeCell = cells[7].textContent;
                const statutCell = cells[11].textContent;

                // Compter les personnes uniques
                totalPersonnes.add(nom + prenom);

                // Calculer la durée totale
                const dureeMatch = dureeCell.match(/(\d+)/);
                if (dureeMatch) {
                    totalDuree += parseInt(dureeMatch[1]);
                }

                // Compter les congés finissant bientôt
                if (statutCell.includes('Bientôt terminé')) {
                    congesFinissant++;
                }
            });

            // Mettre à jour les statistiques
            document.getElementById('congesFinissant').textContent = congesFinissant;
            document.getElementById('totalPersonnes').textContent = totalPersonnes.size;
            document.getElementById('moyenneDuree').textContent = totalConges > 0 ? Math.round(totalDuree / totalConges) : 0;
        }

        // Écouteurs d'événements pour les filtres
        document.getElementById('globalSearch').addEventListener('input', filterTable);
        document.getElementById('nomFilter').addEventListener('input', filterTable);
        document.getElementById('prenomFilter').addEventListener('input', filterTable);
        document.getElementById('departementFilter').addEventListener('input', filterTable);
        document.getElementById('posteFilter').addEventListener('input', filterTable);
        document.getElementById('dateDebutFilter').addEventListener('change', filterTable);
        document.getElementById('dateFinFilter').addEventListener('change', filterTable);
        document.getElementById('dureeFilter').addEventListener('change', filterTable);
        document.getElementById('statutFilter').addEventListener('change', filterTable);
        document.getElementById('dateValidationSort').addEventListener('change', applySorting);

        function filterTable() {
            const globalSearch = document.getElementById('globalSearch').value.toLowerCase();
            const nomFilter = document.getElementById('nomFilter').value.toLowerCase();
            const prenomFilter = document.getElementById('prenomFilter').value.toLowerCase();
            const departementFilter = document.getElementById('departementFilter').value.toLowerCase();
            const posteFilter = document.getElementById('posteFilter').value.toLowerCase();
            const dateDebutFilter = document.getElementById('dateDebutFilter').value;
            const dateFinFilter = document.getElementById('dateFinFilter').value;
            const dureeFilter = document.getElementById('dureeFilter').value;
            const statutFilter = document.getElementById('statutFilter').value;

            const rows = document.querySelectorAll('#congesBody tr');
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

                // Filtres individuels
                if (showRow && nomFilter && !cells[1].textContent.toLowerCase().includes(nomFilter)) {
                    showRow = false;
                }
                if (showRow && prenomFilter && !cells[2].textContent.toLowerCase().includes(prenomFilter)) {
                    showRow = false;
                }
                if (showRow && departementFilter && !cells[3].textContent.toLowerCase().includes(departementFilter)) {
                    showRow = false;
                }
                if (showRow && posteFilter && !cells[4].textContent.toLowerCase().includes(posteFilter)) {
                    showRow = false;
                }

                // Filtre par date de début
                if (showRow && dateDebutFilter) {
                    const dateDebutCell = cells[5].textContent.trim();
                    if (dateDebutCell < dateDebutFilter) {
                        showRow = false;
                    }
                }

                // Filtre par date de fin
                if (showRow && dateFinFilter) {
                    const dateFinCell = cells[6].textContent.trim();
                    if (dateFinCell > dateFinFilter) {
                        showRow = false;
                    }
                }

                // Filtre par durée
                if (showRow && dureeFilter !== '') {
                    const dureeCell = cells[7].textContent;
                    const dureeMatch = dureeCell.match(/(\d+)/);
                    if (dureeMatch) {
                        const duree = parseInt(dureeMatch[1]);
                        
                        if (dureeFilter === '1-3') {
                            if (duree < 1 || duree > 3) showRow = false;
                        } else if (dureeFilter === '4-7') {
                            if (duree < 4 || duree > 7) showRow = false;
                        } else if (dureeFilter === '8-14') {
                            if (duree < 8 || duree > 14) showRow = false;
                        } else if (dureeFilter === '15') {
                            if (duree < 15) showRow = false;
                        }
                    } else {
                        showRow = false;
                    }
                }

                // Filtre par statut
                if (showRow && statutFilter !== '') {
                    const statutCell = cells[11].textContent.toLowerCase();
                    if (statutFilter === 'actif' && !statutCell.includes('en cours')) {
                        showRow = false;
                    } else if (statutFilter === 'finition' && !statutCell.includes('bientôt')) {
                        showRow = false;
                    }
                }

                row.style.display = showRow ? '' : 'none';
                if (showRow) visibleCount++;
            });

            // Mettre à jour le compteur
            document.getElementById('resultCount').textContent = visibleCount + ' congé(s) en cours';
            
            // Afficher/masquer le message "Aucun résultat"
            document.getElementById('noResults').style.display = visibleCount === 0 ? 'block' : 'none';

            // Recalculer les statistiques
            calculateStats();
        }

        function applySorting() {
            const dateSort = document.getElementById('dateValidationSort').value;
            if (dateSort) {
                sortTableByColumn(10, dateSort);
            }
        }

        function sortTable(columnIndex) {
            const sortOrder = sortDirection === 1 ? 'asc' : 'desc';
            sortTableByColumn(columnIndex, sortOrder);
            
            // Inverser la direction pour le prochain clic
            sortDirection = -sortDirection;
        }

        function sortTableByColumn(columnIndex, order) {
            const tbody = document.getElementById('congesBody');
            const rows = Array.from(tbody.getElementsByTagName('tr'));

            rows.sort((a, b) => {
                const aCell = a.getElementsByTagName('td')[columnIndex].textContent;
                const bCell = b.getElementsByTagName('td')[columnIndex].textContent;

                let aValue, bValue;

                // Gestion spéciale pour les colonnes numériques
                if (columnIndex === 0 || columnIndex === 7) { // ID et Durée
                    aValue = extractNumber(aCell);
                    bValue = extractNumber(bCell);
                } else if (columnIndex === 5 || columnIndex === 6 || columnIndex === 9 || columnIndex === 10) { // Dates
                    aValue = new Date(aCell);
                    bValue = new Date(bCell);
                } else if (columnIndex === 8) { // Progression
                    aValue = extractNumber(aCell);
                    bValue = extractNumber(bCell);
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
            const match = text.match(/(\d+)/);
            return match ? parseInt(match[1]) : 0;
        }

        function updateSortIndicators(columnIndex, order) {
            const headers = document.querySelectorAll('#congesTable th');
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
            document.getElementById('departementFilter').value = '';
            document.getElementById('posteFilter').value = '';
            document.getElementById('dateDebutFilter').value = '';
            document.getElementById('dateFinFilter').value = '';
            document.getElementById('dureeFilter').value = '';
            document.getElementById('statutFilter').value = '';
            document.getElementById('dateValidationSort').value = '';
            
            filterTable();
        }

        function exportToExcel() {
            alert('Fonctionnalité d\'export Excel en cours de développement');
        }

        function generateReport() {
            alert('Génération du rapport des congés en cours...');
        }

        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            filterTable();
            calculateStats();
            
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