<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Contrats - BusinessSuite</title>
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
            --warning: #ffc107;
            --danger: #dc3545;
            --info: #0dcaf0;
            --border-radius: 6px;
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

        .back-btn, .logout-btn {
            background: var(--navy-blue);
            color: var(--white);
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .back-btn:hover, .logout-btn:hover {
            background: var(--navy-light);
        }

        /* Cartes de Statistiques */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            border-left: 4px solid var(--navy-blue);
            cursor: pointer;
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(26, 54, 93, 0.12);
        }

        .stat-card h3 {
            font-size: 0.875rem;
            color: var(--gray);
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--navy-blue);
            margin-bottom: 0.5rem;
        }

        .stat-trend {
            font-size: 0.875rem;
            color: var(--success);
        }

        /* Section Filtres */
        .filter-section {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .filter-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .filter-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--navy-blue);
        }

        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .filter-input, .filter-select {
            width: 100%;
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
            box-shadow: 0 0 0 2px rgba(26, 54, 93, 0.1);
        }

        .filter-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 500;
            font-size: 0.875rem;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
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

        /* Tableau */
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

        .contrats-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.875rem;
        }

        .contrats-table th {
            background: var(--gray-lighter);
            color: var(--navy-blue);
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            border-bottom: 1px solid var(--gray-light);
            cursor: pointer;
            transition: var(--transition);
            position: relative;
        }

        .contrats-table th:hover {
            background: var(--cream-dark);
        }

        .contrats-table th::after {
            content: '↕';
            position: absolute;
            right: 15px;
            opacity: 0.7;
            font-size: 0.8rem;
        }

        .contrats-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--gray-light);
            transition: var(--transition);
        }

        .contrats-table tbody tr:nth-child(even) {
            background: var(--gray-lighter);
        }

        .contrats-table tbody tr:hover {
            background: var(--cream);
        }

        .contrats-table tbody tr:last-child td {
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
            color: white;
        }

        .badge-warning {
            background: var(--warning);
            color: black;
        }

        .badge-info {
            background: var(--info);
            color: black;
        }

        .badge-secondary {
            background: var(--gray-light);
            color: var(--gray);
        }

        .contrat-status {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .status-actif { 
            background: #d4edda; 
            color: #155724; 
        }
        .status-termine { 
            background: #f8d7da; 
            color: #721c24; 
        }
        .status-rompu { 
            background: #fff3cd; 
            color: #856404; 
        }

        /* Actions */
        .action-link {
            color: var(--navy-blue);
            text-decoration: none;
            font-weight: 500;
            padding: 0.25rem 0.5rem;
            border-radius: var(--border-radius);
            transition: var(--transition);
            border: 1px solid transparent;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            font-size: 0.75rem;
        }

        .action-link:hover {
            background: var(--navy-blue);
            color: var(--white);
            border-color: var(--navy-blue);
        }

        /* Indicateurs de tri */
        .sort-asc::after {
            content: ' ↑' !important;
            opacity: 1 !important;
        }

        .sort-desc::after {
            content: ' ↓' !important;
            opacity: 1 !important;
        }

        /* Message aucun résultat */
        .no-results {
            text-align: center;
            padding: 3rem 2rem;
            color: var(--gray);
        }

        .no-results i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .no-results h3 {
            margin-bottom: 0.5rem;
            color: var(--gray);
        }

        /* Messages d'alerte */
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
            border-left: 4px solid var(--danger);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
            border-left: 4px solid var(--success);
            display: flex;
            align-items: center;
            gap: 0.5rem;
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
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .filter-grid {
                grid-template-columns: 1fr;
            }
            .table-container {
                overflow-x: auto;
            }
            .contrats-table {
                min-width: 1000px;
            }
            .top-bar {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
        }

        @media (max-width: 576px) {
            .filter-actions {
                flex-direction: column;
            }
            .btn {
                width: 100%;
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
                    <h2>Gestion des Contrats</h2>
                    <p>Liste de tous les contrats de travail</p>
                </div>
                <div class="user-menu">
                    <a href="${pageContext.request.contextPath}/rh/employe" class="back-btn">
                        <i class="fas fa-arrow-left"></i>
                        Retour aux employés
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i>
                        Déconnexion
                    </a>
                </div>
            </div>

            <!-- Messages d'alerte -->
            <c:if test="${not empty error}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="success-message">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>

            <!-- Cartes de Statistiques -->
            <div class="stats-grid">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/rh/contrats'">
                    <h3>Total Contrats</h3>
                    <div class="stat-number">${totalContrats}</div>
                    <div class="stat-trend">En cours</div>
                </div>
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/rh/contrats?statut=actif'">
                    <h3>Contrats Actifs</h3>
                    <div class="stat-number">${contratsActifs}</div>
                    <div class="stat-trend">En vigueur</div>
                </div>
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/rh/contrats?type=CDI'">
                    <h3>Contrats CDI</h3>
                    <div class="stat-number">${contratsCDI}</div>
                    <div class="stat-trend">Définitifs</div>
                </div>
            </div>

            <!-- Section Filtres -->
            <div class="filter-section">
                <div class="filter-header">
                    <h3>Filtres des contrats</h3>
                </div>
                
                <input type="text" id="globalSearch" class="filter-input" placeholder="Rechercher dans tous les champs..." style="margin-bottom: 1rem;">
                
                <div class="filter-grid">
                    <input type="text" id="employeFilter" class="filter-input" placeholder="Filtrer par employé">
                    <input type="text" id="posteFilter" class="filter-input" placeholder="Filtrer par poste">
                    <input type="text" id="numeroContratFilter" class="filter-input" placeholder="Filtrer par numéro contrat">
                    
                    <select id="typeContratFilter" class="filter-select">
                        <option value="">Tous les types</option>
                        <option value="CDI">CDI</option>
                        <option value="CDD">CDD</option>
                        <option value="INTERIM">Intérim</option>
                        <option value="APPRENTISSAGE">Apprentissage</option>
                    </select>

                    <select id="statutContratFilter" class="filter-select">
                        <option value="">Tous les statuts</option>
                        <option value="actif">Actif</option>
                        <option value="termine">Terminé</option>
                        <option value="rompu">Rompu</option>
                    </select>
                    
                    <select id="classificationFilter" class="filter-select">
                        <option value="">Toutes classifications</option>
                        <option value="Cadre">Cadre</option>
                        <option value="ETAM">ETAM</option>
                        <option value="Ouvrier">Ouvrier</option>
                    </select>

                    <select id="dateSort" class="filter-select">
                        <option value="">Trier par date</option>
                        <option value="date_debut_asc">Date début croissante</option>
                        <option value="date_debut_desc">Date début décroissante</option>
                        <option value="date_creation_desc">Plus récents</option>
                    </select>
                </div>
                
                <div class="filter-actions">
                    <button onclick="resetFilters()" class="btn btn-secondary">
                        <i class="fas fa-undo"></i>
                        Réinitialiser
                    </button>
                    <button onclick="applyFilters()" class="btn btn-primary">
                        <i class="fas fa-filter"></i>
                        Appliquer filtres
                    </button>
                </div>
            </div>

            <!-- Tableau des contrats -->
            <div class="table-container">
                <div class="table-header">
                    <h3>Liste des Contrats</h3>
                    <div class="table-count" id="resultCount">
                        ${contrats.size()} contrat(s) trouvé(s)
                    </div>
                </div>
                
                <table class="contrats-table" id="contratsTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable(0)">Numéro Contrat</th>
                            <th onclick="sortTable(1)">Employé</th>
                            <th onclick="sortTable(2)">Type</th>
                            <th onclick="sortTable(3)">Poste</th>
                            <th onclick="sortTable(4)">Classification</th>
                            <th onclick="sortTable(5)">Date Début</th>
                            <th onclick="sortTable(6)">Date Fin</th>
                            <th onclick="sortTable(7)">Salaire</th>
                            <th onclick="sortTable(8)">Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="contratsBody">
                        <c:forEach var="contrat" items="${contrats}">
                            <tr>
                                <td><strong>${contrat.numeroContrat}</strong></td>
                                <td>
                                    <strong>${contrat.prenom} ${contrat.nom}</strong>
                                    <br><small style="color: var(--gray);">${contrat.mail}</small>
                                    <br><small style="color: var(--gray); font-size: 0.7rem;">${contrat.departement}</small>
                                </td>
                                <td>
                                    <span class="badge 
                                        <c:choose>
                                            <c:when test="${contrat.typeContrat == 'CDI'}">badge-success</c:when>
                                            <c:when test="${contrat.typeContrat == 'CDD'}">badge-warning</c:when>
                                            <c:when test="${contrat.typeContrat == 'INTERIM'}">badge-info</c:when>
                                            <c:otherwise>badge-secondary</c:otherwise>
                                        </c:choose>">
                                        ${contrat.typeContrat}
                                    </span>
                                </td>
                                <td>${contrat.posteContrat}</td>
                                <td>
                                    <span class="badge badge-secondary">${contrat.classification}</span>
                                </td>
                                <td>${contrat.dateDebut}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty contrat.dateFin}">
                                            ${contrat.dateFin}
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: var(--gray); font-style: italic;">Indéterminée</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <strong>${contrat.salaireBase} Ar</strong>
                                </td>
                                <td>
                                    <span class="contrat-status status-${contrat.statutContrat}">
                                        ${contrat.statutContrat}
                                    </span>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 0.25rem; flex-wrap: wrap;">
                                        <a href="${pageContext.request.contextPath}/rh/contrats/employe?id_employe=${contrat.idEmploye}" 
                                           class="action-link" title="Voir détails employé">
                                            <i class="fas fa-eye"></i>
                                            Détails
                                        </a>
                                        <a href="#" class="action-link" title="Modifier contrat" style="color: var(--warning);">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="#" class="action-link" title="Télécharger PDF" style="color: var(--danger);">
                                            <i class="fas fa-file-pdf"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div id="noResults" class="no-results" style="display: none;">
                    <i class="fas fa-file-contract"></i>
                    <h3>Aucun contrat trouvé</h3>
                    <p>Aucun contrat ne correspond aux critères de recherche sélectionnés.</p>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Script pour les filtres et le tri
        let currentSortColumn = -1;
        let sortDirection = 1;

        document.getElementById('globalSearch').addEventListener('input', filterTable);
        document.getElementById('employeFilter').addEventListener('input', filterTable);
        document.getElementById('posteFilter').addEventListener('input', filterTable);
        document.getElementById('numeroContratFilter').addEventListener('input', filterTable);
        document.getElementById('typeContratFilter').addEventListener('change', filterTable);
        document.getElementById('statutContratFilter').addEventListener('change', filterTable);
        document.getElementById('classificationFilter').addEventListener('change', filterTable);
        document.getElementById('dateSort').addEventListener('change', applySorting);

        function filterTable() {
            const globalSearch = document.getElementById('globalSearch').value.toLowerCase();
            const employeFilter = document.getElementById('employeFilter').value.toLowerCase();
            const posteFilter = document.getElementById('posteFilter').value.toLowerCase();
            const numeroContratFilter = document.getElementById('numeroContratFilter').value.toLowerCase();
            const typeContratFilter = document.getElementById('typeContratFilter').value;
            const statutContratFilter = document.getElementById('statutContratFilter').value;
            const classificationFilter = document.getElementById('classificationFilter').value;

            const rows = document.querySelectorAll('#contratsBody tr');
            let visibleCount = 0;

            rows.forEach(row => {
                const cells = row.getElementsByTagName('td');
                let showRow = true;

                // Recherche globale
                if (globalSearch) {
                    let rowText = '';
                    for (let i = 0; i < cells.length - 1; i++) {
                        rowText += cells[i].textContent.toLowerCase() + ' ';
                    }
                    if (!rowText.includes(globalSearch)) {
                        showRow = false;
                    }
                }

                // Filtre employé (colonne 1)
                if (showRow && employeFilter && !cells[1].textContent.toLowerCase().includes(employeFilter)) {
                    showRow = false;
                }

                // Filtre poste (colonne 3)
                if (showRow && posteFilter && !cells[3].textContent.toLowerCase().includes(posteFilter)) {
                    showRow = false;
                }

                // Filtre numéro contrat (colonne 0)
                if (showRow && numeroContratFilter && !cells[0].textContent.toLowerCase().includes(numeroContratFilter)) {
                    showRow = false;
                }

                // Filtre type contrat (colonne 2)
                if (showRow && typeContratFilter) {
                    const typeContrat = cells[2].textContent.trim();
                    if (typeContrat !== typeContratFilter) {
                        showRow = false;
                    }
                }

                // Filtre statut contrat (colonne 8)
                if (showRow && statutContratFilter) {
                    const statutContrat = cells[8].textContent.trim();
                    if (statutContrat !== statutContratFilter) {
                        showRow = false;
                    }
                }

                // Filtre classification (colonne 4)
                if (showRow && classificationFilter) {
                    const classification = cells[4].textContent.trim();
                    if (classification !== classificationFilter) {
                        showRow = false;
                    }
                }

                row.style.display = showRow ? '' : 'none';
                if (showRow) visibleCount++;
            });

            // Mettre à jour le compteur
            document.getElementById('resultCount').textContent = visibleCount + ' contrat(s) trouvé(s)';
            document.getElementById('noResults').style.display = visibleCount === 0 ? 'block' : 'none';
        }

        function applySorting() {
            const dateSort = document.getElementById('dateSort').value;
            if (dateSort === 'date_debut_asc') {
                sortTableByColumn(5, 'asc');
            } else if (dateSort === 'date_debut_desc') {
                sortTableByColumn(5, 'desc');
            } else if (dateSort === 'date_creation_desc') {
                // Par défaut déjà trié par date création desc
                filterTable();
            }
        }

        function sortTable(columnIndex) {
            const sortOrder = sortDirection === 1 ? 'asc' : 'desc';
            sortTableByColumn(columnIndex, sortOrder);
            sortDirection = -sortDirection;
        }

        function sortTableByColumn(columnIndex, order) {
            const tbody = document.getElementById('contratsBody');
            const rows = Array.from(tbody.getElementsByTagName('tr'));

            rows.sort((a, b) => {
                const aCell = a.getElementsByTagName('td')[columnIndex].textContent;
                const bCell = b.getElementsByTagName('td')[columnIndex].textContent;

                let aValue, bValue;

                if (columnIndex === 5 || columnIndex === 6) { // Dates
                    aValue = new Date(aCell);
                    bValue = new Date(bCell);
                } else if (columnIndex === 7) { // Salaire
                    aValue = parseFloat(aCell.replace(' Ar', '').replace(/\s/g, ''));
                    bValue = parseFloat(bCell.replace(' Ar', '').replace(/\s/g, ''));
                } else {
                    aValue = aCell.toLowerCase();
                    bValue = bCell.toLowerCase();
                }

                let result = 0;
                if (aValue < bValue) result = -1;
                if (aValue > bValue) result = 1;

                return order === 'desc' ? -result : result;
            });

            rows.forEach(row => tbody.appendChild(row));
            updateSortIndicators(columnIndex, order);
        }

        function updateSortIndicators(columnIndex, order) {
            const headers = document.querySelectorAll('#contratsTable th');
            headers.forEach((header, index) => {
                header.className = '';
                if (index === columnIndex) {
                    header.className = order === 'asc' ? 'sort-asc' : 'sort-desc';
                }
            });
        }

        function resetFilters() {
            document.getElementById('globalSearch').value = '';
            document.getElementById('employeFilter').value = '';
            document.getElementById('posteFilter').value = '';
            document.getElementById('numeroContratFilter').value = '';
            document.getElementById('typeContratFilter').value = '';
            document.getElementById('statutContratFilter').value = '';
            document.getElementById('classificationFilter').value = '';
            document.getElementById('dateSort').value = '';
            
            const headers = document.querySelectorAll('#contratsTable th');
            headers.forEach(header => {
                header.className = '';
            });
            
            filterTable();
        }

        function applyFilters() {
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