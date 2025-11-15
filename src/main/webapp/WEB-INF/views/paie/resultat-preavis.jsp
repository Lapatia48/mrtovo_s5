<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Calcul de Préavis</title>
    <style>
        .container { max-width: 1000px; margin: 20px auto; padding: 20px; border: 1px solid #ddd; }
        .header { text-align: center; margin-bottom: 30px; border-bottom: 2px solid #333; padding-bottom: 20px; }
        .section { margin-bottom: 30px; padding: 20px; border: 1px solid #eee; border-radius: 5px; }
        .section-title { font-weight: bold; font-size: 18px; margin-bottom: 15px; color: #333; border-bottom: 1px solid #ddd; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 12px 8px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f5f5f5; font-weight: bold; }
        .amount { text-align: right; }
        .currency { font-family: monospace; }
        .positive { color: green; }
        .negative { color: red; }
        .highlight { background-color: #f0f8ff; font-weight: bold; }
        .total-row { background-color: #e8f4fd; }
        .info-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px; margin-top: 15px; }
        .info-card { border: 1px solid #e0e0e0; padding: 15px; border-radius: 5px; }
        .info-label { font-weight: bold; color: #666; margin-bottom: 5px; }
        .info-value { font-size: 16px; }
        .signature-section { display: flex; justify-content: space-between; margin-top: 50px; }
        .signature-box { text-align: center; width: 45%; }
        .signature-line { border-top: 1px solid #333; margin: 40px 0 10px 0; }
        .watermark { position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%) rotate(-45deg); 
                    font-size: 80px; color: rgba(0,0,0,0.1); z-index: -1; font-weight: bold; }
        .logo { font-size: 24px; font-weight: bold; color: #333; }
        .subtitle { font-size: 14px; color: #666; margin-top: 5px; }
        .periode { text-align: center; font-weight: bold; margin: 20px 0; font-size: 16px; }
    </style>
</head>
<body>
    <div class="watermark">PRÉAVIS RH</div>
    
    <div class="container">
        <div class="header">
            <div class="logo">BUSINESS SUITE RH</div>
            <div class="subtitle">Système de Gestion des Ressources Humaines</div>
        </div>

        <!-- Période -->
        <div class="periode">
            CALCUL DE PRÉAVIS - ${motif == 'renvoi' ? 'RENVOI' : 'DÉMISSION'}
        </div>

        <!-- Contenu principal -->
        <div class="content">
            <!-- Informations employé -->
            <div class="section">
                <div class="section-title">Informations de l'Employé</div>
                <div class="info-grid">
                    <div class="info-card">
                        <div class="info-label">Nom et Prénoms</div>
                        <div class="info-value">${employe.nom} ${employe.prenom}</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label">Matricule</div>
                        <div class="info-value">${employe.id}/TNR</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label">Fonction</div>
                        <div class="info-value">${employe.poste}</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label">Date d'embauche</div>
                        <div class="info-value">${employe.dateEmbauche}</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label">N° CNaPS</div>
                        <div class="info-value">345670000</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label">Classification</div>
                        <div class="info-value">HC</div>
                    </div>
                </div>
            </div>

            <!-- Paramètres de calcul -->
            <div class="section">
                <div class="section-title">Paramètres de Calcul</div>
                <div class="info-grid">
                    <div class="info-card">
                        <div class="info-label">Salaire de base</div>
                        <div class="info-value currency"><fmt:formatNumber value="${salaireBase}" type="number"/> Ar</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label">Taux journalier</div>
                        <div class="info-value currency"><fmt:formatNumber value="${tauxJournalier}" type="number"/> Ar</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label">Durée préavis</div>
                        <div class="info-value">${dureePreavis} mois</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label">Quota congé restant</div>
                        <div class="info-value">${quotaConge} jours</div>
                    </div>
                </div>
            </div>

            <!-- Calcul des éléments -->
            <div class="section">
                <div class="section-title">Calcul des Éléments</div>
                <div class="table-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Désignations</th>
                                <th>Calcul</th>
                                <th class="amount">Montant</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Préavis (${dureePreavis} mois)</td>
                                <td>${dureePreavis} × <fmt:formatNumber value="${salaireBase}" type="number"/> Ar</td>
                                <td class="amount currency"><fmt:formatNumber value="${montantPreavis}" type="number"/> Ar</td>
                            </tr>
                            <tr>
                                <td>Congés payés (${quotaConge} jours)</td>
                                <td>${quotaConge} × <fmt:formatNumber value="${tauxJournalier}" type="number"/> Ar</td>
                                <td class="amount currency"><fmt:formatNumber value="${montantConges}" type="number"/> Ar</td>
                            </tr>
                            <c:if test="${motif == 'renvoi'}">
                                <tr class="total-row">
                                    <td colspan="2"><strong>TOTAL BRUT (Préavis + Congés)</strong></td>
                                    <td class="amount currency"><strong><fmt:formatNumber value="${totalBrut}" type="number"/> Ar</strong></td>
                                </tr>
                            </c:if>
                            <c:if test="${motif == 'demission'}">
                                <tr>
                                    <td>Solde (Préavis - Congés)</td>
                                    <td>
                                        <fmt:formatNumber value="${montantPreavis}" type="number"/> - 
                                        <fmt:formatNumber value="${montantConges}" type="number"/> Ar
                                    </td>
                                    <td class="amount">
                                        <c:choose>
                                            <c:when test="${totalBrut > 0}">
                                                <span class="negative">- <fmt:formatNumber value="${totalBrut}" type="number"/> Ar</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="positive"><fmt:formatNumber value="${totalBrut.abs()}" type="number"/> Ar</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <c:if test="${motif == 'renvoi'}">
                <!-- Retenues et déductions -->
                <div class="section">
                    <div class="section-title">Retenues et Déductions</div>
                    <div class="table-container">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Désignations</th>
                                    <th>Taux</th>
                                    <th class="amount">Montant</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Retenue CNaPS 1%</td>
                                    <td>1%</td>
                                    <td class="amount negative currency">- <fmt:formatNumber value="${retenueCnaps}" type="number"/> Ar</td>
                                </tr>
                                <tr>
                                    <td>Retenue sanitaire (OSTIE)</td>
                                    <td>1%</td>
                                    <td class="amount negative currency">- <fmt:formatNumber value="${retenueOstie}" type="number"/> Ar</td>
                                </tr>
                                <tr>
                                    <td>Tranche IRSA INF 350 000</td>
                                    <td>0%</td>
                                    <td class="amount currency">- Ar</td>
                                </tr>
                                <tr>
                                    <td>Tranche IRSA DE 350 001 à 400 000</td>
                                    <td>5%</td>
                                    <td class="amount negative currency">- <fmt:formatNumber value="${irsaTranche2}" type="number"/> Ar</td>
                                </tr>
                                <tr>
                                    <td>Tranche IRSA DE 400 001 à 500 000</td>
                                    <td>10%</td>
                                    <td class="amount negative currency">- <fmt:formatNumber value="${irsaTranche3}" type="number"/> Ar</td>
                                </tr>
                                <tr>
                                    <td>Tranche IRSA DE 500 001 à 600 000</td>
                                    <td>15%</td>
                                    <td class="amount negative currency">- <fmt:formatNumber value="${irsaTranche4}" type="number"/> Ar</td>
                                </tr>
                                <tr>
                                    <td>Tranche IRSA DE 600 001 à 4 000 000</td>
                                    <td>20%</td>
                                    <td class="amount negative currency">- <fmt:formatNumber value="${irsaTranche5}" type="number"/> Ar</td>
                                </tr>
                                <tr>
                                    <td>Tranche IRSA PLUS DE 4 000 000</td>
                                    <td>25%</td>
                                    <td class="amount negative currency">- <fmt:formatNumber value="${irsaTranche6}" type="number"/> Ar</td>
                                </tr>
                                <tr class="total-row">
                                    <td colspan="2"><strong>TOTAL IRSA</strong></td>
                                    <td class="amount negative currency"><strong>- <fmt:formatNumber value="${retenueIrsa}" type="number"/> Ar</strong></td>
                                </tr>
                                <tr class="total-row">
                                    <td colspan="2"><strong>TOTAL DES RETENUES</strong></td>
                                    <td class="amount negative currency"><strong>- <fmt:formatNumber value="${totalRetenues}" type="number"/> Ar</strong></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Résultat net -->
                <div class="section">
                    <div class="section-title">Résultat Net</div>
                    <div class="table-container">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <td><strong>Total Brut</strong></td>
                                    <td class="amount currency"><strong><fmt:formatNumber value="${totalBrut}" type="number"/> Ar</strong></td>
                                </tr>
                                <tr>
                                    <td><strong>Total des Retenues</strong></td>
                                    <td class="amount negative currency"><strong>- <fmt:formatNumber value="${totalRetenues}" type="number"/> Ar</strong></td>
                                </tr>
                                <tr class="highlight">
                                    <td><strong>NET À PAYER</strong></td>
                                    <td class="amount currency"><strong><fmt:formatNumber value="${netAPayer}" type="number"/> Ar</strong></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>

            <c:if test="${motif == 'demission'}">
                <!-- Résultat final pour démission -->
                <div class="section">
                    <div class="section-title">Résultat Final</div>
                    <div class="table-container">
                        <table class="table">
                            <tbody>
                                <tr class="highlight">
                                    <td>
                                        <c:choose>
                                            <c:when test="${netAPayer > 0}">
                                                <strong>MONTANT DÛ PAR L'ENTREPRISE</strong>
                                            </c:when>
                                            <c:otherwise>
                                                <strong>MONTANT DÛ PAR L'EMPLOYÉ</strong>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="amount">
                                        <c:choose>
                                            <c:when test="${netAPayer > 0}">
                                                <span class="positive"><strong><fmt:formatNumber value="${netAPayer}" type="number"/> Ar</strong></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="negative"><strong><fmt:formatNumber value="${netAPayer.abs()}" type="number"/> Ar</strong></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>

            <!-- Signatures -->
            <div class="signature-section">
                <div class="signature-box">
                    <div class="signature-label">L'Employeur</div>
                    <div class="signature-line"></div>
                    <div>Direction des Ressources Humaines</div>
                </div>
                <div class="signature-box">
                    <div class="signature-label">L'Employé(e)</div>
                    <div class="signature-line"></div>
                    <div>${employe.nom} ${employe.prenom}</div>
                </div>
            </div>
        </div>
    </div>

    <div style="margin-top: 20px; text-align: center;">
        <button onclick="window.print()" style="padding: 10px 20px; margin: 5px;">Imprimer</button>
        <button onclick="window.history.back()" style="padding: 10px 20px; margin: 5px;">Retour</button>
    </div>
</body>
</html>