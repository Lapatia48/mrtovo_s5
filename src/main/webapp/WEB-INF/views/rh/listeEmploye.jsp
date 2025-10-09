<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des employés</title>
    <style>
        .filter-section {
            background-color: #f5f5f5;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .filter-section input, .filter-section select {
            margin: 5px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            cursor: pointer;
        }
        th:hover {
            background-color: #e6e6e6;
        }
        button {
            padding: 8px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        #noResults {
            display: none;
            text-align: center;
            padding: 20px;
            font-size: 16px;
            color: #666;
        }
    </style>
</head>
<body>
    <h2>Liste des employés</h2>
    <a href="${pageContext.request.contextPath}/accueilRh">Retour</a>

    <!-- Section Filtres -->
    <div class="filter-section">
        <h3>Filtres des employés</h3>
        <input type="text" id="globalSearch" placeholder="Rechercher dans tous les champs..." style="width: 300px;">
        
        <br>
        <input type="text" id="nomFilter" placeholder="Filtrer par nom...">
        <input type="text" id="prenomFilter" placeholder="Filtrer par prénom...">
        <input type="text" id="emailFilter" placeholder="Filtrer par email...">
        <input type="text" id="adresseFilter" placeholder="Filtrer par adresse...">
        <input type="text" id="departementFilter" placeholder="Filtrer par département...">
        <input type="text" id="posteFilter" placeholder="Filtrer par poste...">
        <input type="text" id="diplomeFilter" placeholder="Filtrer par diplôme...">
        
        <br>
        <select id="ageFilter">
            <option value="">Tous les âges</option>
            <option value="18">18+ ans</option>
            <option value="18-35">18 à 35 ans</option>
            <option value="35">35+ ans</option>
        </select>

        <select id="experienceFilter">
            <option value="">Toutes les expériences</option>
            <option value="0">0 an</option>
            <option value="1">1+ an</option>
            <option value="2">2+ ans</option>
            <option value="3">3+ ans</option>
            <option value="4">4+ ans</option>
            <option value="5">5+ ans</option>
        </select>

        <select id="salaireFilter">
            <option value="">Tous les salaires</option>
            <option value="500000">500 000 Ar+</option>
            <option value="800000">800 000 Ar+</option>
            <option value="1000000">1 000 000 Ar+</option>
            <option value="1500000">1 500 000 Ar+</option>
        </select>
        
        <select id="statutFilter">
            <option value="">Tous les statuts</option>
            <option value="actif">Actif</option>
            <option value="inactif">Inactif</option>
        </select>

        <select id="dateEmbaucheSort">
            <option value="">Trier par date d'embauche</option>
            <option value="asc">Date croissante</option>
            <option value="desc">Date décroissante</option>
        </select>
        
        <button onclick="resetFilters()">Réinitialiser</button>
    </div>

    <!-- Tableau des employés -->
    <div id="tableContainer">
        <table border="1" cellpadding="5" id="employesTable">
            <thead>
                <tr>
                    <th onclick="sortTable(0)">Nom</th>
                    <th onclick="sortTable(1)">Prénom</th>
                    <th onclick="sortTable(2)">Email</th>
                    <th onclick="sortTable(3)">Adresse</th>
                    <th onclick="sortTable(4)">Date de naissance</th>
                    <th onclick="sortTable(5)">Âge</th>
                    <th onclick="sortTable(6)">Département</th>
                    <th onclick="sortTable(7)">Poste</th>
                    <th onclick="sortTable(8)">Expérience</th>
                    <th onclick="sortTable(9)">Diplôme</th>
                    <th onclick="sortTable(10)">Date d'embauche</th>
                    <th onclick="sortTable(11)">Salaire</th>
                    <th onclick="sortTable(12)">Statut</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="employesBody">
                <c:forEach var="e" items="${employes}">
                    <tr>
                        <td>${e.nom}</td>
                        <td>${e.prenom}</td>
                        <td>${e.mail}</td>
                        <td>${e.adresse}</td>
                        <td>${e.dateNaissance}</td>
                        <td>${e.age} ans</td>
                        <td>${e.departement}</td>
                        <td>${e.poste}</td>
                        <td>${e.anneeExperience} ans</td>
                        <td>${e.diplome}</td>
                        <td>${e.dateEmbauche}</td>
                        <td>${e.salaire} Ar</td>
                        <td>${e.statut}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/rh/candidats/pdf?id_cand=${e.idCandidat}">exporter en pdf</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div id="noResults" style="display: none; text-align: center; padding: 20px;">
            Aucun employé ne correspond aux critères de recherche.
        </div>
    </div>

    <script>
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
                header.textContent = header.textContent.replace(' ▲', '').replace(' ▼', '');
                if (index === columnIndex) {
                    header.textContent += order === 'asc' ? ' ▲' : ' ▼';
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
            
            // Réinitialiser les indicateurs de tri
            const headers = document.querySelectorAll('#employesTable th');
            headers.forEach(header => {
                header.textContent = header.textContent.replace(' ▲', '').replace(' ▼', '');
            });
            
            filterTable();
        }

        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            filterTable();
        });
    </script>
</body>
</html>