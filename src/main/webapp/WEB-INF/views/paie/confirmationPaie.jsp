<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fiche de Paie</title>
</head>
<body>
    <h2>FICHE DE PAIE</h2>
    <p><strong>ARRETE AU ${periodeFin}</strong></p>
    
    <table border="1">
        <tr>
            <td><strong>Nom et Prénoms :</strong></td>
            <td>${employe.nom} ${employe.prenom}</td>
            <td><strong>Classification :</strong></td>
            <td>HC</td>
        </tr>
        <tr>
            <td><strong>Matricule :</strong></td>
            <td>${employe.id}/TNR</td>
            <td><strong>Salaire de base :</strong></td>
            <td>${salaireBase} Ar</td>
        </tr>
        <tr>
            <td><strong>Fonction :</strong></td>
            <td>${employe.poste}</td>
            <td><strong>Taux journaliers :</strong></td>
            <td>${tauxJournalier} Ar</td>
        </tr>
        <tr>
            <td><strong>N° CNaPS :</strong></td>
            <td>345670000</td>
            <td><strong>Taux horaires :</strong></td>
            <td>${tauxHoraire} Ar</td>
        </tr>
        <tr>
            <td><strong>Date d'embauche :</strong></td>
            <td>${employe.dateEmbauche}</td>
            <td><strong>Indice :</strong></td>
            <td>${indice} Ar</td>
        </tr>
    </table>

    <br>

    <table border="1">
        <tr>
            <th>Désignations</th>
            <th>Nombre</th>
            <th>Taux</th>
            <th>Montant</th>
        </tr>
        <tr>
            <td>Salaire du ${periodeDebut} au ${periodeFin}</td>
            <td>1 mois</td>
            <td>${tauxJournalier} Ar</td>
            <td>${salaireBase} Ar</td>
        </tr>
        <tr>
            <td>Absences déductibles</td>
            <td>${absences} h</td>
            <td>${tauxHoraire} Ar</td>
            <td>- ${montantAbsences} Ar</td>
        </tr>
        <tr>
            <td>Primes de rendement</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Primes d'ancienneté</td>
            <td></td>
            <td>${primeAnciennete} Ar</td>
            <td>${primeAnciennete} Ar</td>
        </tr>
        <tr>
            <td>Heures supplémentaires majorées de 30%</td>
            <td>${heuresSupNormales} h</td>
            <td>${tauxHeuresSup30} Ar</td>
            <td>${montantHeuresSupNormales} Ar</td>
        </tr>
        <tr>
            <td>Heures supplémentaires majorées de 50%</td>
            <td>${heuresSupWeekend} h</td>
            <td>${tauxHeuresSup50} Ar</td>
            <td>${montantHeuresSupWeekend} Ar</td>
        </tr>
        <tr>
            <td>Majoration pour heures de nuit</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Primes diverses</td>
            <td></td>
            <td>${autresPrimes} Ar</td>
            <td>${autresPrimes} Ar</td>
        </tr>
        <tr>
            <td>Rappels sur période antérieure</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Droits de congés</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Droits de préavis</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Indemnités de licenciement</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td colspan="3" align="right"><strong>A</strong></td>
            <td><strong>${salaireBrut} Ar</strong></td>
        </tr>
        <tr>
            <td colspan="4"><strong>Salaire brut</strong></td>
            <td><strong>${salaireBrut} Ar</strong></td>
        </tr>
    </table>

    <br>

    <table border="1">
        <tr>
            <td>Retenue CNaPS 1%</td>
            <td></td>
            <td>${retenueCnaps} Ar</td>
        </tr>
        <tr>
            <td>Retenue sanitaire</td>
            <td></td>
            <td>${retenueOstie} Ar</td>
        </tr>
        <tr>
            <td>Tranche IRSA INF 350 000</td>
            <td></td>
            <td>- Ar</td>
        </tr>
        <tr>
            <td>Tranche IRSA DE 350 001 à 400 000</td>
            <td>5%</td>
            <td>${irsaTranche2} Ar</td>
        </tr>
        <tr>
            <td>Tranche IRSA DE 400 001 à 500 000</td>
            <td>10%</td>
            <td>${irsaTranche3} Ar</td>
        </tr>
        <tr>
            <td>Tranche IRSA DE 500 001 à 600 000</td>
            <td>15%</td>
            <td>${irsaTranche4} Ar</td>
        </tr>
        <tr>
            <td>Tranche IRSA DE 600 001 à 4000 000</td>
            <td>20%</td>
            <td>${irsaTranche5} Ar</td>
        </tr>
        <tr>
            <td>Tranche IRSA PLUS DE 4000 000</td>
            <td>25%</td>
            <td>${irsaTranche6} Ar</td>
        </tr>
        <tr>
            <td colspan="2"><strong>TOTAL IRSA</strong></td>
            <td><strong>${retenueIrsa} Ar</strong></td>
        </tr>
        <tr>
            <td colspan="2"><strong>Total des retenues</strong></td>
            <td><strong>${totalRetenues} Ar</strong></td>
        </tr>
        <tr>
            <td colspan="2">Autres indemnités</td>
            <td></td>
        </tr>
        <tr>
            <td colspan="2"><strong>Net à payer</strong></td>
            <td><strong>${netAPayer} Ar</strong></td>
        </tr>
    </table>

    <br>

    <table border="1">
        <tr>
            <td>Avantages en nature :</td>
            <td></td>
        </tr>
        <tr>
            <td>Déductions IRSA :</td>
            <td></td>
        </tr>
        <tr>
            <td>Montant imposable :</td>
            <td>${salaireBrut} Ar</td>
        </tr>
    </table>

    <br>

    <table border="1">
        <tr>
            <td><strong>Mode de paiement :</strong></td>
            <td>${modePaiement}</td>
        </tr>
    </table>

    <br>

    <table border="1">
        <tr>
            <td><strong>L'employeur</strong></td>
            <td><strong>L'employé(e)</strong></td>
        </tr>
    </table>

    <br>

    <form action="${pageContext.request.contextPath}/rh/employe/sauvegarderPaie" method="post">
        <input type="hidden" name="id_emp" value="${idEmp}">
        <input type="hidden" name="periode_debut" value="${periodeDebut}">
        <input type="hidden" name="periode_fin" value="${periodeFin}">
        <input type="hidden" name="heures_sup_normales" value="${heuresSupNormales}">
        <input type="hidden" name="heures_sup_weekend" value="${heuresSupWeekend}">
        <input type="hidden" name="prime_anciennete" value="${primeAnciennete}">
        <input type="hidden" name="absences" value="${absences}">
        <input type="hidden" name="autres_primes" value="${autresPrimes}">
        <input type="hidden" name="salaire_brut" value="${salaireBrut}">
        <input type="hidden" name="net_a_payer" value="${netAPayer}">
        <input type="hidden" name="mode_paiement" value="${modePaiement}">
        
        <button type="submit">Confirmer et Enregistrer</button>
        <a href="${pageContext.request.contextPath}/rh/employe/payer?id_emp=${idEmp}">Modifier</a>
    </form>
</body>
</html>