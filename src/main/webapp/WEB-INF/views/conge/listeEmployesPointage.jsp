<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pointage des Employés - BusinessSuite RH</title>
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

        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.8rem;
        }

        /* Tableau des employés */
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

        .badge-secondary {
            background: var(--gray);
            color: var(--white);
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

        /* Avatar */
        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 14px;
            color: var(--white);
            background: var(--navy-blue);
        }

        /* Alertes */
        .alert {
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.2);
            color: var(--danger);
        }

        .alert .btn-close {
            background: none;
            border: none;
            font-size: 1.25rem;
            cursor: pointer;
            margin-left: auto;
        }

        /* Actions */
        .actions-container {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            justify-content: center;
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
            .actions-container {
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
                min-width: 1000px;
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
        <jsp:include page="sidebarRh.jsp" />
        
        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2><i class="fas fa-clipboard-check me-2"></i>Pointage des Employés</h2>
                    <p>Gestion des absences, retards et présences</p>
                </div>
                <div class="user-menu">
                    <a href="${pageContext.request.contextPath}/rh/dashboard" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Retour
                    </a>
                </div>
            </div>

            <!-- Messages d'erreur -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i>${error}
                    <button type="button" class="btn-close">&times;</button>
                </div>
            </c:if>

            <!-- Cartes de statistiques -->
            <div class="stats-cards">
                <div class="stat-card primary">
                    <i class="fas fa-users"></i>
                    <div class="stat-number">${totalEmployes}</div>
                    <div class="stat-label">Total Employés</div>
                </div>
                <div class="stat-card success">
                    <i class="fas fa-filter"></i>
                    <div class="stat-number">${employes.size()}</div>
                    <div class="stat-label">Résultats</div>
                </div>
                <c:forEach var="stat" items="${statistiquesDepartement}" varStatus="loop">
                    <c:if test="${loop.index < 2}">
                        <div class="stat-card info">
                            <i class="fas fa-building"></i>
                            <div class="stat-number">${stat.value}</div>
                            <div class="stat-label">${stat.key}</div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>

            <!-- Section Filtres -->
            <div class="filter-section">
                <h3><i class="fas fa-filter"></i> Filtres des employés</h3>
                
                <form method="get" class="filter-grid">
                    <div class="filter-group">
                        <label for="departement">Département</label>
                        <input type="text" id="departement" name="departement" class="filter-input" 
                               value="${departement}" placeholder="ex: RH, IT, Marketing...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="recherche">Recherche</label>
                        <input type="text" id="recherche" name="recherche" class="filter-input" 
                               value="${recherche}" placeholder="Nom ou prénom...">
                    </div>
                    
                    <div class="filter-group global-search">
                        <label for="globalSearch">Recherche globale</label>
                        <input type="text" id="globalSearch" class="filter-input" placeholder="Rechercher dans tous les champs...">
                    </div>
                </form>
                
                <div class="filter-actions">
                    <button type="submit" formmethod="get" class="btn btn-primary">
                        <i class="fas fa-filter me-2"></i>Filtrer
                    </button>
                    <a href="${pageContext.request.contextPath}/rh/conge/pointage" class="btn btn-secondary">
                        <i class="fas fa-refresh me-2"></i>Réinitialiser
                    </a>
                </div>
            </div>

            <!-- Tableau des employés -->
            <div class="table-container">
                <div class="table-header">
                    <h3>Liste des Employés</h3>
                    <div class="table-count" id="resultCount">
                        ${employes.size()} employé(s)
                    </div>
                </div>
                
                <table class="data-table" id="employesTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable(0)">Employé <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(1)">Département <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(2)">Poste <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(3)">Date Embauche <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(4)">Soldes Congés <i class="fas fa-sort"></i></th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="employesBody">
                        <c:forEach var="employe" items="${employes}">
                            <tr>
                                <td>
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
                                            <strong>
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
                                            <small class="text-muted">ID: ${employe.id}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge badge-primary">
                                        <c:choose>
                                            <c:when test="${not empty employe.departement}">
                                                ${employe.departement}
                                            </c:when>
                                            <c:otherwise>
                                                Non assigné
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty employe.poste}">
                                            ${employe.poste}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Non défini</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="badge badge-info">
                                        ${employe.dateEmbauche}
                                    </span>
                                </td>
                                <td>
                                    <div class="d-flex flex-column gap-1">
                                        <span class="badge bg-primary" title="Solde annuel">
                                            <i class="fas fa-calendar-day me-1"></i>${employe.soldeAnnuelActuel}j
                                        </span>
                                        <span class="badge bg-warning text-dark" title="Solde exceptionnel">
                                            <i class="fas fa-star me-1"></i>${employe.soldeExceptionnelActuel}j
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <div class="actions-container">
                                        <!-- Absence -->
                                        <button class="btn btn-outline-primary btn-sm" 
                                                title="Déclarer une absence"
                                                onclick="ouvrirFormulairePointage(${employe.id}, 'absence')">
                                            <i class="fas fa-file-contract me-1"></i>Absence
                                        </button>
                                        
                                        <!-- Retard -->
                                        <button class="btn btn-outline-warning btn-sm" 
                                                title="Déclarer un retard"
                                                onclick="ouvrirFormulairePointage(${employe.id}, 'retard')">
                                            <i class="fas fa-clock me-1"></i>Retard
                                        </button>
                                        
                                        <!-- Maladie -->
                                        <button class="btn btn-outline-danger btn-sm" 
                                                title="Déclarer une maladie"
                                                onclick="ouvrirFormulairePointage(${employe.id}, 'maladie')">
                                            <i class="fas fa-head-side-cough me-1"></i>Maladie
                                        </button>
                                        
                                        <!-- Mission/Formation -->
                                        <button class="btn btn-outline-info btn-sm" 
                                                title="Déclarer mission/formation"
                                                onclick="ouvrirFormulairePointage(${employe.id}, 'mission')">
                                            <i class="fas fa-briefcase me-1"></i>Mission
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div id="noResults" class="no-results" style="display: none;">
                    <i class="fas fa-search"></i>
                    <h3>Aucun employé trouvé</h3>
                    <p>Aucun employé ne correspond aux critères de recherche</p>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Variables globales pour le tri
        let currentSortColumn = -1;
        let sortDirection = 1;

        // Écouteurs d'événements pour les filtres
        document.getElementById('globalSearch').addEventListener('input', filterTable);
        document.getElementById('departement').addEventListener('change', function() {
            this.form.submit();
        });
        document.getElementById('recherche').addEventListener('change', function() {
            this.form.submit();
        });

        function filterTable() {
            const globalSearch = document.getElementById('globalSearch').value.toLowerCase();
            const rows = document.querySelectorAll('#employesBody tr');
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

                row.style.display = showRow ? '' : 'none';
                if (showRow) visibleCount++;
            });

            // Mettre à jour le compteur
            document.getElementById('resultCount').textContent = visibleCount + ' employé(s)';
            
            // Afficher/masquer le message "Aucun résultat"
            document.getElementById('noResults').style.display = visibleCount === 0 ? 'block' : 'none';
        }

        function sortTable(columnIndex) {
            const tbody = document.getElementById('employesBody');
            const rows = Array.from(tbody.getElementsByTagName('tr'));

            rows.sort((a, b) => {
                const aCell = a.getElementsByTagName('td')[columnIndex].textContent;
                const bCell = b.getElementsByTagName('td')[columnIndex].textContent;

                let aValue, bValue;

                // Gestion spéciale pour les colonnes numériques
                if (columnIndex === 4) { // Soldes Congés
                    aValue = extractNumber(aCell);
                    bValue = extractNumber(bCell);
                } else {
                    aValue = aCell.toLowerCase();
                    bValue = bCell.toLowerCase();
                }

                let result = 0;
                if (aValue < bValue) result = -1;
                if (aValue > bValue) result = 1;

                return sortDirection === 1 ? result : -result;
            });

            // Réinsérer les lignes triées
            rows.forEach(row => tbody.appendChild(row));

            // Mettre à jour les indicateurs de tri
            updateSortIndicators(columnIndex);

            // Inverser la direction pour le prochain clic
            sortDirection = -sortDirection;
        }

        function extractNumber(text) {
            const match = text.match(/(\d+)/);
            return match ? parseInt(match[1]) : 0;
        }

        function updateSortIndicators(columnIndex) {
            const headers = document.querySelectorAll('#employesTable th');
            headers.forEach((header, index) => {
                header.innerHTML = header.innerHTML.replace(/<i class="fas fa-sort-(up|down)"><\/i>/, '') + '<i class="fas fa-sort"></i>';
                if (index === columnIndex) {
                    header.innerHTML = header.innerHTML.replace('<i class="fas fa-sort"></i>', 
                        sortDirection === 1 ? '<i class="fas fa-sort-up"></i>' : '<i class="fas fa-sort-down"></i>');
                }
            });
        }

        function ouvrirFormulairePointage(employeId, typeEvenement) {
            // Redirection vers le formulaire de pointage
            window.location.href = '${pageContext.request.contextPath}/rh/conge/formulaire?employeId=' + employeId + '&type=' + typeEvenement;
        }

        // Fermer les alertes
        document.querySelectorAll('.btn-close').forEach(button => {
            button.addEventListener('click', function() {
                this.closest('.alert').style.display = 'none';
            });
        });

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