<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Entretien - ${candidat.prenom} ${candidat.nom}</title>
</head>
<body>
    <h2>Entretien avec ${candidat.prenom} ${candidat.nom}</h2>
    
    <c:if test="${not empty error}">
        <div style="color: red; margin-bottom: 20px;">
            ${error}
        </div>
    </c:if>
    
    <!-- Div 1: Détails de l'annonce -->
    <div style="border: 1px solid #ccc; padding: 15px; margin-bottom: 20px;">
        <h3>Détails de l'annonce</h3>
        
        <c:choose>
            <c:when test="${not empty candidatAdmis}">
                <table>
                    <tr>
                        <td><strong>Poste :</strong></td>
                        <td>${candidatAdmis.annoncePostulee}</td>
                    </tr>
                    <tr>
                        <td><strong>Département :</strong></td>
                        <td>${candidatAdmis.departement}</td>
                    </tr>
                    <tr>
                        <td><strong>Salaire proposé :</strong></td>
                        <td>${candidatAdmis.salaireAnnonce} Ar</td>
                    </tr>
                    <tr>
                        <td><strong>Note QCM :</strong></td>
                        <td>
                            <c:choose>
                                <c:when test="${candidatAdmis.noteQcm != null}">
                                    ${candidatAdmis.noteQcm}%
                                </c:when>
                                <c:otherwise>
                                    Non noté
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
            </c:when>
            <c:otherwise>
                <p>Informations sur l'annonce non disponibles</p>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Div 2: Détails du candidat -->
    <div style="border: 1px solid #ccc; padding: 15px; margin-bottom: 20px;">
        <h3>Détails du candidat</h3>
        
        <table>
            <tr>
                <td><strong>Nom complet :</strong></td>
                <td>${candidat.nom} ${candidat.prenom}</td>
            </tr>
            <tr>
                <td><strong>Email :</strong></td>
                <td>${candidat.mail}</td>
            </tr>
            <tr>
                <td><strong>Adresse :</strong></td>
                <td>${candidat.adresse}</td>
            </tr>
            <tr>
                <td><strong>Date de naissance :</strong></td>
                <td>${candidat.dateNaissance}</td>
            </tr>
            <tr>
                <td><strong>Âge :</strong></td>
                <td>${candidat.age} ans</td>
            </tr>
            <tr>
                <td><strong>Diplôme :</strong></td>
                <td>${candidat.diplome}</td>
            </tr>
            <tr>
                <td><strong>Expérience :</strong></td>
                <td>${candidat.anneeExperience} ans</td>
            </tr>
            <tr>
                <td><strong>Département souhaité :</strong></td>
                <td>${candidat.departement}</td>
            </tr>
            <tr>
                <td><strong>Date de postulation :</strong></td>
                <td>${candidat.datePostule}</td>
            </tr>
            <c:if test="${not empty candidat.renseignement}">
                <tr>
                    <td><strong>Informations supplémentaires :</strong></td>
                    <td>${candidat.renseignement}</td>
                </tr>
            </c:if>
        </table>
    </div>
    
    <!-- valider l'entretien  -->
    <div style="border: 1px solid #ccc; padding: 15px;">
        <h3>Notes d'entretien</h3>
        <form method="post" action="${pageContext.request.contextPath}/rh/entretien/valider">
            <input type="hidden" name="idCandidat" value="${candidat.id}" required>
                        
            <div style="margin-bottom: 15px;">
                <label for="statut"><strong>Statut :</strong></label><br>
                <select id="statut" name="statut" required onchange="toggleEssaiFields()">
                    <option value="">selectionner</option>
                    <option value="essai">Validé pour periode d'essai</option>
                    <option value="refuse">Refusé</option>
                </select>
            </div>

            <div id="essaiFields" style="display: none; margin-bottom: 15px;">
                <label for="periode"><strong>Periode accordee:</strong></label><br>
                <select name="periode" id="periode">
                    <option value="">selectionner</option>
                    <option value="3">3 mois</option>
                    <option value="6">6 mois</option>
                </select>
            </div>

            <div id="salaireField" style="display: none; margin-bottom: 15px;">
                <label for="salairePropose"><strong>Salaire conclu :</strong></label><br>
                <input type="number" id="salairePropose" name="salairePropose" placeholder="Salaire proposé en Ariary">
            </div>
            
            <button type="submit">Valider l'entretien</button>
        </form>
    </div>

    <script>
        function toggleEssaiFields() {
            const statut = document.getElementById('statut').value;
            const essaiFields = document.getElementById('essaiFields');
            const salaireField = document.getElementById('salaireField');
            
            if (statut === 'essai') {
                essaiFields.style.display = 'block';
                salaireField.style.display = 'block';
                // Rendre requis seulement si statut = essai
                document.getElementById('periode').required = true;
                document.getElementById('salairePropose').required = true;
            } else {
                essaiFields.style.display = 'none';
                salaireField.style.display = 'none';
                // Enlever le required si statut ≠ essai
                document.getElementById('periode').required = false;
                document.getElementById('salairePropose').required = false;
            }
        }

        // Initialiser au chargement
        document.addEventListener('DOMContentLoaded', function() {
            toggleEssaiFields();
        });
    </script>
    
    <br>
    <a href="${pageContext.request.contextPath}/rh/candidats">Retour à la liste</a>
</body>
</html>