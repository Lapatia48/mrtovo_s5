<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Candidats - BusinessSuite</title>
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

        .back-btn {
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

        .back-btn:hover {
            background: var(--navy-light);
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

        .table-actions {
            display: flex;
            gap: 0.5rem;
        }

        .candidats-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.875rem;
        }

        .candidats-table th {
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

        .candidats-table th:hover {
            background: var(--cream-dark);
        }

        .candidats-table th::after {
            content: '↕';
            position: absolute;
            right: 15px;
            opacity: 0.7;
            font-size: 0.8rem;
        }

        .candidats-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--gray-light);
            transition: var(--transition);
        }

        .candidats-table tbody tr:nth-child(even) {
            background: var(--gray-lighter);
        }

        .candidats-table tbody tr:hover {
            background: var(--cream);
        }

        .candidats-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Badges et Actions */
        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
        }

        .status-noted {
            background: var(--navy-blue);
            color: var(--white);
        }

        .status-not-rated {
            background: var(--gray-light);
            color: var(--gray);
        }

        .action-link {
            color: var(--navy-blue);
            text-decoration: none;
            font-weight: 500;
            padding: 0.25rem 0.5rem;
            border-radius: var(--border-radius);
            transition: var(--transition);
            border: 1px solid transparent;
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
            font-size: 1rem;
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
            .candidats-table {
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
            .table-actions {
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
        <jsp:include page="../sidebar/sidebarRh.jsp" />

        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Liste des Candidats</h2>
                    <p>Gestion complète des profils candidats</p>
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

            <!-- Cartes de Statistiques -->
            <!-- <div class="stats-grid">
                <div class="stat-card">
                    <h3>Total Candidats</h3>
                    <div class="stat-number">${candidats.size()}</div>
                    <div class="stat-trend">+8% ce mois</div>
                </div>
                <div class="stat-card">
                    <h3>Notes Moyennes</h3>
                    <div class="stat-number">72%</div>
                    <div class="stat-trend">+3% vs dernier mois</div>
                </div>
                <div class="stat-card">
                    <h3>Nouveaux Candidats</h3>
                    <div class="stat-number">15</div>
                    <div class="stat-trend">Cette semaine</div>
                </div>
            </div> -->

            <!-- Section Filtres -->
            <div class="filter-section">
                <div class="filter-header">
                    <h3>Filtres des candidats</h3>
                </div>
                
                <input type="text" id="globalSearch" class="filter-input" placeholder="Rechercher dans tous les champs..." style="margin-bottom: 1rem;">
                
                <div class="filter-grid">
                    <input type="text" id="nomFilter" class="filter-input" placeholder="Filtrer par nom">
                    <input type="text" id="prenomFilter" class="filter-input" placeholder="Filtrer par prénom">
                    <input type="text" id="emailFilter" class="filter-input" placeholder="Filtrer par email">
                    <input type="text" id="adresseFilter" class="filter-input" placeholder="Filtrer par adresse">
                    <input type="text" id="departementFilter" class="filter-input" placeholder="Filtrer par poste">
                    <input type="text" id="diplomeFilter" class="filter-input" placeholder="Filtrer par diplôme">
                    
                    <select id="ageFilter" class="filter-select">
                        <option value="">Tous les âges</option>
                        <option value="18">18+ ans</option>
                        <option value="18-35">18 à 35 ans</option>
                        <option value="35">35+ ans</option>
                    </select>

                    <select id="experienceFilter" class="filter-select">
                        <option value="">Toutes les expériences</option>
                        <option value="0">0 an</option>
                        <option value="1">1+ an</option>
                        <option value="2">2+ ans</option>
                        <option value="3">3+ ans</option>
                        <option value="4">4+ ans</option>
                        <option value="5">5+ ans</option>
                    </select>
                    
                    <select id="dateSort" class="filter-select">
                        <option value="">Trier par date</option>
                        <option value="asc">Date croissante</option>
                        <option value="desc">Date décroissante</option>
                    </select>

                    <select id="noteQcmFilter" class="filter-select">
                        <option value="">Toutes les notes</option>
                        <option value="50-">Moins de 50%</option>
                        <option value="50+">50% et plus</option>
                        <option value="75+">75% et plus</option>
                        <option value="100">100%</option>
                        <option value="non-note">Non noté</option>
                    </select>
                </div>
                
                <div class="filter-actions">
                    <button onclick="resetFilters()" class="btn btn-secondary">Réinitialiser</button>
                </div>
            </div>

            <!-- Tableau des candidats -->
            <div class="table-container">
                <div class="table-header">
                    <h3>Tous les Candidats</h3>
                    <div class="table-actions">
                        <button class="btn btn-primary">
                            <i class="fas fa-download"></i>
                            Exporter
                        </button>
                    </div>
                </div>
                
                <table class="candidats-table" id="candidatsTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable(0)">Nom</th>
                            <th onclick="sortTable(1)">Prénom</th>
                            <th onclick="sortTable(2)">Email</th>
                            <th onclick="sortTable(3)">Adresse</th>
                            <th onclick="sortTable(4)">Date de naissance</th>
                            <th onclick="sortTable(5)">Âge</th>
                            <th onclick="sortTable(6)">Departement</th>
                            <th onclick="sortTable(7)">Expérience</th>
                            <th onclick="sortTable(8)">Diplôme</th>
                            <th onclick="sortTable(9)">Date de postulation</th>
                            <th>Note QCM</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="candidatsBody">
                        <c:forEach var="c" items="${candidats}">
                            <tr>
                                <td><strong>${c.nom}</strong></td>
                                <td>${c.prenom}</td>
                                <td>${c.mail}</td>
                                <td>${c.adresse}</td>
                                <td>${c.dateNaissance}</td>
                                <td>${c.age} ans</td>
                                <td>${c.departement}</td>
                                <td>${c.anneeExperience} ans</td>
                                <td>${c.diplome}</td>
                                <td>${c.datePostule}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.noteQcm != null}">
                                            <span class="status-badge status-noted">${c.noteQcm}%</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-not-rated">Non noté</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/rh/candidats/pdf?id_cand=${c.id}" class="action-link" title="Télécharger PDF">
                                        <i class="fas fa-file-pdf"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div id="noResults" class="no-results" style="display: none;">
                    <i class="fas fa-search" style="font-size: 2rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                    <p>Aucun candidat ne correspond aux critères de recherche.</p>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Script JavaScript identique à la version précédente
        let currentSortColumn = -1;
        let sortDirection = 1;

        document.getElementById('globalSearch').addEventListener('input', filterTable);
        document.getElementById('nomFilter').addEventListener('input', filterTable);
        document.getElementById('prenomFilter').addEventListener('input', filterTable);
        document.getElementById('emailFilter').addEventListener('input', filterTable);
        document.getElementById('adresseFilter').addEventListener('input', filterTable);
        document.getElementById('departementFilter').addEventListener('input', filterTable);
        document.getElementById('diplomeFilter').addEventListener('input', filterTable);
        document.getElementById('ageFilter').addEventListener('change', filterTable);
        document.getElementById('experienceFilter').addEventListener('change', filterTable);
        document.getElementById('dateSort').addEventListener('change', applySorting);
        document.getElementById('noteQcmFilter').addEventListener('change', filterTable);

        function filterTable() {
            const globalSearch = document.getElementById('globalSearch').value.toLowerCase();
            const nomFilter = document.getElementById('nomFilter').value.toLowerCase();
            const prenomFilter = document.getElementById('prenomFilter').value.toLowerCase();
            const emailFilter = document.getElementById('emailFilter').value.toLowerCase();
            const adresseFilter = document.getElementById('adresseFilter').value.toLowerCase();
            const departementFilter = document.getElementById('departementFilter').value.toLowerCase();
            const diplomeFilter = document.getElementById('diplomeFilter').value.toLowerCase();
            const ageFilter = document.getElementById('ageFilter').value;
            const experienceFilter = document.getElementById('experienceFilter').value;
            const noteQcmFilter = document.getElementById('noteQcmFilter').value;

            const rows = document.querySelectorAll('#candidatsBody tr');
            let visibleCount = 0;

            rows.forEach(row => {
                const cells = row.getElementsByTagName('td');
                let showRow = true;

                if (globalSearch) {
                    let rowText = '';
                    for (let i = 0; i < cells.length - 1; i++) {
                        rowText += cells[i].textContent.toLowerCase() + ' ';
                    }
                    if (!rowText.includes(globalSearch)) {
                        showRow = false;
                    }
                }

                if (showRow && nomFilter && !cells[0].textContent.toLowerCase().includes(nomFilter)) {
                    showRow = false;
                }
                if (showRow && prenomFilter && !cells[1].textContent.toLowerCase().includes(prenomFilter)) {
                    showRow = false;
                }
                if (showRow && emailFilter && !cells[2].textContent.toLowerCase().includes(emailFilter)) {
                    showRow = false;
                }
                if (showRow && adresseFilter && !cells[3].textContent.toLowerCase().includes(adresseFilter)) {
                    showRow = false;
                }
                if (showRow && departementFilter && !cells[6].textContent.toLowerCase().includes(departementFilter)) {
                    showRow = false;
                }
                if (showRow && diplomeFilter && !cells[8].textContent.toLowerCase().includes(diplomeFilter)) {
                    showRow = false;
                }

                if (showRow && ageFilter !== '') {
                    const ageCell = cells[5].textContent;
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

                if (showRow && experienceFilter !== '') {
                    const expCell = cells[7].textContent;
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

                if (showRow && noteQcmFilter !== '') {
                    const noteQcmCell = cells[10].textContent.trim();
                    
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

            document.getElementById('noResults').style.display = visibleCount === 0 ? 'block' : 'none';
        }

        function applySorting() {
            const dateSort = document.getElementById('dateSort').value;
            if (dateSort) {
                sortTableByColumn(9, dateSort);
            }
        }

        function sortTable(columnIndex) {
            const sortOrder = sortDirection === 1 ? 'asc' : 'desc';
            sortTableByColumn(columnIndex, sortOrder);
            sortDirection = -sortDirection;
        }

        function sortTableByColumn(columnIndex, order) {
            const tbody = document.getElementById('candidatsBody');
            const rows = Array.from(tbody.getElementsByTagName('tr'));

            rows.sort((a, b) => {
                const aCell = a.getElementsByTagName('td')[columnIndex].textContent;
                const bCell = b.getElementsByTagName('td')[columnIndex].textContent;

                let aValue, bValue;

                if (columnIndex === 5 || columnIndex === 7) {
                    aValue = extractNumber(aCell);
                    bValue = extractNumber(bCell);
                } else if (columnIndex === 9) {
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

            rows.forEach(row => tbody.appendChild(row));
            updateSortIndicators(columnIndex, order);
        }

        function extractNumber(text) {
            const match = text.match(/(\d+)/);
            return match ? parseInt(match[1]) : 0;
        }

        function updateSortIndicators(columnIndex, order) {
            const headers = document.querySelectorAll('#candidatsTable th');
            headers.forEach((header, index) => {
                header.className = '';
                if (index === columnIndex) {
                    header.className = order === 'asc' ? 'sort-asc' : 'sort-desc';
                }
            });
        }

        function resetFilters() {
            document.getElementById('globalSearch').value = '';
            document.getElementById('nomFilter').value = '';
            document.getElementById('prenomFilter').value = '';
            document.getElementById('emailFilter').value = '';
            document.getElementById('adresseFilter').value = '';
            document.getElementById('departementFilter').value = '';
            document.getElementById('diplomeFilter').value = '';
            document.getElementById('ageFilter').value = '';
            document.getElementById('experienceFilter').value = '';
            document.getElementById('dateSort').value = '';
            document.getElementById('noteQcmFilter').value = '';
            
            const headers = document.querySelectorAll('#candidatsTable th');
            headers.forEach(header => {
                header.className = '';
            });
            
            filterTable();
        }

        document.addEventListener('DOMContentLoaded', function() {
            filterTable();
        });
    </script>
</body>
</html>