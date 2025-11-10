<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Historique des Paiements - BusinessSuite RH</title>
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

        /* Tableau des paiements */
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

        .badge-primary {
            background: var(--navy-blue);
            color: var(--white);
        }

        .badge-info {
            background: var(--info);
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
                    <h2>Historique des Paiements</h2>
                    <p>Consultation de l'historique complet des paiements des employés</p>
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

            <!-- Section Filtres -->
            <div class="filter-section">
                <h3><i class="fas fa-filter"></i> Filtres des paiements</h3>
                
                <div class="filter-grid">
                    <div class="filter-group global-search">
                        <label for="globalSearch">Recherche globale</label>
                        <input type="text" id="globalSearch" class="filter-input" placeholder="Rechercher dans tous les champs...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="idEmployeFilter">ID Employé</label>
                        <input type="text" id="idEmployeFilter" class="filter-input" placeholder="Filtrer par ID employé...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="periodeDebutFilter">Période début</label>
                        <input type="date" id="periodeDebutFilter" class="filter-input">
                    </div>
                    
                    <div class="filter-group">
                        <label for="periodeFinFilter">Période fin</label>
                        <input type="date" id="periodeFinFilter" class="filter-input">
                    </div>
                    
                    <div class="filter-group">
                        <label for="datePaiementFilter">Date de paiement</label>
                        <input type="date" id="datePaiementFilter" class="filter-input">
                    </div>
                    
                    <div class="filter-group">
                        <label for="modePaiementFilter">Mode de paiement</label>
                        <select id="modePaiementFilter" class="filter-select">
                            <option value="">Tous les modes</option>
                            <option value="virement">Virement</option>
                            <option value="cheque">Chèque</option>
                            <option value="especes">Espèces</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="salaireMinFilter">Salaire minimum</label>
                        <input type="number" id="salaireMinFilter" class="filter-input" placeholder="Salaire min...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="salaireMaxFilter">Salaire maximum</label>
                        <input type="number" id="salaireMaxFilter" class="filter-input" placeholder="Salaire max...">
                    </div>
                    
                    <div class="filter-group">
                        <label for="datePaiementSort">Tri par date de paiement</label>
                        <select id="datePaiementSort" class="filter-select">
                            <option value="">Ordre par défaut</option>
                            <option value="asc">Plus anciens</option>
                            <option value="desc">Plus récents</option>
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

            <!-- Tableau des paiements -->
            <div class="table-container">
                <div class="table-header">
                    <h3>Liste des paiements</h3>
                    <div class="table-count" id="resultCount">
                        ${listePaies.size()} paiement(s) trouvé(s)
                    </div>
                </div>
                
                <table class="data-table" id="paiementsTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable(0)">ID <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(1)">ID Employé <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(2)">Période <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(3)">Salaire Base <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(4)">Salaire Brut <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(5)">Net à Payer <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(6)">Date Paiement <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(7)">Mode Paiement <i class="fas fa-sort"></i></th>
                        </tr>
                    </thead>
                    <tbody id="paiementsBody">
                        <c:forEach var="paie" items="${listePaies}">
                            <tr>
                                <td><strong>#${paie.id}</strong></td>
                                <td>
                                    <span class="badge badge-primary">${paie.idEmploye}</span>
                                </td>
                                <td>${paie.periodeDebut} à ${paie.periodeFin}</td>
                                <td class="currency">${paie.salaireBase} Ar</td>
                                <td class="currency">${paie.salaireBrut} Ar</td>
                                <td class="currency">
                                    <span class="badge badge-success">${paie.netAPayer} Ar</span>
                                </td>
                                <td>${paie.datePaie}</td>
                                <td>
                                    <span class="badge badge-info">${paie.modePaiement}</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div id="noResults" class="no-results" style="display: none;">
                    <i class="fas fa-file-invoice-dollar"></i>
                    <h3>Aucun paiement trouvé</h3>
                    <p>Aucun paiement ne correspond aux critères de recherche sélectionnés.</p>
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
        document.getElementById('idEmployeFilter').addEventListener('input', filterTable);
        document.getElementById('periodeDebutFilter').addEventListener('change', filterTable);
        document.getElementById('periodeFinFilter').addEventListener('change', filterTable);
        document.getElementById('datePaiementFilter').addEventListener('change', filterTable);
        document.getElementById('modePaiementFilter').addEventListener('change', filterTable);
        document.getElementById('salaireMinFilter').addEventListener('input', filterTable);
        document.getElementById('salaireMaxFilter').addEventListener('input', filterTable);
        document.getElementById('datePaiementSort').addEventListener('change', applySorting);

        function filterTable() {
            const globalSearch = document.getElementById('globalSearch').value.toLowerCase();
            const idEmployeFilter = document.getElementById('idEmployeFilter').value.toLowerCase();
            const periodeDebutFilter = document.getElementById('periodeDebutFilter').value;
            const periodeFinFilter = document.getElementById('periodeFinFilter').value;
            const datePaiementFilter = document.getElementById('datePaiementFilter').value;
            const modePaiementFilter = document.getElementById('modePaiementFilter').value;
            const salaireMinFilter = document.getElementById('salaireMinFilter').value;
            const salaireMaxFilter = document.getElementById('salaireMaxFilter').value;

            const rows = document.querySelectorAll('#paiementsBody tr');
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

                // Filtre par ID employé
                if (showRow && idEmployeFilter && !cells[1].textContent.toLowerCase().includes(idEmployeFilter)) {
                    showRow = false;
                }

                // Filtre par période début
                if (showRow && periodeDebutFilter) {
                    const periodeCell = cells[2].textContent;
                    if (periodeCell < periodeDebutFilter) {
                        showRow = false;
                    }
                }

                // Filtre par période fin
                if (showRow && periodeFinFilter) {
                    const periodeCell = cells[2].textContent;
                    if (periodeCell > periodeFinFilter) {
                        showRow = false;
                    }
                }

                // Filtre par date de paiement
                if (showRow && datePaiementFilter) {
                    const datePaiementCell = cells[6].textContent.trim();
                    if (datePaiementCell !== datePaiementFilter) {
                        showRow = false;
                    }
                }

                // Filtre par mode de paiement
                if (showRow && modePaiementFilter !== '') {
                    const modePaiementCell = cells[7].textContent.toLowerCase();
                    if (!modePaiementCell.includes(modePaiementFilter.toLowerCase())) {
                        showRow = false;
                    }
                }

                // Filtre par salaire minimum
                if (showRow && salaireMinFilter !== '') {
                    const salaireCell = cells[5].textContent;
                    const salaireMatch = salaireCell.match(/(\d+)/);
                    if (salaireMatch) {
                        const salaire = parseInt(salaireMatch[1]);
                        const minSalaire = parseInt(salaireMinFilter);
                        
                        if (salaire < minSalaire) {
                            showRow = false;
                        }
                    } else {
                        showRow = false;
                    }
                }

                // Filtre par salaire maximum
                if (showRow && salaireMaxFilter !== '') {
                    const salaireCell = cells[5].textContent;
                    const salaireMatch = salaireCell.match(/(\d+)/);
                    if (salaireMatch) {
                        const salaire = parseInt(salaireMatch[1]);
                        const maxSalaire = parseInt(salaireMaxFilter);
                        
                        if (salaire > maxSalaire) {
                            showRow = false;
                        }
                    } else {
                        showRow = false;
                    }
                }

                row.style.display = showRow ? '' : 'none';
                if (showRow) visibleCount++;
            });

            // Mettre à jour le compteur
            document.getElementById('resultCount').textContent = visibleCount + ' paiement(s) trouvé(s)';
            
            // Afficher/masquer le message "Aucun résultat"
            document.getElementById('noResults').style.display = visibleCount === 0 ? 'block' : 'none';
        }

        function applySorting() {
            const dateSort = document.getElementById('datePaiementSort').value;
            if (dateSort) {
                sortTableByColumn(6, dateSort);
            }
        }

        function sortTable(columnIndex) {
            const sortOrder = sortDirection === 1 ? 'asc' : 'desc';
            sortTableByColumn(columnIndex, sortOrder);
            
            // Inverser la direction pour le prochain clic
            sortDirection = -sortDirection;
        }

        function sortTableByColumn(columnIndex, order) {
            const tbody = document.getElementById('paiementsBody');
            const rows = Array.from(tbody.getElementsByTagName('tr'));

            rows.sort((a, b) => {
                const aCell = a.getElementsByTagName('td')[columnIndex].textContent;
                const bCell = b.getElementsByTagName('td')[columnIndex].textContent;

                let aValue, bValue;

                // Gestion spéciale pour les colonnes numériques
                if (columnIndex === 0 || columnIndex === 1) { // ID et ID Employé
                    aValue = extractNumber(aCell);
                    bValue = extractNumber(bCell);
                } else if (columnIndex === 3 || columnIndex === 4 || columnIndex === 5) { // Salaires
                    aValue = extractNumber(aCell);
                    bValue = extractNumber(bCell);
                } else if (columnIndex === 2 || columnIndex === 6) { // Dates
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
            const match = text.match(/(\d+)/);
            return match ? parseInt(match[1]) : 0;
        }

        function updateSortIndicators(columnIndex, order) {
            const headers = document.querySelectorAll('#paiementsTable th');
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
            document.getElementById('idEmployeFilter').value = '';
            document.getElementById('periodeDebutFilter').value = '';
            document.getElementById('periodeFinFilter').value = '';
            document.getElementById('datePaiementFilter').value = '';
            document.getElementById('modePaiementFilter').value = '';
            document.getElementById('salaireMinFilter').value = '';
            document.getElementById('salaireMaxFilter').value = '';
            document.getElementById('datePaiementSort').value = '';
            
            filterTable();
        }

        function exportToExcel() {
            alert('Fonctionnalité d\'export Excel en cours de développement');
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