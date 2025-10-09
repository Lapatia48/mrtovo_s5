<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Renouvellement d'essai - ${candidat.prenom} ${candidat.nom}</title>
</head>
<body>
    <h2>Renouvellement d'essai - ${candidat.prenom} ${candidat.nom}</h2>
    
    <c:if test="${not empty error}">
        <div style="color: red; margin-bottom: 20px;">
            ${error}
        </div>
    </c:if>
    
    <!-- Div 1: Détails de l'annonce -->
    <div style="border: 1px solid #ccc; padding: 15px; margin-bottom: 20px;">
        <h3>Détails de l'annonce</h3>
        
        <c:choose>
            <c:when test="${not empty candidat}">
                <table>
                    <tr>
                        <td><strong>Poste :</strong></td>
                        <td>${candidat.annoncePostulee}</td>
                    </tr>
                    <tr>
                        <td><strong>Département :</strong></td>
                        <td>${candidat.departement}</td>
                    </tr>
                    <tr>
                        <td><strong>Salaire actuel :</strong></td>
                        <td>${candidat.salaire} Ar</td>
                    </tr>
                    <tr>
                        <td><strong>Période actuelle :</strong></td>
                        <td>${candidat.periode} mois</td>
                    </tr>
                    <tr>
                        <td><strong>Note QCM :</strong></td>
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
    
    <!-- Section pour le renouvellement d'essai -->
    <div style="border: 1px solid #ccc; padding: 15px;">
        <h3>Renouvellement d'essai</h3>
        <form method="post" action="${pageContext.request.contextPath}/essai/renouv/valider">
            <input type="hidden" name="idCandidat" value="${candidat.idCandidat}">
            
            <div style="margin-bottom: 15px;">
                <label for="statut"><strong>Décision :</strong></label><br>
                <select id="statut" name="statut" required>
                    <option value="">Sélectionner</option>
                    <option value="renouveler">Renouveler l'essai</option>
                </select>
            </div>

            <div style="margin-bottom: 15px;">
                <label for="periode"><strong>Nouvelle période :</strong></label><br>
                <select name="periode" id="periode" required>
                    <option value="">Sélectionner</option>
                    <option value="3">3 mois</option>
                </select>
            </div>

            <div style="margin-bottom: 15px;">
                <label for="salaire"><strong>Nouveau salaire :</strong></label><br>
                <input type="number" id="salaire" name="salaire" value="${candidat.salaire}" 
                       placeholder="Nouveau salaire en Ariary" required min="0">
            </div>
            
            <button type="submit">Valider le renouvellement</button>
            <button type="button" onclick="window.history.back()">Annuler</button>
        </form>
    </div>
    
    <br>
    <a href="${pageContext.request.contextPath}/rh/essai">Retour à la liste</a>
</body>
</html>