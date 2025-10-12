<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Candidats Refusés - BusinessSuite RH</title>
    <style>
        /* Variables CSS - Palette Navy Blue + Cream + White (identique à l'accueil) */
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

        /* Sidebar Navigation (identique à l'accueil) */
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

        /* Top Bar (identique à l'accueil) */
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

        /* Tableau des candidats */
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

        .badge-danger {
            background: var(--danger);
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

        .badge-success {
            background: var(--success);
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
                min-width: 1000px;
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
        <!-- Sidebar Navigation (identique à l'accueil) -->
        <jsp:include page="sidebarRh.jsp" />

        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Candidats Refusés</h2>
                    <p>Gestion et consultation des candidats non retenus</p>
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
                <h3><i class="fas fa-filter"></i> Filtres des candidats refusés</h3>
                
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
                        <label for="etapeFilter">Étape de refus</label>
                        <input type="text" id="etapeFilter" class="filter-input" placeholder="Filtrer par étape...">
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

            <!-- Tableau des candidats refusés -->
            <div class="table-container">
                <div class="table-header">
                    <h3>Liste des candidats refusés</h3>
                    <div class="table-count" id="resultCount">
                        ${candidatsRefuses.size()} candidat(s) trouvé(s)
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
                            <th onclick="sortTable(7)">Note QCM <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(8)">Étape de refus <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(9)">Date postulation <i class="fas fa-sort"></i></th>
                        </tr>
                    </thead>
                    <tbody id="candidatsBody">
                        <c:forEach var="c" items="${candidatsRefuses}">
                            <tr>
                                <td><strong>${c.nom}</strong></td>
                                <td>${c.prenom}</td>
                                <td>${c.mail}</td>
                                <td>${c.age} ans</td>
                                <td>${c.anneeExperience} ans</td>
                                <td>${c.diplome}</td>
                                <td>${c.departement}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.noteQcm != null}">
                                            <span class="badge ${c.noteQcm >= 75 ? 'badge-success' : c.noteQcm >= 50 ? 'badge-warning' : 'badge-danger'}">
                                                ${c.noteQcm}%
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-info">Non noté</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="badge badge-danger">${c.libelleEtape}</span>
                                </td>
                                <td>${c.datePostule}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div id="noResults" class="no-results" style="display: none;">
                    <i class="fas fa-search"></i>
                    <h3>Aucun candidat refusé trouvé</h3>
                    <p>Aucun candidat ne correspond aux critères de recherche sélectionnés.</p>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Le script JavaScript reste identique à votre version originale
        let currentSortColumn = -1;
        let sortDirection = 1;

        // Écouteurs d'événements pour les filtres
        document.getElementById('globalSearch').addEventListener('input', filterTable);
        document.getElementById('nomFilter').addEventListener('input', filterTable);
        document.getElementById('prenomFilter').addEventListener('input', filterTable);
        document.getElementById('emailFilter').addEventListener('input', filterTable);
        document.getElementById('departementFilter').addEventListener('input', filterTable);
        document.getElementById('diplomeFilter').addEventListener('input', filterTable);
        document.getElementById('etapeFilter').addEventListener('input', filterTable);
        document.getElementById('ageFilter').addEventListener('change', filterTable);
        document.getElementById('experienceFilter').addEventListener('change', filterTable);
        document.getElementById('noteQcmFilter').addEventListener('change', filterTable);
        document.getElementById('dateSort').addEventListener('change', applySorting);

        function filterTable() {
            const globalSearch = document.getElementById('globalSearch').value.toLowerCase();
            const nomFilter = document.getElementById('nomFilter').value.toLowerCase();
            const prenomFilter = document.getElementById('prenomFilter').value.toLowerCase();
            const emailFilter = document.getElementById('emailFilter').value.toLowerCase();
            const departementFilter = document.getElementById('departementFilter').value.toLowerCase();
            const diplomeFilter = document.getElementById('diplomeFilter').value.toLowerCase();
            const etapeFilter = document.getElementById('etapeFilter').value.toLowerCase();
            const ageFilter = document.getElementById('ageFilter').value;
            const experienceFilter = document.getElementById('experienceFilter').value;
            const noteQcmFilter = document.getElementById('noteQcmFilter').value;

            const rows = document.querySelectorAll('#candidatsBody tr');
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
                if (showRow && etapeFilter && !cells[8].textContent.toLowerCase().includes(etapeFilter)) {
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

                // Filtre par note QCM
                if (showRow && noteQcmFilter !== '') {
                    const noteQcmCell = cells[7].textContent.trim();
                    
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
            document.getElementById('resultCount').textContent = visibleCount + ' candidat(s) trouvé(s)';
            
            // Afficher/masquer le message "Aucun résultat"
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
                if (columnIndex === 3 || columnIndex === 4 || columnIndex === 7) { // Âge, Expérience, Note QCM
                    aValue = extractNumber(aCell);
                    bValue = extractNumber(bCell);
                } else if (columnIndex === 9) { // Date
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
            document.getElementById('etapeFilter').value = '';
            document.getElementById('ageFilter').value = '';
            document.getElementById('experienceFilter').value = '';
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