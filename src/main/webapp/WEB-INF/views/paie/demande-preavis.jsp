<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Employés - BusinessSuite RH</title>
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
                min-width: 1200px;
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
        <jsp:include page="sidebarRh.jsp" />


        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Gestion des Employés</h2>
                    <p>Liste et gestion de tous les employés de l'entreprise</p>
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
                <h3><i class="fas fa-filter"></i> Filtres des employés</h3>
                
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
                        <label for="adresseFilter">Adresse</label>
                        <input type="text" id="adresseFilter" class="filter-input" placeholder="Filtrer par adresse...">
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
                        <label for="diplomeFilter">Diplôme</label>
                        <input type="text" id="diplomeFilter" class="filter-input" placeholder="Filtrer par diplôme...">
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
                        <label for="salaireFilter">Salaire minimum</label>
                        <select id="salaireFilter" class="filter-select">
                            <option value="">Tous les salaires</option>
                            <option value="500000">500 000 Ar+</option>
                            <option value="800000">800 000 Ar+</option>
                            <option value="1000000">1 000 000 Ar+</option>
                            <option value="1500000">1 500 000 Ar+</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="statutFilter">Statut</label>
                        <select id="statutFilter" class="filter-select">
                            <option value="">Tous les statuts</option>
                            <option value="actif">Actif</option>
                            <option value="inactif">Inactif</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="dateEmbaucheSort">Tri par date d'embauche</label>
                        <select id="dateEmbaucheSort" class="filter-select">
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

            <!-- Tableau des employés -->
            <div class="table-container">
                <div class="table-header">
                    <h3>Liste des employés</h3>
                    <div class="table-count" id="resultCount">
                        ${employes.size()} employé(s) trouvé(s)
                    </div>
                </div>
                
                <table class="data-table" id="employesTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable(0)">Nom <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(1)">Prénom <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(2)">Email <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(3)">Adresse <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(4)">Date de naissance <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(5)">Âge <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(6)">Département <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(7)">Poste <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(8)">Expérience <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(9)">Diplôme <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(10)">Date d'embauche <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(11)">Salaire <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(12)">Statut <i class="fas fa-sort"></i></th>
                            <th>Actions</th>
                            <!-- <th>Contrat</th>   -->
                            <!-- <th>Creer contrat</th> -->
                        </tr>
                    </thead>
                    <tbody id="employesBody">
                        <c:forEach var="e" items="${employes}">
                            <tr>
                                <td><strong>${e.nom}</strong></td>
                                <td>${e.prenom}</td>
                                <td>${e.mail}</td>
                                <td>${e.adresse}</td>
                                <td>${e.dateNaissance}</td>
                                <!-- <td>
                                    <span class="badge badge-info">${e.age} ans</span>
                                </td>
                                <td>${e.departement}</td>
                                <td>
                                    <span class="badge badge-success">${e.poste}</span>
                                </td>
                                <td>
                                    <span class="badge ${e.anneeExperience >= 3 ? 'badge-success' : e.anneeExperience >= 1 ? 'badge-warning' : 'badge-info'}">
                                        ${e.anneeExperience} ans
                                    </span>
                                </td> -->

                                <td>
                                    <c:choose>
                                        <c:when test="${not empty e.age}">
                                            <span class="badge badge-info">${e.age} ans</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-info">Non spécifié</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${e.departement}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty e.poste}">
                                            <span class="badge badge-success">${e.poste}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-info">Non spécifié</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty e.anneeExperience}">
                                            <span class="badge ${e.anneeExperience >= 3 ? 'badge-success' : e.anneeExperience >= 1 ? 'badge-warning' : 'badge-info'}">
                                                ${e.anneeExperience} ans
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-info">0 an</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>


                                <td>${e.diplome}</td>
                                <td>${e.dateEmbauche}</td>
                                <td>
                                    <strong>${e.salaire} Ar</strong>
                                </td>
                                <td>
                                    <span class="badge ${e.statut == 'actif' ? 'badge-success' : 'badge-danger'}">
                                        ${e.statut}
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/rh/employe/payer?id_emp=${e.id}" class="action-link success">
                                        <i class="fas fa-sign-out-alt"></i>
                                        Payer
                                    </a><br>
                                    <a href="${pageContext.request.contextPath}/rh/paie/formPreavis?id_employe=${e.id}" class="action-link success" title="Exporter en PDF">
                                        <i class="fas fa-plane-departure"></i>
                                        Demande de preavis
                                    </a><br>
                                </td>
                                <!-- Contrats -->
                                <!-- <td>
                                    <c:set var="contratsActifs" value="${contratService.findContratsActifsByEmploye(e.id)}" />
                                    <c:choose>
                                        <c:when test="${ empty contratsActifs}">
                                            <span class="badge badge-success">
                                                ${contratsActifs[0].typeContrat}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-warning">
                                                Sans contrat
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                 <td>
                                    <c:if test="${empty contratsActifs}">
                                        <a href="${pageContext.request.contextPath}/rh/contrat/creer?id_employe=${e.id}" class="btn btn-sm btn-info">
                                            Créer contrat
                                        </a>
                                    </c:if>
                                </td> -->
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div id="noResults" class="no-results" style="display: none;">
                    <i class="fas fa-search"></i>
                    <h3>Aucun employé trouvé</h3>
                    <p>Aucun employé ne correspond aux critères de recherche sélectionnés.</p>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Le script JavaScript adapté pour les employés
        let currentSortColumn = -1;
        let sortDirection = 1;

        // Écouteurs d'événements pour les filtres
        document.getElementById('globalSearch').addEventListener('input', filterTable);
        document.getElementById('nomFilter').addEventListener('input', filterTable);
        document.getElementById('prenomFilter').addEventListener('input', filterTable);
        document.getElementById('emailFilter').addEventListener('input', filterTable);
        document.getElementById('adresseFilter').addEventListener('input', filterTable);
        document.getElementById('departementFilter').addEventListener('input', filterTable);
        document.getElementById('posteFilter').addEventListener('input', filterTable);
        document.getElementById('diplomeFilter').addEventListener('input', filterTable);
        document.getElementById('ageFilter').addEventListener('change', filterTable);
        document.getElementById('experienceFilter').addEventListener('change', filterTable);
        document.getElementById('salaireFilter').addEventListener('change', filterTable);
        document.getElementById('statutFilter').addEventListener('change', filterTable);
        document.getElementById('dateEmbaucheSort').addEventListener('change', applySorting);

        function filterTable() {
            const globalSearch = document.getElementById('globalSearch').value.toLowerCase();
            const nomFilter = document.getElementById('nomFilter').value.toLowerCase();
            const prenomFilter = document.getElementById('prenomFilter').value.toLowerCase();
            const emailFilter = document.getElementById('emailFilter').value.toLowerCase();
            const adresseFilter = document.getElementById('adresseFilter').value.toLowerCase();
            const departementFilter = document.getElementById('departementFilter').value.toLowerCase();
            const posteFilter = document.getElementById('posteFilter').value.toLowerCase();
            const diplomeFilter = document.getElementById('diplomeFilter').value.toLowerCase();
            const ageFilter = document.getElementById('ageFilter').value;
            const experienceFilter = document.getElementById('experienceFilter').value;
            const salaireFilter = document.getElementById('salaireFilter').value;
            const statutFilter = document.getElementById('statutFilter').value;

            const rows = document.querySelectorAll('#employesBody tr');
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
                if (showRow && adresseFilter && !cells[3].textContent.toLowerCase().includes(adresseFilter)) {
                    showRow = false;
                }
                if (showRow && departementFilter && !cells[6].textContent.toLowerCase().includes(departementFilter)) {
                    showRow = false;
                }
                if (showRow && posteFilter && !cells[7].textContent.toLowerCase().includes(posteFilter)) {
                    showRow = false;
                }
                if (showRow && diplomeFilter && !cells[9].textContent.toLowerCase().includes(diplomeFilter)) {
                    showRow = false;
                }

                // Filtre par âge
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

                // Filtre par expérience
                if (showRow && experienceFilter !== '') {
                    const expCell = cells[8].textContent;
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

                // Filtre par salaire
                if (showRow && salaireFilter !== '') {
                    const salaireCell = cells[11].textContent;
                    // Extraire les chiffres du salaire (supprimer les espaces et "Ar")
                    const salaireText = salaireCell.replace(/\s/g, '').replace('Ar', '');
                    const salaireMatch = salaireText.match(/(\d+)/);
                    if (salaireMatch) {
                        const salaire = parseInt(salaireMatch[1]);
                        const minSalaire = parseInt(salaireFilter);
                        
                        if (salaire < minSalaire) {
                            showRow = false;
                        }
                    } else {
                        showRow = false;
                    }
                }

                // Filtre par statut
                if (showRow && statutFilter !== '') {
                    const statutCell = cells[12].textContent.toLowerCase();
                    if (statutCell !== statutFilter.toLowerCase()) {
                        showRow = false;
                    }
                }

                row.style.display = showRow ? '' : 'none';
                if (showRow) visibleCount++;
            });

            // Mettre à jour le compteur
            document.getElementById('resultCount').textContent = visibleCount + ' employé(s) trouvé(s)';
            
            // Afficher/masquer le message "Aucun résultat"
            document.getElementById('noResults').style.display = visibleCount === 0 ? 'block' : 'none';
        }

        function applySorting() {
            const dateSort = document.getElementById('dateEmbaucheSort').value;
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
            const tbody = document.getElementById('employesBody');
            const rows = Array.from(tbody.getElementsByTagName('tr'));

            rows.sort((a, b) => {
                const aCell = a.getElementsByTagName('td')[columnIndex].textContent;
                const bCell = b.getElementsByTagName('td')[columnIndex].textContent;

                let aValue, bValue;

                // Gestion spéciale pour les colonnes numériques
                if (columnIndex === 5 || columnIndex === 8) { // Âge et Expérience
                    aValue = extractNumber(aCell);
                    bValue = extractNumber(bCell);
                } else if (columnIndex === 10 || columnIndex === 4) { // Dates (embauche et naissance)
                    aValue = new Date(aCell);
                    bValue = new Date(bCell);
                } else if (columnIndex === 11) { // Salaire
                    aValue = extractNumber(aCell.replace(/\s/g, '').replace('Ar', ''));
                    bValue = extractNumber(bCell.replace(/\s/g, '').replace('Ar', ''));
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
            const headers = document.querySelectorAll('#employesTable th');
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
            document.getElementById('adresseFilter').value = '';
            document.getElementById('departementFilter').value = '';
            document.getElementById('posteFilter').value = '';
            document.getElementById('diplomeFilter').value = '';
            document.getElementById('ageFilter').value = '';
            document.getElementById('experienceFilter').value = '';
            document.getElementById('salaireFilter').value = '';
            document.getElementById('statutFilter').value = '';
            document.getElementById('dateEmbaucheSort').value = '';
            
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