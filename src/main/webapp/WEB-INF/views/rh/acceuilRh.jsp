<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil RH</title>
</head>
<body>
    <p style="color: green;">${success}</p>
    <div class="container">
        <h2>Bienvenue RH</h2>

        <a href="${pageContext.request.contextPath}/logout">Se deconnecter</a>
        <br>
        <a href="${pageContext.request.contextPath}/rh/candidats">Voir la liste des candidats</a>
        <br>
        <a href="${pageContext.request.contextPath}/rh/listCandidatRefuse">Voir la liste des candidats refusés</a>
        <br>
        <a href="${pageContext.request.contextPath}/rh/essai">Voir la liste des candidats en période d'essai</a>
        <br>
        <a href="${pageContext.request.contextPath}/rh/essaiRenouv">Voir la liste des candidats en renouvellement d'essai</a>
        <br>
        <a href="${pageContext.request.contextPath}/rh/employe">Liste de nos employes</a>
        <br><br>
        <!-- Section Filtres -->
        <div class="filter-section">
            <h3>Filtres des candidats admis au QCM</h3>
            <input type="text" id="globalSearch" placeholder="Rechercher dans tous les champs..." style="width: 300px;">
            
            <br>
            <input type="text" id="nomFilter" placeholder="Filtrer par nom...">
            <input type="text" id="prenomFilter" placeholder="Filtrer par prénom...">
            <input type="text" id="departementFilter" placeholder="Filtrer par département...">
            <input type="text" id="diplomeFilter" placeholder="Filtrer par diplôme...">
            <input type="text" id="annonceFilter" placeholder="Filtrer par annonce...">
            
            <select id="noteFilter">
                <option value="">Toutes les notes</option>
                <option value="0">Sans note</option>
                <option value="50">50%+</option>
                <option value="75">75%+</option>
                <option value="100">100%</option>
            </select>
                        
            <select id="experienceFilter">
                <option value="">Toutes les expériences</option>
                <option value="0">0 an</option>
                <option value="1">1+ an</option>
                <option value="2">2+ ans</option>
                <option value="3">3+ ans</option>
                <option value="5">5+ ans</option>
            </select>
            
            <button onclick="resetFilters()">Réinitialiser</button>
        </div>

        <!-- Tableau des candidats admis -->
        <div id="tableContainer">
            <table class="candidats-table" id="candidatsTable" border="1">
                <thead>
                    <tr>
                        <th onclick="sortTable(0)">Nom</th>
                        <th onclick="sortTable(1)">Prénom</th>
                        <th onclick="sortTable(2)">Email</th>
                        <th onclick="sortTable(3)">Âge</th>
                        <th onclick="sortTable(4)">Expérience</th>
                        <th onclick="sortTable(5)">Diplôme</th>
                        <th onclick="sortTable(6)">Département</th>
                        <th onclick="sortTable(7)">Annonce</th>
                        <th onclick="sortTable(8)">Salaire annonce</th>
                        <th onclick="sortTable(9)">Note QCM</th>
                        <th>PDF</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="candidatsBody">
                    <c:forEach var="candidat" items="${candidatsAdmis}">
                        <tr>
                            <td>${candidat.nom}</td>
                            <td>${candidat.prenom}</td>
                            <td>${candidat.mail}</td>
                            <td>${candidat.age}</td>
                            <td>${candidat.anneeExperience} an(s)</td>
                            <td>${candidat.diplome}</td>
                            <td>${candidat.departement}</td>
                            <td>${candidat.annoncePostulee}</td>
                            <td>${candidat.salaireAnnonce} Ar</td>
                            <td>
                                <c:choose>
                                    <c:when test="${candidat.noteQcm != null}">
                                        ${candidat.noteQcm}%
                                    </c:when>
                                    <c:otherwise>
                                        Non noté
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><a href="${pageContext.request.contextPath}/rh/candidats/pdf?id_cand=${candidat.id}">PDF</a></td>
                            <td><a href="${pageContext.request.contextPath}/rh/entretien?id_cand=${candidat.id}">Faire passer l'entretien</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div id="noResults" class="no-results" style="display: none;">
                Aucun candidat ne correspond aux critères de recherche.
            </div>
        </div>
    </div>

    <script>
        let currentSortColumn = -1;
        let sortDirection = 1;

        // Filtrage global
        document.getElementById('globalSearch').addEventListener('input', filterTable);
        document.getElementById('nomFilter').addEventListener('input', filterTable);
        document.getElementById('prenomFilter').addEventListener('input', filterTable);
        document.getElementById('departementFilter').addEventListener('input', filterTable);
        document.getElementById('diplomeFilter').addEventListener('input', filterTable);
        document.getElementById('annonceFilter').addEventListener('input', filterTable);
        document.getElementById('noteFilter').addEventListener('change', filterTable);
        document.getElementById('experienceFilter').addEventListener('change', filterTable);

        function filterTable() {
            const globalSearch = document.getElementById('globalSearch').value.toLowerCase();
            const nomFilter = document.getElementById('nomFilter').value.toLowerCase();
            const prenomFilter = document.getElementById('prenomFilter').value.toLowerCase();
            const departementFilter = document.getElementById('departementFilter').value.toLowerCase();
            const diplomeFilter = document.getElementById('diplomeFilter').value.toLowerCase();
            const annonceFilter = document.getElementById('annonceFilter').value.toLowerCase();
            const noteFilter = document.getElementById('noteFilter').value;
            const experienceFilter = document.getElementById('experienceFilter').value;

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
                if (showRow && departementFilter && !cells[6].textContent.toLowerCase().includes(departementFilter)) {
                    showRow = false;
                }
                if (showRow && diplomeFilter && !cells[5].textContent.toLowerCase().includes(diplomeFilter)) {
                    showRow = false;
                }
                if (showRow && annonceFilter && !cells[7].textContent.toLowerCase().includes(annonceFilter)) {
                    showRow = false;
                }

                // Filtre par note (en pourcentage)
                if (showRow && noteFilter !== '') {
                    const noteCell = cells[9].textContent;
                    
                    if (noteFilter === '0') {
                        // Filtre "Sans note"
                        if (!noteCell.includes('Non noté')) showRow = false;
                    } else {
                        // Extraire le pourcentage
                        const percentMatch = noteCell.match(/(\d+)%/);
                        if (percentMatch) {
                            const percent = parseInt(percentMatch[1]);
                            const minPercent = parseInt(noteFilter);
                            
                            if (percent < minPercent) {
                                showRow = false;
                            }
                        } else {
                            // Si pas de pourcentage trouvé et qu'on filtre par note, masquer la ligne
                            showRow = false;
                        }
                    }
                }

                // Filtre par expérience
                if (showRow && experienceFilter !== '') {
                    const expCell = cells[4].textContent;
                    const expMatch = expCell.match(/(\d+)/);
                    if (!expMatch || parseInt(expMatch[1]) < parseInt(experienceFilter)) {
                        showRow = false;
                    }
                }

                row.style.display = showRow ? '' : 'none';
                if (showRow) visibleCount++;
            });

            // Afficher/masquer le message "Aucun résultat"
            document.getElementById('noResults').style.display = visibleCount === 0 ? 'block' : 'none';
        }

        function sortTable(columnIndex) {
            const table = document.getElementById('candidatsTable');
            const tbody = document.getElementById('candidatsBody');
            const rows = Array.from(tbody.getElementsByTagName('tr'));

            if (currentSortColumn === columnIndex) {
                sortDirection = -sortDirection;
            } else {
                currentSortColumn = columnIndex;
                sortDirection = 1;
            }

            rows.sort((a, b) => {
                const aCell = a.getElementsByTagName('td')[columnIndex].textContent;
                const bCell = b.getElementsByTagName('td')[columnIndex].textContent;

                let aValue, bValue;

                // Gestion spéciale pour les colonnes numériques
                if (columnIndex === 3 || columnIndex === 4 || columnIndex === 8 || columnIndex === 9) {
                    aValue = extractNumber(aCell);
                    bValue = extractNumber(bCell);
                } else {
                    aValue = aCell.toLowerCase();
                    bValue = bCell.toLowerCase();
                }

                if (aValue < bValue) return -1 * sortDirection;
                if (aValue > bValue) return 1 * sortDirection;
                return 0;
            });

            // Réinsérer les lignes triées
            rows.forEach(row => tbody.appendChild(row));

            // Mettre à jour les en-têtes pour indiquer le tri
            updateSortIndicators(columnIndex);
        }

        function extractNumber(text) {
            const match = text.match(/(\d+)/);
            return match ? parseInt(match[1]) : 0;
        }

        function updateSortIndicators(columnIndex) {
            const headers = document.querySelectorAll('#candidatsTable th');
            headers.forEach((header, index) => {
                header.textContent = header.textContent.replace(' ▲', '').replace(' ▼', '');
                if (index === columnIndex) {
                    header.textContent += sortDirection === 1 ? ' ▲' : ' ▼';
                }
            });
        }

        function resetFilters() {
            document.getElementById('globalSearch').value = '';
            document.getElementById('nomFilter').value = '';
            document.getElementById('prenomFilter').value = '';
            document.getElementById('departementFilter').value = '';
            document.getElementById('diplomeFilter').value = '';
            document.getElementById('annonceFilter').value = '';
            document.getElementById('noteFilter').value = '';
            document.getElementById('experienceFilter').value = '';
            filterTable();
        }

        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            filterTable();
        });
    </script>
</body>
</html>