<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des candidats</title>
</head>
<body>
    <h2>Liste des candidats</h2>
    <a href="${pageContext.request.contextPath}/accueilRh">Retour</a>

    <!-- Section Filtres -->
    <div class="filter-section">
        <h3>Filtres des candidats</h3>
        <input type="text" id="globalSearch" placeholder="Rechercher dans tous les champs..." style="width: 300px;">
        
        <br>
        <input type="text" id="nomFilter" placeholder="Filtrer par nom...">
        <input type="text" id="prenomFilter" placeholder="Filtrer par prénom...">
        <input type="text" id="emailFilter" placeholder="Filtrer par email...">
        <input type="text" id="adresseFilter" placeholder="Filtrer par adresse...">
        <input type="text" id="departementFilter" placeholder="Filtrer par poste...">
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
        
        <select id="dateSort">
            <option value="">Trier par date</option>
            <option value="asc">Date croissante</option>
            <option value="desc">Date décroissante</option>
        </select>
        
        <button onclick="resetFilters()">Réinitialiser</button>
    </div>

    <!-- Tableau des candidats -->
    <div id="tableContainer">
        <table border="1" cellpadding="5" id="candidatsTable">
            <thead>
                <tr>
                    <th onclick="sortTable(0)">Nom</th>
                    <th onclick="sortTable(1)">Prénom</th>
                    <th onclick="sortTable(2)">Email</th>
                    <th onclick="sortTable(3)">Adresse</th>
                    <th onclick="sortTable(4)">Date de naissance</th>
                    <th onclick="sortTable(5)">Âge</th>
                    <th onclick="sortTable(6)">Poste</th>
                    <th onclick="sortTable(7)">Expérience</th>
                    <th onclick="sortTable(8)">Diplôme</th>
                    <th onclick="sortTable(9)">Date de postulation</th>
                    <th>PDF</th>
                </tr>
            </thead>
            <tbody id="candidatsBody">
                <c:forEach var="c" items="${candidats}">
                    <tr>
                        <td>${c.nom}</td>
                        <td>${c.prenom}</td>
                        <td>${c.mail}</td>
                        <td>${c.adresse}</td>
                        <td>${c.dateNaissance}</td>
                        <td>${c.age} ans</td>
                        <td>${c.departement}</td>
                        <td>${c.anneeExperience} ans</td>
                        <td>${c.diplome}</td>
                        <td>${c.datePostule}</td>
                        <td><a href="${pageContext.request.contextPath}/rh/candidats/pdf?id_cand=${c.id}">PDF</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div id="noResults" style="display: none; text-align: center; padding: 20px;">
            Aucun candidat ne correspond aux critères de recherche.
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
        document.getElementById('diplomeFilter').addEventListener('input', filterTable);
        document.getElementById('ageFilter').addEventListener('change', filterTable);
        document.getElementById('experienceFilter').addEventListener('change', filterTable);
        document.getElementById('dateSort').addEventListener('change', applySorting);

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

            const rows = document.querySelectorAll('#candidatsBody tr');
            let visibleCount = 0;

            rows.forEach(row => {
                const cells = row.getElementsByTagName('td');
                let showRow = true;

                // Filtre global
                if (globalSearch) {
                    let rowText = '';
                    for (let i = 0; i < cells.length - 1; i++) { // -1 pour exclure la colonne PDF
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
                if (showRow && diplomeFilter && !cells[8].textContent.toLowerCase().includes(diplomeFilter)) {
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

                row.style.display = showRow ? '' : 'none';
                if (showRow) visibleCount++;
            });

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
                if (columnIndex === 5 || columnIndex === 7) { // Âge et Expérience
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
            const match = text.match(/(\d+)/);
            return match ? parseInt(match[1]) : 0;
        }

        function updateSortIndicators(columnIndex, order) {
            const headers = document.querySelectorAll('#candidatsTable th');
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
            document.getElementById('diplomeFilter').value = '';
            document.getElementById('ageFilter').value = '';
            document.getElementById('experienceFilter').value = '';
            document.getElementById('dateSort').value = '';
            
            // Réinitialiser les indicateurs de tri
            const headers = document.querySelectorAll('#candidatsTable th');
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