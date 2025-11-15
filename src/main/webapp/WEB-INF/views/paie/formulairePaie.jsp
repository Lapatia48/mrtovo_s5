<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire de Paiement - BusinessSuite RH</title>
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
            --border-radius: 16px;
            --shadow: 0 12px 40px rgba(0,0,0,0.12);
            --shadow-light: 0 6px 20px rgba(0,0,0,0.08);
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
            max-width: 800px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .logo {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--white);
            margin-bottom: 10px;
            letter-spacing: 1px;
        }

        .subtitle {
            font-size: 1.1rem;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 300;
        }

        .card {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 30px;
            transition: var(--transition);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: var(--white);
            padding: 25px 30px;
            position: relative;
        }

        .card-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" opacity="0.1"><circle cx="50" cy="50" r="2" fill="white"/></svg>') repeat;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .card-title i {
            font-size: 1.3rem;
        }

        .card-subtitle {
            font-size: 0.95rem;
            opacity: 0.9;
            font-weight: 300;
        }

        .card-body {
            padding: 30px;
        }

        .info-employe {
            background: linear-gradient(135deg, #e8f4fd, #d1ecf1);
            border: 1px solid #b8daff;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
        }

        .info-employe-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .info-item {
            background: var(--white);
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid var(--secondary);
        }

        .info-label {
            font-size: 0.8rem;
            color: var(--gray);
            font-weight: 500;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 1rem;
            font-weight: 600;
            color: var(--primary);
        }

        .quota-section {
            background: linear-gradient(135deg, #e8f5e8, #d4edda);
            border: 1px solid #c3e6cb;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            text-align: center;
        }

        .quota-icon {
            font-size: 2.5rem;
            color: var(--success);
            margin-bottom: 10px;
        }

        .quota-label {
            font-size: 0.9rem;
            color: var(--gray);
            font-weight: 500;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .quota-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--success);
            line-height: 1;
        }

        .quota-unit {
            font-size: 0.9rem;
            color: var(--gray);
            font-weight: 500;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            display: block;
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-label i {
            color: var(--secondary);
            width: 20px;
            text-align: center;
        }

        .form-control {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid var(--gray-light);
            border-radius: 12px;
            font-size: 1rem;
            font-family: 'Inter', sans-serif;
            transition: var(--transition);
            background: var(--white);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.1);
            transform: translateY(-2px);
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 2px solid var(--light);
        }

        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 12px;
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
            font-family: 'Inter', sans-serif;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--secondary), var(--accent));
            color: var(--white);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(52, 152, 219, 0.4);
        }

        .btn-secondary {
            background: var(--light);
            color: var(--dark);
            border: 2px solid var(--gray-light);
        }

        .btn-secondary:hover {
            background: var(--gray-light);
            transform: translateY(-2px);
        }

        .watermark {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-45deg);
            font-size: 8rem;
            font-weight: 900;
            color: rgba(255, 255, 255, 0.03);
            pointer-events: none;
            z-index: -1;
            white-space: nowrap;
        }

        @media (max-width: 768px) {
            body {
                padding: 20px 10px;
            }

            .container {
                max-width: 100%;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                justify-content: center;
            }

            .watermark {
                font-size: 4rem;
            }

            .card-body {
                padding: 20px;
            }
        }

        .animation-pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .required::after {
            content: " *";
            color: var(--danger);
        }
    </style>
</head>
<body>
    <div class="watermark">BUSINESS SUITE RH</div>
    
    <div class="container">
        <!-- En-tête -->
        <div class="header">
            <div class="logo">BUSINESS SUITE RH</div>
            <div class="subtitle">Système de Gestion des Ressources Humaines</div>
        </div>

        <!-- Carte Formulaire de Paiement -->
        <div class="card">
            <div class="card-header">
                <div class="card-title">
                    <i class="fas fa-calculator"></i>
                    Formulaire de Paiement
                </div>
                <div class="card-subtitle">Calcul de la fiche de paie pour ${employe.prenom} ${employe.nom}</div>
            </div>
            <div class="card-body">
                <!-- Informations Employé -->
                <div class="info-employe">
                    <div class="info-employe-title">
                        <i class="fas fa-user-tie"></i>
                        Informations du Collaborateur
                    </div>
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">Nom et Prénoms</div>
                            <div class="info-value">${employe.prenom} ${employe.nom}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Poste</div>
                            <div class="info-value">${employe.poste}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Département</div>
                            <div class="info-value">${employe.departement}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Salaire de base</div>
                            <div class="info-value">${employe.salaire} Ar</div>
                        </div>
                    </div>
                </div>

                <!-- Quota de Congé -->
                <div class="quota-section animation-pulse">
                    <div class="quota-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="quota-label">Quota de congé total restant</div>
                    <div class="quota-value">${quotaConge}</div>
                    <div class="quota-unit">jours</div>
                </div>

                <!-- Formulaire -->
                <form action="${pageContext.request.contextPath}/rh/employe/calculerPaie" method="post">
                    <input type="hidden" name="id_emp" value="${idEmp}">
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label required" for="periode_debut">
                                <i class="fas fa-calendar-alt"></i>
                                Période début
                            </label>
                            <input type="date" class="form-control" id="periode_debut" name="periode_debut" value="2025-12-01" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label required" for="periode_fin">
                                <i class="fas fa-calendar-alt"></i>
                                Période fin
                            </label>
                            <input type="date" class="form-control" id="periode_fin" name="periode_fin" value="2025-12-31" required>
                        </div>
                    </div>

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label" for="heures_sup_normales">
                                <i class="fas fa-clock"></i>
                                Heures supplémentaires normales
                            </label>
                            <input type="number" class="form-control" id="heures_sup_normales" name="heures_sup_normales" 
                                   step="0.5" value="0" min="0" placeholder="0">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="heures_sup_weekend">
                                <i class="fas fa-weekend"></i>
                                Heures supplémentaires weekend
                            </label>
                            <input type="number" class="form-control" id="heures_sup_weekend" name="heures_sup_weekend" 
                                   step="0.5" value="0" min="0" placeholder="0">
                        </div>
                    </div>

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label" for="prime_anciennete">
                                <i class="fas fa-award"></i>
                                Prime ancienneté (Ar)
                            </label>
                            <input type="number" class="form-control" id="prime_anciennete" name="prime_anciennete" 
                                   value="0" min="0" placeholder="0">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="absences">
                                <i class="fas fa-user-clock"></i>
                                Absences (heures)
                            </label>
                            <input type="number" class="form-control" id="absences" name="absences" 
                                   value="0" min="0" placeholder="0">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="autres_primes">
                            <i class="fas fa-gift"></i>
                            Autres primes (Ar)
                        </label>
                        <input type="number" class="form-control" id="autres_primes" name="autres_primes" 
                               value="0" min="0" placeholder="0">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="mode_paiement">
                            <i class="fas fa-credit-card"></i>
                            Mode de paiement
                        </label>
                        <select class="form-control" id="mode_paiement" name="mode_paiement">
                            <option value="Virement" selected>Virement bancaire</option>
                            <option value="Chèque">Chèque</option>
                            <option value="Espèces">Espèces</option>
                        </select>
                    </div>

                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/rh/paie/preavis" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Annuler
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-calculator"></i>
                            Calculer la paie
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>