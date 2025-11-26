<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Demande de Préavis - BusinessSuite RH</title>
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

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .info-item {
            background: var(--light);
            padding: 20px;
            border-radius: 12px;
            border-left: 4px solid var(--secondary);
            transition: var(--transition);
        }

        .info-item:hover {
            background: #e3e8ea;
            transform: translateX(5px);
        }

        .info-label {
            font-size: 0.85rem;
            color: var(--gray);
            font-weight: 500;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--primary);
        }

        .quota-section {
            background: linear-gradient(135deg, #e8f5e8, #d4edda);
            border: 1px solid #c3e6cb;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
            text-align: center;
        }

        .quota-icon {
            font-size: 3rem;
            color: var(--success);
            margin-bottom: 15px;
        }

        .quota-label {
            font-size: 1rem;
            color: var(--gray);
            font-weight: 500;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .quota-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--success);
            line-height: 1;
        }

        .quota-unit {
            font-size: 1rem;
            color: var(--gray);
            font-weight: 500;
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

        .form-control:invalid {
            border-color: var(--danger);
        }

        .form-text {
            font-size: 0.85rem;
            color: var(--gray);
            margin-top: 8px;
            display: block;
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

        .badge {
            display: inline-block;
            padding: 6px 16px;
            background: var(--success);
            color: var(--white);
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-warning {
            background: var(--warning);
        }

        .badge-danger {
            background: var(--danger);
        }

        .animation-pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
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

        <!-- Carte Informations Employé -->
        <div class="card">
            <div class="card-header">
                <div class="card-title">
                    <i class="fas fa-user-tie"></i>
                    Informations de l'Employé
                </div>
                <div class="card-subtitle">Détails complets du collaborateur</div>
            </div>
            <div class="card-body">
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
                    <div class="info-item">
                        <div class="info-label">Date d'embauche</div>
                        <div class="info-value">${employe.dateEmbauche}</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Carte Quota de Congé -->
        <div class="card">
            <div class="card-header">
                <div class="card-title">
                    <i class="fas fa-chart-pie"></i>
                    Situation des Congés
                </div>
                <div class="card-subtitle">Quota disponible pour le préavis</div>
            </div>
            <div class="card-body">
                <div class="quota-section animation-pulse">
                    <div class="quota-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="quota-label">Quota de congé total restant</div>
                    <div class="quota-value">${quotaConge}</div>
                    <div class="quota-unit">jours</div>
                </div>
            </div>
        </div>

        <!-- Carte Formulaire Préavis -->
        <div class="card">
            <div class="card-header">
                <div class="card-title">
                    <i class="fas fa-file-contract"></i>
                    Demande de Préavis
                </div>
                <div class="card-subtitle">Configuration des paramètres du préavis</div>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/rh/paie/calculerPreavis" method="post">
                    <input type="hidden" name="id_emp" value="${employe.id}">
                    
                    <div class="form-group">
                        <label class="form-label" for="motif">
                            <i class="fas fa-clipboard-list"></i>
                            Motif du préavis
                        </label>
                        <select class="form-control" id="motif" name="motif" required>
                            <option value="">Sélectionnez un motif</option>
                            <option value="renvoi">Renvoi</option>
                            <option value="demission">Démission</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="duree_preavis">
                            <i class="fas fa-clock"></i>
                            Durée du préavis
                        </label>
                        <select class="form-control" id="duree_preavis" name="duree_preavis" required>
                            <option value="3">3 mois</option>
                            <option value="2">2 mois</option>
                            <option value="1">1 mois</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="quota_conge">
                            <i class="fas fa-calendar-alt"></i>
                            Quota de congé à utiliser
                        </label>
                        <input type="number" class="form-control" id="quota_conge" name="quota_conge" 
                               value="${quotaConge}" 
                               required min="0" max="${quotaConge}"
                               title="Le nombre de jours de congé restant ne peut pas dépasser ${quotaConge} jours">
                        <span class="form-text">Maximum : ${quotaConge} jours disponibles</span>
                    </div>

                    <div class="form-actions">
                        <button type="button" onclick="window.history.back()" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Annuler
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-calculator"></i>
                            Calculer le préavis
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Validation côté client pour empêcher de saisir plus que le quota disponible
        document.getElementById('quota_conge').addEventListener('input', function() {
            const maxQuota = ${quotaConge};
            if (this.value > maxQuota) {
                this.value = maxQuota;
                alert(`Le nombre de jours ne peut pas dépasser ${maxQuota} jours`);
            }
        });

        // Ajustement automatique du quota en fonction du motif
        document.getElementById('motif').addEventListener('change', function() {
            const motif = this.value;
            const quotaInput = document.getElementById('quota_conge');
            const maxQuota = ${quotaConge};
            
            if (motif === 'demission') {
                // Pour les démissions, on peut utiliser tout le quota
                quotaInput.max = maxQuota;
                quotaInput.title = `Le nombre de jours de congé ne peut pas dépasser ${maxQuota} jours`;
            } else if (motif === 'renvoi') {
                // Pour les renvois, même règle
                quotaInput.max = maxQuota;
                quotaInput.title = `Le nombre de jours de congé ne peut pas dépasser ${maxQuota} jours`;
            }
        });
    </script>
</body>
</html>