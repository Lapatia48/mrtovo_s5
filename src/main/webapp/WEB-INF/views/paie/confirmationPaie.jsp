<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fiche de Paie - BusinessSuite RH</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #2C3E50;
            --primary-light: #34495E;
            --secondary: #3498DB;
            --accent: #2980B9;
            --success: #27AE60;
            --warning: #F39C12;
            --danger: #E74C3C;
            --light: #ECF0F1;
            --dark: #2C3E50;
            --gray: #95A5A6;
            --gray-light: #BDC3C7;
            --white: #FFFFFF;
            --border-radius: 12px;
            --shadow: 0 8px 30px rgba(0,0,0,0.08);
            --shadow-light: 0 4px 15px rgba(0,0,0,0.05);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            color: var(--dark);
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .fiche-paie {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .header {
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: var(--white);
            padding: 40px;
            text-align: center;
            position: relative;
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" opacity="0.1"><circle cx="50" cy="50" r="2" fill="white"/></svg>') repeat;
        }

        .logo {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            letter-spacing: 1px;
        }

        .subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            font-weight: 300;
        }

        .periode {
            background: var(--secondary);
            color: var(--white);
            padding: 15px 40px;
            text-align: center;
            font-size: 1.2rem;
            font-weight: 600;
        }

        .content {
            padding: 40px;
        }

        .section {
            margin-bottom: 40px;
        }

        .section-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--light);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            color: var(--secondary);
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .info-card {
            background: var(--light);
            padding: 25px;
            border-radius: var(--border-radius);
            border-left: 4px solid var(--secondary);
        }

        .info-label {
            font-size: 0.9rem;
            color: var(--gray);
            font-weight: 500;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--primary);
        }

        .table-container {
            background: var(--white);
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-light);
            margin-bottom: 25px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
        }

        .table th {
            background: linear-gradient(135deg, var(--primary-light), var(--primary));
            color: var(--white);
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table td {
            padding: 16px 15px;
            border-bottom: 1px solid var(--light);
            transition: var(--transition);
        }

        .table tbody tr:hover td {
            background: rgba(52, 152, 219, 0.05);
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .amount {
            text-align: right;
            font-weight: 600;
            font-family: 'Courier New', monospace;
        }

        .negative {
            color: var(--danger);
        }

        .positive {
            color: var(--success);
        }

        .total-row {
            background: var(--light) !important;
            font-weight: 700;
            font-size: 1.1rem;
        }

        .total-row td {
            border-top: 2px solid var(--gray-light);
            border-bottom: none !important;
        }

        .highlight {
            background: linear-gradient(135deg, var(--success), #2ECC71) !important;
            color: var(--white);
        }

        .highlight td {
            color: var(--white);
            font-size: 1.1rem;
            font-weight: 700;
        }

        .actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 14px 28px;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--secondary), var(--accent));
            color: var(--white);
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
        }

        .btn-success {
            background: linear-gradient(135deg, var(--success), #2ECC71);
            color: var(--white);
            box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
        }

        .btn-secondary {
            background: var(--light);
            color: var(--dark);
            border: 2px solid var(--gray-light);
        }

        .btn-secondary:hover {
            background: var(--gray-light);
        }

        .signature-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 2px solid var(--light);
        }

        .signature-box {
            text-align: center;
            padding: 25px;
            background: var(--light);
            border-radius: var(--border-radius);
        }

        .signature-label {
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 15px;
            font-size: 1.1rem;
        }

        .signature-line {
            height: 2px;
            background: var(--gray-light);
            margin: 25px 0;
            position: relative;
        }

        .signature-line::after {
            content: 'Signature';
            position: absolute;
            top: -12px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--light);
            padding: 0 15px;
            color: var(--gray);
            font-size: 0.8rem;
        }

        .watermark {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-45deg);
            font-size: 8rem;
            font-weight: 900;
            color: rgba(44, 62, 80, 0.03);
            pointer-events: none;
            z-index: -1;
            white-space: nowrap;
        }

        @media (max-width: 768px) {
            body {
                padding: 20px 10px;
            }

            .content {
                padding: 20px;
            }

            .header {
                padding: 30px 20px;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .table-container {
                overflow-x: auto;
            }

            .table {
                min-width: 600px;
            }

            .signature-section {
                grid-template-columns: 1fr;
            }

            .actions {
                flex-direction: column;
            }

            .btn {
                justify-content: center;
            }

            .watermark {
                font-size: 4rem;
            }
        }

        @media print {
            body {
                background: none;
                padding: 0;
            }

            .fiche-paie {
                box-shadow: none;
                margin: 0;
            }

            .actions {
                display: none;
            }

            .watermark {
                display: none;
            }
        }

        .currency {
            font-family: 'Courier New', monospace;
            letter-spacing: 0.5px;
        }

        .badge {
            display: inline-block;
            padding: 4px 12px;
            background: var(--success);
            color: var(--white);
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-confirmed {
            background: var(--success);
        }

        .status-pending {
            background: var(--warning);
        }
    </style>
</head>
<body>
    <div class="watermark">BUSINESS SUITE RH</div>
    
    <div class="container">
        <div class="fiche-paie">
            <!-- En-tête -->
            <div class="header">
                <div class="logo">BUSINESS SUITE RH</div>
                <div class="subtitle">Système de Gestion des Ressources Humaines</div>
            </div>

            <!-- Période -->
            <div class="periode">
                FICHE DE PAIE ARRÊTÉE AU ${periodeFin}
            </div>

            <!-- Contenu principal -->
            <div class="content">
                <!-- Informations employé -->
                <div class="section">
                    <div class="section-title">
                        <i class="fas fa-user-tie"></i>
                        Informations de l'Employé
                    </div>
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

                <!-- Salaire et taux -->
                <div class="section">
                    <div class="section-title">
                        <i class="fas fa-chart-line"></i>
                        Paramètres de Rémunération
                    </div>
                    <div class="info-grid">
                        <div class="info-card">
                            <div class="info-label">Salaire de base</div>
                            <div class="info-value currency">${salaireBase} Ar</div>
                        </div>
                        <div class="info-card">
                            <div class="info-label">Taux journalier</div>
                            <div class="info-value currency">${tauxJournalier} Ar</div>
                        </div>
                        <div class="info-card">
                            <div class="info-label">Taux horaire</div>
                            <div class="info-value currency">${tauxHoraire} Ar</div>
                        </div>
                        <div class="info-card">
                            <div class="info-label">Indice</div>
                            <div class="info-value currency">${indice} Ar</div>
                        </div>
                    </div>
                </div>

                <!-- Gains et rémunérations -->
                <div class="section">
                    <div class="section-title">
                        <i class="fas fa-plus-circle"></i>
                        Gains et Rémunérations
                    </div>
                    <div class="table-container">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Désignations</th>
                                    <th>Nombre</th>
                                    <th>Taux</th>
                                    <th class="amount">Montant</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Salaire du ${periodeDebut} au ${periodeFin}</td>
                                    <td>1 mois</td>
                                    <td class="currency">${tauxJournalier} Ar</td>
                                    <td class="amount currency">${salaireBase} Ar</td>
                                </tr>
                                <tr>
                                    <td>Absences déductibles</td>
                                    <td>${absences} h</td>
                                    <td class="currency">${tauxHoraire} Ar</td>
                                    <td class="amount negative currency">- ${montantAbsences} Ar</td>
                                </tr>
                                <tr>
                                    <td>Primes de rendement</td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td class="amount currency">- Ar</td>
                                </tr>
                                <tr>
                                    <td>Primes d'ancienneté</td>
                                    <td>-</td>
                                    <td class="currency">${primeAnciennete} Ar</td>
                                    <td class="amount positive currency">${primeAnciennete} Ar</td>
                                </tr>
                                <tr>
                                    <td>Heures supplémentaires majorées de 30%</td>
                                    <td>${heuresSupNormales} h</td>
                                    <td class="currency">${tauxHeuresSup30} Ar</td>
                                    <td class="amount positive currency">${montantHeuresSupNormales} Ar</td>
                                </tr>
                                <tr>
                                    <td>Heures supplémentaires majorées de 50%</td>
                                    <td>${heuresSupWeekend} h</td>
                                    <td class="currency">${tauxHeuresSup50} Ar</td>
                                    <td class="amount positive currency">${montantHeuresSupWeekend} Ar</td>
                                </tr>
                                <tr>
                                    <td>Majoration pour heures de nuit</td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td class="amount currency">- Ar</td>
                                </tr>
                                <tr>
                                    <td>Primes diverses</td>
                                    <td>-</td>
                                    <td class="currency">${autresPrimes} Ar</td>
                                    <td class="amount positive currency">${autresPrimes} Ar</td>
                                </tr>
                                <tr class="total-row">
                                    <td colspan="3" class="amount"><strong>SALAIRE BRUT (A)</strong></td>
                                    <td class="amount currency"><strong>${salaireBrut} Ar</strong></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Retenues et déductions -->
                <div class="section">
                    <div class="section-title">
                        <i class="fas fa-minus-circle"></i>
                        Retenues et Déductions
                    </div>
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
                                    <td class="amount negative currency">${retenueCnaps} Ar</td>
                                </tr>
                                <tr>
                                    <td>Retenue sanitaire (OSTIE)</td>
                                    <td>1%</td>
                                    <td class="amount negative currency">${retenueOstie} Ar</td>
                                </tr>
                                <tr>
                                    <td>Tranche IRSA INF 350 000</td>
                                    <td>0%</td>
                                    <td class="amount currency">- Ar</td>
                                </tr>
                                <tr>
                                    <td>Tranche IRSA DE 350 001 à 400 000</td>
                                    <td>5%</td>
                                    <td class="amount negative currency">${irsaTranche2} Ar</td>
                                </tr>
                                <tr>
                                    <td>Tranche IRSA DE 400 001 à 500 000</td>
                                    <td>10%</td>
                                    <td class="amount negative currency">${irsaTranche3} Ar</td>
                                </tr>
                                <tr>
                                    <td>Tranche IRSA DE 500 001 à 600 000</td>
                                    <td>15%</td>
                                    <td class="amount negative currency">${irsaTranche4} Ar</td>
                                </tr>
                                <tr>
                                    <td>Tranche IRSA DE 600 001 à 4 000 000</td>
                                    <td>20%</td>
                                    <td class="amount negative currency">${irsaTranche5} Ar</td>
                                </tr>
                                <tr>
                                    <td>Tranche IRSA PLUS DE 4 000 000</td>
                                    <td>25%</td>
                                    <td class="amount negative currency">${irsaTranche6} Ar</td>
                                </tr>
                                <tr class="total-row">
                                    <td colspan="2"><strong>TOTAL IRSA</strong></td>
                                    <td class="amount negative currency"><strong>${retenueIrsa} Ar</strong></td>
                                </tr>
                                <tr class="total-row">
                                    <td colspan="2"><strong>TOTAL DES RETENUES (B)</strong></td>
                                    <td class="amount negative currency"><strong>${totalRetenues} Ar</strong></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Résultat net -->
                <div class="section">
                    <div class="section-title">
                        <i class="fas fa-calculator"></i>
                        Résultat Net
                    </div>
                    <div class="table-container">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <td><strong>Salaire Brut (A)</strong></td>
                                    <td class="amount currency"><strong>${salaireBrut} Ar</strong></td>
                                </tr>
                                <tr>
                                    <td><strong>Total des Retenues (B)</strong></td>
                                    <td class="amount negative currency"><strong>${totalRetenues} Ar</strong></td>
                                </tr>
                                <tr class="highlight">
                                    <td><strong>NET À PAYER (A - B)</strong></td>
                                    <td class="amount currency"><strong>${netAPayer} Ar</strong></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Informations complémentaires -->
                <div class="section">
                    <div class="section-title">
                        <i class="fas fa-info-circle"></i>
                        Informations Complémentaires
                    </div>
                    <div class="info-grid">
                        <div class="info-card">
                            <div class="info-label">Mode de paiement</div>
                            <div class="info-value">${modePaiement}</div>
                        </div>
                        <div class="info-card">
                            <div class="info-label">Montant imposable</div>
                            <div class="info-value currency">${salaireBrut} Ar</div>
                        </div>
                    </div>
                </div>

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

                <!-- Actions -->
                <div class="actions">
                    <form action="${pageContext.request.contextPath}/rh/employe/sauvegarderPaie" method="post" style="display: inline;">
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
                        
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-check-circle"></i>
                            Confirmer et Enregistrer
                        </button>
                    </form>

                    <a href="${pageContext.request.contextPath}/rh/employe/payer?id_emp=${idEmp}" class="btn btn-secondary">
                        <i class="fas fa-edit"></i>
                        Modifier
                    </a>

                    <form action="${pageContext.request.contextPath}/rh/employe/exporterExcel" method="post" style="display: inline;">
                        <input type="hidden" name="id_emp" value="${idEmp}">
                        <input type="hidden" name="periode_debut" value="${periodeDebut}">
                        <input type="hidden" name="periode_fin" value="${periodeFin}">
                        <input type="hidden" name="salaire_base" value="${salaireBase}">
                        <input type="hidden" name="taux_journalier" value="${tauxJournalier}">
                        <input type="hidden" name="taux_horaire" value="${tauxHoraire}">
                        <input type="hidden" name="heures_sup_normales" value="${heuresSupNormales}">
                        <input type="hidden" name="heures_sup_weekend" value="${heuresSupWeekend}">
                        <input type="hidden" name="prime_anciennete" value="${primeAnciennete}">
                        <input type="hidden" name="absences" value="${absences}">
                        <input type="hidden" name="autres_primes" value="${autresPrimes}">
                        <input type="hidden" name="salaire_brut" value="${salaireBrut}">
                        <input type="hidden" name="retenue_cnaps" value="${retenueCnaps}">
                        <input type="hidden" name="retenue_ostie" value="${retenueOstie}">
                        <input type="hidden" name="retenue_irsa" value="${retenueIrsa}">
                        <input type="hidden" name="total_retenues" value="${totalRetenues}">
                        <input type="hidden" name="net_a_payer" value="${netAPayer}">
                        <input type="hidden" name="mode_paiement" value="${modePaiement}">
                        <input type="hidden" name="nom_employe" value="${employe.nom}">
                        <input type="hidden" name="prenom_employe" value="${employe.prenom}">
                        <input type="hidden" name="poste_employe" value="${employe.poste}">
                        <input type="hidden" name="date_embauche" value="${employe.dateEmbauche}">
                        
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-file-excel"></i>
                            Exporter Excel
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>