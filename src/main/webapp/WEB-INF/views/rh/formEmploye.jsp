<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Formulaire d'embauche - ${candidat.prenom} ${candidat.nom}</title>
</head>
<body>
    <h2>Formulaire d'embauche</h2>
    <a href="${pageContext.request.contextPath}/rh/essai">Retour à la liste</a>

    <c:if test="${not empty error}">
        <div style="color: red; margin-bottom: 20px;">
            ${error}
        </div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/essai/embauche/valider">
        <input type="hidden" name="idCandidat" value="${candidat.idCandidat}" required>
        
        <h3>Informations personnelles</h3>
        <table border="1" cellpadding="5">
            <tr>
                <td><strong>Nom * :</strong></td>
                <td>
                    <input type="text" name="nom" value="${candidat.nom}" 
                           readonly required style="background-color: #f0f0f0;">
                </td>
            </tr>
            <tr>
                <td><strong>Prénom * :</strong></td>
                <td>
                    <input type="text" name="prenom" value="${candidat.prenom}" 
                           readonly required style="background-color: #f0f0f0;">
                </td>
            </tr>
            <tr>
                <td><strong>Email * :</strong></td>
                <td>
                    <input type="email" name="mail" value="${candidat.mail}" 
                           readonly required style="background-color: #f0f0f0;">
                </td>
            </tr>
            <tr>
                <td><strong>Adresse * :</strong></td>
                <td>
                    <input type="text" name="adresse" value="${candidat.adresse}" 
                           readonly required style="background-color: #f0f0f0;">
                </td>
            </tr>
            <tr>
                <td><strong>Date de naissance * :</strong></td>
                <td>
                    <input type="text" name="dateNaissance" value="${candidat.dateNaissance}" 
                           readonly required style="background-color: #f0f0f0;">
                </td>
            </tr>
            <tr>
                <td><strong>Diplôme * :</strong></td>
                <td>
                    <input type="text" name="diplome" value="${candidat.diplome}" 
                           readonly required style="background-color: #f0f0f0;">
                </td>
            </tr>
            <tr>
                <td><strong>Expérience * :</strong></td>
                <td>
                    <input type="text" name="anneeExperience" value="${candidat.anneeExperience} ans" 
                           readonly required style="background-color: #f0f0f0;">
                </td>
            </tr>
            <tr>
                <td><strong>Département * :</strong></td>
                <td>
                    <input type="text" name="departement" value="${candidat.departement}" 
                           readonly required style="background-color: #f0f0f0;">
                </td>
            </tr>
            <tr>
                <td><strong>Poste initial * :</strong></td>
                <td>
                    <input type="text" name="annoncePostulee" value="${candidat.annoncePostulee}" 
                           readonly required style="background-color: #f0f0f0;">
                </td>
            </tr>
        </table>

        <h3>Informations d'embauche</h3>
        <table border="1" cellpadding="5">
            <tr>
                <td><strong>Mot de passe * :</strong></td>
                <td>
                    <input type="password" name="motDePasse" required 
                           placeholder="Définir le mot de passe de connexion">
                </td>
            </tr>
            <tr>
                <td><strong>Confirmer le mot de passe * :</strong></td>
                <td>
                    <input type="password" name="confirmationMotDePasse" required 
                           placeholder="Confirmer le mot de passe">
                </td>
            </tr>
            <tr>
                <td><strong>Date d'embauche * :</strong></td>
                <td>
                    <input type="date" name="dateEmbauche" value="${dateEmbauche}" required>
                </td>
            </tr>
            <tr>
                <td><strong>Poste attribué * :</strong></td>
                <td>
                    <input type="text" name="poste" value="${candidat.annoncePostulee}" required 
                           placeholder="Poste définitif">
                </td>
            </tr>
            <tr>
                <td><strong>Salaire définitif * :</strong></td>
                <td>
                    <input type="number" name="salaire" value="${candidat.salaire}" required 
                           placeholder="Salaire en Ariary" min="0">
                </td>
            </tr>
            <tr>
                <td><strong>Informations complémentaires :</strong></td>
                <td>
                    <textarea name="renseignement" rows="3" cols="50" 
                              placeholder="Informations supplémentaires sur l'employé">${candidat.renseignement}</textarea>
                </td>
            </tr>
        </table>

        <br>
        <button type="submit" onclick="return validerFormulaire()">Valider l'embauche</button>
        <button type="button" onclick="window.history.back()">Annuler</button>
    </form>

    <script>
        function validerFormulaire() {
            const motDePasse = document.getElementsByName('motDePasse')[0].value;
            const confirmation = document.getElementsByName('confirmationMotDePasse')[0].value;
            
            if (motDePasse !== confirmation) {
                alert('Les mots de passe ne correspondent pas');
                return false;
            }
            
            if (motDePasse.length < 6) {
                alert('Le mot de passe doit contenir au moins 6 caractères');
                return false;
            }
            
            return confirm('Êtes-vous sûr de vouloir embaucher ${candidat.prenom} ${candidat.nom} ?');
        }

        // Focus sur le premier champ modifiable
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementsByName('motDePasse')[0].focus();
        });
    </script>
</body>
</html>